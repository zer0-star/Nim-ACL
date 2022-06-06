# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B

include "template/template.nim"

include "string/rolling_hash.nim"

proc main() =
  let T, P = nextString()
  var
    rh = initRollingHash(T)
    rh2 = initRollingHash(P)
  for i in 0..T.len - P.len:
    if rh.get(i..<i + P.len) == rh2.get(0..<P.len): echo i

main()
