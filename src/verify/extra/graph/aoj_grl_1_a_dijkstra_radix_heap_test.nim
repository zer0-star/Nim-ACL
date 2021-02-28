# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A

include atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra_radix_heap

proc main() =
  var
    V = nextInt()
    E = nextInt()
    R = nextInt()
    g = initGraph[int32](V)

  for i in 0..<E:
    var
      a = nextInt()
      b = nextInt()
      c = nextInt().int32
    g.addEdge(a, b, c)
  
  let dist = dijkstra_radix_heap(g, R)
  for d in dist:
    if d == int32.inf: echo "INF"
    else: echo d

main()
