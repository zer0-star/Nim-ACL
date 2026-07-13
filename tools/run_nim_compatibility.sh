#!/usr/bin/env bash

set -euo pipefail

PROFILE="${1:-}"

ROOT="$(
  cd "$(dirname "$0")/.." &&
  pwd
)"

if [ -z "$PROFILE" ]; then
  echo "usage: $0 latest|atcoder" >&2
  exit 2
fi

EXPECTED="$(
  python3 - "$ROOT/tools/nim_version_policy.json" "$PROFILE" <<'PY2'
import json
import pathlib
import sys

policy = json.loads(
    pathlib.Path(sys.argv[1]).read_text(
        encoding="utf-8"
    )
)

profile = sys.argv[2]

if profile not in ("latest", "atcoder"):
    raise SystemExit(
        f"unsupported required profile: {profile}"
    )

print(policy[profile])
PY2
)"

ACTUAL="$(
  nim --version |
  sed -n     's/^Nim Compiler Version \([^ ]*\).*$/\1/p' |
  head -n 1
)"

if [ -z "$ACTUAL" ]; then
  echo "could not determine active Nim version" >&2
  exit 3
fi

echo "NIM_COMPATIBILITY_PROFILE=$PROFILE"
echo "EXPECTED_NIM_VERSION=$EXPECTED"
echo "ACTUAL_NIM_VERSION=$ACTUAL"

if [ "$ACTUAL" != "$EXPECTED" ]; then
  echo     "active Nim version does not match profile '$PROFILE'"     >&2
  exit 4
fi

cd "$ROOT"

bash tools/quick_verify.sh
