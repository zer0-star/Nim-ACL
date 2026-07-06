# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_B

include atcoder/header
include atcoder/mincostflow

block:
  let V, E, F = nextInt()
  var mcf = initMinCostFlow[int, int](V)
  for i in 0..<E:
    let a, b, c, d = nextInt()
    mcf.addEdge(a, b, c, d)
  var f = mcf.flow(0, V - 1, F)
  if f.cap < F:
    echo -1
  else:
    echo f.cost
