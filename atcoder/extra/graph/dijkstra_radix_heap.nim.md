---
data:
  _extendedDependsOn:
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
  _extendedRequiredBy:
  - icon: ':warning:'
    path: tests/test_shortest_path.nim
    title: tests/test_shortest_path.nim
  - icon: ':warning:'
    path: tests/test_shortest_path.nim
    title: tests/test_shortest_path.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
    title: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
    title: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DIJKSTRA_RADIX_HEAP_HPP:\n  const ATCODER_DIJKSTRA_RADIX_HEAP_HPP*\
    \ = 1\n  import std/sequtils\n  import atcoder/extra/graph/graph_template\n  import\
    \ atcoder/extra/structure/radix_heap\n  import atcoder/extra/other/inf\n\n  include\
    \ atcoder/extra/graph/dijkstra_result\n\n  proc dijkstra_radix_heap*[G:Graph](g:G,\
    \ s:G.U or seq[G.U]): auto =\n    static:\n      assert G.T is SomeInteger, \"\
    weight type must be integer\"\n    let n = g.len\n    var\n      dist = newSeqWith(n,\
    \ G.T.inf)\n      prev_set = newSeqWith(n, false)\n      prev = newSeq[G.U](n)\n\
    \n    var heap = initRadixHeap[G.T, Edge[G.T, G.U]]()\n    when s is G.U:\n  \
    \    let si = g.id(s)\n      dist[si] = G.T(0)\n      heap.push(dist[si], initEdge(s,\
    \ s, G.T(0)))\n    else:\n      for s in s:\n        let si = g.id(s)\n      \
    \  dist[si] = G.T(0)\n        heap.push(dist[si], initEdge(s, s, G.T(0)))\n  \
    \  while not heap.empty():\n      let (cost, p) = heap.pop()\n      let ui = g.id(p.dst)\n\
    \      if prev_set[ui]: continue\n      prev_set[ui] = true\n      prev[ui] =\
    \ p.src\n      for e in g[p.dst]:\n        let next_cost = cost + e.weight\n \
    \       let vi = g.id(e.dst)\n        if dist[vi] <= next_cost: continue\n   \
    \     dist[vi] = next_cost\n        heap.push(dist[vi], e)\n    result = DijkstraResult[G.T,\
    \ G.U](dist:dist, prev:prev)\n    when G.U isnot int: result.id = g.id\n"
  dependsOn:
  - atcoder/extra/structure/radix_heap.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/structure/radix_heap.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  isVerificationFile: false
  path: atcoder/extra/graph/dijkstra_radix_heap.nim
  requiredBy:
  - tests/test_shortest_path.nim
  - tests/test_shortest_path.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
documentation_of: atcoder/extra/graph/dijkstra_radix_heap.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/dijkstra_radix_heap.nim
- /library/atcoder/extra/graph/dijkstra_radix_heap.nim.html
title: atcoder/extra/graph/dijkstra_radix_heap.nim
---
