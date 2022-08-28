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
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/radix_heap.nim
    title: atcoder/extra/structure/radix_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/radix_heap.nim
    title: atcoder/extra/structure/radix_heap.nim
  _extendedRequiredBy: []
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DIJKSTRA_RADIX_HEAP_HPP:\n  const ATCODER_DIJKSTRA_RADIX_HEAP_HPP*\
    \ = 1\n  import std/sequtils\n  import atcoder/extra/graph/graph_template\n  import\
    \ atcoder/extra/structure/radix_heap\n  import atcoder/extra/other/inf\n\n  include\
    \ atcoder/extra/graph/dijkstra_result\n\n  proc dijkstra_radix_heap*[G:Graph](g:G,\
    \ s:G.U or seq[G.U]): auto =\n    static:\n      assert G.T is SomeInteger, \"\
    weight type must be integer\"\n    var default_val: tuple[dist:G.T, prev_set:bool,\
    \ prev:G.U]\n    default_val.dist = G.T.inf\n    default_val.prev_set = false\n\
    \    let n = g.len\n    var a = initNodeArray(g, default_val, g.len)\n    static:\n\
    \      echo a.type\n\n    var heap = initRadixHeap[G.T, Edge[G.T, G.U]]()\n  \
    \  when s is G.U:\n#      let si = g.id(s)\n      var x = a[s]\n      x[].dist\
    \ = G.T(0)\n#      dist[si] = G.T(0)\n      heap.push(G.T(0), initEdge(s, s, G.T(0)))\n\
    \    else:\n      for s in s:\n        #let si = g.id(s)\n        var x = a[s]\n\
    \        x[].dist = G.T(0)\n        #dist[si] = G.T(0)\n        heap.push(G.T(0),\
    \ initEdge(s, s, G.T(0)))\n    while not heap.empty():\n      let (cost, p) =\
    \ heap.pop()\n      var x = a[p.dst]\n#      let ui = g.id(p.dst)\n#      if prev_set[ui]:\
    \ continue\n      if x[].prev_set: continue\n      x[].prev_set = true\n#    \
    \  prev_set[ui] = true\n      x[].prev = p.src\n#      prev[ui] = p.src\n    \
    \  for e in g[p.dst]:\n        let next_cost = cost + e.weight\n        var x\
    \ = a[e.dst]\n#        let vi = g.id(e.dst)\n        if x[].dist <= next_cost:\
    \ continue\n        x[].dist = next_cost\n        heap.push(x[].dist, e)\n   \
    \ result = DijkstraResult[G.T, G.U, G.useId](a:a)\n"
  dependsOn:
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/structure/radix_heap.nim
  - atcoder/extra/structure/radix_heap.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/structure/radix_heap.nim
  - atcoder/extra/structure/radix_heap.nim
  isVerificationFile: false
  path: atcoder/extra/graph/dijkstra_radix_heap.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
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
