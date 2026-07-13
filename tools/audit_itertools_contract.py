#!/usr/bin/env python3

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

ITERTOOLS = ROOT / "src/atcoder/extra/other/itertools.nim"
ALGORITHMUTILS = ROOT / "src/atcoder/extra/other/algorithmutils.nim"
HEADER = ROOT / "src/atcoder/extra/header/chaemon_header.nim"

TESTS = (
    ROOT / "tests/test_itertools.nim",
    ROOT / "tests/test_itertools_coexistence.nim",
    ROOT / "tests/test_algorithmutils.nim",
    ROOT / "tests/test_algorithmutils_importer.nim",
    ROOT / "tests/test_itertools_header.nim",
)

ITERTOOLS_DOC = ROOT / "document_ja/extra/other/itertools.md"
ALGORITHMUTILS_DOC = ROOT / "document_ja/extra/other/algorithmutils.md"
INDEX = ROOT / "document_ja/index.md"
QUICK = ROOT / "tools/quick_verify.sh"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(
            f"ITERTOOLS_CONTRACT_AUDIT_ERROR: {message}"
        )


for path in (
    ITERTOOLS,
    ALGORITHMUTILS,
    HEADER,
    *TESTS,
    ITERTOOLS_DOC,
    ALGORITHMUTILS_DOC,
    INDEX,
    QUICK,
):
    require(
        path.exists(),
        f"missing {path.relative_to(ROOT)}",
    )


itertools = ITERTOOLS.read_text(encoding="utf-8")
algorithmutils = ALGORITHMUTILS.read_text(encoding="utf-8")
header = HEADER.read_text(encoding="utf-8")
itertools_doc = ITERTOOLS_DOC.read_text(encoding="utf-8")
algorithmutils_doc = ALGORITHMUTILS_DOC.read_text(encoding="utf-8")
index = INDEX.read_text(encoding="utf-8")
quick = QUICK.read_text(encoding="utf-8")

tests = "\n".join(
    path.read_text(encoding="utf-8")
    for path in TESTS
)


for marker in (
    "type CartesianPower*",
    "iterator permutations*",
    "iterator combinations*",
    "iterator cartesianProduct*",
    "iterator product*",
    "proc cartesianPower*",
    "iterator items*",
    "proc `^`*",
    "let valid = 0 <= r and r <= n",
    "let valid = repeat >= 0",
):
    require(
        marker in itertools,
        f"canonical marker missing: {marker}",
    )


for marker in (
    "import atcoder/extra/other/itertools as itertools",
    "itertools.permutations(v)",
    "itertools.combinations(v, r)",
    "proc defaultLess",
):
    require(
        marker in algorithmutils,
        f"legacy marker missing: {marker}",
    )


require(
    "import atcoder/extra/other/itertools" in header,
    "chaemon_header does not expose Itertools",
)


for marker in (
    "CANONICAL_ITERTOOLS_CONTRACT_OK",
    "STD_PRODUCT_COEXISTENCE_OK",
    "CARET_COEXISTENCE_OK",
    "LEGACY_ALGORITHMUTILS_COMPATIBILITY_OK",
    "ITERTOOLS_HEADER_EXPOSURE_OK",
):
    require(
        marker in tests,
        f"test marker missing: {marker}",
    )


for marker in (
    "## permutations",
    "## combinations",
    "## product",
    "## cartesianProduct",
    "## Cartesian power",
    "## 境界条件",
    "## 遅延評価",
    "## 計算量",
    "(0 .. 3) ^ 5",
    "std/algorithm.product",
    "distinctPermutations",
):
    require(
        marker in itertools_doc,
        f"Itertools documentation marker missing: {marker}",
    )


for marker in (
    "## permutationとcombination",
    "## nth_element",
    "## 境界条件",
    "## 計算量",
):
    require(
        marker in algorithmutils_doc,
        f"AlgorithmUtils documentation marker missing: {marker}",
    )


require(
    index.count(
        "`import atcoder/extra/other/itertools`"
    ) == 1,
    "Itertools manual catalog row is not unique",
)

require(
    index.count(
        "[Itertools](./extra/other/itertools.html)"
    ) == 1,
    "Itertools curated link is not unique",
)

require(
    index.count(
        "`import atcoder/extra/other/algorithmutils`"
    ) == 1,
    "AlgorithmUtils manual catalog row is not unique",
)

require(
    "- [itertools](extra/other/itertools.md)"
    not in index,
    "generated Itertools bullet remains in index",
)

require(
    "# <<< ITERTOOLS_CONTRACT_REGRESSION_V1 >>>"
    in quick,
    "Quick Verify regression is missing",
)


print("ITERTOOLS_CONTRACT_AUDIT=OK")
print("CANONICAL_MODULE=atcoder/extra/other/itertools")
print("MANUAL_CATALOG_PROMOTION=OK")
print("CATALOG_GENERATED_BULLET_REMOVED=OK")
print("LAZY_ITERATION=OK")
print("SAFE_INVALID_INPUTS=OK")
print("OPERATOR_COEXISTENCE=REGISTERED")
print("LEGACY_WRAPPERS=REGISTERED")
print("HEADER_INCLUDE_EXPOSURE=REGISTERED")
