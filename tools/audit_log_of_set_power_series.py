#!/usr/bin/env python3

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]

SOURCE = (
    ROOT
    / "src/atcoder/extra/math/log_of_set_power_series.nim"
)

TEST = (
    ROOT
    / "tests/test_extra_log_of_set_power_series.nim"
)

CROSS_HELPER = (
    ROOT
    / "tests/support/"
    "log_of_set_power_series_cross_module_helper.nim"
)

CROSS_TEST = (
    ROOT
    / "tests/test_extra_log_of_set_power_series_cross_module.nim"
)

JA_DOC = (
    ROOT
    / "document_ja/extra/math/log_of_set_power_series.md"
)

EN_DOC = (
    ROOT
    / "document_en/extra/math/log_of_set_power_series.md"
)

QUICK_VERIFY = ROOT / "tools/quick_verify.sh"

errors: list[str] = []


def require(condition: bool, message: str) -> None:
    if not condition:
        errors.append(message)


def read(path: Path) -> str:
    require(path.is_file(), f"missing file: {path}")

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
        proc\s+
        logOfSetPowerSeries\*\[T\]
        \s*\(
        \s*values:\s*openArray\[T\],
        \s*\)
        \s*:\s*seq\[T\]
        """,
        source,
        flags=re.MULTILINE | re.VERBOSE,
    )
    is not None,
    "public signature differs",
)

for fragment in (
    "import atcoder/extra/math/subset_convolution",
    "proc inverseUnitSetPowerSeriesSolve[T](",
    "proc logOfSetPowerSeriesSolve[T](",
    "subsetConvolution(",
    "the empty-set coefficient must be one",
):
    require(
        fragment in source,
        f"source fragment missing: {fragment}",
    )

require(
    "inverseUnitSetPowerSeriesSolve*" not in source,
    "unit inverse helper must remain private",
)

for fragment in (
    'test "scalar unit series":',
    'test "known exponential and logarithm pair":',
    'test "unit inverse recurrence used by logarithm":',
    'test "randomized exp-log and log-exp roundtrips":',
    'test "invalid length and empty-set coefficient":',
    "naiveUnitLog(",
    "expOfSetPowerSeries(",
):
    require(
        fragment in test,
        f"test fragment missing: {fragment}",
    )

require(
    "buildCrossModuleSetPowerSeriesResult*" in cross_helper,
    "cross-module helper is missing",
)

require(
    "public API remains usable across modules" in cross_test,
    "cross-module test is missing",
)

orders = [
    (
        "Japanese",
        ja_doc,
        [
            "## 一般形",
            "## 引数・型",
            "## 前提条件",
            "## 返り値",
            "## 具体例",
            "## 関連API",
            "## 計算量と内部実装",
        ],
    ),
    (
        "English",
        en_doc,
        [
            "## General form",
            "## Parameters and types",
            "## Preconditions",
            "## Return value",
            "## Example",
            "## Related APIs",
            "## Complexity and implementation",
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
    "logOfSetPowerSeries(",
    "expOfSetPowerSeries",
    "可換環",
    "逆元は独立した公開APIにはしていません",
    "O(k^2 2^k)",
):
    require(
        fragment in ja_doc,
        f"Japanese documentation missing: {fragment}",
    )

for fragment in (
    "logOfSetPowerSeries(",
    "expOfSetPowerSeries",
    "commutative ring",
    "not exposed as a separate public API",
    "O(k^2 2^k)",
):
    require(
        fragment in en_doc,
        f"English documentation missing: {fragment}",
    )

require(
    "LOG_OF_SET_POWER_SERIES_TEST" in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("LOG_OF_SET_POWER_SERIES_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("LOG_OF_SET_POWER_SERIES_API_AUDIT=OK")
print("PUBLIC_API=logOfSetPowerSeries(values)")
print("RETURN_TYPE=seq[T]")
print("PRECONDITION=POSITIVE_POWER_OF_TWO_AND_UNIT_CONSTANT")
print("INTERNAL_INVERSE=PRIVATE")
print("CORE_SET_POWER_SERIES_SCOPE=EXP_AND_LOG")
print("DOC_ORDER=PST_STYLE")
