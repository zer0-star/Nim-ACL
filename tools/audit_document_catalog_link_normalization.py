#!/usr/bin/env python3

from hashlib import sha256
from pathlib import Path
import runpy
from tempfile import TemporaryDirectory


ROOT = Path(__file__).resolve().parents[1]

SCANNER = (
    ROOT
    / "tools/create_missing_docs_and_update_index.py"
)

namespace = runpy.run_path(
    str(SCANNER),
    run_name="nacl_catalog_audit_module",
)

existing_links = namespace["existing_links"]
should_skip_src = namespace["should_skip_src"]
update_index = namespace["update_index"]


links = existing_links(
    "\n".join(
        (
            "[Dense BitSet]"
            "(./extra/structure/dense_bitset.html)",
            "[Bitmask]"
            "(./extra/bit/bitmask.md)",
        )
    )
)

expected_links = {
    "extra/structure/dense_bitset.html",
    "extra/structure/dense_bitset.md",
    "extra/bit/bitmask.md",
    "extra/bit/bitmask.html",
}

if not expected_links <= links:
    raise SystemExit(
        "DOCUMENT_CATALOG_AUDIT_ERROR: "
        f"missing normalized links: "
        f"{sorted(expected_links - links)}"
    )

for unexpected in (
    "./extra/structure/dense_bitset.html",
    "./extra/bit/bitmask.md",
):
    if unexpected in links:
        raise SystemExit(
            "DOCUMENT_CATALOG_AUDIT_ERROR: "
            f"leading ./ remains: {unexpected}"
        )


for path in (
    ROOT / "src/atcoder/extra/other/bitset.nim",
    ROOT / "src/atcoder/extra/other/bitutils.nim",
):
    if not should_skip_src(path, False):
        raise SystemExit(
            "DOCUMENT_CATALOG_AUDIT_ERROR: "
            f"compatibility shim is not skipped: {path}"
        )

    if not should_skip_src(path, True):
        raise SystemExit(
            "DOCUMENT_CATALOG_AUDIT_ERROR: "
            f"include_legacy bypasses shim marker: {path}"
        )


with TemporaryDirectory() as temporary:
    temporary_root = Path(temporary)
    document_root = temporary_root / "document_ja"
    index_path = document_root / "index.md"

    (
        document_root
        / "extra/structure"
    ).mkdir(parents=True)

    (
        document_root
        / "extra/bit"
    ).mkdir(parents=True)

    (
        document_root
        / "extra/other"
    ).mkdir(parents=True)

    (
        document_root
        / "extra/structure/dense_bitset.md"
    ).write_text(
        "# Dense BitSet\n",
        encoding="utf-8",
    )

    (
        document_root
        / "extra/bit/bitmask.md"
    ).write_text(
        "# Bitmask\n",
        encoding="utf-8",
    )

    (
        document_root
        / "extra/other/auto_probe.md"
    ).write_text(
        "# Auto probe\n",
        encoding="utf-8",
    )

    index_path.write_text(
        "\n".join(
            (
                "# Test index",
                "",
                "[Dense BitSet]"
                "(./extra/structure/dense_bitset.html)",
                "",
                "[Bitmask](./extra/bit/bitmask.html)",
                "",
            )
        ),
        encoding="utf-8",
    )

    function_globals = update_index.__globals__
    original_doc = function_globals["DOC"]
    original_index = function_globals["INDEX"]

    try:
        function_globals["DOC"] = document_root
        function_globals["INDEX"] = index_path

        hashes = []

        for _ in range(3):
            update_index(True)

            hashes.append(
                sha256(
                    index_path.read_bytes()
                ).hexdigest()
            )
    finally:
        function_globals["DOC"] = original_doc
        function_globals["INDEX"] = original_index

    if len(set(hashes)) != 1:
        raise SystemExit(
            "DOCUMENT_CATALOG_AUDIT_ERROR: "
            f"index update is not idempotent: {hashes}"
        )

    index_text = index_path.read_text(
        encoding="utf-8"
    )

    if index_text.count(
        "extra/other/auto_probe.md"
    ) != 1:
        raise SystemExit(
            "DOCUMENT_CATALOG_AUDIT_ERROR: "
            "generated link is not stable"
        )

    if "extra/structure/dense_bitset.md" in index_text:
        raise SystemExit(
            "DOCUMENT_CATALOG_AUDIT_ERROR: "
            "curated Dense BitSet was duplicated"
        )

    if "extra/bit/bitmask.md" in index_text:
        raise SystemExit(
            "DOCUMENT_CATALOG_AUDIT_ERROR: "
            "curated Bitmask was duplicated"
        )


print("DOCUMENT_CATALOG_LINK_NORMALIZATION=OK")
print("GENERATED_BLOCK_IDEMPOTENCE=OK")
print("COMPATIBILITY_SHIMS_SKIPPED=OK")
print("CURATED_HTML_SUPPRESSES_MD_DUPLICATES=OK")
