#!/usr/bin/env python3

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

SOURCE = ROOT / "src/atcoder/extra/structure/kd_tree.nim"
TEST = ROOT / "tests/test_extra_kd_tree.nim"
HELPER = ROOT / "tests/support/kd_tree_cross_module_helper.nim"
CROSS = ROOT / "tests/test_extra_kd_tree_cross_module.nim"
JA_DOC = ROOT / "document_ja/extra/structure/kd_tree.md"
EN_DOC = ROOT / "document_en/extra/structure/kd_tree.md"
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
helper = read(HELPER)
cross = read(CROSS)
ja_doc = read(JA_DOC)
en_doc = read(EN_DOC)
quick_verify = read(QUICK_VERIFY)

for fragment in (
    "KDPoint*",
    "KDNearestResult*",
    "KDTree*",
    "proc initKDTree*",
    "proc len*",
    "proc nearest*",
    "proc rangeSearch*",
    "Option[",
    "squaredDistance",
):
    require(
        fragment in source,
        f"source fragment missing: {fragment}",
    )

for fragment in (
    'test "empty tree":',
    'test "known nearest point and duplicate tie":',
    'test "half-open orthogonal range":',
    'test "random differential and input preservation":',
):
    require(
        fragment in test,
        f"unit test missing: {fragment}",
    )

require(
    "buildKDTreeCrossModuleResult*" in helper,
    "cross-module helper is missing",
)

require(
    "generic dimensions and public operations" in cross,
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
            "## 返り値と副作用",
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
            "## Return values and side effects",
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
    "initKDTree",
    "nearest",
    "rangeSearch",
    "squaredDistance",
):
    require(
        fragment in ja_doc,
        f"Japanese documentation missing: {fragment}",
    )

    require(
        fragment in en_doc,
        f"English documentation missing: {fragment}",
    )

require(
    "KD_TREE_AND_MINKOWSKI_SUM_TEST" in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("KD_TREE_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("KD_TREE_API_AUDIT=OK")
print("PUBLIC_TYPE=KDTree[D,T]")
print("POINT_TYPE=KDPoint[D,T]")
print("NEAREST_RETURN=Option[KDNearestResult[T]]")
print("RANGE_POLICY=HALF_OPEN")
print("TIE_POLICY=LOWEST_ORIGINAL_INDEX")
print("DOC_ORDER=PST_STYLE")
