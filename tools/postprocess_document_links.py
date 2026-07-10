#!/usr/bin/env python3

from __future__ import annotations

import argparse
import html
from pathlib import Path
import re
from urllib.parse import urlsplit


REPO_ROOT = Path(__file__).resolve().parent.parent

ANCHOR_RE = re.compile(
    r"<a\b(?P<attrs>[^>]*)>",
    re.IGNORECASE,
)

ATTRIBUTE_TEMPLATE = (
    r"""(?<![-:\w]){name}\s*=\s*"""
    r"""(?P<quote>["'])(?P<value>.*?)(?P=quote)"""
)


def attribute_match(
    attrs: str,
    name: str,
) -> re.Match[str] | None:
    return re.search(
        ATTRIBUTE_TEMPLATE.format(
            name=re.escape(name)
        ),
        attrs,
        flags=re.IGNORECASE | re.DOTALL,
    )


def get_attribute(
    attrs: str,
    name: str,
) -> str | None:
    match = attribute_match(attrs, name)

    if match is None:
        return None

    return html.unescape(match.group("value"))


def set_attribute(
    attrs: str,
    name: str,
    value: str,
) -> str:
    match = attribute_match(attrs, name)
    replacement = f'{name}="{value}"'

    if match is None:
        return attrs.rstrip() + " " + replacement

    return (
        attrs[:match.start()]
        + replacement
        + attrs[match.end():]
    )


def is_external(href: str) -> bool:
    parsed = urlsplit(href)

    if parsed.scheme not in {"http", "https"}:
        return False

    host = (parsed.hostname or "").lower()

    if host == "nim-acl.github.io":
        return False

    return True


def process_anchor(
    match: re.Match[str],
) -> str:
    attrs = match.group("attrs")
    href = get_attribute(attrs, "href")

    if href is None or not is_external(href):
        return match.group(0)

    attrs = set_attribute(
        attrs,
        "target",
        "_blank",
    )

    current_rel = get_attribute(attrs, "rel") or ""

    rel_tokens = [
        token
        for token in current_rel.split()
        if token
    ]

    lower_tokens = {
        token.casefold()
        for token in rel_tokens
    }

    if "noopener" not in lower_tokens:
        rel_tokens.append("noopener")

    attrs = set_attribute(
        attrs,
        "rel",
        " ".join(rel_tokens),
    )

    return f"<a{attrs}>"


def process_file(path: Path) -> int:
    original = path.read_text(encoding="utf-8")
    changed_links = 0

    def replace(match: re.Match[str]) -> str:
        nonlocal changed_links

        updated = process_anchor(match)

        if updated != match.group(0):
            changed_links += 1

        return updated

    updated = ANCHOR_RE.sub(
        replace,
        original,
    )

    if updated != original:
        path.write_text(
            updated,
            encoding="utf-8",
        )

    return changed_links


def process_roots(roots: list[Path]) -> tuple[int, int]:
    changed_files = 0
    changed_links = 0

    for root in roots:
        if not root.exists():
            continue

        for path in sorted(root.rglob("*.html")):
            count = process_file(path)

            if count:
                changed_files += 1
                changed_links += count

    return changed_files, changed_links


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "roots",
        nargs="*",
        type=Path,
    )

    return parser.parse_args()


def main() -> None:
    arguments = parse_arguments()

    roots = arguments.roots or [
        REPO_ROOT / "document_ja",
        REPO_ROOT / "document_en",
    ]

    roots = [
        root
        if root.is_absolute()
        else REPO_ROOT / root
        for root in roots
    ]

    files, links = process_roots(roots)

    print(
        "External-link postprocessing: "
        f"files={files} links={links}"
    )


if __name__ == "__main__":
    main()
