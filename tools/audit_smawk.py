#!/usr/bin/env python3

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]

SOURCE = ROOT / "src/atcoder/extra/dp/smawk.nim"
TEST = ROOT / "tests/test_extra_smawk.nim"
CROSS_HELPER = ROOT / "tests/support/smawk_cross_module_helper.nim"
CROSS_TEST = ROOT / "tests/test_extra_smawk_cross_module.nim"
JA_DOC = ROOT / "document_ja/extra/dp/smawk.md"
EN_DOC = ROOT / "document_en/extra/dp/smawk.md"
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
        proc[ ]smawk\*\[T\]
        \(
        \s*rowCount,
        \s*columnCount:[ ]int,
        \s*value:[ ]proc\(
        """,
        source,
        flags=re.MULTILINE | re.VERBOSE,
    )
    is not None,
    "public signature differs",
)

for fragment in (
    "answer: var seq[int]",
    "newSeqOfCap[int]",
    "discard reduced.pop()",
    "rowCount must be nonnegative",
    "columnCount must be positive when rows exist",
):
    require(
        fragment in source,
        f"source fragment missing: {fragment}",
    )

for fragment in (
    'test "zero rows":',
    'test "invalid dimensions":',
    'test "leftmost minimum wins ties":',
    'test "known rectangular matrix":',
    'test "randomized totally monotone differential":',
    'test "value evaluations remain linear":',
):
    require(
        fragment in test,
        f"test missing: {fragment}",
    )

require(
    "buildCrossSmawkResult*" in cross_helper,
    "cross-module helper is missing",
)

require(
    "public callback API remains visible" in cross_test,
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
    "smawk[T](",
    "totally monotone",
    "最も左",
    "O(rowCount + columnCount)",
):
    require(
        fragment in ja_doc,
        f"Japanese documentation missing: {fragment}",
    )

for fragment in (
    "smawk[T](",
    "totally monotone",
    "leftmost",
    "O(rowCount + columnCount)",
):
    require(
        fragment in en_doc,
        f"English documentation missing: {fragment}",
    )

require(
    "SMAWK_TEST" in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("SMAWK_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("SMAWK_API_AUDIT=OK")
print("PUBLIC_API=smawk(rowCount,columnCount,value)")
print("RETURN_TYPE=seq[int]")
print("TIE_BREAKING=LEFTMOST_MINIMUM")
print("CALLBACK_STYLE=MONOTONE_MINIMA_COMPATIBLE")
print("DOC_ORDER=PST_STYLE")
