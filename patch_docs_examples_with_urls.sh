#!/usr/bin/env bash
set -euo pipefail

if [ ! -f tools/generate_document.py ] || [ ! -f document_ja/lib/main.css ]; then
  echo "error: please run from Nim-ACL repository root"
  exit 1
fi

cat > tools/generate_document.py <<'PY'
#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path
import html
import os
import re
import sys
import tomllib
from typing import Any


TOOL_DIR = Path(__file__).resolve().parent
ROOT = TOOL_DIR.parent
EXAMPLE_DIR = ROOT / "test" / "example"
PROBLEMS_TOML = EXAMPLE_DIR / "problems.toml"


def rel_link(from_path: Path, to_path: Path) -> str:
    return os.path.relpath(to_path, from_path.parent).replace(os.sep, "/")


def flatten_toml(data: dict, prefix: str = "") -> dict[str, str]:
    result: dict[str, str] = {}

    for key, value in data.items():
        full_key = f"{prefix}.{key}" if prefix else key
        if isinstance(value, dict):
            result.update(flatten_toml(value, full_key))
        else:
            result[full_key] = str(value)

    return result


def load_keywords(doc_dir: Path) -> dict[str, str]:
    path = doc_dir / "keywords.toml"
    if not path.exists():
        return {}

    with path.open("rb") as f:
        data = tomllib.load(f)

    keywords = flatten_toml(data)

    for key, value in list(keywords.items()):
        keywords.setdefault(key.split(".")[-1], value)

    return keywords


def default_keyword_replacements(lang: str) -> dict[str, str]:
    if lang == "ja":
        return {
            "keyword.constraints": '<h4 class="doc-keyword">制約</h4>',
            "keyword.complexity": '<h4 class="doc-keyword">計算量</h4>',
        }

    return {
        "keyword.constraints": '<h4 class="doc-keyword">Constraints</h4>',
        "keyword.complexity": '<h4 class="doc-keyword">Complexity</h4>',
    }


def load_problem_metadata() -> dict[str, dict[str, str]]:
    """Load example metadata from test/example/problems.toml.

    This is intentionally flexible because old ACL-derived problems.toml
    files have changed shape over time.
    """
    if not PROBLEMS_TOML.exists():
        return {}

    with PROBLEMS_TOML.open("rb") as f:
        data = tomllib.load(f)

    result: dict[str, dict[str, str]] = {}

    def normalize_key(k: str) -> str:
        return k.strip().replace(".", "_")

    def walk(obj: Any, path: list[str]) -> None:
        if isinstance(obj, dict):
            # If this table has a URL, treat the current path as a candidate key.
            url = obj.get("url") or obj.get("problem") or obj.get("link")
            if isinstance(url, str) and path:
                key = normalize_key(path[-1])
                result.setdefault(key, {})["url"] = url

                # Also support example_xxx and full dotted paths.
                result.setdefault(normalize_key(".".join(path)), {})["url"] = url
                result.setdefault(normalize_key(f"example_{path[-1]}"), {})["url"] = url

            for k, v in obj.items():
                walk(v, path + [str(k)])

    walk(data, [])

    # Also support flat values such as segtree_practice = "https://..."
    flat = flatten_toml(data)
    for k, v in flat.items():
        if v.startswith("http://") or v.startswith("https://"):
            parts = k.split(".")
            for candidate in [parts[-1], ".".join(parts), f"example_{parts[-1]}"]:
                result.setdefault(normalize_key(candidate), {})["url"] = v

    return result


PROBLEM_METADATA = load_problem_metadata()


def find_example_file(name: str) -> Path | None:
    key = name.strip()
    key_under = key.replace(".", "_")

    candidates = [
        EXAMPLE_DIR / f"example_{key}.nim",
        EXAMPLE_DIR / f"{key}.nim",
        EXAMPLE_DIR / f"{key_under}.nim",
        EXAMPLE_DIR / f"example_{key_under}.nim",
    ]

    for path in candidates:
        if path.exists():
            return path

    if EXAMPLE_DIR.exists():
        for path in sorted(EXAMPLE_DIR.rglob("*.nim")):
            stem = path.stem
            if stem in {key, f"example_{key}", key_under, f"example_{key_under}"}:
                return path

    return None


def strip_example_metadata(text: str) -> str:
    text = re.sub(r'^\s*#\s*verification-helper:.*?\n', '', text, flags=re.M)
    text = re.sub(r'^\s*discard\s+""".*?"""\s*\n', '', text, flags=re.S)
    return text.strip("\n")


def example_url_for(name: str, path: Path | None) -> str | None:
    keys = [name, name.replace(".", "_")]

    if path is not None:
        keys += [
            path.stem,
            path.stem.replace("example_", "", 1),
        ]

    for key in keys:
        meta = PROBLEM_METADATA.get(key.replace(".", "_"))
        if meta and "url" in meta:
            return meta["url"]

    return None


def render_example(name: str, lang: str) -> str:
    """Render @{example.foo} as an Ace-powered Nim code block with source URL."""
    file_key = name.split(":", 1)[0].strip()

    path = find_example_file(file_key)
    if path is None:
        label = "使用例が見つかりません" if lang == "ja" else "Example not found"
        escaped = html.escape(name)
        return f'<div class="warning">{label}: <code>{escaped}</code></div>'

    code = path.read_text(encoding="utf-8")
    code = strip_example_metadata(code)

    escaped_code = html.escape(code)

    url = example_url_for(file_key, path)
    if url:
        escaped_url = html.escape(url)
        caption = (
            f'<p class="example-caption">'
            f'AC code of <a href="{escaped_url}">{escaped_url}</a>'
            f'</p>\n'
        )
    else:
        caption = ""

    return f'{caption}<div class="sample-code">{escaped_code}</div>'


def replace_placeholders(text: str, keywords: dict[str, str], lang: str) -> str:
    fixed = default_keyword_replacements(lang)

    def repl(m: re.Match[str]) -> str:
        key = m.group(1).strip()

        if key.startswith("example."):
            return render_example(key[len("example."):], lang)

        if key in fixed:
            return fixed[key]

        if key in keywords:
            return keywords[key]

        short_key = key.split(".")[-1]
        if short_key in keywords:
            return keywords[short_key]

        return m.group(0)

    return re.sub(r"@\{([^}]+)\}", repl, text)


def title_from_markdown(text: str) -> str:
    for line in text.splitlines():
        if line.startswith("# "):
            return line[2:].strip()
    return "Nim-ACL"


def rewrite_markdown_links(body: str) -> str:
    return re.sub(
        r'href="([^"]+)\.md(#.*?)?"',
        lambda m: f'href="{m.group(1)}.html{m.group(2) or ""}"',
        body,
    )


def convert_code_blocks_to_ace(body: str) -> str:
    def repl(m: re.Match[str]) -> str:
        code = m.group(1)
        return f'<div class="sample-code">{code}</div>'

    return re.sub(
        r'<pre><code(?: class="[^"]*")?>(.*?)</code></pre>',
        repl,
        body,
        flags=re.S | re.I,
    )


def render_markdown(text: str) -> str:
    try:
        import markdown
    except ModuleNotFoundError:
        print(
            "error: Python package 'markdown' is required.\n"
            "Install it in a virtual environment:\n"
            "  python3 -m venv .venv\n"
            "  source .venv/bin/activate\n"
            "  python -m pip install -r tools/requirements.txt\n"
            "  python tools/generate_document.py",
            file=sys.stderr,
        )
        raise

    body = markdown.markdown(
        text,
        extensions=[
            "fenced_code",
            "tables",
            "toc",
            "sane_lists",
        ],
        output_format="html5",
    )

    body = rewrite_markdown_links(body)
    body = convert_code_blocks_to_ace(body)
    return body


def render_page(
    template: str,
    *,
    lang: str,
    title: str,
    css_path: str,
    index_path: str,
    logo_path: str,
    body: str,
) -> str:
    return (
        template
        .replace("@{lang}", lang)
        .replace("@{title}", html.escape(title))
        .replace("@{css_path}", css_path)
        .replace("@{index_path}", index_path)
        .replace("@{logo_path}", logo_path)
        .replace("@{body}", body)
    )


def convert_one(
    md_path: Path,
    doc_dir: Path,
    lang: str,
    template: str,
    keywords: dict[str, str],
) -> Path:
    raw = md_path.read_text(encoding="utf-8")
    raw = replace_placeholders(raw, keywords, lang)

    title = title_from_markdown(raw)
    body = render_markdown(raw)

    html_path = md_path.with_suffix(".html")

    css_path = rel_link(html_path, doc_dir / "lib" / "main.css")
    index_path = rel_link(html_path, doc_dir / "index.html")
    logo_path = rel_link(html_path, doc_dir / "lib" / "logo-crown.png")

    page = render_page(
        template,
        lang=lang,
        title=title,
        css_path=css_path,
        index_path=index_path,
        logo_path=logo_path,
        body=body,
    )

    html_path.write_text(page, encoding="utf-8")
    return html_path


def convert_doc_dir(dirname: str, lang: str, template: str) -> int:
    doc_dir = ROOT / dirname
    if not doc_dir.exists():
        print(f"skip: {dirname} does not exist")
        return 0

    keywords = load_keywords(doc_dir)

    count = 0
    for md_path in sorted(doc_dir.rglob("*.md")):
        rel_parts = md_path.relative_to(doc_dir).parts
        if "lib" in rel_parts:
            continue

        html_path = convert_one(md_path, doc_dir, lang, template, keywords)
        print(f"write: {html_path.relative_to(ROOT)}")
        count += 1

    print(f"{dirname}: {count} files")
    return count


def main() -> None:
    template_path = TOOL_DIR / "template.html"
    if not template_path.exists():
        raise FileNotFoundError(f"template not found: {template_path}")

    template = template_path.read_text(encoding="utf-8")

    total = 0
    total += convert_doc_dir("document_ja", "ja", template)
    total += convert_doc_dir("document_en", "en", template)

    print(f"total: {total} files")


if __name__ == "__main__":
    main()
PY

# Replace duplicated old Ace CSS blocks with one compact final block by appending an override.
cat >> document_ja/lib/main.css <<'CSS'

/* Final Ace code sample tuning */

.example-caption {
  margin: 1.2em 0 0.4em;
  font-size: 1.05rem;
}

.example-caption a {
  font-weight: 500;
}

.sample-code {
  width: 100%;
  margin: 0.75em 0 1.25em;
  border: 1px solid #e5e5e5;
  background: #ffffff;
  font-size: 13px;
  line-height: 1.45;
}

.sample-code .ace_gutter {
  background: #f2f2f2;
  color: #777;
  border-right: 1px solid #e5e5e5;
}

.sample-code .ace_content {
  background: #ffffff;
}

.sample-code .ace_marker-layer .ace_active-line,
.sample-code .ace_gutter-active-line {
  background: transparent;
}

.sample-code .ace_print-margin {
  display: none;
}

.sample-code .ace_cursor {
  display: none !important;
}
CSS

cp document_ja/lib/main.css document_en/lib/main.css

echo "done."
echo
echo "Next:"
echo "  source .venv/bin/activate"
echo "  python tools/generate_document.py"
