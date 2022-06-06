# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B

include "template/template.nim"

include "string/knuth_morris_pratt.nim"

proc main() =
  let T, P = nextString()
  let v = KnuthMorrisPratt(T, P)
  for a in v: echo a

main()
