# verify-helper: PROBLEM https://judge.yosupo.jp/problem/shortest_path

include atcoder/header

import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra

proc main() =
  let N, M, s, t = nextInt()
  var g = initGraph[int](N)

  for i in 0..<M:
    var
      a = nextInt()
      b = nextInt()
      c = nextInt()
    g.addEdge(a, b, c)
  
  let dist = g.dijkstra(s)
  if dist[t] == int.inf:
    echo -1
  else:
    let p = dist.path(t)
    echo dist[t], " ", p.len - 1
    for i in 0..<p.len - 1:
      echo p[i], " ", p[i + 1]

main()
