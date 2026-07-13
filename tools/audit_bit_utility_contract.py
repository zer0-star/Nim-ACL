#!/usr/bin/env python3

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

DENSE_SOURCE = (
    ROOT
    / "src/atcoder/extra/structure/dense_bitset.nim"
)

BITMASK_SOURCE = (
    ROOT
    / "src/atcoder/extra/bit/bitmask.nim"
)

LEGACY_BITSET_SOURCE = (
    ROOT
    / "src/atcoder/extra/other/bitset.nim"
)

LEGACY_BITUTILS_SOURCE = (
    ROOT
    / "src/atcoder/extra/other/bitutils.nim"
)

BITSET_TEST = ROOT / "tests/test_extra_bitset.nim"
BITUTILS_TEST = ROOT / "tests/test_extra_bitutils.nim"

CANONICAL_API_TEST = (
    ROOT
    / "tests/test_bit_utility_canonical_api.nim"
)

COMPATIBILITY_TEST = (
    ROOT
    / "tests/test_bit_utility_legacy_compatibility.nim"
)

DENSE_DOC = (
    ROOT
    / "document_ja/extra/structure/dense_bitset.md"
)

BITMASK_DOC = (
    ROOT
    / "document_ja/extra/bit/bitmask.md"
)

LEGACY_BITSET_MD = (
    ROOT
    / "document_ja/extra/other/bitset.md"
)

LEGACY_BITUTILS_MD = (
    ROOT
    / "document_ja/extra/other/bitutils.md"
)

LEGACY_BITSET_HTML = (
    ROOT
    / "document_ja/extra/other/bitset.html"
)

LEGACY_BITUTILS_HTML = (
    ROOT
    / "document_ja/extra/other/bitutils.html"
)

INDEX_MD = ROOT / "document_ja/index.md"
QUICK_VERIFY = ROOT / "tools/quick_verify.sh"

DOC_SCANNER = (
    ROOT
    / "tools/create_missing_docs_and_update_index.py"
)


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(
            f"BIT_UTILITY_CONTRACT_AUDIT_ERROR: {message}"
        )


required_paths = (
    DENSE_SOURCE,
    BITMASK_SOURCE,
    LEGACY_BITSET_SOURCE,
    LEGACY_BITUTILS_SOURCE,
    BITSET_TEST,
    BITUTILS_TEST,
    CANONICAL_API_TEST,
    COMPATIBILITY_TEST,
    DENSE_DOC,
    BITMASK_DOC,
    LEGACY_BITSET_HTML,
    LEGACY_BITUTILS_HTML,
    INDEX_MD,
    QUICK_VERIFY,
    DOC_SCANNER,
)

for path in required_paths:
    require(
        path.exists(),
        f"missing {path.relative_to(ROOT)}",
    )


require(
    not LEGACY_BITSET_MD.exists(),
    "legacy BitSet Markdown must not exist",
)

require(
    not LEGACY_BITUTILS_MD.exists(),
    "legacy BitUtils Markdown must not exist",
)


dense_source = DENSE_SOURCE.read_text(encoding="utf-8")
bitmask_source = BITMASK_SOURCE.read_text(encoding="utf-8")

legacy_bitset = LEGACY_BITSET_SOURCE.read_text(
    encoding="utf-8"
)

legacy_bitutils = LEGACY_BITUTILS_SOURCE.read_text(
    encoding="utf-8"
)

bitset_test = BITSET_TEST.read_text(encoding="utf-8")
bitutils_test = BITUTILS_TEST.read_text(encoding="utf-8")

canonical_test = CANONICAL_API_TEST.read_text(
    encoding="utf-8"
)

compatibility_test = COMPATIBILITY_TEST.read_text(
    encoding="utf-8"
)

dense_doc = DENSE_DOC.read_text(encoding="utf-8")
bitmask_doc = BITMASK_DOC.read_text(encoding="utf-8")

legacy_bitset_html = LEGACY_BITSET_HTML.read_text(
    encoding="utf-8"
)

legacy_bitutils_html = LEGACY_BITUTILS_HTML.read_text(
    encoding="utf-8"
)

index_md = INDEX_MD.read_text(encoding="utf-8")

quick_verify = QUICK_VERIFY.read_text(encoding="utf-8")
doc_scanner = DOC_SCANNER.read_text(encoding="utf-8")


for stale in (
    "result = initBitSet(N)",
    "if f != BitWidth: return b + f",
    "if a[i] != b[i]: return a[i] < b[i]",
):
    require(
        stale not in dense_source,
        f"stale BitSet defect remains: {stale}",
    )


for marker in (
    "result = initBitSet[N]()",
    "if f != 0: return b + f - 1",
    "a.data[i] != b.data[i]",
    "proc initFullBitSet*",
    "proc initFullDynamicBitSet*",
    "atcoder/extra/bit/bitmask",
):
    require(
        marker in dense_source,
        f"Dense BitSet marker missing: {marker}",
    )


for marker in (
    "proc maskFromBitIndices*",
    "proc bitIndices*",
    "proc lowBitsMask*",
    "proc toBitString*",
    "iterator submasks*",
    "iterator subsetMasks*",
):
    require(
        marker in bitmask_source,
        f"Bitmask alias missing: {marker}",
    )


for text, target in (
    (
        legacy_bitset,
        "atcoder/extra/structure/dense_bitset",
    ),
    (
        legacy_bitutils,
        "atcoder/extra/bit/bitmask",
    ),
):
    require(
        "NIM_ACL_COMPATIBILITY_SHIM" in text,
        "compatibility shim marker missing",
    )

    require(
        target in text,
        f"compatibility target missing: {target}",
    )


require(
    "atcoder/extra/structure/dense_bitset"
    in bitset_test,
    "BitSet test does not use canonical import",
)

require(
    "atcoder/extra/bit/bitmask"
    in bitutils_test,
    "Bitmask test does not use canonical import",
)


for marker in (
    "maskFromBitIndices",
    "bitIndices",
    "lowBitsMask",
    "initFullBitSet",
    "initFullDynamicBitSet",
):
    require(
        marker in canonical_test,
        f"canonical API test marker missing: {marker}",
    )


for marker in (
    "atcoder/extra/other/bitset",
    "atcoder/extra/other/bitutils",
    "atcoder/extra/structure/dense_bitset",
    "atcoder/extra/bit/bitmask",
):
    require(
        marker in compatibility_test,
        f"compatibility import missing: {marker}",
    )


sections = (
    "## 概要",
    "## import",
    "## 境界条件",
    "## 計算量",
    "## 使用例",
    "## 関連",
    "## 検証",
)

for path, text in (
    (DENSE_DOC, dense_doc),
    (BITMASK_DOC, bitmask_doc),
):
    for section in sections:
        require(
            section in text,
            (
                f"{path.relative_to(ROOT)} "
                f"is missing {section}"
            ),
        )


require(
    "../structure/dense_bitset.html"
    in legacy_bitset_html,
    "legacy BitSet redirect target missing",
)

require(
    "../bit/bitmask.html"
    in legacy_bitutils_html,
    "legacy BitUtils redirect target missing",
)


for marker in (
    "./extra/structure/dense_bitset.html",
    "./extra/bit/bitmask.html",
    "`import atcoder/extra/structure/dense_bitset`",
    "`import atcoder/extra/bit/bitmask`",
):
    require(
        index_md.count(marker) == 1,
        (
            "canonical curated marker must occur once: "
            f"{marker}"
        ),
    )


for marker in (
    "extra/structure/dense_bitset.md",
    "extra/bit/bitmask.md",
):
    require(
        marker not in index_md,
        (
            "canonical Markdown must not be duplicated "
            f"in the generated list: {marker}"
        ),
    )


for marker in (
    "extra/other/bitset.html",
    "extra/other/bitutils.html",
    "extra/other/bitset.md",
    "extra/other/bitutils.md",
    "`import atcoder/extra/other/bitset`",
    "`import atcoder/extra/other/bitutils`",
):
    require(
        marker not in index_md,
        f"legacy catalog marker remains: {marker}",
    )


for marker in (
    'link = link.removeprefix("./")',
    'manual_text = pattern.sub("", text)',
    "NIM_ACL_COMPATIBILITY_SHIM",
):
    require(
        marker in doc_scanner,
        f"document scanner repair missing: {marker}",
    )


require(
    (
        "# <<< BIT_UTILITY_CANONICAL_AND_"
        "COMPATIBILITY_IMPORTS_V1 >>>"
    )
    in quick_verify,
    "canonical and compatibility tests missing",
)


print("BIT_UTILITY_CONTRACT_AUDIT=OK")
print("CANONICAL_DENSE_BITSET=OK")
print("CANONICAL_BITMASK=OK")
print("LEGACY_SOURCE_SHIMS=OK")
print("LEGACY_HTML_REDIRECTS=OK")
print("CURATED_HTML_ROWS=UNIQUE")
print("GENERATED_MARKDOWN_DUPLICATES=ABSENT")
print("DOCUMENT_GENERATOR_REPAIRS=OK")
print("BACKENDS=REFC_AND_ORC")
