#!/usr/bin/env bash
set -euo pipefail

ROOT="$(
  cd "$(dirname "${BASH_SOURCE[0]}")/.." &&
  pwd
)"

TARGET="${1:-all}"
JOBS="${OJ_VERIFY_JOBS:-2}"

if ! [[ "$JOBS" =~ ^[1-9][0-9]*$ ]]; then
  echo "ERROR: OJ_VERIFY_JOBS must be a positive integer" >&2
  return 2 2>/dev/null || exit 2
fi

cd "$ROOT/src"

case "$TARGET" in
  ""|all)
    exec oj-verify run -j "$JOBS"
    ;;
esac

case "$TARGET" in
  src/*)
    TARGET="${TARGET#src/}"
    ;;
esac

if [[ "$TARGET" = /* ]] ||
   [[ "$TARGET" == *".."* ]] ||
   [[ "$TARGET" == *$'\n'* ]]; then

  echo "ERROR: verify target must remain inside src/" >&2
  return 3 2>/dev/null || exit 3
fi

if [ ! -e "$TARGET" ]; then
  echo "ERROR: verify target does not exist: $TARGET" >&2
  return 4 2>/dev/null || exit 4
fi

exec oj-verify run -j "$JOBS" "$TARGET"
