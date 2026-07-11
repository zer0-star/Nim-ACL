#!/usr/bin/env python3

from __future__ import annotations

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent.parent

MONOTONE_URL = (
    "https://atcoder.jp/contests/"
    "abc348/tasks/abc348_g"
)

BASEBALL_URL = (
    "https://atcoder.jp/contests/"
    "abc355/tasks/abc355_g"
)

required = {
    "src/atcoder/extra/dp/monotone_minima.nim": [
        "proc monotoneMinima*",
        "proc divideAndConquerOptimization*",
        "proc divideAndConquerDpLayer*",
    ],

    (
        "src/atcoder/extra/dp/"
        "divide_and_conquer_optimization.nim"
    ): [
        (
            "import atcoder/extra/dp/"
            "monotone_minima"
        ),
        "export monotone_minima",
    ],

    "tests/test_extra_monotone_minima.nim": [
        "randomized differential",
        "evaluation count remains subquadratic",
        "divideAndConquerDpLayer",
    ],

    "document_ja/extra/dp/monotone_minima.md": [
        "# Monotone Minima",
        MONOTONE_URL,
        BASEBALL_URL,
    ],

    "document_en/extra/dp/monotone_minima.md": [
        "# Monotone Minima",
        MONOTONE_URL,
        BASEBALL_URL,
    ],

    (
        "document_ja/extra/dp/"
        "divide_and_conquer_optimization.md"
    ): [
        "# Divide-and-Conquer Optimization",
        "monotone_minima.md",
    ],

    (
        "document_en/extra/dp/"
        "divide_and_conquer_optimization.md"
    ): [
        "# Divide-and-Conquer Optimization",
        "monotone_minima.md",
    ],

    "document_ja/extra/dp/monotone_minima.html": [
        "Monotone Minima",
        MONOTONE_URL,
        BASEBALL_URL,
        'target="_blank"',
        "noopener",
    ],

    "document_en/extra/dp/monotone_minima.html": [
        "Monotone Minima",
        MONOTONE_URL,
        BASEBALL_URL,
        'target="_blank"',
        "noopener",
    ],
}

errors: list[str] = []

for relative, tokens in required.items():
    path = ROOT / relative

    if not path.exists():
        errors.append(
            f"missing file: {relative}"
        )
        continue

    text = path.read_text(
        encoding="utf-8",
        errors="replace",
    )

    for token in tokens:
        if token not in text:
            errors.append(
                f"missing token in {relative}: {token}"
            )

canonical = (
    ROOT
    / "src"
    / "atcoder"
    / "extra"
    / "dp"
    / "monotone_minima.nim"
).read_text(
    encoding="utf-8"
)

alias = (
    ROOT
    / "src"
    / "atcoder"
    / "extra"
    / "dp"
    / "divide_and_conquer_optimization.nim"
).read_text(
    encoding="utf-8"
)

if len(canonical.splitlines()) > 180:
    errors.append(
        "canonical implementation is unexpectedly large"
    )

if len(alias.splitlines()) > 12:
    errors.append(
        "forwarding module is unexpectedly large"
    )

for forbidden in (
    "sort(",
    "newSeqWith",
    "import std/",
):
    if forbidden in alias:
        errors.append(
            "forwarding module contains implementation logic: "
            + forbidden
        )

quick_verify = (
    ROOT
    / "tools"
    / "quick_verify.sh"
).read_text(
    encoding="utf-8"
)

for entry in (
    "tests/test_extra_monotone_minima.nim",
    "python3 tools/audit_dp_optimization.py",
):
    if quick_verify.count(entry) != 1:
        errors.append(
            "quick_verify registration count differs: "
            + entry
        )

print("DP_OPTIMIZATION_CANONICAL_MODULES=1")
print("DP_OPTIMIZATION_ALIAS_MODULES=1")
print("DP_OPTIMIZATION_TESTS=1")
print("DP_OPTIMIZATION_PROBLEM_PAGES=4")
print("DP_OPTIMIZATION_PROBLEM_LINKS=8")

if errors:
    print("DP_OPTIMIZATION_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("DP_OPTIMIZATION_AUDIT=OK")
