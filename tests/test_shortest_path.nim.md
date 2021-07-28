---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/bellman_ford.nim
    title: atcoder/extra/graph/bellman_ford.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/bellman_ford.nim
    title: atcoder/extra/graph/bellman_ford.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra_radix_heap.nim
    title: atcoder/extra/graph/dijkstra_radix_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra_radix_heap.nim
    title: atcoder/extra/graph/dijkstra_radix_heap.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra_result.nim
    title: atcoder/extra/graph/dijkstra_result.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra_result.nim
    title: atcoder/extra/graph/dijkstra_result.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/warshall_floyd.nim
    title: atcoder/extra/graph/warshall_floyd.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/warshall_floyd.nim
    title: atcoder/extra/graph/warshall_floyd.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/radix_heap.nim
    title: atcoder/extra/structure/radix_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/radix_heap.nim
    title: atcoder/extra/structure/radix_heap.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import std/unittest\nimport std/random\nimport std/sequtils\nimport std/math\n\
    import atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/dijkstra\n\
    import atcoder/extra/graph/bellman_ford\nimport atcoder/extra/graph/warshall_floyd\n\
    import atcoder/extra/graph/dijkstra_radix_heap\n\ntest \"ShortestPathTest\":\n\
    \  const N = 50\n  var g = initGraph(N)\n  var A = newSeqWith(N, newSeqWith(N,\
    \ 0))\n  for i in 0..<N:\n    for j in 0..<N:\n      if i == j:\n        A[i][j]\
    \ = 0\n      else:\n        let d = rand(0..10^17)\n        A[i][j] = d\n    \
    \    g.addEdge(i, j, d)\n  var WF = A.warshall_floyd()\n  for s in 0..<N:\n  \
    \  var dijkstra = g.dijkstra(s)\n    var BF = g.bellman_ford(s)\n    var dijkstra_RH\
    \ = g.dijkstra_radix_heap(s)\n    for u in 0..<N:\n      check WF[s][u] == dijkstra[u]\n\
    \      block:\n        let path = dijkstra.path(u)\n        var s = 0\n      \
    \  for i in 0..<path.len-1: s += A[path[i]][path[i + 1]]\n        check dijkstra[u]\
    \ == s\n      check WF[s][u] == BF[u]\n      block:\n        let path = BF.path(u)\n\
    \        var s = 0\n        for i in 0..<path.len-1: s += A[path[i]][path[i +\
    \ 1]]\n        check BF[u] == s\n      check WF[s][u] == dijkstra_RH[u]\n    \
    \  block:\n        let path = dijkstra_RH.path(u)\n        var s = 0\n       \
    \ for i in 0..<path.len-1: s += A[path[i]][path[i + 1]]\n        check dijkstra_RH[u]\
    \ == s\n\n\ntest \"ShortestPathTestInt32\":\n  const N = 50\n  var g = initGraph(N,\
    \ int32)\n  var A = newSeqWith(N, newSeqWith(N, 0.int32))\n  for i in 0..<N:\n\
    \    for j in 0..<N:\n      if i == j:\n        A[i][j] = 0\n      else:\n   \
    \     let d = rand(0..10^8).int32\n        A[i][j] = d\n        g.addEdge(i, j,\
    \ d)\n  var WF = A.warshall_floyd()\n  for s in 0..<N:\n    var dijkstra = g.dijkstra(s)\n\
    \    var BF = g.bellman_ford(s)\n    var dijkstra_RH = g.dijkstra_radix_heap(s)\n\
    \    for u in 0..<N:\n      check WF[s][u] == dijkstra[u]\n      check WF[s][u]\
    \ == BF[u]\n      check WF[s][u] == dijkstra_RH[u]\n\ntest \"ShortestPathTestFloat\"\
    :\n  const eps = 1e-10\n  const N = 50\n  var g = initGraph(N, float)\n  var A\
    \ = newSeqWith(N, newSeqWith(N, 0.0))\n  for i in 0..<N:\n    for j in 0..<N:\n\
    \      if i == j:\n        A[i][j] = 0\n      else:\n        let d = rand(0.0..100.0)\n\
    \        A[i][j] = d\n        g.addEdge(i, j, d)\n  var WF = A.warshall_floyd()\n\
    \  for s in 0..<N:\n    var dijkstra = g.dijkstra(s)\n    var BF = g.bellman_ford(s)\n\
    \    for u in 0..<N:\n      check abs(WF[s][u] - dijkstra[u]) < eps\n      check\
    \ abs(WF[s][u] - BF[u]) < eps\n\ntest \"ShortestPathTestTwoDimensional\":\n  const\
    \ N = 7\n  proc id(x:(int, int)):int = x[0] * N + x[1]\n  var g = initGraph(N\
    \ * N, id)\n  var A = newSeqWith(N * N, newSeqWith(N * N, 0))\n  for x0 in 0..<N:\n\
    \    for y0 in 0..<N:\n      let p0 = (x0, y0)\n      let i0 = id(p0)\n      for\
    \ x1 in 0..<N:\n        for y1 in 0..<N:\n          let p1 = (x1, y1)\n      \
    \    let i1 = id(p1)\n          if p0 == p1:\n            A[i0][i1] = 0\n    \
    \      else:\n            let d = rand(0..100)\n            A[i0][i1] = d\n  \
    \          g.addEdge(p0, p1, d)\n  var WF = A.warshall_floyd()\n  for x in 0..<N:\n\
    \    for y in 0..<N:\n      let s = (x, y)\n      var dijkstra = g.dijkstra(s)\n\
    \      var BF = g.bellman_ford(s)\n      var dijkstra_RH = g.dijkstra_radix_heap(s)\n\
    \      for x1 in 0..<N:\n        for y1 in 0..<N:\n          let u = (x1, y1)\n\
    \          let WFd = WF[id(s)][id(u)]\n          check WFd == dijkstra[u]\n  \
    \        check WFd == BF[u]\n          check WFd == dijkstra_RH[u]\n\ntest \"\
    ShortestPathTestProc\":\n  const N = 7\n  proc id(x:(int, int)):int = x[0] * N\
    \ + x[1]\n  var g = initGraph(N * N, id)\n  var A = newSeqWith(N * N, newSeqWith(N\
    \ * N, 0))\n  for x0 in 0..<N:\n    for y0 in 0..<N:\n      let p0 = (x0, y0)\n\
    \      let i0 = id(p0)\n      for x1 in 0..<N:\n        for y1 in 0..<N:\n   \
    \       let p1 = (x1, y1)\n          let i1 = id(p1)\n          if p0 == p1:\n\
    \            A[i0][i1] = 0\n          else:\n            let d = rand(0..100)\n\
    \            A[i0][i1] = d\n            g.addEdge(p0, p1, d)\n  proc adj(u:(int,\
    \ int)):auto =\n    result = newSeq[((int, int), int)]()\n    for e in g[u]:\n\
    \      result.add((e.dst, e.weight))\n  var g2 = initGraph(N * N, id, adj)\n \
    \ var WF = A.warshall_floyd()\n  for x in 0..<N:\n    for y in 0..<N:\n      let\
    \ s = (x, y)\n      var dijkstra = g2.dijkstra(s)\n      for x1 in 0..<N:\n  \
    \      for y1 in 0..<N:\n          let u = (x1, y1)\n          let WFd = WF[id(s)][id(u)]\n\
    \          check WFd == dijkstra[u]\n\ntest \"ShortestPathTestIter\":\n  const\
    \ N = 7\n  proc id(x:(int, int)):int = x[0] * N + x[1]\n  var g = initGraph(N\
    \ * N, id)\n  var A = newSeqWith(N * N, newSeqWith(N * N, 0))\n  for x0 in 0..<N:\n\
    \    for y0 in 0..<N:\n      let p0 = (x0, y0)\n      let i0 = id(p0)\n      for\
    \ x1 in 0..<N:\n        for y1 in 0..<N:\n          let p1 = (x1, y1)\n      \
    \    let i1 = id(p1)\n          if p0 == p1:\n            A[i0][i1] = 0\n    \
    \      else:\n            let d = rand(0..100)\n            A[i0][i1] = d\n  \
    \          g.addEdge(p0, p1, d)\n  iterator adj(u:(int, int)):((int, int), int)\
    \ {.closure.} =\n    for e in g[u]:\n      yield (e.dst, e.weight)\n  var g2 =\
    \ initGraph(N * N, id, adj)\n  var WF = A.warshall_floyd()\n  for x in 0..<N:\n\
    \    for y in 0..<N:\n      let s = (x, y)\n      var dijkstra = g2.dijkstra(s)\n\
    \      for x1 in 0..<N:\n        for y1 in 0..<N:\n          let u = (x1, y1)\n\
    \          let WFd = WF[id(s)][id(u)]\n          check WFd == dijkstra[u]\n\n\n\
    test \"ShortestPathTest01\":\n  const N = 50\n  var g = initGraph(N)\n  var A\
    \ = newSeqWith(N, newSeqWith(N, 0))\n  for i in 0..<N:\n    for j in 0..<N:\n\
    \      if i == j:\n        A[i][j] = 0\n      else:\n        let d = rand(0..1)\n\
    \        A[i][j] = d\n        g.addEdge(i, j, d)\n  var WF = A.warshall_floyd()\n\
    \  for s in 0..<N:\n    var dijkstra = g.dijkstra01(s)\n    for u in 0..<N:\n\
    \      check WF[s][u] == dijkstra[u]\n"
  dependsOn:
  - atcoder/extra/graph/warshall_floyd.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/structure/radix_heap.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/bellman_ford.nim
  - atcoder/extra/structure/radix_heap.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/bellman_ford.nim
  - atcoder/extra/graph/warshall_floyd.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/dijkstra.nim
  isVerificationFile: false
  path: tests/test_shortest_path.nim
  requiredBy: []
  timestamp: '2021-07-16 02:11:21+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_shortest_path.nim
layout: document
redirect_from:
- /library/tests/test_shortest_path.nim
- /library/tests/test_shortest_path.nim.html
title: tests/test_shortest_path.nim
---
