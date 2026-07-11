#!/usr/bin/env python3

from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent.parent
SOURCE_ROOT = ROOT / "src" / "atcoder"

PARAMETER_RE = re.compile(
    r"""(?x)
    \b(
        expected[A-Z][A-Za-z0-9_]*
      | expected_[a-z0-9_]+
      | capacity
      | initialCapacity
      | initial_capacity
      | nodeCapacity
      | node_capacity
      | maxNodes
      | max_nodes
      | poolSize
      | pool_size
      | reserve
    )
    \s*:
    """
)

QUALITY_TOKENS = {
    "ja": (
        "意味",
        "正しさ",
        "小さすぎ",
        "大きすぎ",
        "省略時",
        "メモリ",
    ),
    "en": (
        "Meaning",
        "Correctness",
        "Too small",
        "Too large",
        "Default",
        "memory",
    ),
}

occurrences: dict[
    tuple[str, str],
    list[tuple[int, str]],
] = {}

for source in SOURCE_ROOT.rglob("*.nim"):
    relative = source.relative_to(
        SOURCE_ROOT
    )

    text = source.read_text(
        encoding="utf-8",
        errors="replace",
    )

    for line_number, line in enumerate(
        text.splitlines(),
        start=1,
    ):
        for match in PARAMETER_RE.finditer(
            line
        ):
            key = (
                str(relative.with_suffix("")),
                match.group(1),
            )

            occurrences.setdefault(
                key,
                [],
            ).append(
                (
                    line_number,
                    line.strip(),
                )
            )

errors: list[str] = []

for (module, parameter), locations in sorted(
    occurrences.items()
):
    for language, doc_root in (
        ("ja", ROOT / "document_ja"),
        ("en", ROOT / "document_en"),
    ):
        doc = doc_root / f"{module}.md"

        if not doc.is_file():
            errors.append(
                f"missing doc for tuning parameter: "
                f"{module} / {language} / {parameter}"
            )
            continue

        text = doc.read_text(
            encoding="utf-8",
            errors="replace",
        )

        marker = (
            "<!-- NIM_ACL_TUNING_PARAMETER: "
            + parameter
            + " -->"
        )

        if marker not in text:
            errors.append(
                f"missing tuning marker: "
                f"{doc.relative_to(ROOT)}: {parameter}"
            )

        if parameter not in text:
            errors.append(
                f"parameter is undocumented: "
                f"{doc.relative_to(ROOT)}: {parameter}"
            )

        folded = text.casefold()

        for token in QUALITY_TOKENS[
            language
        ]:
            if token.casefold() not in folded:
                errors.append(
                    f"documentation quality token missing: "
                    f"{doc.relative_to(ROOT)}: "
                    f"{parameter}: {token}"
                )

if errors:
    print("TUNING_PARAMETER_DOC_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("TUNING_PARAMETER_DOC_AUDIT=OK")
print(
    f"TUNING_PARAMETER_PAIRS={len(occurrences)}"
)
print(
    "POLICY=meaning_correctness_small_large_default_memory"
)
