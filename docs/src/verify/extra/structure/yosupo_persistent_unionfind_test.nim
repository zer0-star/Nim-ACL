# verify-helper: PROBLEM https://judge.yosupo.jp/problem/persistent_unionfind

include atcoder/header

import atcoder/extra/structure/persistent_dsu

proc main() =
  let N, Q = nextInt()
  var
    uf = initPersistentDSU(N)
    G = newSeq[PersistentDSU](Q+1)
  G[0] = uf
  
  for i in 0..<Q:
    var t, k, u, v = nextInt()
    k.inc
    if t == 0:
      G[i+1] = G[k].merge(u, v)
    else:
      echo if G[k].leader(u) == G[k].leader(v): 1 else: 0

main()
