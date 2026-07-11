#!/usr/bin/env python3

from pathlib import Path
import unicodedata

ROOT = Path(__file__).resolve().parent.parent


def nfc(value: str) -> str:
    return unicodedata.normalize("NFC", value)


path_map = {
    nfc(str(path.relative_to(ROOT))): path
    for path in ROOT.rglob("*")
    if ".git" not in path.parts
}

documents = {
    "document_ja/extra/ja/graph/最小全域木.md": (
        "# Minimum Spanning Tree（最小全域木）",
        "minimum_spanning_tree",
    ),
    "document_ja/extra/ja/graph/最小全域有向木.md": (
        "# Minimum Arborescence（Directed MST／最小全域有向木）",
        "directedmst",
    ),
    "document_ja/extra/ja/structure/素集合データ構造.md": (
        "# Disjoint Set Union（Union-Find／素集合データ構造）",
        "unionfind",
    ),
    "document_ja/extra/graph/virtual_tree.md": (
        "# Auxiliary Tree（Virtual Tree／仮想木）",
        "abc340/editorial/",
        "abc359/editorial/",
        "euler_tour.md",
    ),
    "document_en/extra/graph/virtual_tree.md": (
        "# Auxiliary Tree (Virtual Tree)",
        "abc340/editorial/",
        "abc359/editorial/",
        "euler_tour.md",
    ),
}

draft_markers = (
    "自動生成された下書き",
    "automatically generated draft",
    "TODO",
)

errors = []

for relative, tokens in documents.items():
    path = path_map.get(nfc(relative))

    if path is None:
        errors.append(
            f"missing document: {relative}"
        )
        continue

    text = path.read_text(
        encoding="utf-8",
        errors="replace",
    )

    for token in tokens:
        if token not in text:
            errors.append(
                f"missing token: {relative}: {token}"
            )

    for marker in draft_markers:
        if marker.lower() in text.lower():
            errors.append(
                f"draft marker remains: {relative}: {marker}"
            )

    html_path = path_map.get(
        nfc(relative[:-3] + ".html")
    )

    if html_path is None:
        errors.append(
            f"missing generated HTML: {relative}"
        )
        continue

    html = html_path.read_text(
        encoding="utf-8",
        errors="replace",
    )

    if 'target="_blank"' not in html:
        errors.append(
            f"external links lack target=_blank: {html_path}"
        )

index_requirements = {
    "document_ja/index.md": (
        "NIM_ACL_CURATED_JA_FACADE_V1",
        "NIM_ACL_CURATED_AUXILIARY_TREE_V1",
        "Minimum Spanning Tree（最小全域木）",
        "Minimum Arborescence（Directed MST／最小全域有向木）",
        "Disjoint Set Union（Union-Find／素集合データ構造）",
        "Auxiliary Tree（Virtual Tree／仮想木）",
    ),
    "document_en/index.md": (
        "NIM_ACL_CURATED_AUXILIARY_TREE_V1",
        "Auxiliary Tree (Virtual Tree)",
    ),
}

for relative, tokens in index_requirements.items():
    path = ROOT / relative
    text = path.read_text(encoding="utf-8")

    for token in tokens:
        if token not in text:
            errors.append(
                f"index token missing: {relative}: {token}"
            )

    headings = (
        "## 自動生成ドキュメント一覧",
        "## Auto-generated documentation list",
    )

    positions = [
        text.find(heading)
        for heading in headings
        if text.find(heading) >= 0
    ]

    if positions:
        automatic = text[min(positions):]

        for token in (
            "extra/ja/graph/最小全域木.",
            "extra/ja/graph/最小全域有向木.",
            "extra/ja/structure/素集合データ構造.",
            "extra/graph/virtual_tree.",
        ):
            if token in automatic:
                errors.append(
                    f"automatic duplicate remains: "
                    f"{relative}: {token}"
                )

if errors:
    print("CURATED_DOCS_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("CURATED_DOCS_AUDIT=OK")
print("PRIMARY_NAME_POLICY=authoritative_or_common_first")
print("ALTERNATIVE_NAMES=parenthesized")
print("CURATED_DOCUMENTS=5")
