#!/usr/bin/env bash
set -u

LOG="${NACL_QUICK_VERIFY_LOG:-/tmp/nacl_quick_verify.log}"
STATUS=OK
STEP=init

{
  set -e

  STEP="enter repo"
  cd "$(dirname "$0")/.."

  STEP="check nim"
  nim -v >/dev/null

  STEP="targeted tests"
  tests=(
    tests/test_extra_fps.nim
    tests/test_extra_formal_power_series.nim
    tests/test_extra_monoid.nim
    tests/test_extra_graph_template.nim
    tests/test_extra_graph_template_directed_undirected.nim
    tests/test_extra_static_graph.nim
    tests/test_extra_boruvka.nim
    tests/test_extra_chu_liu_edmonds.nim
    tests/test_extra_dp_basic.nim
    tests/test_extra_dp_2d_edit_rectangle.nim
    tests/test_extra_math_basic.nim
    tests/test_extra_xor_basis.nim
    tests/test_extra_arbitrary_mod_combination.nim
    tests/test_extra_geometry_template.nim
    tests/test_extra_geometry_polygon.nim
    tests/test_extra_geometry_triangle_tangent.nim
    tests/test_extra_geometry_facade.nim
    tests/test_extra_radix_heap.nim
    tests/test_extra_sparse_table.nim
    tests/test_extra_dual_fenwicktree.nim
    tests/test_extra_weighted_union_find.nim
    tests/test_extra_convex_hull_trick_add_monotone.nim
    tests/test_extra_li_chao_tree.nim
    tests/test_extra_segtree_2d.nim
    tests/test_extra_wavelet_matrix.nim
    tests/test_extra_partially_persistent_dsu.nim
    tests/test_extra_succinct_indexable_dictionary.nim
    tests/test_extra_binary_trie.nim
    tests/test_extra_rollback_dsu.nim
    tests/test_extra_functional_graph.nim
    tests/test_extra_sorted_set_map.nim
    tests/test_extra_set_map.nim
    tests/test_extra_tree_backend_common_interface.nim
    tests/test_extra_graph_shortest_paths.nim
    tests/test_extra_graph_structural.nim
    tests/test_extra_universal_segtree.nim
    tests/test_extra_universal_segtree_stress.nim
    tests/test_dsu.nim
    tests/test_fenwicktree.nim
    tests/test_segtree.nim
    tests/test_lazysegtree.nim
    tests/test_modint.nim
    tests/test_convolution.nim
    tests/test_scc.nim
    tests/test_maxflow.nim
    tests/test_mincostflow.nim
  )

  for t in "${tests[@]}"; do
    STEP="test $t"
    nim cpp -r "$t"
  done

  STEP="cleanup generated test artifacts"
  for t in "${tests[@]}"; do
    rm -f "${t%.nim}"
  done
  rm -rf .nim_runtime nimcache

  STEP="generate docs"
  if [ -x .venv-docs/bin/python ]; then
    .venv-docs/bin/python tools/generate_document.py
  else
    python3 tools/generate_document.py
  fi

  STEP="check generated docs"
  doc_changes="$(git status --porcelain document_ja document_en)"
  if [ -n "$doc_changes" ]; then
    echo "Generated documentation changed:"
    echo "$doc_changes"
    git --no-pager diff --stat -- document_ja document_en || true

    if [ "${CI:-}" = "true" ] && [ "${NACL_STRICT_DOCS:-0}" != "1" ]; then
      echo
      echo "CI non-strict docs mode:"
      echo "  The documentation generator ran successfully."
      echo "  Generated documentation diffs are reset in CI."
      echo "  Use tools/publish_docs.sh to regenerate, commit, and publish documentation."
      git checkout -- document_ja document_en
    else
      echo
      echo "Generated docs are not committed."
      echo "Run:"
      echo "  bash tools/publish_docs.sh"
      echo "or commit the regenerated documentation."
      false
    fi
  fi

  STEP="cleanup generated files after docs"
  rm -rf .nim_runtime nimcache

  STEP="final clean"
  if [ -n "$(git status --porcelain)" ]; then
    git status --short
    false
  fi

} >"$LOG" 2>&1 || STATUS=NG

echo
echo "===== NACL RESULT START ====="
echo "STATUS: $STATUS"
echo "STEP: $STEP"
echo "LOG: $LOG"

if [ "$STATUS" = OK ]; then
  echo "SUMMARY: quick verify passed"
else
  echo "SUMMARY: quick verify failed"
  echo "LAST_LOG_LINES:"
  tail -n 120 "$LOG"
fi

echo "===== NACL RESULT END ====="

[ "$STATUS" = OK ]
