import std/unittest
import std/random
import std/sequtils
import std/math
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra
import atcoder/extra/graph/bellman_ford
import atcoder/extra/graph/warshall_floyd
import atcoder/extra/graph/dijkstra_radix_heap

test "ShortestPathTest":
  const N = 50
  var g = initGraph(N)
  var A = newSeqWith(N, newSeqWith(N, 0))
  for i in 0..<N:
    for j in 0..<N:
      if i == j:
        A[i][j] = 0
      else:
        let d = rand(0..10^17)
        A[i][j] = d
        g.addEdge(i, j, d)
  var WF = A.warshall_floyd()
  for s in 0..<N:
    var dijkstra = g.dijkstra(s)
    var BF = g.bellman_ford(s)
    var dijkstra_RH = g.dijkstra_radix_heap(s)
    for u in 0..<N:
      check WF[s][u] == dijkstra[u]
      block:
        let path = dijkstra.path(u)
        var s = 0
        for i in 0..<path.len-1: s += A[path[i]][path[i + 1]]
        check dijkstra[u] == s
      check WF[s][u] == BF[u]
      block:
        let path = BF.path(u)
        var s = 0
        for i in 0..<path.len-1: s += A[path[i]][path[i + 1]]
        check BF[u] == s
      check WF[s][u] == dijkstra_RH[u]
      block:
        let path = dijkstra_RH.path(u)
        var s = 0
        for i in 0..<path.len-1: s += A[path[i]][path[i + 1]]
        check dijkstra_RH[u] == s


test "ShortestPathTestInt32":
  const N = 50
  var g = initGraph(N, int32)
  var A = newSeqWith(N, newSeqWith(N, 0.int32))
  for i in 0..<N:
    for j in 0..<N:
      if i == j:
        A[i][j] = 0
      else:
        let d = rand(0..10^8).int32
        A[i][j] = d
        g.addEdge(i, j, d)
  var WF = A.warshall_floyd()
  for s in 0..<N:
    var dijkstra = g.dijkstra(s)
    var BF = g.bellman_ford(s)
    var dijkstra_RH = g.dijkstra_radix_heap(s)
    for u in 0..<N:
      check WF[s][u] == dijkstra[u]
      check WF[s][u] == BF[u]
      check WF[s][u] == dijkstra_RH[u]

test "ShortestPathTestFloat":
  const eps = 1e-10
  const N = 50
  var g = initGraph(N, float)
  var A = newSeqWith(N, newSeqWith(N, 0.0))
  for i in 0..<N:
    for j in 0..<N:
      if i == j:
        A[i][j] = 0
      else:
        let d = rand(0.0..100.0)
        A[i][j] = d
        g.addEdge(i, j, d)
  var WF = A.warshall_floyd()
  for s in 0..<N:
    var dijkstra = g.dijkstra(s)
    var BF = g.bellman_ford(s)
    for u in 0..<N:
      check abs(WF[s][u] - dijkstra[u]) < eps
      check abs(WF[s][u] - BF[u]) < eps


test "ShortestPathTestTwoDimensional":
  const N = 7
  proc id(x:(int, int)):int = x[0] * N + x[1]
  var g = initGraph(N * N, id)
  var A = newSeqWith(N * N, newSeqWith(N * N, 0))
  for x0 in 0..<N:
    for y0 in 0..<N:
      let p0 = (x0, y0)
      let i0 = id(p0)
      for x1 in 0..<N:
        for y1 in 0..<N:
          let p1 = (x1, y1)
          let i1 = id(p1)
          if p0 == p1:
            A[i0][i1] = 0
          else:
            let d = rand(0..100)
            A[i0][i1] = d
            g.addEdge(p0, p1, d)
  var WF = A.warshall_floyd()
  for x in 0..<N:
    for y in 0..<N:
      let s = (x, y)
      var dijkstra = g.dijkstra(s)
      var BF = g.bellman_ford(s)
      var dijkstra_RH = g.dijkstra_radix_heap(s)
      for x1 in 0..<N:
        for y1 in 0..<N:
          let u = (x1, y1)
          let WFd = WF[id(s)][id(u)]
          check WFd == dijkstra[u]
          check WFd == BF[u]
          check WFd == dijkstra_RH[u]


test "ShortestPathTest01":
  const N = 50
  var g = initGraph(N)
  var A = newSeqWith(N, newSeqWith(N, 0))
  for i in 0..<N:
    for j in 0..<N:
      if i == j:
        A[i][j] = 0
      else:
        let d = rand(0..1)
        A[i][j] = d
        g.addEdge(i, j, d)
  var WF = A.warshall_floyd()
  for s in 0..<N:
    var dijkstra = g.dijkstra01(s)
    for u in 0..<N:
      check WF[s][u] == dijkstra[u]
