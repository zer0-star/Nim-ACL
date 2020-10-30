# verify-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind

import atcoder/header
import atcoder/dsu

let N, Q = nextInt()
var uf = initDSU(N)

for _ in 0 ..< Q:
  let t, u, v = nextInt()

  if t == 0:
    uf.merge(u, v)
  elif t == 1:
    echo(
      if uf.same(u, v):
        1
      else:
        0
    )
