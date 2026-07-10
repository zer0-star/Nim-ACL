#!/usr/bin/env python3

from __future__ import annotations

from pathlib import Path
import unicodedata

ROOT = Path(__file__).resolve().parent.parent

EXPECTED_MODULES = {
    (
        "src/atcoder/extra/ja/graph/"
        "最小全域木.nim"
    ): [
        "proc 最小全域木*",
        "kruskal(g)",
    ],

    (
        "src/atcoder/extra/ja/graph/"
        "最小全域有向木.nim"
    ): [
        "proc 最小全域有向木*",
        "minimumArborescence(",
    ],

    (
        "src/atcoder/extra/ja/structure/"
        "素集合データ構造.nim"
    ): [
        "素集合データ構造* = DSU",
        "proc 素集合データ構造を初期化*",
        "proc 併合*",
        "proc 同じ集合か*",
        "proc 代表元*",
        "proc 集合の大きさ*",
        "proc 集合一覧*",
    ],
}

EXPECTED_FILES = {
    (
        "src/atcoder/extra/graph/"
        "minimum_arborescence.nim"
    ): [
        "proc minimumArborescence*",
        "minimumSpanningTreeArborescence(",
    ],

    "tests/test_extra_ja_facades.nim": [
        'import "atcoder/extra/ja/graph/最小全域木"',
        (
            'import "atcoder/extra/ja/graph/'
            '最小全域有向木"'
        ),
        (
            'import "atcoder/extra/ja/structure/'
            '素集合データ構造"'
        ),
        "最小全域木(g)",
        "最小全域有向木(",
        "素集合データ構造を初期化(",
    ],

    "document_ja/extra/ja/index.md": [
        "# 日本語API（試験的）",
        "最小全域木",
        "最小全域有向木",
        "素集合データ構造",
    ],

    "document_en/extra/ja/index.md": [
        "# Japanese API facades (experimental)",
        "最小全域木",
        "最小全域有向木",
        "素集合データ構造",
    ],
}

EXPECTED_GENERATED_DOCS = {
    "document_ja/extra/ja/index.html": [
        "日本語API",
        "最小全域木",
        "最小全域有向木",
        "素集合データ構造",
    ],

    "document_en/extra/ja/index.html": [
        "Japanese API facades",
        "最小全域木",
        "最小全域有向木",
        "素集合データ構造",
    ],
}

EXPECTED_MARKER_DOCS = [
    "document_ja/extra/graph/kruskal.md",
    (
        "document_ja/extra/graph/"
        "chu_liu_edmonds.md"
    ),
    (
        "document_en/extra/graph/"
        "chu_liu_edmonds.md"
    ),
    "document_ja/dsu.md",
    "document_en/dsu.md",
]

FACADE_START = (
    "<!-- NIM_ACL_JAPANESE_FACADE_V1 -->"
)

FACADE_END = (
    "<!-- /NIM_ACL_JAPANESE_FACADE_V1 -->"
)

INDEX_START = (
    "<!-- NIM_ACL_JAPANESE_FACADE_INDEX_V1 -->"
)

INDEX_END = (
    "<!-- /NIM_ACL_JAPANESE_FACADE_INDEX_V1 -->"
)

errors: list[str] = []


def normalized_relative(path: Path) -> str:
    return unicodedata.normalize(
        "NFC",
        str(path.relative_to(ROOT)),
    )


def read_file(path: Path) -> str:
    if not path.exists():
        errors.append(
            f"missing file: {path.relative_to(ROOT)}"
        )
        return ""

    return path.read_text(
        encoding="utf-8",
    )


files_by_normalized_path: dict[str, Path] = {}

for path in ROOT.rglob("*"):
    if not path.is_file():
        continue

    normalized = normalized_relative(path)

    if normalized in files_by_normalized_path:
        errors.append(
            "Unicode-normalization collision: "
            f"{normalized}"
        )
        continue

    files_by_normalized_path[normalized] = path


expected_module_paths = {
    unicodedata.normalize(
        "NFC",
        relative,
    )
    for relative in EXPECTED_MODULES
}

actual_module_paths = {
    normalized_relative(path)
    for path in (
        ROOT
        / "src"
        / "atcoder"
        / "extra"
        / "ja"
    ).rglob("*.nim")
}

if actual_module_paths != expected_module_paths:
    errors.append(
        "Japanese facade module set differs"
    )

for relative, required_tokens in EXPECTED_MODULES.items():
    normalized = unicodedata.normalize(
        "NFC",
        relative,
    )

    path = files_by_normalized_path.get(
        normalized
    )

    if path is None:
        errors.append(
            f"missing Japanese facade: {relative}"
        )
        continue

    text = read_file(path)

    if len(text.splitlines()) > 100:
        errors.append(
            f"facade is unexpectedly large: {relative}"
        )

    for token in required_tokens:
        if token not in text:
            errors.append(
                f"missing token in {relative}: {token}"
            )

    for forbidden in (
        "while ",
        "sort(",
        "sorted(",
        "heap",
        "newSeqWith",
    ):
        if forbidden in text:
            errors.append(
                "facade contains implementation-like "
                f"token {forbidden!r}: {relative}"
            )


for relative, required_tokens in EXPECTED_FILES.items():
    path = ROOT / relative
    text = read_file(path)

    for token in required_tokens:
        if token not in text:
            errors.append(
                f"missing token in {relative}: {token}"
            )


for relative, required_tokens in (
    EXPECTED_GENERATED_DOCS.items()
):
    path = ROOT / relative
    text = read_file(path)

    for token in required_tokens:
        if token not in text:
            errors.append(
                "generated documentation is missing "
                f"{token!r}: {relative}"
            )


for relative in EXPECTED_MARKER_DOCS:
    path = ROOT / relative
    text = read_file(path)

    if text.count(FACADE_START) != 1:
        errors.append(
            "facade marker count differs: "
            f"{relative}"
        )

    if text.count(FACADE_END) != 1:
        errors.append(
            "facade end marker count differs: "
            f"{relative}"
        )


for relative in (
    "document_ja/index.md",
    "document_en/index.md",
):
    path = ROOT / relative
    text = read_file(path)

    if text.count(INDEX_START) != 1:
        errors.append(
            "facade index marker count differs: "
            f"{relative}"
        )

    if text.count(INDEX_END) != 1:
        errors.append(
            "facade index end marker count differs: "
            f"{relative}"
        )


english_kruskal = (
    ROOT
    / "document_en"
    / "extra"
    / "graph"
    / "kruskal.md"
)

if english_kruskal.exists():
    errors.append(
        "unexpected English Kruskal page exists"
    )


quick_verify = read_file(
    ROOT / "tools" / "quick_verify.sh"
)

if (
    quick_verify.count(
        "tests/test_extra_ja_facades.nim"
    )
    != 1
):
    errors.append(
        "Japanese facade test registration count differs"
    )

if (
    quick_verify.count(
        "python3 tools/audit_japanese_facades.py"
    )
    != 1
):
    errors.append(
        "Japanese facade audit registration count differs"
    )


print(
    "JAPANESE_FACADE_MODULES="
    f"{len(actual_module_paths)}"
)

print(
    "JAPANESE_FACADE_NORMALIZED_PATHS="
    f"{len(expected_module_paths)}"
)

print(
    "JAPANESE_FACADE_GENERATED_DOCS="
    f"{len(EXPECTED_GENERATED_DOCS)}"
)

print(
    "JAPANESE_FACADE_CANONICAL_LINK_PAGES="
    f"{len(EXPECTED_MARKER_DOCS)}"
)

print(
    "ENGLISH_KRUSKAL_DOC=ABSENT_AS_EXPECTED"
)

if errors:
    print("JAPANESE_FACADE_AUDIT=NG")

    for error in errors:
        print(error)

    raise SystemExit(1)

print("JAPANESE_FACADE_AUDIT=OK")
