#!/usr/bin/env python3

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]

SOURCE = (
    ROOT
    / "src"
    / "atcoder"
    / "extra"
    / "math"
    / "exp_of_set_power_series.nim"
)

TEST = (
    ROOT
    / "tests"
    / "test_extra_exp_of_set_power_series.nim"
)

CROSS_HELPER = (
    ROOT
    / "tests"
    / "support"
    / "exp_of_set_power_series_cross_module_helper.nim"
)

CROSS_TEST = (
    ROOT
    / "tests"
    / "test_extra_exp_of_set_power_series_cross_module.nim"
)

JA_DOC = (
    ROOT
    / "document_ja"
    / "extra"
    / "math"
    / "exp_of_set_power_series.md"
)

EN_DOC = (
    ROOT
    / "document_en"
    / "extra"
    / "math"
    / "exp_of_set_power_series.md"
)

QUICK_VERIFY = ROOT / "tools" / "quick_verify.sh"


errors: list[str] = []


def require(
    condition: bool,
    message: str,
) -> None:
    if not condition:
        errors.append(message)


def read(path: Path) -> str:
    require(
        path.is_file(),
        f"missing file: {path}",
    )

    if not path.is_file():
        return ""

    return path.read_text(
        encoding="utf-8",
        errors="replace",
    )


source = read(SOURCE)
test = read(TEST)
cross_helper = read(CROSS_HELPER)
cross_test = read(CROSS_TEST)
ja_doc = read(JA_DOC)
en_doc = read(EN_DOC)
quick_verify = read(QUICK_VERIFY)


require(
    re.search(
        r"""
        proc[ ]expOfSetPowerSeries\*
        \[T\]
        \(
        \s*f:[ ]openArray\[T\],
        \s*\):[ ]seq\[T\]
        """,
        source,
        flags=re.MULTILINE | re.VERBOSE,
    )
    is not None,
    "public signature differs",
)

for fragment in (
    "import atcoder/extra/math/subset_convolution",
    "subsetConvolution(",
    "the input length must be a positive power of two",
    "the empty-set coefficient must be zero",
    "result.add(",
):
    require(
        fragment in source,
        f"source fragment missing: {fragment}",
    )

for fragment in (
    'test "one-element input":',
    'test "known example":',
    'test "integer coefficients":',
    'test "input is preserved":',
    'test "empty input is rejected":',
    'test "non-power-of-two length is rejected":',
    'test "nonzero empty-set coefficient is rejected":',
    'test "randomized independent recurrence differential":',
):
    require(
        fragment in test,
        f"test missing: {fragment}",
    )

require(
    "buildCrossSetPowerSeriesExp*" in cross_helper,
    "cross-module helper is missing",
)

require(
    "public API and coefficient type remain visible"
    in cross_test,
    "cross-module test is missing",
)

orders = [
    (
        "Japanese",
        ja_doc,
        [
            "## 一般形",
            "## 引数",
            "## 前提条件",
            "## 返り値",
            "## 具体例",
            "## 関連API",
            "## 計算量",
        ],
    ),
    (
        "English",
        en_doc,
        [
            "## General form",
            "## Parameters",
            "## Preconditions",
            "## Return value",
            "## Example",
            "## Related APIs",
            "## Complexity",
        ],
    ),
]

for label, text, headings in orders:
    positions = [
        text.find(heading)
        for heading in headings
    ]

    require(
        all(position >= 0 for position in positions),
        f"{label} documentation heading is missing",
    )

    require(
        positions == sorted(positions),
        f"{label} documentation order differs",
    )

for fragment in (
    "expOfSetPowerSeries(",
    "f[0] == 0",
    "集合分割",
    "result[0] = 1",
    "O(k^2 * 2^k)",
):
    require(
        fragment in ja_doc,
        f"Japanese documentation missing: {fragment}",
    )

for fragment in (
    "expOfSetPowerSeries(",
    "f[0] == 0",
    "set partitions",
    "result[0] = 1",
    "O(k^2 * 2^k)",
):
    require(
        fragment in en_doc,
        f"English documentation missing: {fragment}",
    )

require(
    "EXP_OF_SET_POWER_SERIES_TEST"
    in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("EXP_OF_SET_POWER_SERIES_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("EXP_OF_SET_POWER_SERIES_API_AUDIT=OK")
print("PUBLIC_API=expOfSetPowerSeries(f)")
print("RETURN_TYPE=seq[T]")
print("EMPTY_SET_COEFFICIENT=ZERO")
print("INTERNAL_BACKEND=subsetConvolution")
print("DOC_ORDER=PST_STYLE")
