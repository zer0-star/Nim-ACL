#!/usr/bin/env python3

from __future__ import annotations

import argparse
import os
from pathlib import Path
import re
import sys
import unicodedata


REPO_ROOT = Path(__file__).resolve().parent.parent

ROOTS = [
    REPO_ROOT / "document_ja",
    REPO_ROOT / "document_en",
]

RELATED_HEADINGS = {
    "関連資料",
    "参考資料",
    "参考文献",
    "関連リンク",
    "related resources",
    "related links",
    "references",
    "further reading",
}

HEADING_RE = re.compile(
    r"^(?P<marks>#{1,6})\s+(?P<title>.*?)\s*$"
)

BULLET_RE = re.compile(
    r"^(?P<prefix>\s*[-*+]\s+)(?P<body>.*?)(?P<ending>\r?\n)?$"
)

FENCE_RE = re.compile(
    r"^\s*(?P<fence>`{3,}|~{3,})"
)

MARKDOWN_LINK_RE = re.compile(
    r"\[[^\]]+\]\([^)]+\)"
)

HTML_LINK_RE = re.compile(
    r"<a\s+[^>]*href\s*=",
    re.IGNORECASE,
)

ABSOLUTE_URL_RE = re.compile(
    r"(?:https?://|<https?://)",
    re.IGNORECASE,
)


def normalize(value: str) -> str:
    value = unicodedata.normalize("NFKC", value)
    value = value.strip()
    value = value.strip("`*_ ")
    value = value.rstrip("。.")
    value = re.sub(r"\s+", " ", value)

    return value.casefold()


EXTERNAL_REPLACEMENTS = {
    normalize("AtCoder Algorithm Lectures"):
        "[AtCoder Algorithm Lectures]"
        "(https://info.atcoder.jp/entry/algorithm_lectures/index)",

    normalize("AtCoder Algorithm Lectures 公式一覧"):
        "[AtCoder Algorithm Lectures 公式一覧]"
        "(https://info.atcoder.jp/entry/algorithm_lectures/index)",

    normalize("Library Checker: Static RMQ"):
        "[Library Checker: Static RMQ]"
        "(https://judge.yosupo.jp/problem/staticrmq)",

    normalize("Persistent data structures"):
        "[cp-algorithms: Persistent Segment Tree]"
        "(https://cp-algorithms.com/data_structures/"
        "segment_tree.html#preserving-the-history-of-its-values-persistent-segment-tree)",

    normalize("Library Checker の persistent / range query 問題"):
        "[Library Checker problem list]"
        "(https://judge.yosupo.jp/problems)",

    normalize("Library Checker persistent / range query problems"):
        "[Library Checker problem list]"
        "(https://judge.yosupo.jp/problems)",

    normalize("AtCoder ABC の mex 問題"):
        "[AtCoder ABC330 E - Mex and Update]"
        "(https://atcoder.jp/contests/abc330/tasks/abc330_e)",

    normalize("AtCoder ABC mex problems"):
        "[AtCoder ABC330 E - Mex and Update]"
        "(https://atcoder.jp/contests/abc330/tasks/abc330_e)",

    normalize("Codeforces の dynamic mex 問題"):
        "[Codeforces 1294D - MEX maximizing]"
        "(https://codeforces.com/problemset/problem/1294/D)",

    normalize("Codeforces dynamic mex problems"):
        "[Codeforces 1294D - MEX maximizing]"
        "(https://codeforces.com/problemset/problem/1294/D)",

    normalize("AtCoder ABC の Fenwick Tree / sweep line 問題"):
        "[AtCoder Library Practice Contest B - Fenwick Tree]"
        "(https://atcoder.jp/contests/practice2/tasks/practice2_b)"
        " / "
        "[AtCoder ABC036 C - 座圧]"
        "(https://atcoder.jp/contests/abc036/tasks/abc036_c)",

    normalize("cp-algorithms: Coordinate Compression を用いる offline algorithm"):
        "[AtCoder ABC036 C - 座圧]"
        "(https://atcoder.jp/contests/abc036/tasks/abc036_c)",

    normalize("Heavy-Light Decomposition"):
        "[cp-algorithms: Heavy-Light Decomposition]"
        "(https://cp-algorithms.com/graph/hld.html)",

    normalize("Fenwick Tree / Segment Tree"):
        "[AC Library: Fenwick Tree]"
        "(https://atcoder.github.io/ac-library/production/document_en/fenwicktree.html)"
        " / "
        "[AC Library: Segment Tree]"
        "(https://atcoder.github.io/ac-library/production/document_en/segtree.html)",
}


def first_heading(path: Path) -> str | None:
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return None

    in_fence = False
    fence = ""

    for line in text.splitlines():
        fence_match = FENCE_RE.match(line)

        if fence_match is not None:
            current = fence_match.group("fence")

            if not in_fence:
                in_fence = True
                fence = current
            elif line.lstrip().startswith(fence):
                in_fence = False
                fence = ""

            continue

        if in_fence:
            continue

        match = HEADING_RE.match(line)

        if match is not None:
            return match.group("title").strip()

    return None


def build_internal_index(root: Path) -> dict[str, list[Path]]:
    result: dict[str, list[Path]] = {}

    for path in sorted(root.rglob("*.md")):
        keys = {
            normalize(path.stem),
            normalize(path.stem.replace("_", " ")),
            normalize(path.stem.replace("-", " ")),
        }

        title = first_heading(path)

        if title:
            keys.add(normalize(title))

        for key in keys:
            if not key:
                continue

            result.setdefault(key, []).append(path)

    return result


def relative_html_link(source: Path, target: Path) -> str:
    target_html = target.with_suffix(".html")
    relative = Path(
        os.path.relpath(
            target_html,
            start=source.parent,
        )
    ).as_posix()

    if not relative.startswith("."):
        relative = "./" + relative

    return relative


def already_linked(body: str) -> bool:
    return bool(
        MARKDOWN_LINK_RE.search(body)
        or HTML_LINK_RE.search(body)
        or ABSOLUTE_URL_RE.search(body)
    )


def find_internal_target(
    source: Path,
    body: str,
    internal_index: dict[str, list[Path]],
) -> Path | None:
    key = normalize(body)
    candidates = [
        candidate
        for candidate in internal_index.get(key, [])
        if candidate != source
    ]

    if len(candidates) == 1:
        return candidates[0]

    return None


def process_file(
    path: Path,
    internal_index: dict[str, list[Path]],
    apply_changes: bool,
) -> tuple[int, list[tuple[int, str]]]:
    original = path.read_text(encoding="utf-8")
    lines = original.splitlines(keepends=True)

    output: list[str] = []
    changes = 0
    unlinked: list[tuple[int, str]] = []

    in_fence = False
    fence = ""
    related_level: int | None = None

    for line_number, line in enumerate(lines, start=1):
        fence_match = FENCE_RE.match(line)

        if fence_match is not None:
            current = fence_match.group("fence")

            if not in_fence:
                in_fence = True
                fence = current
            elif line.lstrip().startswith(fence):
                in_fence = False
                fence = ""

            output.append(line)
            continue

        if in_fence:
            output.append(line)
            continue

        heading_match = HEADING_RE.match(
            line.rstrip("\r\n")
        )

        if heading_match is not None:
            level = len(heading_match.group("marks"))
            title = normalize(
                heading_match.group("title")
            )

            if title in {
                normalize(value)
                for value in RELATED_HEADINGS
            }:
                related_level = level
            elif (
                related_level is not None
                and level <= related_level
            ):
                related_level = None

            output.append(line)
            continue

        if related_level is None:
            output.append(line)
            continue

        bullet_match = BULLET_RE.match(line)

        if bullet_match is None:
            output.append(line)
            continue

        body = bullet_match.group("body").strip()

        if not body or already_linked(body):
            output.append(line)
            continue

        replacement: str | None = None

        target = find_internal_target(
            path,
            body,
            internal_index,
        )

        if target is not None:
            replacement = (
                f"[{body}]"
                f"({relative_html_link(path, target)})"
            )
        else:
            replacement = EXTERNAL_REPLACEMENTS.get(
                normalize(body)
            )

        if replacement is None:
            unlinked.append((line_number, body))
            output.append(line)
            continue

        changes += 1

        ending = bullet_match.group("ending") or ""

        output.append(
            bullet_match.group("prefix")
            + replacement
            + ending
        )

    updated = "".join(output)

    if apply_changes and updated != original:
        path.write_text(
            updated,
            encoding="utf-8",
        )

    return changes, unlinked


def run(apply_changes: bool) -> tuple[int, list[str]]:
    total_changes = 0
    remaining: list[str] = []

    for root in ROOTS:
        if not root.exists():
            continue

        internal_index = build_internal_index(root)

        for path in sorted(root.rglob("*.md")):
            changes, unlinked = process_file(
                path,
                internal_index,
                apply_changes,
            )

            total_changes += changes

            for line_number, body in unlinked:
                relative = path.relative_to(REPO_ROOT)
                remaining.append(
                    f"{relative}:{line_number}\t{body}"
                )

    return total_changes, remaining


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--audit-only",
        action="store_true",
        help="Do not modify Markdown files.",
    )

    return parser.parse_args()


def main() -> None:
    arguments = parse_arguments()

    changes, remaining = run(
        apply_changes=not arguments.audit_only
    )

    print(f"RELATED_LINKS_ADDED={changes}")
    print(f"RELATED_UNLINKED={len(remaining)}")

    if remaining:
        print("RELATED_UNLINKED_ITEMS_START")

        for item in remaining:
            print(item)

        print("RELATED_UNLINKED_ITEMS_END")


if __name__ == "__main__":
    main()
