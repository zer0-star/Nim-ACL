#!/usr/bin/env python3

from __future__ import annotations

import argparse
import base64
import bisect
import hashlib
import html
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
from dataclasses import dataclass


REPO_ROOT = Path(__file__).resolve().parent.parent
HIGHLIGHTER_SOURCE = (
    REPO_ROOT / "tools" / "nim_doc_highlighter.nim"
)

CODE_BLOCK_RE = re.compile(
    r"""
    <pre(?P<pre_attrs>[^>]*)>
    (?P<inner>.*?)
    </pre>
    """,
    re.IGNORECASE | re.DOTALL | re.VERBOSE,
)

CODE_WRAPPER_RE = re.compile(
    r"""
    ^\s*
    <code(?P<code_attrs>[^>]*)>
    (?P<body>.*?)
    </code>
    \s*$
    """,
    re.IGNORECASE | re.DOTALL | re.VERBOSE,
)

HEADING_RE = re.compile(
    r"<h(?P<level>[1-6])(?P<attrs>[^>]*)>"
    r"(?P<body>.*?)"
    r"</h(?P=level)>",
    re.IGNORECASE | re.DOTALL,
)

TAG_RE = re.compile(r"<[^>]+>")

CLASS_RE = re.compile(
    r"""class\s*=\s*(?P<quote>["'])(?P<value>.*?)(?P=quote)""",
    re.IGNORECASE | re.DOTALL,
)

STYLE_ID = "nim-acl-highlight-style-v1"

STYLE = r"""
<style id="nim-acl-highlight-style-v1">
:root {
  --nim-code-background: #f6f8fa;
  --nim-code-foreground: #24292f;
  --nim-code-border: #d0d7de;
  --nim-code-line-number: #8c959f;
  --nim-code-line-number-border: #d8dee4;

  --nim-token-keyword: #8250df;
  --nim-token-string: #0a7f37;
  --nim-token-escape: #116329;
  --nim-token-number: #0550ae;
  --nim-token-comment: #6e7781;
  --nim-token-operator: #cf222e;
  --nim-token-punctuation: #57606a;
  --nim-token-identifier: #24292f;
  --nim-token-directive: #953800;
  --nim-token-hyperlink: #0969da;
  --nim-token-other: #24292f;
}

@media (prefers-color-scheme: dark) {
  :root {
    --nim-code-background: #161b22;
    --nim-code-foreground: #c9d1d9;
    --nim-code-border: #30363d;
    --nim-code-line-number: #7d8590;
    --nim-code-line-number-border: #30363d;

    --nim-token-keyword: #d2a8ff;
    --nim-token-string: #a5d6ff;
    --nim-token-escape: #79c0ff;
    --nim-token-number: #79c0ff;
    --nim-token-comment: #8b949e;
    --nim-token-operator: #ff7b72;
    --nim-token-punctuation: #c9d1d9;
    --nim-token-identifier: #c9d1d9;
    --nim-token-directive: #ffa657;
    --nim-token-hyperlink: #58a6ff;
    --nim-token-other: #c9d1d9;
  }
}

html[data-theme="dark"],
html.dark,
body.dark,
body[data-theme="dark"] {
  --nim-code-background: #161b22;
  --nim-code-foreground: #c9d1d9;
  --nim-code-border: #30363d;
  --nim-code-line-number: #7d8590;
  --nim-code-line-number-border: #30363d;

  --nim-token-keyword: #d2a8ff;
  --nim-token-string: #a5d6ff;
  --nim-token-escape: #79c0ff;
  --nim-token-number: #79c0ff;
  --nim-token-comment: #8b949e;
  --nim-token-operator: #ff7b72;
  --nim-token-punctuation: #c9d1d9;
  --nim-token-identifier: #c9d1d9;
  --nim-token-directive: #ffa657;
  --nim-token-hyperlink: #58a6ff;
  --nim-token-other: #c9d1d9;
}

pre.nim-code {
  position: relative;
  overflow: auto;
  box-sizing: border-box;
  tab-size: 2;

  background: var(--nim-code-background);
  color: var(--nim-code-foreground);
  border: 1px solid var(--nim-code-border);
  border-radius: 7px;
}

pre.nim-code code {
  display: block;
  box-sizing: border-box;
  min-width: max-content;

  color: var(--nim-code-foreground);
  background: transparent;
  font-family:
    ui-monospace,
    SFMono-Regular,
    SF Mono,
    Menlo,
    Monaco,
    Consolas,
    Liberation Mono,
    monospace;
  line-height: 1.55;
}

pre.nim-line-numbers code {
  counter-reset: nim-code-line;
}

pre.nim-line-numbers .code-line {
  display: block;
  position: relative;
  min-height: 1.55em;
  padding-left: 4.25rem;
  padding-right: 1rem;
  white-space: pre;
}

pre.nim-line-numbers .code-line::before {
  counter-increment: nim-code-line;
  content: counter(nim-code-line);

  position: absolute;
  left: 0;
  top: 0;
  box-sizing: border-box;
  width: 3.25rem;
  padding-right: 0.75rem;

  color: var(--nim-code-line-number);
  border-right: 1px solid var(--nim-code-line-number-border);
  text-align: right;

  user-select: none;
  -webkit-user-select: none;
  pointer-events: none;
}

.tok-keyword {
  color: var(--nim-token-keyword);
  font-weight: 650;
}

.tok-string {
  color: var(--nim-token-string);
}

.tok-escape {
  color: var(--nim-token-escape);
  font-weight: 600;
}

.tok-number {
  color: var(--nim-token-number);
}

.tok-comment {
  color: var(--nim-token-comment);
  font-style: italic;
}

.tok-operator {
  color: var(--nim-token-operator);
}

.tok-punctuation {
  color: var(--nim-token-punctuation);
}

.tok-identifier {
  color: var(--nim-token-identifier);
}

.tok-directive {
  color: var(--nim-token-directive);
  font-weight: 600;
}

.tok-hyperlink {
  color: var(--nim-token-hyperlink);
  text-decoration: underline;
}

.tok-other {
  color: var(--nim-token-other);
}
</style>
""".strip()


@dataclass
class CodeBlock:
    path: Path
    start: int
    end: int
    pre_attrs: str
    code_attrs: str
    source: str
    line_numbers: bool


@dataclass
class FileRecord:
    path: Path
    text: str
    blocks: list[CodeBlock]


def class_values(attrs: str) -> list[str]:
    match = CLASS_RE.search(attrs)

    if match is None:
        return []

    return match.group("value").split()


def has_class(attrs: str, class_name: str) -> bool:
    wanted = class_name.lower()

    return any(
        value.lower() == wanted
        for value in class_values(attrs)
    )


def add_classes(attrs: str, classes: list[str]) -> str:
    current = class_values(attrs)
    lower = {value.lower() for value in current}

    for class_name in classes:
        if class_name.lower() not in lower:
            current.append(class_name)
            lower.add(class_name.lower())

    match = CLASS_RE.search(attrs)
    new_value = " ".join(current)

    if match is None:
        return f'{attrs} class="{new_value}"'

    replacement = f'class="{new_value}"'

    return (
        attrs[:match.start()]
        + replacement
        + attrs[match.end():]
    )


def is_nim_code(code_attrs: str) -> bool:
    classes = [
        value.lower().replace("_", "-")
        for value in class_values(code_attrs)
    ]

    for value in classes:
        if value in {
            "nim",
            "lang-nim",
            "language-nim",
            "langnim",
        }:
            return True

        if value.startswith("language-") and value.endswith("nim"):
            return True

    return False


def heading_text(raw: str) -> str:
    return html.unescape(
        TAG_RE.sub("", raw)
    ).strip()


def heading_positions(text: str) -> tuple[list[int], list[str]]:
    positions: list[int] = []
    values: list[str] = []

    for match in HEADING_RE.finditer(text):
        positions.append(match.start())
        values.append(heading_text(match.group("body")))

    return positions, values


def heading_before(
    positions: list[int],
    values: list[str],
    position: int,
) -> str:
    index = bisect.bisect_right(positions, position) - 1

    if index < 0:
        return ""

    return values[index]


def substantial_example(
    source: str,
    heading: str,
) -> bool:
    normalized = heading.casefold()

    example_heading = any(
        marker in normalized
        for marker in (
            "使用例",
            "実行例",
            "完全な例",
            "example",
            "usage",
        )
    )

    if not example_heading:
        return False

    nonempty_lines = [
        line
        for line in source.splitlines()
        if line.strip()
    ]

    return len(nonempty_lines) >= 4


def nearby_marker(
    text: str,
    position: int,
    marker: str,
) -> bool:
    before = text[max(0, position - 600):position]

    return marker in before


def wants_line_numbers(
    text: str,
    position: int,
    pre_attrs: str,
    code_attrs: str,
    source: str,
    heading: str,
) -> bool:
    attrs = f"{pre_attrs} {code_attrs}"

    if nearby_marker(
        text,
        position,
        "<!-- nim-no-line-numbers -->",
    ):
        return False

    if nearby_marker(
        text,
        position,
        "<!-- nim-line-numbers -->",
    ):
        return True

    if has_class(attrs, "line-numbers"):
        return True

    if has_class(attrs, "runnable"):
        return True

    return substantial_example(source, heading)


def compiler_cache_path() -> Path:
    nim_version = subprocess.run(
        ["nim", "--version"],
        check=True,
        text=True,
        capture_output=True,
    ).stdout

    digest = hashlib.sha256(
        HIGHLIGHTER_SOURCE.read_bytes()
        + nim_version.encode("utf-8")
    ).hexdigest()[:20]

    suffix = ".exe" if os.name == "nt" else ""

    return (
        Path(tempfile.gettempdir())
        / f"nim-acl-doc-highlighter-{digest}{suffix}"
    )


def ensure_highlighter() -> Path:
    binary = compiler_cache_path()

    if binary.exists():
        return binary

    temporary = binary.with_name(binary.name + ".building")

    if temporary.exists():
        temporary.unlink()

    subprocess.run(
        [
            "nim",
            "c",
            "-d:release",
            "--hints:off",
            "--warnings:off",
            f"--out:{temporary}",
            str(HIGHLIGHTER_SOURCE),
        ],
        cwd=REPO_ROOT,
        check=True,
    )

    temporary.replace(binary)

    return binary


def highlight_sources(sources: list[str]) -> list[str]:
    if not sources:
        return []

    binary = ensure_highlighter()

    encoded_input = "\n".join(
        base64.b64encode(
            source.encode("utf-8")
        ).decode("ascii")
        for source in sources
    ) + "\n"

    completed = subprocess.run(
        [str(binary)],
        input=encoded_input,
        text=True,
        capture_output=True,
        check=True,
    )

    encoded_output = completed.stdout.splitlines()

    if len(encoded_output) != len(sources):
        raise RuntimeError(
            "Nim highlighter result count mismatch: "
            f"expected {len(sources)}, "
            f"received {len(encoded_output)}\n"
            f"stderr:\n{completed.stderr}"
        )

    return [
        base64.b64decode(value).decode("utf-8")
        if value
        else ""
        for value in encoded_output
    ]


def add_line_markup(
    highlighted: str,
    source: str,
) -> str:
    lines = highlighted.split("\n")

    if (
        source.endswith("\n")
        and lines
        and lines[-1] == ""
    ):
        lines.pop()

    return "\n".join(
        f'<span class="code-line">{line}</span>'
        for line in lines
    )


def inject_style(text: str) -> str:
    if STYLE_ID in text:
        return text

    lower = text.lower()
    index = lower.find("</head>")

    if index >= 0:
        return (
            text[:index]
            + "\n"
            + STYLE
            + "\n"
            + text[index:]
        )

    return STYLE + "\n" + text



def extract_code_parts(
    match: re.Match[str],
) -> tuple[str, str, str]:
    """Return pre attrs, code attrs, and escaped source body.

    Generated Nim documentation may use either:

        <pre class="language-nim">...</pre>

    or:

        <pre><code class="language-nim">...</code></pre>
    """
    pre_attrs = match.group("pre_attrs") or ""
    inner = match.group("inner")

    code_match = CODE_WRAPPER_RE.match(inner)

    if code_match is None:
        return pre_attrs, "", inner

    return (
        pre_attrs,
        code_match.group("code_attrs") or "",
        code_match.group("body"),
    )

def collect_file(path: Path) -> FileRecord | None:
    text = path.read_text(encoding="utf-8")

    if "<pre" not in text.lower():
        return None

    positions, headings = heading_positions(text)
    blocks: list[CodeBlock] = []

    for match in CODE_BLOCK_RE.finditer(text):
        pre_attrs, code_attrs, source_body = (
            extract_code_parts(match)
        )

        if not (
            is_nim_code(code_attrs)
            or is_nim_code(pre_attrs)
        ):
            continue

        if (
            has_class(pre_attrs, "nim-acl-highlighted")
            or has_class(code_attrs, "nim-acl-highlighted")
        ):
            continue

        source = html.unescape(source_body)
        heading = heading_before(
            positions,
            headings,
            match.start(),
        )

        blocks.append(
            CodeBlock(
                path=path,
                start=match.start(),
                end=match.end(),
                pre_attrs=pre_attrs,
                code_attrs=code_attrs,
                source=source,
                line_numbers=wants_line_numbers(
                    text,
                    match.start(),
                    pre_attrs,
                    code_attrs,
                    source,
                    heading,
                ),
            )
        )

    if not blocks:
        return None

    return FileRecord(
        path=path,
        text=text,
        blocks=blocks,
    )


def process_roots(
    roots: list[Path],
) -> tuple[int, int, int]:
    records: list[FileRecord] = []

    for root in roots:
        if not root.exists():
            continue

        for path in sorted(root.rglob("*.html")):
            record = collect_file(path)

            if record is not None:
                records.append(record)

    all_blocks = [
        block
        for record in records
        for block in record.blocks
    ]

    highlighted = highlight_sources(
        [block.source for block in all_blocks]
    )

    highlighted_index = 0
    numbered = 0

    for record in records:
        replacements: list[tuple[int, int, str]] = []

        for block in record.blocks:
            highlighted_body = highlighted[highlighted_index]
            highlighted_index += 1

            pre_classes = [
                "nim-code",
                "nim-acl-highlighted",
            ]

            if block.line_numbers:
                pre_classes.append("nim-line-numbers")
                numbered += 1
                highlighted_body = add_line_markup(
                    highlighted_body,
                    block.source,
                )

            pre_attrs = add_classes(
                block.pre_attrs,
                pre_classes,
            )

            code_attrs = add_classes(
                block.code_attrs,
                [
                    "language-nim",
                    "nim-acl-highlighted",
                ],
            )

            replacement = (
                f"<pre{pre_attrs}>"
                f"<code{code_attrs}>"
                f"{highlighted_body}"
                f"</code></pre>"
            )

            replacements.append(
                (
                    block.start,
                    block.end,
                    replacement,
                )
            )

        new_text = record.text

        for start, end, replacement in reversed(replacements):
            new_text = (
                new_text[:start]
                + replacement
                + new_text[end:]
            )

        new_text = inject_style(new_text)

        record.path.write_text(
            new_text,
            encoding="utf-8",
        )

    return len(records), len(all_blocks), numbered


def self_test() -> None:
    with tempfile.TemporaryDirectory(
        prefix="nim-acl-doc-highlight-test-"
    ) as temporary_directory:
        root = Path(temporary_directory)

        fixture = root / "fixture.html"

        fixture.write_text(
            """<!doctype html>
<html>
<head><title>fixture</title></head>
<body>
<h2>使用例</h2>
<!-- nim-line-numbers -->
<pre><code class="language-nim">import std/strutils
let value = 42
proc twice(x: int): int =
  x * 2
# comment
doAssert twice(value) == 84
</code></pre>
</body>
</html>
""",
            encoding="utf-8",
        )

        files, blocks, numbered = process_roots([root])

        assert files == 1
        assert blocks == 1
        assert numbered == 1

        result = fixture.read_text(encoding="utf-8")

        assert STYLE_ID in result
        assert "nim-acl-highlighted" in result
        assert "nim-line-numbers" in result
        assert 'class="code-line"' in result
        assert (
            '<span class="tok-keyword">let</span>'
            in result
        )
        assert (
            '<span class="tok-keyword">proc</span>'
            in result
        )
        assert (
            '<span class="tok-number">42</span>'
            in result
        )
        assert (
            '<span class="tok-comment"># comment</span>'
            in result
        )

        before_second_run = result
        process_roots([root])
        after_second_run = fixture.read_text(
            encoding="utf-8"
        )

        assert before_second_run == after_second_run

    print("nim documentation highlighter self-test: OK")


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Apply Nim's official highlite tokenizer "
            "to generated Nim-ACL HTML documentation."
        )
    )

    parser.add_argument(
        "roots",
        nargs="*",
        type=Path,
        help=(
            "HTML roots to process. Defaults to "
            "document_ja and document_en."
        ),
    )

    parser.add_argument(
        "--self-test",
        action="store_true",
    )

    return parser.parse_args()


def main() -> None:
    arguments = parse_arguments()

    if arguments.self_test:
        self_test()
        return

    roots = arguments.roots or [
        REPO_ROOT / "document_ja",
        REPO_ROOT / "document_en",
    ]

    files, blocks, numbered = process_roots(
        [
            root
            if root.is_absolute()
            else REPO_ROOT / root
            for root in roots
        ]
    )

    print(
        "Nim documentation highlighting: "
        f"files={files} "
        f"blocks={blocks} "
        f"numbered={numbered}"
    )


if __name__ == "__main__":
    main()
