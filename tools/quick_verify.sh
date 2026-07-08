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

  STEP="cleanup test binaries"
  for t in "${tests[@]}"; do
    rm -f "${t%.nim}"
  done

  STEP="generate docs"
  if [ -x .venv-docs/bin/python ]; then
    .venv-docs/bin/python tools/generate_document.py
  else
    python3 tools/generate_document.py
  fi

  STEP="check docs are committed"
  test -z "$(git status --porcelain document_ja document_en)"

  STEP="final clean"
  test -z "$(git status --porcelain)"

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
