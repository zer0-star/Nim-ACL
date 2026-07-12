#!/usr/bin/env python3

from __future__ import annotations

import argparse
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

JA_MD = ROOT / "document_ja/index.md"
EN_MD = ROOT / "document_en/index.md"
JA_HTML = ROOT / "document_ja/index.html"
EN_HTML = ROOT / "document_en/index.html"

START = "<!-- NIM_ACL_HOME_NAV_START -->"
END = "<!-- NIM_ACL_HOME_NAV_END -->"

parser = argparse.ArgumentParser()
parser.add_argument(
    "--html",
    action="store_true",
)
args = parser.parse_args()

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
        f"missing file: {path}",
    )

    if not path.is_file():
        return ""

    return path.read_text(
        encoding="utf-8",
        errors="replace",
    )


ja = read(JA_MD)
en = read(EN_MD)

for label, text in (
    ("Japanese", ja),
    ("English", en),
):
    require(
        text.count(START) == 1,
        f"{label} start marker count differs",
    )

    require(
        text.count(END) == 1,
        f"{label} end marker count differs",
    )

required_links = [
    "./segtree.html",
    "./lazysegtree.html",
    "./fenwicktree.html",
    "./convolution.html",
    "./maxflow.html",
    "./mincostflow.html",
    "./dsu.html",
    "./scc.html",
    "./string.html",
    "./modint.html",
    "./extra/dp/monotone_minima.html",
    "./extra/dp/divide_and_conquer_optimization.html",
    "./extra/dp/smawk.html",
    "./extra/math/berlekamp_massey.html",
    "./extra/math/polynomial_interpolation.html",
    "./extra/math/subset_convolution.html",
    "./extra/math/exp_of_set_power_series.html",
    "./extra/math/log_of_set_power_series.html",
    "./extra/math/fps.html",
    "./extra/structure/persistent_segment_tree.html",
    "./extra/structure/implicit_treap.html",
    "./extra/structure/kd_tree.html",
    "./extra/structure/binary_trie.html",
    "./extra/graph/bipartite_edge_coloring.html",
    "./extra/graph/bflow.html",
    "./extra/geometry/minkowski_sum.html",
    "./guide/atcoder_level_guide.html",
    "./guide/atcoder_algorithm_lectures_coverage.html",
]

for link in required_links:
    require(
        link in ja,
        f"Japanese index missing link: {link}",
    )

    require(
        link in en,
        f"English index missing link: {link}",
    )

for fragment in (
    "KD-tree",
    "Minkowski Sum",
    "Set Power Series",
    "Minimum-Cost B-Flow",
    "Binary Trie",
):
    require(
        fragment in ja,
        f"Japanese index missing: {fragment}",
    )

    require(
        fragment in en,
        f"English index missing: {fragment}",
    )

ja_headings = [
    "## ライブラリマップ",
    "### まず使う標準API",
    "### 最近追加・整備されたAPI",
    "### 分野別追加ライブラリ",
    "### ガイド",
    "### ドキュメントの構成",
]

en_headings = [
    "## Library map",
    "### Start with the standard APIs",
    "### Recently added or substantially improved",
    "### Additional libraries by category",
    "### Guides",
    "### Documentation structure",
]

for label, text, headings in (
    ("Japanese", ja, ja_headings),
    ("English", en, en_headings),
):
    positions = [
        text.find(heading)
        for heading in headings
    ]

    require(
        all(position >= 0 for position in positions),
        f"{label} heading is missing",
    )

    require(
        positions == sorted(positions),
        f"{label} heading order differs",
    )

if args.html:
    ja_html = read(JA_HTML)
    en_html = read(EN_HTML)

    for label, text, heading in (
        (
            "Japanese HTML",
            ja_html,
            "ライブラリマップ",
        ),
        (
            "English HTML",
            en_html,
            "Library map",
        ),
    ):
        require(
            heading in text,
            f"{label} navigation heading missing",
        )

        for fragment in (
            "extra/structure/kd_tree.html",
            "extra/geometry/minkowski_sum.html",
            "extra/math/log_of_set_power_series.html",
            "extra/graph/bflow.html",
            "guide/atcoder_level_guide.html",
        ):
            require(
                fragment in text,
                f"{label} missing: {fragment}",
            )

if errors:
    print("DOCS_HOMEPAGE_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("DOCS_HOMEPAGE_AUDIT=OK")
print("LANGUAGES=JA_AND_EN")
print("STANDARD_ACL_NAVIGATION=REGISTERED")
print("RECENT_ADDITIONS=REGISTERED")
print("CATEGORY_MAP=REGISTERED")
print("GUIDES=REGISTERED")
print(
    "GENERATED_HTML="
    + (
        "AUDITED"
        if args.html
        else "DEFERRED"
    )
)
