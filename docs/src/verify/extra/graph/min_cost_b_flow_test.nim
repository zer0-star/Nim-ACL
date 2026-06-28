# verify-helper: PROBLEM https://judge.yosupo.jp/problem/min_cost_b_flow

import atcoder/header
import atcoder/extra/math/int128

import atcoder/extra/graph/bflow

when isMainModule:
  let N, M = nextInt()

  var bf = initBFlow[int, Int128](N)

  for u in 0 ..< N:
    let b = nextInt()
    bf.add_supply(u, b)

  for _ in 0..<M:
    let src, dst, lower, upper, c = nextInt()

    bf.addEdge(src, dst, lower, upper, c)

  let ret = bf.solve()
  if ret[0]:
    echo ret[1]
    for p in bf.potential:
      assert(p >= -int(1e15) and p <= int(1e15))
      echo p
    for f in bf.f: echo f
  else:
    echo "infeasible"
