# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_B

include atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/bellman_ford

proc main() =
  var
    V, E, R = nextInt()
  var g = initGraph(V)
  for i in 0..<E:
    var a, b, c = nextInt()
    g.addEdge(a,b,c)
  let bf = bellman_ford(g, R);
  if bf.negative_cycle: echo "NEGATIVE CYCLE"
  else:
    for u in 0..<V:
      if bf[u] == int.inf: echo "INF"
      else: echo bf[u]

main()
