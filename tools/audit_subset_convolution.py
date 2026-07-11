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
    / "subset_convolution.nim"
)

TEST = (
    ROOT
    / "tests"
    / "test_extra_subset_convolution.nim"
)

CROSS_HELPER = (
    ROOT
    / "tests"
    / "support"
    / "subset_convolution_cross_module_helper.nim"
)

CROSS_TEST = (
    ROOT
    / "tests"
    / "test_extra_subset_convolution_cross_module.nim"
)

JA_DOC = (
    ROOT
    / "document_ja"
    / "extra"
    / "math"
    / "subset_convolution.md"
)

EN_DOC = (
    ROOT
    / "document_en"
    / "extra"
    / "math"
    / "subset_convolution.md"
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
        proc[ ]subsetConvolution\*
        \[T\]
        \(
        \s*f,
        \s*g:[ ]openArray\[T\],
        \s*\):[ ]seq\[T\]
        """,
        source,
        flags=re.MULTILINE | re.VERBOSE,
    )
    is not None,
    "public signature differs",
)

for fragment in (
    "import std/bitops",
    "countSetBits(mask)",
    "rankedF",
    "rankedG",
    "rankedH",
    "the input length must be a positive power of two",
):
    require(
        fragment in source,
        f"source fragment missing: {fragment}",
    )

for fragment in (
    'test "one-element input":',
    'test "known example":',
    'test "inputs are preserved":',
    'test "length mismatch is rejected":',
    'test "empty input is rejected":',
    'test "non-power-of-two length is rejected":',
    'test "randomized naive differential":',
):
    require(
        fragment in test,
        f"test missing: {fragment}",
    )

require(
    "buildCrossSubsetConvolution*" in cross_helper,
    "cross-module helper is missing",
)

require(
    "public API and element type remain visible"
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
    "subsetConvolution(",
    "f.len == g.len",
    "正の2冪",
    "result[S]",
    "O(k^2 * 2^k)",
):
    require(
        fragment in ja_doc,
        f"Japanese documentation missing: {fragment}",
    )

for fragment in (
    "subsetConvolution(",
    "f.len == g.len",
    "positive power of two",
    "result[S]",
    "O(k^2 * 2^k)",
):
    require(
        fragment in en_doc,
        f"English documentation missing: {fragment}",
    )

require(
    "SUBSET_CONVOLUTION_TEST"
    in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("SUBSET_CONVOLUTION_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("SUBSET_CONVOLUTION_API_AUDIT=OK")
print("PUBLIC_API=subsetConvolution(f,g)")
print("RETURN_TYPE=seq[T]")
print("INPUT_LENGTH=POSITIVE_POWER_OF_TWO")
print("INTERNAL_LAYOUT=FLAT_RANKED_TRANSFORM")
print("DOC_ORDER=PST_STYLE")
