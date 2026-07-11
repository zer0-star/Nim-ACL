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
    / "polynomial_interpolation.nim"
)

TEST = (
    ROOT
    / "tests"
    / "test_extra_polynomial_interpolation.nim"
)

CROSS_HELPER = (
    ROOT
    / "tests"
    / "support"
    / "polynomial_interpolation_cross_module_helper.nim"
)

CROSS_TEST = (
    ROOT
    / "tests"
    / "test_extra_polynomial_interpolation_cross_module.nim"
)

JA_DOC = (
    ROOT
    / "document_ja"
    / "extra"
    / "math"
    / "polynomial_interpolation.md"
)

EN_DOC = (
    ROOT
    / "document_en"
    / "extra"
    / "math"
    / "polynomial_interpolation.md"
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
        proc[ ]polynomialInterpolation\*
        \[
        \s*T:[ ]FiniteFieldElem
        \s*\]
        \(
        \s*xs,
        \s*ys:[ ]openArray\[T\],
        \s*\):[ ]FormalPowerSeries\[T\]
        """,
        source,
        flags=re.MULTILINE | re.VERBOSE,
    )
    is not None,
    "public signature differs",
)

for fragment in (
    "import atcoder/extra/math/ntt",
    "export ntt",
    "subproduct_tree(",
    "multipointEvaluation(",
    "productTree[1].diff()",
    "xs and ys must have the same length",
    "xs must be pairwise distinct",
    "result.setLen(n)",
):
    require(
        fragment in source,
        f"source fragment missing: {fragment}",
    )

for fragment in (
    'test "empty input":',
    'test "singleton":',
    'test "known non-power-of-two example":',
    'test "length mismatch is rejected":',
    'test "duplicate x coordinates are rejected":',
    'test "randomized multipoint roundtrip":',
):
    require(
        fragment in test,
        f"test missing: {fragment}",
    )

require(
    "buildCrossInterpolation*" in cross_helper,
    "cross-module helper is missing",
)

require(
    "return type and coefficients remain visible"
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
    "polynomialInterpolation(",
    "FormalPowerSeries[T]",
    "coefficients[i]",
    "xs.len == ys.len",
    "互いに異なる",
    "次数の昇順",
):
    require(
        fragment in ja_doc,
        f"Japanese documentation missing: {fragment}",
    )

for fragment in (
    "polynomialInterpolation(",
    "FormalPowerSeries[T]",
    "coefficients[i]",
    "xs.len == ys.len",
    "pairwise distinct",
    "ascending degree",
):
    require(
        fragment in en_doc,
        f"English documentation missing: {fragment}",
    )

require(
    "POLYNOMIAL_INTERPOLATION_TEST"
    in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("POLYNOMIAL_INTERPOLATION_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("POLYNOMIAL_INTERPOLATION_API_AUDIT=OK")
print("PUBLIC_API=polynomialInterpolation(xs,ys)")
print("RETURN_TYPE=FormalPowerSeries")
print("COEFFICIENT_ORDER=ASCENDING_DEGREE")
print("INVALID_INPUT=VALUE_ERROR")
print("DOC_ORDER=PST_STYLE")
