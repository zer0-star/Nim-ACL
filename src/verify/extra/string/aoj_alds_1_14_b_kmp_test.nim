# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B

import atcoder/header
import atcoder/extra/string/knuth_morris_pratt

proc main() =
  let T, P = nextString()
  let v = KnuthMorrisPratt(T, P)
  for a in v: echo a

main()
