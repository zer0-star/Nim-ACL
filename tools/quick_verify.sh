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
    tests/test_extra_ja_facades.nim
    tests/test_extra_dp_basic.nim
    tests/test_extra_monotone_minima.nim
    tests/test_extra_dp_2d_edit_rectangle.nim
    tests/test_extra_math_basic.nim
    tests/test_extra_xor_basis.nim
    tests/test_extra_xor_basis_random.nim
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
    tests/test_extra_binary_trie_random.nim
    tests/test_extra_rollback_dsu.nim
    tests/test_extra_rollback_dsu_random.nim
    tests/test_extra_offline_dynamic_connectivity.nim
    tests/test_extra_virtual_tree.nim
    tests/test_extra_euler_tour.nim
    tests/test_extra_persistent_segment_tree.nim
    tests/test_extra_persistent_segment_tree_static_api.nim
    tests/test_extra_sqrt_tree.nim
    tests/test_extra_dsu_on_tree.nim
    tests/test_extra_undirected_decomposition.nim
    tests/test_extra_rerooting_dp.nim
    tests/test_extra_functional_graph.nim
    tests/test_extra_functional_graph_random.nim
    tests/test_extra_manacher.nim
    tests/test_extra_manacher_random.nim
    tests/test_extra_aho_corasick.nim
    tests/test_extra_aho_corasick_random.nim
    tests/test_extra_kmp.nim
    tests/test_extra_kmp_random.nim
    tests/test_extra_minimum_rotation.nim
    tests/test_extra_suffix_automaton.nim
    tests/test_extra_suffix_automaton_random.nim
    tests/test_extra_palindromic_tree.nim
    tests/test_extra_cartesian_tree.nim
    tests/test_extra_fast_set.nim
    tests/test_extra_fast_set_random.nim
    tests/test_extra_disjoint_sparse_table.nim
    tests/test_extra_mo.nim
    tests/test_extra_coordinate_compression.nim
    tests/test_extra_run_length_encoding.nim
    tests/test_extra_mex_set.nim
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
# NIM_ACL_DOCUMENT_HIGHLIGHT_FALLBACK_V1
python3 tools/postprocess_document_html.py
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

  # >>> BERLEKAMP_MASSEY_AUDIT >>>
if ! python3 tools/audit_berlekamp_massey.py
then
  STATUS="NG"
  STEP="Berlekamp-Massey audit"
fi
# <<< BERLEKAMP_MASSEY_AUDIT <<<

# >>> PST_VERSION_FIRST_CROSS_TEST >>>
PST_VERSION_FIRST_TMP="/tmp/nacl_pst_version_first_quick_$$"

rm -rf "$PST_VERSION_FIRST_TMP"
mkdir -p "$PST_VERSION_FIRST_TMP"

if ! nim cpp \
  -d:release \
  --path:src \
  --path:tests \
  --hints:off \
  --verbosity:0 \
  --nimcache:"$PST_VERSION_FIRST_TMP/nimcache-static" \
  --out:"$PST_VERSION_FIRST_TMP/static-test" \
  tests/test_extra_persistent_segment_tree_static_api.nim
then
  STATUS="NG"
  STEP="PersistentSegTree version-first static test"

elif ! "$PST_VERSION_FIRST_TMP/static-test"
then
  STATUS="NG"
  STEP="PersistentSegTree version-first static run"
fi

if ! nim cpp \
  -d:release \
  --path:src \
  --path:tests \
  --hints:off \
  --verbosity:0 \
  --nimcache:"$PST_VERSION_FIRST_TMP/nimcache-cross" \
  --out:"$PST_VERSION_FIRST_TMP/cross-test" \
  tests/test_extra_persistent_segment_tree_version_first_cross_module.nim
then
  STATUS="NG"
  STEP="PersistentSegTree version-first cross test"

elif ! "$PST_VERSION_FIRST_TMP/cross-test"
then
  STATUS="NG"
  STEP="PersistentSegTree version-first cross run"
fi

rm -rf "$PST_VERSION_FIRST_TMP"
# <<< PST_VERSION_FIRST_CROSS_TEST <<<

# >>> POLYNOMIAL_INTERPOLATION_TEST >>>
POLYNOMIAL_INTERPOLATION_TMP="/tmp/nacl_polynomial_interpolation_quick_$$"

rm -rf "$POLYNOMIAL_INTERPOLATION_TMP"
mkdir -p "$POLYNOMIAL_INTERPOLATION_TMP"

if ! nim cpp \
  -d:release \
  --path:src \
  --path:tests \
  --hints:off \
  --verbosity:0 \
  --nimcache:"$POLYNOMIAL_INTERPOLATION_TMP/nimcache-main" \
  --out:"$POLYNOMIAL_INTERPOLATION_TMP/main-test" \
  tests/test_extra_polynomial_interpolation.nim
then
  STATUS="NG"
  STEP="Polynomial Interpolation test compile"

elif ! "$POLYNOMIAL_INTERPOLATION_TMP/main-test"
then
  STATUS="NG"
  STEP="Polynomial Interpolation test run"
fi

if ! nim cpp \
  -d:release \
  --path:src \
  --path:tests \
  --hints:off \
  --verbosity:0 \
  --nimcache:"$POLYNOMIAL_INTERPOLATION_TMP/nimcache-cross" \
  --out:"$POLYNOMIAL_INTERPOLATION_TMP/cross-test" \
  tests/test_extra_polynomial_interpolation_cross_module.nim
then
  STATUS="NG"
  STEP="Polynomial Interpolation cross compile"

elif ! "$POLYNOMIAL_INTERPOLATION_TMP/cross-test"
then
  STATUS="NG"
  STEP="Polynomial Interpolation cross run"
fi

rm -rf "$POLYNOMIAL_INTERPOLATION_TMP"
# <<< POLYNOMIAL_INTERPOLATION_TEST <<<

# >>> SUBSET_CONVOLUTION_TEST >>>
SUBSET_CONVOLUTION_TMP="/tmp/nacl_subset_convolution_quick_$$"

rm -rf "$SUBSET_CONVOLUTION_TMP"
mkdir -p "$SUBSET_CONVOLUTION_TMP"

if ! nim cpp \
  -d:release \
  --path:src \
  --path:tests \
  --hints:off \
  --verbosity:0 \
  --nimcache:"$SUBSET_CONVOLUTION_TMP/nimcache-main" \
  --out:"$SUBSET_CONVOLUTION_TMP/main-test" \
  tests/test_extra_subset_convolution.nim
then
  STATUS="NG"
  STEP="Subset Convolution test compile"

elif ! "$SUBSET_CONVOLUTION_TMP/main-test"
then
  STATUS="NG"
  STEP="Subset Convolution test run"
fi

if ! nim cpp \
  -d:release \
  --path:src \
  --path:tests \
  --hints:off \
  --verbosity:0 \
  --nimcache:"$SUBSET_CONVOLUTION_TMP/nimcache-cross" \
  --out:"$SUBSET_CONVOLUTION_TMP/cross-test" \
  tests/test_extra_subset_convolution_cross_module.nim
then
  STATUS="NG"
  STEP="Subset Convolution cross compile"

elif ! "$SUBSET_CONVOLUTION_TMP/cross-test"
then
  STATUS="NG"
  STEP="Subset Convolution cross run"
fi

rm -rf "$SUBSET_CONVOLUTION_TMP"
# <<< SUBSET_CONVOLUTION_TEST <<<

# >>> EXP_OF_SET_POWER_SERIES_TEST >>>
EXP_SET_POWER_SERIES_TMP="/tmp/nacl_exp_set_power_series_quick_$$"

rm -rf "$EXP_SET_POWER_SERIES_TMP"
mkdir -p "$EXP_SET_POWER_SERIES_TMP"

if ! nim cpp \
  -d:release \
  --path:src \
  --path:tests \
  --hints:off \
  --verbosity:0 \
  --nimcache:"$EXP_SET_POWER_SERIES_TMP/nimcache-main" \
  --out:"$EXP_SET_POWER_SERIES_TMP/main-test" \
  tests/test_extra_exp_of_set_power_series.nim
then
  STATUS="NG"
  STEP="Exp of Set Power Series test compile"

elif ! "$EXP_SET_POWER_SERIES_TMP/main-test"
then
  STATUS="NG"
  STEP="Exp of Set Power Series test run"
fi

if ! nim cpp \
  -d:release \
  --path:src \
  --path:tests \
  --hints:off \
  --verbosity:0 \
  --nimcache:"$EXP_SET_POWER_SERIES_TMP/nimcache-cross" \
  --out:"$EXP_SET_POWER_SERIES_TMP/cross-test" \
  tests/test_extra_exp_of_set_power_series_cross_module.nim
then
  STATUS="NG"
  STEP="Exp of Set Power Series cross compile"

elif ! "$EXP_SET_POWER_SERIES_TMP/cross-test"
then
  STATUS="NG"
  STEP="Exp of Set Power Series cross run"
fi

rm -rf "$EXP_SET_POWER_SERIES_TMP"
# <<< EXP_OF_SET_POWER_SERIES_TEST <<<

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

# NIM_ACL_GENERATED_DOCUMENT_AUDIT_V1
python3 tools/postprocess_document_links.py
python3 tools/audit_generated_document_html.py

# NIM_ACL_STRICT_HIGHLIGHT_COUNT_AUDIT_V1
NIM_ACL_DOC_AUDIT_OUTPUT="$(
  python3 tools/audit_generated_document_html.py
)"
printf '%s\n' "$NIM_ACL_DOC_AUDIT_OUTPUT"

nim_acl_read_count() {
  printf '%s\n' "$NIM_ACL_DOC_AUDIT_OUTPUT" \
    | sed -n "s/^$1=\([0-9][0-9]*\)$/\1/p"
}

NIM_ACL_HIGHLIGHTED="$(
  nim_acl_read_count HIGHLIGHTED_BLOCKS
)"
NIM_ACL_TOKENS="$(
  nim_acl_read_count TOKEN_SPANS
)"
NIM_ACL_NUMBERED="$(
  nim_acl_read_count NUMBERED_BLOCKS
)"
NIM_ACL_LINES="$(
  nim_acl_read_count CODE_LINES
)"
NIM_ACL_MARKERS="$(
  nim_acl_read_count MARKED_EXAMPLES
)"
NIM_ACL_NIM_BLOCKS="$(
  nim_acl_read_count NIM_CODE_BLOCKS
)"

test -n "$NIM_ACL_HIGHLIGHTED"
test -n "$NIM_ACL_TOKENS"
test -n "$NIM_ACL_NUMBERED"
test -n "$NIM_ACL_LINES"
test -n "$NIM_ACL_MARKERS"
test -n "$NIM_ACL_NIM_BLOCKS"

test "$NIM_ACL_HIGHLIGHTED" -gt 0
test "$NIM_ACL_TOKENS" -gt 0
test "$NIM_ACL_NIM_BLOCKS" -gt 0

if [ "$NIM_ACL_MARKERS" -gt 0 ]; then
  test "$NIM_ACL_NUMBERED" -gt 0
  test "$NIM_ACL_LINES" -gt 0
fi

# NIM_ACL_SPECIFIC_LECTURE_LINK_AUDIT_V1
python3 tools/audit_atcoder_lecture_links.py
# NIM_ACL_PROBLEM_EXAMPLES_AUDIT_V1
python3 tools/audit_problem_examples.py
# NIM_ACL_DP_OPTIMIZATION_AUDIT_V1
python3 tools/audit_dp_optimization.py
# NIM_ACL_CURATED_DOCS_AUDIT_V1
python3 tools/audit_curated_docs.py
# NIM_ACL_PERSISTENT_SEGTREE_API_AUDIT_V1
python3 tools/audit_persistent_segment_tree_api.py
# NIM_ACL_TUNING_PARAMETER_DOC_AUDIT_V1
python3 tools/audit_tuning_parameters.py
# NIM_ACL_JAPANESE_FACADE_AUDIT_V1
python3 tools/audit_japanese_facades.py
