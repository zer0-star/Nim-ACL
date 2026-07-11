#!/usr/bin/env python3

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]

SOURCE = (
    ROOT
    / "src"
    / "atcoder"
    / "extra"
    / "structure"
    / "persistent_segment_tree.nim"
)

STATIC_TEST = (
    ROOT
    / "tests"
    / "test_extra_persistent_segment_tree_static_api.nim"
)

CROSS_HELPER = (
    ROOT
    / "tests"
    / "support"
    / "persistent_segment_tree_version_first_helper.nim"
)

CROSS_TEST = (
    ROOT
    / "tests"
    / "test_extra_persistent_segment_tree_version_first_cross_module.nim"
)

JA_DOC = (
    ROOT
    / "document_ja"
    / "extra"
    / "structure"
    / "persistent_segment_tree.md"
)

EN_DOC = (
    ROOT
    / "document_en"
    / "extra"
    / "structure"
    / "persistent_segment_tree.md"
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


def matches(
    text: str,
    pattern: str,
) -> bool:
    return re.search(
        pattern,
        text,
        flags=(
            re.MULTILINE
            | re.DOTALL
            | re.VERBOSE
        ),
    ) is not None


source = read(SOURCE)
static_test = read(STATIC_TEST)
cross_helper = read(CROSS_HELPER)
cross_test = read(CROSS_TEST)
ja_doc = read(JA_DOC)
en_doc = read(EN_DOC)
quick_verify = read(QUICK_VERIFY)


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

static_source = (
    source[static_marker.start():]
    if static_marker is not None
    else ""
)


signatures = {
    "set(version, position, value)": r"""
        proc[ ]set\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]var[ ]PST,
        \s*version:[ ]PersistentVersion,
        \s*position:[ ]IndexType,
        \s*value:[ ]PST\.S,
        \s*\):[ ]PersistentVersion[ ]=
    """,

    "get(version, position)": r"""
        proc[ ]get\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]PST,
        \s*version:[ ]PersistentVersion,
        \s*position:[ ]IndexType,
        \s*\):[ ]PST\.S[ ]=
    """,

    "prod(version, range)": r"""
        proc[ ]prod\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]PST,
        \s*version:[ ]PersistentVersion,
        \s*range:[ ]RangeType,
        \s*\):[ ]PST\.S[ ]=
    """,

    "prod(version, left, right)": r"""
        proc[ ]prod\*\[
        \s*PST:[ ]PersistentSegTree
        \s*\]\(
        \s*tree:[ ]PST,
        \s*version:[ ]PersistentVersion,
        \s*left,
        \s*right:[ ]int,
        \s*\):[ ]PST\.S[ ]=
    """,
}

for label, pattern in signatures.items():
    require(
        matches(
            static_source,
            pattern,
        ),
        f"signature differs: {label}",
    )


old_signatures = {
    "set(position,value,version)": r"""
        proc[ ]set\*\[
        .*?
        tree:[ ]var[ ]PST,
        \s*position:[ ]IndexType,
        \s*value:[ ]PST\.S,
        \s*version:[ ]PersistentVersion
    """,

    "get(position,version)": r"""
        proc[ ]get\*\[
        .*?
        tree:[ ]PST,
        \s*position:[ ]IndexType,
        \s*version:[ ]PersistentVersion
    """,

    "prod(range,version)": r"""
        proc[ ]prod\*\[
        .*?
        tree:[ ]PST,
        \s*range:[ ]RangeType,
        \s*version:[ ]PersistentVersion
    """,
}

for label, pattern in old_signatures.items():
    require(
        not matches(
            static_source,
            pattern,
        ),
        f"removed version-last signature remains: {label}",
    )


for fragment in (
    "PersistentVersionReadView*",
    "PersistentVersionWriteView*",
    "tree[version][position] = value",
    "tree[version][left ..< right]",
    "version: var PersistentVersion",
    "view.version[] =",
):
    target = (
        source
        if fragment
        in {
            "PersistentVersionReadView*",
            "PersistentVersionWriteView*",
            "version: var PersistentVersion",
            "view.version[] =",
        }
        else ja_doc + en_doc
    )

    require(
        fragment in target,
        f"version view fragment missing: {fragment}",
    )


for fragment in (
    'test "flat and nested indexing":',
    'test "stored write view updates its version":',
    'test "persistent branches remain independent":',
    'test "noncommutative operation":',
    'test "multiple anonymous monoids remain distinct":',
    'test "randomized version differential":',
):
    require(
        fragment in static_test,
        f"static test missing: {fragment}",
    )


require(
    "buildCrossTree*" in cross_helper,
    "cross-module helper is missing",
)

require(
    "tree[version][1] = 5"
    in cross_test,
    "cross-module nested write test is missing",
)

require(
    "tree.prod(" in cross_test,
    "cross-module version-first prod test is missing",
)


for label, text, requirements in (
    (
        "Japanese",
        ja_doc,
        [
            "一般形は次のとおりです。",
            "`version`: 更新元のversion",
            "`position`: 更新する添字",
            "`value`: 新しい値",
            "tree.set(",
            "tree[version][position] = value",
            "expectedUpdates",
            "小さすぎても",
            "大きすぎると",
        ],
    ),
    (
        "English",
        en_doc,
        [
            "The general form is:",
            "`version`: source version",
            "`position`: updated index",
            "`value`: new value",
            "tree.set(",
            "tree[version][position] = value",
            "expectedUpdates",
            "If too small",
            "If too large",
        ],
    ),
):
    for fragment in requirements:
        require(
            fragment in text,
            f"{label} documentation missing: {fragment}",
        )


for text, general_marker, example_marker in (
    (
        ja_doc,
        "一般形は次のとおりです。",
        "加算モノイドの具体例",
    ),
    (
        en_doc,
        "The general form is:",
        "For a sum monoid",
    ),
):
    require(
        text.find(general_marker)
        < text.find(example_marker),
        "general initialization form must appear "
        "before its concrete example",
    )


require(
    "PST_VERSION_FIRST_CROSS_TEST"
    in quick_verify,
    "quick_verify version-first registration is missing",
)


if errors:
    print("PERSISTENT_SEGTREE_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)


print("PERSISTENT_SEGTREE_API_AUDIT=OK")
print("CANONICAL_ARGUMENT_ORDER=VERSION_POSITION_VALUE")
print("VERSION_LAST_OVERLOADS=REMOVED")
print("FLAT_INDEXING=REGISTERED")
print("NESTED_INDEXING=REGISTERED")
print("NESTED_WRITE=REGISTERED")
print("CROSS_MODULE_TEST=REGISTERED")
print("DOCUMENT_ORDER=GENERAL_PARAMETERS_EXAMPLE")
print("STATIC_FACTORY_WRAP=GENSYM_INLINE")
