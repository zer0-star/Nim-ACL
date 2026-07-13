#!/usr/bin/env python3

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

RANGE_SOURCE = ROOT / "src/atcoder/rangeutils.nim"

SLICE_SOURCE = (
    ROOT
    / "src/atcoder/extra/other/sliceutils.nim"
)

RANGE_TEST = ROOT / "tests/test_rangeutils.nim"

OVERFLOW_TEST = (
    ROOT
    / "tests/test_rangeutils_overflow.nim"
)

SLICE_TEST = ROOT / "tests/test_sliceutils.nim"

RANGE_DOC = ROOT / "document_ja/rangeutils.md"

SLICE_DOC = (
    ROOT
    / "document_ja/extra/other/sliceutils.md"
)

INDEX = ROOT / "document_ja/index.md"
QUICK = ROOT / "tools/quick_verify.sh"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(
            f"RANGE_SLICE_CONTRACT_AUDIT_ERROR: {message}"
        )


for path in (
    RANGE_SOURCE,
    SLICE_SOURCE,
    RANGE_TEST,
    OVERFLOW_TEST,
    SLICE_TEST,
    RANGE_DOC,
    SLICE_DOC,
    INDEX,
    QUICK,
):
    require(
        path.exists(),
        f"missing {path.relative_to(ROOT)}",
    )


range_source = RANGE_SOURCE.read_text(encoding="utf-8")
slice_source = SLICE_SOURCE.read_text(encoding="utf-8")

range_test = RANGE_TEST.read_text(encoding="utf-8")
overflow_test = OVERFLOW_TEST.read_text(encoding="utf-8")
slice_test = SLICE_TEST.read_text(encoding="utf-8")

range_doc = RANGE_DOC.read_text(encoding="utf-8")
slice_doc = SLICE_DOC.read_text(encoding="utf-8")

index = INDEX.read_text(encoding="utf-8")
quick = QUICK.read_text(encoding="utf-8")


for marker in (
    "Slice[int]",
    "HSlice[int, BackwardsIndex]",
    "HSlice[BackwardsIndex, int]",
    "Slice[BackwardsIndex]",
    "template halfOpenEndpoints*",
):
    require(
        marker in range_source,
        f"rangeutils marker missing: {marker}",
    )


for marker in (
    "backwardsClosed",
    "backwardsHalfOpen",
    "backwardsEmpty",
    "allByCaretZero",
    "emptyAtEnd",
    "closedThroughCaretZero",
    "beforeStart",
    "maximumSafeClosed",
    "initFenwickTree",
    "RANGEUTILS_CONTRACT_TEST_OK",
):
    require(
        marker in range_test,
        f"range test marker missing: {marker}",
    )


for marker in (
    "high(int)",
    "halfOpenEndpoints",
    "UNEXPECTED_RANGE_OVERFLOW_ACCEPTED",
):
    require(
        marker in overflow_test,
        f"overflow test marker missing: {marker}",
    )


for marker in (
    "rev(1 .. 4)",
    ".rev()",
    ">> 2",
    "<< 2",
    "for i in 5",
    "values[(0 .. 4) >> 2]",
    "SLICEUTILS_CONTRACT_TEST_OK",
):
    require(
        marker in slice_test,
        f"slice test marker missing: {marker}",
    )


for marker in (
    "proc index*",
    "proc rev*",
    "proc `>>`*",
    "proc `<<`*",
    "proc `[]`*",
    "proc `[]=`*",
):
    require(
        marker in slice_source,
        f"sliceutils API missing: {marker}",
    )


require(
    "type ReversedSlice*" not in slice_source,
    "ReversedSlice must remain an implementation type",
)

require(
    "type StepSlice*" not in slice_source,
    "StepSlice must remain an implementation type",
)


sections = (
    "## 概要",
    "## import",
    "## 境界条件",
    "## 計算量",
    "## 関連",
    "## 検証",
)

for path, text in (
    (RANGE_DOC, range_doc),
    (SLICE_DOC, slice_doc),
):
    for section in sections:
        require(
            section in text,
            (
                f"{path.relative_to(ROOT)} "
                f"is missing {section}"
            ),
        )


for marker in (
    "0 ..< ^0",
    "^0 ..< ^0",
    "high(int)",
    "overflow",
):
    require(
        marker in range_doc,
        f"range documentation marker missing: {marker}",
    )


for marker in (
    "rev(1 .. 4)",
    ".rev()",
    "property形式",
):
    require(
        marker in slice_doc,
        f"slice documentation marker missing: {marker}",
    )


require(
    index.count(
        "[Range utilities](./rangeutils.html)"
    )
    == 1,
    "rangeutils catalog row is not unique",
)

require(
    index.count(
        "[Slice utilities]"
        "(./extra/other/sliceutils.html)"
    )
    == 1,
    "sliceutils catalog row is not unique",
)

require(
    (
        "# <<< RANGE_SLICE_CONTRACT_REGRESSION_V2 >>>"
    )
    in quick,
    "Quick Verify registration is missing",
)


print("RANGE_SLICE_CONTRACT_AUDIT=OK")
print("RANGE_ENDPOINT_COMBINATIONS=4")
print("CARET_ZERO_CONTRACT=OK")
print("ZERO_LENGTH_CONTRACT=OK")
print("CHECKED_OVERFLOW_REJECTION=REGISTERED")
print("SLICE_REV_CANONICAL_SYNTAX=rev(slice)_OR_slice.rev()")
print("HELPER_TYPES_REMAIN_IMPLEMENTATION_ONLY=OK")
print("CURATED_DOCUMENTATION=REGISTERED")
