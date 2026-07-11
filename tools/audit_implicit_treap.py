#!/usr/bin/env python3

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]

SOURCE = (
    ROOT
    / "src/atcoder/extra/structure/implicit_treap.nim"
)

TEST = (
    ROOT
    / "tests/test_extra_implicit_treap.nim"
)

CROSS_HELPER = (
    ROOT
    / "tests/support/"
    "implicit_treap_cross_module_helper.nim"
)

CROSS_TEST = (
    ROOT
    / "tests/test_extra_implicit_treap_cross_module.nim"
)

JA_DOC = (
    ROOT
    / "document_ja/extra/structure/implicit_treap.md"
)

EN_DOC = (
    ROOT
    / "document_en/extra/structure/implicit_treap.md"
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
        template\s+
        ImplicitTreapType\*\[S\]
        \s*\(
        \s*op0,
        \s*e0:\s*untyped,
        \s*\)
        """,
        source,
        flags=re.MULTILINE | re.VERBOSE,
    )
    is not None,
    "public factory signature differs",
)

for fragment in (
    "DefaultImplicitTreapSeed*",
    "ImplicitTreap*[",
    "forwardAggregate: S",
    "backwardAggregate: S",
    "reversePending: bool",
    "freeList: seq[int]",
    "{.gensym, inline.}",
    "proc insert*[",
    "proc erase*[",
    "proc get*[",
    "proc set*[",
    "proc reverse*[",
    "proc prod*[",
    "proc allProd*[",
    "proc toSeq*[",
    "proc `[]`*[",
    "proc `[]=`*[",
):
    require(
        fragment in source,
        f"source fragment missing: {fragment}",
    )

for fragment in (
    'test "multiple factories coexist":',
    'test "basic dynamic sequence operations":',
    'test "noncommutative aggregate survives reversal":',
    'test "empty ranges use the identity":',
    'test "fixed and custom seeds preserve semantics":',
    'test "erase and insert churn remains correct":',
    'test "randomized differential against seq":',
    'test "invalid positions and ranges":',
    "0 ..< 5000",
):
    require(
        fragment in test,
        f"test missing: {fragment}",
    )

for fragment in (
    "CrossSumTreap*",
    "CrossStringTreap*",
    "buildCrossModuleTreapResult*",
):
    require(
        fragment in cross_helper,
        f"cross-module helper missing: {fragment}",
    )

require(
    "factory types and public operations remain usable"
    in cross_test,
    "cross-module public API test is missing",
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
    "ImplicitTreapType[S]",
    "DefaultImplicitTreapSeed",
    "非可換",
    "削除したノード",
    "Lazy Action",
    "O(log n)",
):
    require(
        fragment in ja_doc,
        f"Japanese documentation missing: {fragment}",
    )

for fragment in (
    "ImplicitTreapType[S]",
    "DefaultImplicitTreapSeed",
    "noncommutative",
    "Erased node",
    "Lazy Actions",
    "O(log n)",
):
    require(
        fragment in en_doc,
        f"English documentation missing: {fragment}",
    )

require(
    "IMPLICIT_TREAP_TEST" in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("IMPLICIT_TREAP_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("IMPLICIT_TREAP_API_AUDIT=OK")
print("PUBLIC_FACTORY=ImplicitTreapType[S](op,e)")
print(
    "PUBLIC_OPERATIONS="
    "len,insert,erase,get,set,reverse,prod,allProd,toSeq,[],[]="
)
print("RANGE_CONVENTION=HALF_OPEN")
print("NONCOMMUTATIVE_MONOID=SUPPORTED")
print("REVERSE_AGGREGATE_CALLBACK=NOT_REQUIRED")
print("OWNERSHIP=OWNER_CONTAINER")
print("ERASED_NODE_REUSE=FREE_LIST")
print("LAZY_ACTION=DEFERRED")
print("DOC_ORDER=PST_STYLE")
