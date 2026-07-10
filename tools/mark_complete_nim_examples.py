#!/usr/bin/env python3

from __future__ import annotations

from pathlib import Path
import re


REPO_ROOT = Path(__file__).resolve().parent.parent

HEADING_RE = re.compile(
    r"^\s*#{1,6}\s+(?P<title>.+?)\s*$"
)

FENCE_RE = re.compile(
    r"^(?P<indent>\s*)"
    r"(?P<fence>`{3,}|~{3,})"
    r"(?P<info>.*)$"
)

LINE_MARKER = "<!-- nim-line-numbers -->"
NO_LINE_MARKER = "<!-- nim-no-line-numbers -->"


def is_usage_heading(title: str) -> bool:
    normalized = title.casefold()

    return any(
        marker in normalized
        for marker in (
            "使用例",
            "実行例",
            "完全な例",
            "example",
            "usage",
        )
    )


def is_nim_info(info: str) -> bool:
    normalized = info.strip().casefold()

    return (
        normalized == "nim"
        or normalized.startswith("nim ")
        or "language-nim" in normalized
    )


def mark_file(path: Path) -> int:
    original = path.read_text(encoding="utf-8")
    lines = original.splitlines(keepends=True)

    output: list[str] = []
    heading = ""
    index = 0
    added = 0

    while index < len(lines):
        line = lines[index]

        heading_match = HEADING_RE.match(
            line.rstrip("\r\n")
        )

        if heading_match is not None:
            heading = heading_match.group("title")
            output.append(line)
            index += 1
            continue

        fence_match = FENCE_RE.match(
            line.rstrip("\r\n")
        )

        if (
            fence_match is None
            or not is_nim_info(fence_match.group("info"))
        ):
            output.append(line)
            index += 1
            continue

        fence = fence_match.group("fence")
        block = [line]
        code_lines: list[str] = []
        index += 1

        while index < len(lines):
            current = lines[index]
            block.append(current)

            stripped = current.lstrip()

            if stripped.startswith(fence):
                index += 1
                break

            code_lines.append(
                current.rstrip("\r\n")
            )
            index += 1

        substantial = (
            is_usage_heading(heading)
            and len(
                [
                    code_line
                    for code_line in code_lines
                    if code_line.strip()
                ]
            ) >= 4
        )

        previous_nonempty = ""

        for previous in reversed(output):
            if previous.strip():
                previous_nonempty = previous.strip()
                break

        already_marked = previous_nonempty in {
            LINE_MARKER,
            NO_LINE_MARKER,
        }

        if substantial and not already_marked:
            output.append(
                fence_match.group("indent")
                + LINE_MARKER
                + "\n"
            )
            added += 1

        output.extend(block)

    updated = "".join(output)

    if updated != original:
        path.write_text(updated, encoding="utf-8")

    return added


def main() -> None:
    total = 0
    changed_files = 0

    for root_name in ("document_ja", "document_en"):
        root = REPO_ROOT / root_name

        if not root.exists():
            continue

        for path in sorted(root.rglob("*.md")):
            added = mark_file(path)

            if added:
                total += added
                changed_files += 1

    print(
        "Marked substantial Nim examples: "
        f"files={changed_files} blocks={total}"
    )


if __name__ == "__main__":
    main()
