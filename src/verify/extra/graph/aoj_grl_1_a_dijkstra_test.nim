# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A

include atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra

proc main() =
  var
    V = nextInt()
    E = nextInt()
    R = nextInt()
    g = initGraph(V)

  for i in 0..<E:
    var
      a = nextInt()
      b = nextInt()
      c = nextInt()
    g.addEdge(a, b, c)
  
  let dist = dijkstra(g, R)
  for u in 0..<V:
    if dist[u] == int.inf: echo "INF"
    else: echo dist[u]

main()
