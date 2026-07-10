#!/usr/bin/env python3

from __future__ import annotations

from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urlsplit

ROOT = Path(__file__).resolve().parent.parent

EXPECTED = {
    "extra/structure/binary_trie": {
        "https://atcoder.jp/contests/"
        "abc308/tasks/abc308_g",
        "https://judge.yosupo.jp/"
        "problem/set_xor_min",
    },
    "extra/math/xor_basis": {
        "https://atcoder.jp/contests/"
        "abc141/tasks/abc141_f",
        "https://atcoder.jp/contests/"
        "abc236/tasks/abc236_f",
        "https://atcoder.jp/contests/"
        "abc283/tasks/abc283_g",
    },
    "extra/string/kmp": {
        "https://atcoder.jp/contests/"
        "abc257/tasks/abc257_g",
    },
    "extra/string/manacher": {
        "https://judge.yosupo.jp/"
        "problem/enumerate_palindromes",
    },
    "extra/structure/rollback_dsu": {
        (
            "https://judge.yosupo.jp/problem/"
            "dynamic_graph_vertex_add_component_sum"
        ),
    },
}

ALLOWED_HOSTS = {
    "atcoder.jp",
    "judge.yosupo.jp",
}


class ProblemExampleParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(
            convert_charrefs=True
        )

        self.problem_depth = 0
        self.problem_details = 0
        self.open_details = 0
        self.summary_count = 0
        self.links: list[
            tuple[str, str, set[str]]
        ] = []

    def handle_starttag(
        self,
        tag: str,
        attrs_list: list[
            tuple[str, str | None]
        ],
    ) -> None:
        tag = tag.casefold()

        attrs = {
            key.casefold(): value
            for key, value in attrs_list
        }

        if tag == "details":
            classes = {
                token.casefold()
                for token in (
                    attrs.get("class") or ""
                ).split()
            }

            if (
                "problem-examples" in classes
                and self.problem_depth == 0
            ):
                self.problem_details += 1
                self.problem_depth = 1

                if "open" in attrs:
                    self.open_details += 1

                return

            if self.problem_depth > 0:
                self.problem_depth += 1
                return

        if self.problem_depth <= 0:
            return

        if tag == "summary":
            self.summary_count += 1

        if tag == "a":
            href = attrs.get("href") or ""
            target = (
                attrs.get("target") or ""
            ).casefold()

            rel = {
                token.casefold()
                for token in (
                    attrs.get("rel") or ""
                ).split()
            }

            self.links.append(
                (href, target, rel)
            )

    def handle_endtag(
        self,
        tag: str,
    ) -> None:
        if (
            tag.casefold() == "details"
            and self.problem_depth > 0
        ):
            self.problem_depth -= 1


def inspect_page(
    path: Path,
    expected_urls: set[str],
) -> list[str]:
    errors: list[str] = []

    if not path.exists():
        return [f"missing page: {path}"]

    parser = ProblemExampleParser()

    parser.feed(
        path.read_text(
            encoding="utf-8"
        )
    )

    if parser.problem_details != 1:
        errors.append(
            "expected one problem details: "
            f"{path}"
        )

    if parser.open_details != 0:
        errors.append(
            "problem details must be closed: "
            f"{path}"
        )

    if parser.summary_count != 1:
        errors.append(
            "expected one problem summary: "
            f"{path}"
        )

    actual_urls = {
        href
        for href, _, _ in parser.links
    }

    if actual_urls != expected_urls:
        errors.append(
            "problem URLs differ: "
            f"{path}"
        )

    if len(parser.links) != len(expected_urls):
        errors.append(
            "duplicate or missing problem links: "
            f"{path}"
        )

    for href, target, rel in parser.links:
        parsed = urlsplit(href)

        if parsed.scheme != "https":
            errors.append(
                f"non-HTTPS problem URL: {href}"
            )

        if parsed.hostname not in ALLOWED_HOSTS:
            errors.append(
                f"unexpected problem host: {href}"
            )

        if "editorial" in href.casefold():
            errors.append(
                f"editorial link is forbidden: {href}"
            )

        if target != "_blank":
            errors.append(
                "problem link lacks "
                f'target="_blank": {path}: {href}'
            )

        if "noopener" not in rel:
            errors.append(
                "problem link lacks "
                f'rel="noopener": {path}: {href}'
            )

    return errors


errors: list[str] = []
source_pages = 0
generated_pages = 0
source_links = 0
generated_links = 0

for relative, expected_urls in EXPECTED.items():
    language_urls: dict[
        str,
        set[str],
    ] = {}

    for language in ("ja", "en"):
        md_path = (
            ROOT
            / f"document_{language}"
            / f"{relative}.md"
        )

        html_path = md_path.with_suffix(
            ".html"
        )

        md_errors = inspect_page(
            md_path,
            expected_urls,
        )

        html_errors = inspect_page(
            html_path,
            expected_urls,
        )

        errors.extend(md_errors)
        errors.extend(html_errors)

        if not md_errors:
            source_pages += 1
            source_links += len(
                expected_urls
            )

        if not html_errors:
            generated_pages += 1
            generated_links += len(
                expected_urls
            )

        language_urls[language] = set(
            expected_urls
        )

    if (
        language_urls.get("ja")
        != language_urls.get("en")
    ):
        errors.append(
            "Japanese and English URLs differ: "
            f"{relative}"
        )

print(
    f"PROBLEM_SOURCE_PAGES={source_pages}"
)

print(
    "PROBLEM_GENERATED_PAGES="
    f"{generated_pages}"
)

print(
    f"PROBLEM_SOURCE_LINKS={source_links}"
)

print(
    "PROBLEM_GENERATED_LINKS="
    f"{generated_links}"
)

if source_pages != 10:
    errors.append(
        "expected 10 valid source pages"
    )

if generated_pages != 10:
    errors.append(
        "expected 10 valid generated pages"
    )

if source_links != 16:
    errors.append(
        "expected 16 valid source links"
    )

if generated_links != 16:
    errors.append(
        "expected 16 valid generated links"
    )

if errors:
    print("PROBLEM_EXAMPLES_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("PROBLEM_EXAMPLES_AUDIT=OK")
