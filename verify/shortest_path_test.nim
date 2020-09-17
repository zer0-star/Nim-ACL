# verify-helper: PROBLEM https://judge.yosupo.jp/problem/shortest_path

include atcoder/header
import "atcoder/extra/graph/template.nim"
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
  
  let (dist, prev) = g.dijkstra(s)
  if dist[t] == int.inf:
    echo -1
  else:
    var
      u = t
      ans = newSeq[int]()
    while true:
      ans.add(u)
      if u == s: break
      u = prev[u]
    ans.reverse
    echo dist[t], " ", ans.len - 1
    for i in 0..<ans.len - 1:
      echo ans[i], " ", ans[i+1]

main()
