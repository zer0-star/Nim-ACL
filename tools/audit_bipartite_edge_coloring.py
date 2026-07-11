#!/usr/bin/env python3

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]

SOURCE = (
    ROOT
    / "src/atcoder/extra/graph/bipartite_edge_coloring.nim"
)

TEST = (
    ROOT
    / "tests/test_extra_bipartite_edge_coloring.nim"
)

CROSS_HELPER = (
    ROOT
    / "tests/support/"
    "bipartite_edge_coloring_cross_module_helper.nim"
)

CROSS_TEST = (
    ROOT
    / "tests/"
    "test_extra_bipartite_edge_coloring_cross_module.nim"
)

JA_DOC = (
    ROOT
    / "document_ja/extra/graph/bipartite_edge_coloring.md"
)

EN_DOC = (
    ROOT
    / "document_en/extra/graph/bipartite_edge_coloring.md"
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
        proc\s+
        bipartiteEdgeColoring\*
        \s*\(
        \s*leftCount,
        \s*rightCount:\s*int,
        \s*edges:\s*openArray\[
        \(int,\s*int\)
        \]
        """,
        source,
        flags=re.MULTILINE | re.VERBOSE,
    )
    is not None,
    "public signature differs",
)

for fragment in (
    "import atcoder/extra/graph/hopcroft_karp",
    "originalEdgeIds: seq[int]",
    "dummyCount: int",
    "initHopcroftKarp(",
    "matching.maximum_matching()",
    "left endpoint is out of range",
    "right endpoint is out of range",
    "regularized graph has no perfect matching",
):
    require(
        fragment in source,
        f"source fragment missing: {fragment}",
    )

for fragment in (
    'test "empty graph":',
    'test "simple graph":',
    'test "parallel edges":',
    'test "rectangular multigraph":',
    'test "large padding uses compressed dummy multiplicities":',
    'test "invalid counts and endpoints":',
    'test "randomized bipartite multigraphs":',
):
    require(
        fragment in test,
        f"test missing: {fragment}",
    )

require(
    "buildCrossModuleEdgeColors*" in cross_helper,
    "cross-module helper is missing",
)

require(
    "public free-function API remains visible" in cross_test,
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
    "bipartiteEdgeColoring(",
    "平行辺",
    "入力順序",
    "0 ..< Δ",
    "O(Δ (M + N) sqrt(N))",
):
    require(
        fragment in ja_doc,
        f"Japanese documentation missing: {fragment}",
    )

for fragment in (
    "bipartiteEdgeColoring(",
    "Parallel edges",
    "input order",
    "0 ..< Δ",
    "O(Δ (M + N) sqrt(N))",
):
    require(
        fragment in en_doc,
        f"English documentation missing: {fragment}",
    )

require(
    "BIPARTITE_EDGE_COLORING_TEST" in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("BIPARTITE_EDGE_COLORING_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("BIPARTITE_EDGE_COLORING_API_AUDIT=OK")
print(
    "PUBLIC_API="
    "bipartiteEdgeColoring(leftCount,rightCount,edges)"
)
print("RETURN_TYPE=seq[int]")
print("EDGE_ORDER=INPUT_EDGE_ORDER")
print("COLOR_COUNT=MAXIMUM_DEGREE")
print("PARALLEL_EDGES=SUPPORTED")
print("BACKEND=HOPCROFT_KARP")
print("DOC_ORDER=PST_STYLE")
