# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_A

include atcoder/header

import atcoder/extra/graph/graph_template
import atcoder/extra/graph/kruskal

proc main() =
  var
    V, E = nextInt()
    g = initGraph(V)
  for i in 0..<E:
    let a, b, c = nextInt()
    g.addBiEdge(a,b,c)
  echo kruskal(g)[0]

main()
