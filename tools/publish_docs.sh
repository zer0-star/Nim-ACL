#!/usr/bin/env bash
set -u

LOG="${NACL_PUBLISH_DOCS_LOG:-/tmp/nacl_publish_docs.log}"
STATUS=OK
STEP=init

{
  set -e

  STEP="enter repo"
  cd "$(dirname "$0")/.."

  STEP="check master"
  current_branch="$(git branch --show-current)"
  test "$current_branch" = "master"

  STEP="pull master"
  git pull origin master

  STEP="check clean before docs"
  test -z "$(git status --porcelain)"

  STEP="generate docs"
  if [ -x .venv-docs/bin/python ]; then
    .venv-docs/bin/python tools/generate_document.py
  else
    python3 tools/generate_document.py
# NIM_ACL_DOCUMENT_HIGHLIGHT_FALLBACK_V1
python3 tools/postprocess_document_html.py
  fi

  STEP="commit generated docs if needed"
  if [ -n "$(git status --porcelain document_ja document_en)" ]; then
    git add document_ja document_en
    git commit -m "Regenerate documentation"
    git push origin master
  fi

  STEP="publish gh-pages"
  tmp="$(mktemp -d)"
  git fetch origin gh-pages
  git worktree add -B gh-pages "$tmp/gh-pages" origin/gh-pages

  rsync -a --delete document_ja/ "$tmp/gh-pages/document_ja/"
  rsync -a --delete document_en/ "$tmp/gh-pages/document_en/"
  touch "$tmp/gh-pages/.nojekyll"

  (
    cd "$tmp/gh-pages"
    if [ -n "$(git status --porcelain)" ]; then
      git add document_ja document_en .nojekyll
      git commit -m "Publish generated documentation"
      git push origin gh-pages
    fi
  )

  git worktree remove "$tmp/gh-pages"
  rmdir "$tmp" 2>/dev/null || true

  STEP="live docs sanity"
  curl -fsSL "https://nim-acl.github.io/Nim-ACL/document_ja/index.html?cacheBust=$(date +%s)" \
    | grep -E "FPS facade|extra/math/fps.html"
  curl -fsSL "https://nim-acl.github.io/Nim-ACL/document_ja/extra/monoid/monoid.html?cacheBust=$(date +%s)" \
    | grep -E "useMonoid|MonoidOf|ActedMonoidOf"
  curl -fsSL "https://nim-acl.github.io/Nim-ACL/document_ja/extra/graph/dijkstra.html?cacheBust=$(date +%s)" \
    | grep -E "基本例|dijkstra|dijkstra01"

  STEP="final clean"
  test -z "$(git status --porcelain)"

} >"$LOG" 2>&1 || STATUS=NG

echo
echo "===== NACL RESULT START ====="
echo "STATUS: $STATUS"
echo "STEP: $STEP"
echo "LOG: $LOG"

if [ "$STATUS" = OK ]; then
  echo "SUMMARY: docs generated, published, and live-checked"
else
  echo "SUMMARY: docs publish failed"
  echo "LAST_LOG_LINES:"
  tail -n 120 "$LOG"
fi

echo "===== NACL RESULT END ====="

[ "$STATUS" = OK ]
