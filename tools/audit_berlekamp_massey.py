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
    / "berlekamp_massey.nim"
)

TEST = (
    ROOT
    / "tests"
    / "test_extra_berlekamp_massey.nim"
)

CROSS_HELPER = (
    ROOT
    / "tests"
    / "support"
    / "berlekamp_massey_cross_module_helper.nim"
)

CROSS_TEST = (
    ROOT
    / "tests"
    / "test_extra_berlekamp_massey_cross_module.nim"
)

JA_DOC = (
    ROOT
    / "document_ja"
    / "extra"
    / "math"
    / "berlekamp_massey.md"
)

EN_DOC = (
    ROOT
    / "document_en"
    / "extra"
    / "math"
    / "berlekamp_massey.md"
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
        f"required file is missing: {path}",
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
        r"""(?msx)
        proc[ ]berlekampMassey\*\[T\]\(
        \s*sequence:[ ]openArray\[T\],
        \s*\):[ ]seq\[T\][ ]=
        """,
        source,
    ) is not None,
    "public berlekampMassey signature differs",
)

for fragment in (
    "if sequence.len == 0:",
    "if firstNonzero < 0:",
    "let one =",
    "currentLength",
    "previousDiscrepancy",
    "result[index] =",
    "zero - current[index + 1]",
):
    require(
        fragment in source,
        f"implementation fragment missing: {fragment}",
    )

for fragment in (
    'test "empty and all-zero sequences":',
    'test "Fibonacci recurrence":',
    'test "known order-three recurrence":',
    'test "multiple field types in one module":',
    'test "random generated recurrences reproduce every prefix":',
    'test "returned recurrence is minimal on random prefixes over F_5":',
):
    require(
        fragment in test,
        f"permanent targeted test missing: {fragment}",
    )

require(
    "export modint" in cross_helper,
    "cross-module helper must re-export modint operations",
)

require(
    "recoverCrossModuleFibonacci*" in cross_helper,
    "cross-module helper is missing",
)

require(
    "import support/berlekamp_massey_cross_module_helper"
    in cross_test,
    "cross-module test import is missing",
)

require(
    "recoverCrossModuleFibonacci()" in cross_test,
    "cross-module test call is missing",
)

for fragment in (
    "Berlekamp–Massey",
    "berlekampMassey",
    "直前の項から順",
    "O(n^2)",
    "Kitamasa",
):
    require(
        fragment in ja_doc,
        f"Japanese documentation fragment missing: {fragment}",
    )

for fragment in (
    "Berlekamp–Massey",
    "berlekampMassey",
    "immediately preceding term",
    "O(n^2)",
    "Kitamasa",
):
    require(
        fragment in en_doc,
        f"English documentation fragment missing: {fragment}",
    )

require(
    "BERLEKAMP_MASSEY_AUDIT" in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("BERLEKAMP_MASSEY_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("BERLEKAMP_MASSEY_AUDIT=OK")
print("API=berlekampMassey")
print("RETURN_ORDER=PREVIOUS_TERM_FIRST")
print("KNOWN_TESTS=PASS_REGISTERED")
print("RANDOM_DIFFERENTIAL=REGISTERED")
print("MINIMALITY_OVER_F5=REGISTERED")
print("MULTIPLE_FIELD_TYPES=REGISTERED")
print("CROSS_MODULE_TEST=REGISTERED")
print("COMPLEXITY=O_N_SQUARED_TIME_O_N_MEMORY")
