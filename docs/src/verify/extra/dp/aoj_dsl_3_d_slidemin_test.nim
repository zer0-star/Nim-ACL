# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_3_D

include atcoder/header

import atcoder/extra/dp/slide_min

proc main() =
  let
    N, L = nextInt()
    a = newSeqWith(N, nextInt())
  echo a.slideMin(L).join(" ")

main()
