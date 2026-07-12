#!/usr/bin/env python3

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]

SOURCE = ROOT / "src/atcoder/extra/graph/bflow.nim"
VERIFY = ROOT / "src/verify/extra/graph/min_cost_b_flow_test.nim"
TEST = ROOT / "tests/test_extra_bflow.nim"
CROSS_HELPER = ROOT / "tests/support/bflow_cross_module_helper.nim"
CROSS_TEST = ROOT / "tests/test_extra_bflow_cross_module.nim"
JA_DOC = ROOT / "document_ja/extra/graph/bflow.md"
EN_DOC = ROOT / "document_en/extra/graph/bflow.md"
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
verify = read(VERIFY)
test = read(TEST)
cross_helper = read(CROSS_HELPER)
cross_test = read(CROSS_TEST)
ja_doc = read(JA_DOC)
en_doc = read(EN_DOC)
quick_verify = read(QUICK_VERIFY)

for fragment in (
    "BFlow*[CAP, COST]",
    "proc initBFlow*",
    "proc add_supply*",
    "proc add_demand*",
    "proc add_edge*",
    "lower_cap",
    "upper_cap",
    "proc solve*",
    "infeasible*: bool",
    "f*: seq[CAP]",
    "potential*: seq[COST]",
):
    require(
        fragment in source,
        f"source fragment missing: {fragment}",
    )

require(
    "import atcoder/extra/graph/bflow" in verify,
    "existing verifier import is missing",
)

for fragment in (
    'test "lower bound, cost, flow order, and potentials":',
    'test "parallel edges use input-edge order":',
    'test "negative edge costs":',
    'test "capacity shortage is reported by solve":',
    'test "unbalanced total supply and demand":',
    'test "invalid lower and upper bounds":',
):
    require(
        fragment in test,
        f"unit test missing: {fragment}",
    )

require(
    "buildCrossModuleBFlowResult*" in cross_helper,
    "cross-module helper is missing",
)

require(
    "public type and operations remain usable" in cross_test,
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
    "solve()[0]",
    "flow.f[edgeId]",
    "flow.potential",
    "lower > upper",
    "flow.infeasible",
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
    "BFLOW_TEST" in quick_verify,
    "quick_verify registration is missing",
)

if errors:
    print("BFLOW_API_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("BFLOW_API_AUDIT=OK")
print("PUBLIC_TYPE=BFlow[CAP,COST]")
print(
    "PUBLIC_API="
    "initBFlow,add_supply,add_demand,add_edge,solve"
)
print("GENERAL_FEASIBILITY=solve()[0]")
print("FLOW_RECOVERY=flow.f_IN_INPUT_EDGE_ORDER")
print("POTENTIAL_RECOVERY=flow.potential")
print("DOC_ORDER=PST_STYLE")
