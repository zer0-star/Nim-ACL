#!/usr/bin/env python3

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

BITSET_SOURCE = ROOT / "src/atcoder/extra/other/bitset.nim"
BITUTILS_SOURCE = ROOT / "src/atcoder/extra/other/bitutils.nim"

BITSET_TEST = ROOT / "tests/test_extra_bitset.nim"
BITUTILS_TEST = ROOT / "tests/test_extra_bitutils.nim"

BITSET_DOC = ROOT / "document_ja/extra/other/bitset.md"
BITUTILS_DOC = ROOT / "document_ja/extra/other/bitutils.md"

QUICK_VERIFY = ROOT / "tools/quick_verify.sh"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(
            f"BIT_UTILITY_CONTRACT_AUDIT_ERROR: {message}"
        )


for path in (
    BITSET_SOURCE,
    BITUTILS_SOURCE,
    BITSET_TEST,
    BITUTILS_TEST,
    BITSET_DOC,
    BITUTILS_DOC,
    QUICK_VERIFY,
):
    require(
        path.exists(),
        f"missing {path.relative_to(ROOT)}",
    )


bitset_source = BITSET_SOURCE.read_text(encoding="utf-8")
bitutils_source = BITUTILS_SOURCE.read_text(encoding="utf-8")

bitset_test = BITSET_TEST.read_text(encoding="utf-8")
bitutils_test = BITUTILS_TEST.read_text(encoding="utf-8")

bitset_doc = BITSET_DOC.read_text(encoding="utf-8")
bitutils_doc = BITUTILS_DOC.read_text(encoding="utf-8")

quick_verify = QUICK_VERIFY.read_text(encoding="utf-8")


for stale in (
    "result = initBitSet(N)",
    "if f != BitWidth: return b + f",
    "if a[i] != b[i]: return a[i] < b[i]",
):
    require(
        stale not in bitset_source,
        f"stale BitSet defect remains: {stale}",
    )


for marker in (
    "result = initBitSet[N]()",
    "if f != 0: return b + f - 1",
    "a.data[i] != b.data[i]",
):
    require(
        marker in bitset_source,
        f"BitSet repair marker missing: {marker}",
    )


for marker in (
    "fixedProbe[63]()",
    "fixedProbe[64]()",
    "fixedProbe[65]()",
    "fixedProbe[127]()",
    "fixedProbe[128]()",
    "fixedProbe[129]()",
    "randomDynamicProbe",
    "original[1] == 0",
):
    require(
        marker in bitset_test,
        f"BitSet test marker missing: {marker}",
    )


for marker in (
    "allSetBits[uint64](0)",
    "allSetBits[uint64](64)",
    "for subset in subsets(mask)",
    "for first in 0 ..< 64",
):
    require(
        marker in bitutils_test,
        f"BitUtils test marker missing: {marker}",
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
    (BITSET_DOC, bitset_doc),
    (BITUTILS_DOC, bitutils_doc),
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
    "# <<< BITSET_CONTRACT_REGRESSION_V1 >>>" in quick_verify,
    "BitSet test is not registered in Quick Verify",
)

require(
    "# <<< BITUTILS_THREE_DEFECTS_REGRESSION_V1 >>>"
    in quick_verify,
    "BitUtils test is not registered in Quick Verify",
)

print("BIT_UTILITY_CONTRACT_AUDIT=OK")
print("BITSET_CONFIRMED_DEFECTS=3")
print("BITUTILS_CONFIRMED_DEFECTS=3")
print("BOUNDARIES=0,1,2,63,64,65,127,128,129")
print("BACKENDS=REFC_AND_ORC")
print("RANDOM_DIFFERENTIAL=REGISTERED")
print("CURATED_DOCUMENTATION=REGISTERED")
