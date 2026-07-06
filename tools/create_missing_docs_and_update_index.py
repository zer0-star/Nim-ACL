#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path
import argparse
import re


ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "src" / "atcoder"
DOC = ROOT / "document_ja"
INDEX = DOC / "index.md"

BEGIN = "<!-- AUTO-GENERATED-DOC-LINKS:BEGIN -->"
END = "<!-- AUTO-GENERATED-DOC-LINKS:END -->"


CATEGORY_ORDER = [
    "standard",
    "extra/structure",
    "extra/graph",
    "extra/tree",
    "extra/math",
    "extra/dp",
    "extra/string",
    "extra/geometry",
    "extra/monoid",
    "extra/other",
    "other",
]


CATEGORY_TITLE = {
    "standard": "標準ライブラリ",
    "extra/structure": "Extra / データ構造",
    "extra/graph": "Extra / グラフ",
    "extra/tree": "Extra / 木",
    "extra/math": "Extra / 数学",
    "extra/dp": "Extra / DP",
    "extra/string": "Extra / 文字列",
    "extra/geometry": "Extra / 幾何",
    "extra/monoid": "Extra / Monoid",
    "extra/other": "Extra / その他",
    "other": "その他",
}


SKIP_DOC_NAMES = {
    "index.md",
    "appendix.md",
    "keywords.toml",
}


SKIP_FILE_NAMES = {
    "combined.nim",
}


PUBLIC_DECL_RE = re.compile(
    r"^\s*(proc|func|template|macro|iterator|converter|type|const|let|var)\s+"
)


def should_skip_src(path: Path, include_legacy: bool) -> bool:
    name = path.name
    stem = path.stem

    if name in SKIP_FILE_NAMES:
        return True

    if stem.startswith("internal_"):
        return True

    if stem.startswith("generate_"):
        return True

    if not include_legacy:
        if "backup" in stem:
            return True
        if stem.endswith("_old"):
            return True
        if stem.startswith("old_"):
            return True

    rel = path.relative_to(SRC).parts

    if len(rel) >= 2 and rel[0] == "extra":
        # header/template/forward_compatibility are implementation-support modules.
        if rel[1] in {"header", "template", "forward_compatibility"}:
            return True

    return False


def doc_path_for(src_path: Path) -> Path | None:
    rel = src_path.relative_to(SRC)

    if len(rel.parts) == 1:
        return DOC / rel.with_suffix(".md").name

    if rel.parts[0] == "extra":
        return DOC / rel.with_suffix(".md")

    return None


def module_import_for(src_path: Path) -> str:
    rel = src_path.relative_to(SRC).with_suffix("")
    return "atcoder/" + "/".join(rel.parts)


def title_for(path: Path) -> str:
    return path.stem


def category_for_doc(rel: Path) -> str:
    parts = rel.parts

    if len(parts) == 1:
        return "standard"

    if len(parts) >= 3 and parts[0] == "extra":
        cat = f"{parts[0]}/{parts[1]}"
        if cat in CATEGORY_TITLE:
            return cat
        return "extra/other"

    return "other"


def extract_public_decls(src_path: Path) -> list[str]:
    lines = src_path.read_text(encoding="utf-8", errors="replace").splitlines()
    decls: list[str] = []

    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()

        if not PUBLIC_DECL_RE.match(line):
            i += 1
            continue

        # Keep only exported declarations. This is approximate but useful.
        if "*" not in stripped:
            i += 1
            continue

        block = [stripped]

        # Collect short multiline signatures until "=" or ":" balance seems closed.
        j = i + 1
        paren_balance = stripped.count("(") - stripped.count(")")
        while j < len(lines) and j < i + 8:
            nxt = lines[j]
            nxt_stripped = nxt.strip()

            if not nxt_stripped:
                break

            if PUBLIC_DECL_RE.match(nxt):
                break

            if paren_balance <= 0 and ("=" in stripped or stripped.endswith(":")):
                break

            if nxt.startswith(" ") or nxt.startswith("\t"):
                block.append(nxt_stripped)
                paren_balance += nxt_stripped.count("(") - nxt_stripped.count(")")
                if "=" in nxt_stripped and paren_balance <= 0:
                    break
                j += 1
            else:
                break

        decl = " ".join(block)
        decl = re.sub(r"\s+", " ", decl).strip()
        decls.append(decl)

        i = max(j, i + 1)

    # Keep document readable.
    seen = set()
    uniq = []
    for d in decls:
        if d in seen:
            continue
        seen.add(d)
        uniq.append(d)

    return uniq[:80]


def render_stub_doc(src_path: Path, doc_path: Path) -> str:
    title = title_for(src_path)
    imp = module_import_for(src_path)
    decls = extract_public_decls(src_path)

    lines: list[str] = []
    lines.append(f"# {title}")
    lines.append("")
    lines.append("このページは自動生成された下書きです。")
    lines.append("")
    lines.append("公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。")
    lines.append("")
    lines.append("## import")
    lines.append("")
    lines.append(f"    import {imp}")
    lines.append("")

    if decls:
        lines.append("## 公開 API")
        lines.append("")
        for decl in decls:
            lines.append(f"    {decl}")
        lines.append("")
    else:
        lines.append("## 公開 API")
        lines.append("")
        lines.append("このファイルから公開 API を自動抽出できませんでした。ソースを確認して追記してください。")
        lines.append("")

    lines.append("## 概要")
    lines.append("")
    lines.append("TODO: このライブラリの用途と使いどころを記述してください。")
    lines.append("")
    lines.append("## 使用例")
    lines.append("")
    lines.append("TODO: 使用例を追加してください。")
    lines.append("")
    lines.append("## 注意")
    lines.append("")
    lines.append("TODO: 制約、前提条件、落とし穴を記述してください。")
    lines.append("")

    return "\n".join(lines)


def create_missing_docs(apply: bool, include_legacy: bool) -> list[Path]:
    created: list[Path] = []

    for src_path in sorted(SRC.rglob("*.nim")):
        if should_skip_src(src_path, include_legacy):
            continue

        doc_path = doc_path_for(src_path)
        if doc_path is None:
            continue

        if doc_path.exists():
            continue

        created.append(doc_path)

        if apply:
            doc_path.parent.mkdir(parents=True, exist_ok=True)
            doc_path.write_text(render_stub_doc(src_path, doc_path), encoding="utf-8")

    return created


def existing_links(index_text: str) -> set[str]:
    links = set(re.findall(r"\]\(([^)]+)\)", index_text))
    normalized: set[str] = set()

    for link in links:
        link = link.split("#", 1)[0].strip()
        normalized.add(link)

        if link.endswith(".html"):
            normalized.add(link[:-5] + ".md")
        elif link.endswith(".md"):
            normalized.add(link[:-3] + ".html")

    return normalized


def collect_all_docs() -> list[tuple[str, str, str]]:
    rows: list[tuple[str, str, str]] = []

    for md in sorted(DOC.rglob("*.md")):
        rel = md.relative_to(DOC)

        if rel.name in SKIP_DOC_NAMES:
            continue

        if "lib" in rel.parts:
            continue

        cat = category_for_doc(rel)
        name = md.stem
        link = str(rel).replace("\\", "/")
        rows.append((cat, name, link))

    return rows


def render_index_block(rows: list[tuple[str, str, str]], known_links: set[str]) -> str:
    missing_by_cat: dict[str, list[tuple[str, str]]] = {}

    for cat, name, link in rows:
        if link in known_links or link[:-3] + ".html" in known_links:
            continue

        missing_by_cat.setdefault(cat, []).append((name, link))

    lines: list[str] = []
    lines.append(BEGIN)
    lines.append("")
    lines.append("## 自動生成ドキュメント一覧")
    lines.append("")
    lines.append("この節は `tools/create_missing_docs_and_update_index.py` により自動更新されます。")
    lines.append("")

    has_any = False

    for cat in CATEGORY_ORDER:
        items = missing_by_cat.get(cat, [])
        if not items:
            continue

        has_any = True
        lines.append(f"### {CATEGORY_TITLE[cat]}")
        lines.append("")

        for name, link in sorted(items):
            lines.append(f"- [{name}]({link})")

        lines.append("")

    unknown_cats = sorted(set(missing_by_cat) - set(CATEGORY_ORDER))
    for cat in unknown_cats:
        items = missing_by_cat[cat]
        if not items:
            continue

        has_any = True
        lines.append(f"### {cat}")
        lines.append("")

        for name, link in sorted(items):
            lines.append(f"- [{name}]({link})")

        lines.append("")

    if not has_any:
        lines.append("未掲載のドキュメントはありません。")
        lines.append("")

    lines.append(END)
    lines.append("")

    return "\n".join(lines)


def update_index(apply: bool) -> None:
    if not INDEX.exists():
        raise FileNotFoundError(INDEX)

    text = INDEX.read_text(encoding="utf-8")
    known = existing_links(text)
    rows = collect_all_docs()
    block = render_index_block(rows, known)

    pattern = re.compile(
        re.escape(BEGIN) + r".*?" + re.escape(END) + r"\n?",
        flags=re.S,
    )

    if pattern.search(text):
        new_text = pattern.sub(block, text)
    else:
        new_text = text.rstrip() + "\n\n" + block

    if apply:
        INDEX.write_text(new_text, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--apply", action="store_true")
    parser.add_argument("--include-legacy", action="store_true")
    args = parser.parse_args()

    created = create_missing_docs(args.apply, args.include_legacy)

    print("== missing docs to create ==")
    if not created:
        print("none")
    else:
        for p in created:
            print(p.relative_to(ROOT))

    update_index(args.apply)

    if args.apply:
        print("")
        print("updated document_ja/index.md")
        print("next:")
        print("  source .venv/bin/activate")
        print("  python tools/generate_document.py")
    else:
        print("")
        print("dry-run only. Use --apply to create files and update index.md")


if __name__ == "__main__":
    main()
