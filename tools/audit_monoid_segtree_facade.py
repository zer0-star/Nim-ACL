#!/usr/bin/env python3

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]

MONOID = ROOT / "src/atcoder/extra/monoid/monoid.nim"
FACADE = ROOT / "src/atcoder/extra/structure/monoid_segtree.nim"
HEADER = ROOT / "src/atcoder/extra/header/chaemon_header.nim"

TESTS = (
    ROOT / "tests/test_action_monoid_alias.nim",
    ROOT / "tests/test_monoid_segtree_facade.nim",
    ROOT / "tests/test_monoid_segtree_header.nim",
)

DOCS = (
    ROOT / "document_ja/extra/structure/monoid_segtree.md",
    ROOT / "document_ja/extra/monoid/monoid.md",
    ROOT / "document_ja/segtree.md",
    ROOT / "document_ja/lazysegtree.md",
)

INDEX = ROOT / "document_ja/index.md"
QUICK = ROOT / "tools/quick_verify.sh"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(
            "MONOID_SEGTREE_FACADE_AUDIT_ERROR: "
            + message
        )


for path in (
    MONOID,
    FACADE,
    HEADER,
    *TESTS,
    *DOCS,
    INDEX,
    QUICK,
):
    require(
        path.exists(),
        f"missing {path.relative_to(ROOT)}",
    )


monoid = MONOID.read_text(encoding="utf-8")
facade = FACADE.read_text(encoding="utf-8")
header = HEADER.read_text(encoding="utf-8")

tests = "\n".join(
    path.read_text(encoding="utf-8")
    for path in TESTS
)

facade_doc = DOCS[0].read_text(encoding="utf-8")
monoid_doc = DOCS[1].read_text(encoding="utf-8")
segtree_doc = DOCS[2].read_text(encoding="utf-8")
lazy_doc = DOCS[3].read_text(encoding="utf-8")

index = INDEX.read_text(encoding="utf-8")
quick = QUICK.read_text(encoding="utf-8")


require(
    re.search(
        r"""
        template\s+useActionMonoid\*\(
        \s*Name,
        \s*MF,
        \s*MS,
        \s*mapping0:
        """,
        monoid,
        flags=re.DOTALL | re.VERBOSE,
    )
    is not None,
    "useActionMonoid does not present MF before MS",
)

require(
    "useActedMonoid(" in monoid,
    "legacy useActedMonoid delegation is missing",
)

require(
    "template useActionMonoid*" not in facade,
    "facade duplicates useActionMonoid",
)

for marker in (
    "import atcoder/extra/monoid/monoid",
    "import atcoder/segtree",
    "import atcoder/lazysegtree",
    "export monoid",
    "export segtree",
    "export lazysegtree",
    "template initSegTree*",
    "template initLazySegTree*",
    "values[i] = identity",
    "actionComposition",
):
    require(
        marker in facade,
        f"facade marker missing: {marker}",
    )


require(
    facade.count("template initSegTree*") == 2,
    "expected two initSegTree descriptor overloads",
)

require(
    facade.count("template initLazySegTree*") == 2,
    "expected two initLazySegTree descriptor overloads",
)

require(
    "newSeq[S](n)" not in facade,
    "length constructor uses default(S) directly",
)

require(
    (
        "import atcoder/extra/structure/monoid_segtree"
        in header
    ),
    "chaemon_header does not expose the facade",
)


for marker in (
    "USE_ACTION_MONOID_DIRECT_IMPORT_OK",
    "PUBLIC_F_BEFORE_S_OK",
    "LEGACY_S_BEFORE_F_OK",
    "SEGTREE_DESCRIPTOR_OK",
    "SEGTREE_UFCS_OK",
    "SEGTREE_LENGTH_IDENTITY_OK",
    "SEGTREE_CALLBACK_OK",
    "LAZY_DESCRIPTOR_OK",
    "LAZY_UFCS_OK",
    "LAZY_LENGTH_IDENTITY_OK",
    "LAZY_LEGACY_DESCRIPTOR_OK",
    "LAZY_CALLBACK_OK",
    "NONCOMMUTATIVE_COMPOSITION_OK",
    "CHAEMON_HEADER_MONOID_SEGTREE_OK",
):
    require(
        marker in tests,
        f"test marker missing: {marker}",
    )


for marker in (
    "## Monoid記述子",
    "## SegTreeの構築",
    "## ActionMonoid",
    "## LazySegTreeの構築",
    "## 作用の合成順序",
    "## 既存callback APIとの共存",
    "useActionMonoid(",
    "op(f, g)(x) = f(g(x))",
):
    require(
        marker in facade_doc,
        f"facade documentation marker missing: {marker}",
    )


require(
    "NIM_ACL_ACTION_MONOID_FACADE_START"
    in monoid_doc,
    "Monoid documentation extension is missing",
)

require(
    "NIM_ACL_MONOID_SEGTREE_FACADE_START"
    in segtree_doc,
    "SegTree documentation extension is missing",
)

require(
    "NIM_ACL_LAZY_MONOID_SEGTREE_FACADE_START"
    in lazy_doc,
    "LazySegTree documentation extension is missing",
)


require(
    index.count(
        "`import atcoder/extra/structure/monoid_segtree`"
    ) == 1,
    "facade catalog import marker is not unique",
)

require(
    index.count(
        "[Monoid SegTree facade]"
        "(./extra/structure/monoid_segtree.html)"
    ) == 1,
    "facade catalog link is not unique",
)

require(
    "- [monoid_segtree]"
    "(extra/structure/monoid_segtree.md)"
    not in index,
    "generated facade bullet remains",
)

require(
    (
        "# <<< MONOID_SEGTREE_FACADE_REGRESSION_V1 >>>"
        in quick
    ),
    "Quick Verify facade regression is missing",
)


print("MONOID_SEGTREE_FACADE_AUDIT=OK")
print("PUBLIC_ACTION_ORDER=F_BEFORE_S")
print("LEGACY_ACTION_ORDER=S_BEFORE_F_PRESERVED")
print("LENGTH_INITIALIZATION=MONOID_IDENTITY")
print("COMPOSITION_ORDER=F_AFTER_G")
print("CALLBACK_COMPATIBILITY=REGISTERED")
print("HEADER_EXPOSURE=REGISTERED")
