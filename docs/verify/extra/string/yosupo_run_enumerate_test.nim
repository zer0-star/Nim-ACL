# verify-helper: PROBLEM https://judge.yosupo.jp/problem/runenumerate

include atcoder/header
import atcoder/extra/string/run_enumerate

proc main() =
  let
    s = nextString()
    ans = RunEnumerate(s)
  echo ans.len
  for (t,l,r) in ans:
    echo t, " ",l, " ",r

main()
