#!/usr/bin/env python3

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]

SOURCE_PATH = (
    ROOT
    / "src"
    / "atcoder"
    / "extra"
    / "structure"
    / "persistent_segment_tree.nim"
)

source = SOURCE_PATH.read_text(
    encoding="utf-8",
    errors="replace",
)

errors: list[str] = []


def require(
    condition: bool,
    message: str,
) -> None:
    if not condition:
        errors.append(message)


def matches(
    text: str,
    pattern: str,
) -> bool:
    return re.search(
        pattern,
        text,
        flags=re.MULTILINE | re.DOTALL | re.VERBOSE,
    ) is not None


static_marker = re.search(
    r"""
    ^[ ]{4}PersistentVersion\*
    [ ]*=[ ]*distinct[ ]+int
    """,
    source,
    flags=re.MULTILINE | re.VERBOSE,
)

require(
    static_marker is not None,
    "static facade marker is missing",
)

if static_marker is None:
    static_source = ""
else:
    static_source = source[
        static_marker.start():
    ]


require(
    "proc all_prod*[" not in source,
    "explicit all_prod declaration conflicts with allProd",
)

require(
    source.count(
        "  proc allProd*["
    ) == 2,
    "expected one legacy and one static allProd declaration",
)

require(
    static_source.count(
        "  proc allProd*["
    ) == 1,
    "static facade must have exactly one allProd declaration",
)

require(
    "tree.all_prod(version)"
    not in static_source,
    "normalized allProd self-recursion remains",
)

require(
    "tree.impl.allProd(int(version))"
    in static_source,
    "static allProd must explicitly call the legacy backend",
)

require(
    "valuesOrLength: seq[S] or int"
    not in static_source,
    "non-inferable sequence-or-length shorthand remains",
)

require(
    static_source.count(
        "template initPersistentSegmentTree*"
    ) == 2,
    "expected sequence and length shorthand constructors",
)

require(
    matches(
        static_source,
        r"""
        template[ ]initPersistentSegmentTree\*\[S\]\(
        \s*values:[ ]seq\[S\],
        \s*op,
        \s*e:[ ]untyped,
        \s*expectedUpdates:[ ]int[ ]=[ ]0
        """,
    ),
    "sequence shorthand constructor is missing",
)

require(
    matches(
        static_source,
        r"""
        template[ ]initPersistentSegmentTree\*\(
        \s*n:[ ]int,
        \s*op,
        \s*e:[ ]untyped,
        \s*expectedUpdates:[ ]int[ ]=[ ]0
        """,
    ),
    "length shorthand constructor is missing",
)

require(
    "type S = typeof(e())"
    in static_source,
    "length shorthand does not infer S from e()",
)


factory_start = static_source.find(
    "  template PersistentSegTreeType*[S]("
)

factory_end = static_source.find(
    "  proc init*[",
    factory_start,
)

if (
    factory_start < 0
    or factory_end < 0
):
    errors.append(
        "PersistentSegTreeType factory block is missing"
    )
else:
    factory = static_source[
        factory_start:factory_end
    ]

    require(
        factory.count(
            "{.gensym, inline.}"
        ) == 2,
        "PersistentSegTreeType must wrap op and e "
        "with gensym+inline",
    )

    require(
        "op: op1" in factory,
        "PersistentSegTreeType does not store wrapped op",
    )

    require(
        "e: e1" in factory,
        "PersistentSegTreeType does not store wrapped e",
    )


signature_checks = {
    "set argument order": r"""
        proc[ ]set\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]var[ ]PST,
        \s*position:[ ]IndexType,
        \s*value:[ ]PST\.S,
        \s*version:[ ]PersistentVersion
        \s*\):[ ]PersistentVersion[ ]=
    """,

    "get argument order": r"""
        proc[ ]get\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]PST,
        \s*position:[ ]IndexType,
        \s*version:[ ]PersistentVersion
        \s*\):[ ]PST\.S[ ]=
    """,

    "range prod argument order": r"""
        proc[ ]prod\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]PST,
        \s*range:[ ]RangeType,
        \s*version:[ ]PersistentVersion
        \s*\):[ ]PST\.S[ ]=
    """,

    "endpoint prod argument order": r"""
        proc[ ]prod\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]PST,
        \s*left,
        \s*right:[ ]int,
        \s*version:[ ]PersistentVersion
        \s*\):[ ]PST\.S[ ]=
    """,

    "allProd argument order": r"""
        proc[ ]allProd\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]PST,
        \s*version:[ ]PersistentVersion
        \s*\):[ ]PST\.S[ ]=
    """,

    "toSeq argument order": r"""
        proc[ ]toSeq\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]PST,
        \s*version:[ ]PersistentVersion
        \s*\):[ ]seq\[PST\.S\][ ]=
    """,
}

for label, pattern in signature_checks.items():
    require(
        matches(
            static_source,
            pattern,
        ),
        f"signature differs: {label}",
    )


required_fragments = [
    "PersistentVersion* = distinct int",
    "PersistentSegTree*[S; p: static[tuple]]",
    "initialVersion*",
    "expectedUpdates: int = 0",
    "PST.calc_op(left, right)",
    "PST.calc_e()",
    "tree.impl.setValue(",
    "tree.impl.prod(",
    "tree.impl.allProd(",
]

for fragment in required_fragments:
    require(
        fragment in static_source,
        f"required static API fragment missing: {fragment}",
    )


require(
    static_source.count(
        "proc runtimeOp("
    ) == 2,
    "expected two static-to-legacy runtimeOp adapters",
)

require(
    static_source.count(
        "{.closure.}"
    ) >= 2,
    "runtime adapter closure declarations are missing",
)


if errors:
    print("PERSISTENT_SEGTREE_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)


print("PERSISTENT_SEGTREE_API_AUDIT=OK")
print("STATIC_ALLPROD_COUNT=1")
print("GLOBAL_ALLPROD_COUNT=2")
print("VERSION_ARGUMENT_POSITION=LAST")
print("STATIC_FACTORY_WRAP=GENSYM_INLINE")
print("SHORTHAND_OVERLOADS=SEQUENCE_AND_LENGTH")
print("STATIC_RUNTIME_ADAPTER=LEGACY_CLOSURE_COMPATIBILITY")
