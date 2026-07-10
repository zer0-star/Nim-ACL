#!/usr/bin/env python3

from pathlib import Path


TOP = (
    "https://info.atcoder.jp/"
    "entry/algorithm_lectures/index"
)

violations: list[str] = []


for root_name in (
    "document_ja",
    "document_en",
):
    root = Path(root_name)

    for path in sorted(root.rglob("*.md")):
        relative = path.relative_to(root)

        # Catalog links are intentional on guide and index pages.
        if (
            relative.parts
            and relative.parts[0] == "guide"
        ):
            continue

        if relative.name == "index.md":
            continue

        text = path.read_text(
            encoding="utf-8"
        )

        if TOP in text:
            violations.append(str(path))


print(
    "GENERIC_LECTURE_LINKS_REMAINING="
    f"{len(violations)}"
)

if violations:
    print("GENERIC_LECTURE_LINK_FILES_START")

    for path in violations:
        print(path)

    print("GENERIC_LECTURE_LINK_FILES_END")

    raise SystemExit(1)

print("ATCODER_LECTURE_LINK_AUDIT=OK")
