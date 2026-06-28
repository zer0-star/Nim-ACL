# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B

import atcoder/header
import atcoder/extra/string/rolling_hash

proc main() =
  let T, P = nextString()
  var
    rh = initRollingHash(T)
    rh2 = initRollingHash(P)
  for i in 0..T.len - P.len:
    if rh[i..<i + P.len] == rh2[0..<P.len]: echo i

main()
