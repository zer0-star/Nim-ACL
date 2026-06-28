# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_A

include atcoder/header
include atcoder/maxflow

block:
  let V, E = nextInt()
  var mf = initMaxFlow[int](V)
  for i in 0..<E:
    let a, b, c = nextInt()
    mf.addEdge(a, b, c)
  echo mf.flow(0, V - 1)
