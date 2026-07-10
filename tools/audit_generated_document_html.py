#!/usr/bin/env python3

from __future__ import annotations

from html.parser import HTMLParser
from pathlib import Path
import sys
from urllib.parse import urlsplit


REPO_ROOT = Path(__file__).resolve().parent.parent


def class_tokens(attrs: dict[str, str | None]) -> set[str]:
    value = attrs.get("class") or ""

    return {
        token.casefold()
        for token in value.split()
    }


def is_external(href: str) -> bool:
    parsed = urlsplit(href)

    if parsed.scheme not in {"http", "https"}:
        return False

    host = (parsed.hostname or "").casefold()

    return host != "nim-acl.github.io"


def is_nim_class_set(classes: set[str]) -> bool:
    for token in classes:
        normalized = token.casefold().replace("_", "-")

        if normalized in {
            "nim",
            "lang-nim",
            "language-nim",
            "langnim",
        }:
            return True

        if (
            normalized.startswith("language-")
            and normalized.endswith("nim")
        ):
            return True

    return False


class AuditParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(
            convert_charrefs=False
        )

        self.highlighted_blocks = 0
        self.numbered_blocks = 0
        self.token_spans = 0
        self.code_lines = 0
        self.nim_code_blocks = 0

        self.external_links = 0
        self.secure_external_links = 0
        self.insecure_external_links: list[str] = []

    def handle_starttag(
        self,
        tag: str,
        attrs_list: list[tuple[str, str | None]],
    ) -> None:
        attrs = {
            key.casefold(): value
            for key, value in attrs_list
        }

        classes = class_tokens(attrs)
        tag = tag.casefold()

        if tag == "pre":
            if "nim-acl-highlighted" in classes:
                self.highlighted_blocks += 1

            if "nim-line-numbers" in classes:
                self.numbered_blocks += 1

            if (
                "nim-code" in classes
                or is_nim_class_set(classes)
            ):
                self.nim_code_blocks += 1

        elif tag == "code":
            if is_nim_class_set(classes):
                self.nim_code_blocks += 1

        elif tag == "span":
            if any(
                token.startswith("tok-")
                for token in classes
            ):
                self.token_spans += 1

            if "code-line" in classes:
                self.code_lines += 1

        elif tag == "a":
            href = attrs.get("href") or ""

            if not is_external(href):
                return

            self.external_links += 1

            target = (
                attrs.get("target") or ""
            ).casefold()

            rel = {
                token.casefold()
                for token in (
                    attrs.get("rel") or ""
                ).split()
            }

            if (
                target == "_blank"
                and "noopener" in rel
            ):
                self.secure_external_links += 1
            else:
                self.insecure_external_links.append(
                    href
                )


def count_markers() -> int:
    result = 0

    for root_name in (
        "document_ja",
        "document_en",
    ):
        root = REPO_ROOT / root_name

        if not root.exists():
            continue

        for path in root.rglob("*.md"):
            text = path.read_text(
                encoding="utf-8"
            )

            result += text.count(
                "<!-- nim-line-numbers -->"
            )

    return result


def main() -> None:
    parser = AuditParser()

    html_files = 0

    for root_name in (
        "document_ja",
        "document_en",
    ):
        root = REPO_ROOT / root_name

        if not root.exists():
            continue

        for path in sorted(root.rglob("*.html")):
            html_files += 1

            parser.feed(
                path.read_text(
                    encoding="utf-8"
                )
            )

    markers = count_markers()

    print(f"HTML_FILES={html_files}")
    print(
        "HIGHLIGHTED_BLOCKS="
        f"{parser.highlighted_blocks}"
    )
    print(
        f"TOKEN_SPANS={parser.token_spans}"
    )
    print(
        "NUMBERED_BLOCKS="
        f"{parser.numbered_blocks}"
    )
    print(f"CODE_LINES={parser.code_lines}")
    print(f"NIM_CODE_BLOCKS={parser.nim_code_blocks}")
    print(f"MARKED_EXAMPLES={markers}")
    print(
        f"EXTERNAL_LINKS={parser.external_links}"
    )
    print(
        "SECURE_EXTERNAL_LINKS="
        f"{parser.secure_external_links}"
    )
    print(
        "INSECURE_EXTERNAL_LINKS="
        f"{len(parser.insecure_external_links)}"
    )

    errors: list[str] = []

    if markers > 0 and parser.numbered_blocks == 0:
        errors.append(
            "Markdown has line-number markers, "
            "but generated HTML has no numbered blocks."
        )

    if markers > 0 and parser.code_lines == 0:
        errors.append(
            "Markdown has line-number markers, "
            "but generated HTML has no code-line elements."
        )

    if parser.nim_code_blocks == 0:
        errors.append(
            "No Nim code blocks were recognized in generated HTML."
        )

    if parser.highlighted_blocks == 0:
        errors.append(
            "No generated Nim block has the highlighting marker."
        )

    if parser.token_spans == 0:
        errors.append(
            "Generated HTML has no Nim syntax token spans."
        )

    if parser.insecure_external_links:
        errors.append(
            "External links without "
            'target="_blank" rel="noopener":'
        )

        for href in parser.insecure_external_links[:30]:
            errors.append(f"  {href}")

    if errors:
        print("DOCUMENT_HTML_AUDIT=NG")

        for error in errors:
            print(error)

        raise SystemExit(1)

    print("DOCUMENT_HTML_AUDIT=OK")


if __name__ == "__main__":
    main()
