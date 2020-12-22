# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A

include atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra

proc main() =
  var
    V = nextInt()
    E = nextInt()
    R = nextInt()
    g = initGraph[int](V)

  for i in 0..<E:
    var
      a = nextInt()
      b = nextInt()
      c = nextInt()
    g.addEdge(a, b, c)
  
  let dist = dijkstra(g, R)[0]
  for d in dist:
    if d == int.inf: echo "INF"
    else: echo d

main()
