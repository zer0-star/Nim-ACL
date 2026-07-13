#!/usr/bin/env python3

from __future__ import annotations

import json
import pathlib
import re
import sys


ROOT = pathlib.Path(__file__).resolve().parents[1]

POLICY_PATH = ROOT / "tools/nim_version_policy.json"
QUICK_WORKFLOW = ROOT / ".github/workflows/verify.yml"
OJ_WORKFLOW = ROOT / ".github/workflows/oj-verify.yml"


def fail(message: str) -> None:
    print(f"NIM_VERSION_MATRIX_AUDIT=NG")
    print(message)
    raise SystemExit(1)


def required_entry(
    text: str,
    profile: str,
    version: str,
    workflow_name: str,
) -> None:
    pattern = (
        rf"- profile:\s*{re.escape(profile)}\s*"
        rf"\n\s*nim-version:\s*['\"]"
        rf"{re.escape(version)}['\"]"
    )

    if not re.search(pattern, text):
        fail(
            f"{workflow_name} is missing "
            f"{profile} / Nim {version}"
        )


policy = json.loads(
    POLICY_PATH.read_text(encoding="utf-8")
)

latest = policy["latest"]
atcoder = policy["atcoder"]
legacy = policy["atcoder_legacy"]

quick = QUICK_WORKFLOW.read_text(encoding="utf-8")
oj = OJ_WORKFLOW.read_text(encoding="utf-8")

for name, text in (
    ("quick-verify", quick),
    ("oj-verify", oj),
):
    required_entry(
        text,
        "latest",
        latest,
        name,
    )

    required_entry(
        text,
        "atcoder",
        atcoder,
        name,
    )

    if "fail-fast: false" not in text:
        fail(f"{name} must use fail-fast: false")

    if "nim-version: ${{ matrix.nim-version }}" not in text:
        fail(
            f"{name} setup-nim step is not matrix-backed"
        )

if "tools/run_nim_compatibility.sh" not in quick:
    fail(
        "quick-verify does not use "
        "the local compatibility runner"
    )

if re.search(
    r"(?m)^\s{6}nim-version:\s*$",
    oj,
):
    fail(
        "oj-verify still exposes the old "
        "single-version workflow input"
    )

print("NIM_VERSION_MATRIX_AUDIT=OK")
print(f"LATEST_NIM_VERSION={latest}")
print(f"ATCODER_NIM_VERSION={atcoder}")
print(f"ATCODER_LEGACY_NIM_VERSION={legacy}")
print("REQUIRED_PROFILES=latest,atcoder")
print("QUICK_VERIFY_MATRIX=OK")
print("OJ_VERIFY_MATRIX=OK")
