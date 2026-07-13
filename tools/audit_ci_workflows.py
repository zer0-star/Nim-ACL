#!/usr/bin/env python3

from __future__ import annotations

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
QUICK_PATH = ROOT / ".github/workflows/verify.yml"
OJ_PATH = ROOT / ".github/workflows/oj-verify.yml"
RUNNER_PATH = ROOT / "tools/run_oj_verify_target.sh"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(f"CI_WORKFLOW_AUDIT_ERROR: {message}")


quick = QUICK_PATH.read_text(encoding="utf-8")
oj = OJ_PATH.read_text(encoding="utf-8")
runner = RUNNER_PATH.read_text(encoding="utf-8")

for name, text in (("quick", quick), ("oj", oj)):
    require(
        "actions/checkout@v5" in text,
        f"{name} workflow must use actions/checkout@v5",
    )
    require(
        "actions/setup-python@v6" in text,
        f"{name} workflow must use actions/setup-python@v6",
    )
    require(
        "python-version: '3.12'" in text,
        f"{name} workflow must pin Python 3.12",
    )
    require(
        "'setuptools<81'" in text,
        f"{name} workflow must preserve setuptools<81",
    )
    require(
        "nim-version: '2.2.10'" in text,
        f"{name} workflow must include Nim 2.2.10",
    )
    require(
        "nim-version: '2.2.4'" in text,
        f"{name} workflow must include Nim 2.2.4",
    )
    require(
        "permissions:" in text and "contents: read" in text,
        f"{name} workflow must use read-only repository permissions",
    )

require(
    'bash tools/run_oj_verify_target.sh "$VERIFY_TARGET"' in oj,
    "oj workflow must dispatch through the target-normalizing helper",
)
require(
    "oj-verify ${{ inputs.verify-target }}" not in oj,
    "oj workflow must not forward the input as a subcommand",
)
require(
    "GITHUB_TOKEN:" not in oj,
    "oj workflow must not expose GITHUB_TOKEN to verification-helper",
)
require(
    "GH_PAT:" not in oj,
    "oj workflow must not expose GH_PAT to verification-helper",
)
require(
    "oj-verify run" in runner,
    "runner must invoke the run subcommand",
)
require(
    '""|all)' in runner,
    "runner must normalize the all target",
)
require(
    "TARGET=\"${TARGET#src/}\"" in runner,
    "runner must accept paths written relative to repository root",
)

print("CI_WORKFLOW_AUDIT_OK")


# NIM_ACL_NIM_RUNTIME_LIFETIME_AUDIT_V1
QUICK_VERIFY_PATH = ROOT / "tools/quick_verify.sh"
quick_verify = QUICK_VERIFY_PATH.read_text(encoding="utf-8")
runtime_cleanup = "rm -rf .nim_runtime nimcache"
pst_end_marker = "# <<< PST_VERSION_FIRST_CROSS_TEST <<<"

require(
    quick_verify.count(runtime_cleanup) == 1,
    (
        "quick_verify must remove .nim_runtime exactly once, "
        "after all Nim-based checks"
    ),
)
require(
    pst_end_marker in quick_verify,
    "quick_verify must retain the PersistentSegTree audit marker",
)
require(
    quick_verify.rfind(runtime_cleanup)
    > quick_verify.rfind(pst_end_marker),
    (
        "quick_verify must keep .nim_runtime alive through "
        "the final Nim-based PersistentSegTree checks"
    ),
)

print("NIM_RUNTIME_LIFETIME_AUDIT_OK")
