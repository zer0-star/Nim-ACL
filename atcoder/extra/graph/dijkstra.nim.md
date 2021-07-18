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
  _extendedRequiredBy:
  - icon: ':warning:'
    path: tests/test_shortest_path.nim
    title: tests/test_shortest_path.nim
  - icon: ':warning:'
    path: tests/test_shortest_path.nim
    title: tests/test_shortest_path.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
    title: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
    title: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
    title: verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
    title: verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  - icon: ':x:'
    path: verify/extra/graph/yosupo_shortest_path_test.nim
    title: verify/extra/graph/yosupo_shortest_path_test.nim
  - icon: ':x:'
    path: verify/extra/graph/yosupo_shortest_path_test.nim
    title: verify/extra/graph/yosupo_shortest_path_test.nim
  - icon: ':x:'
    path: verify/shortest_path_test.nim
    title: verify/shortest_path_test.nim
  - icon: ':x:'
    path: verify/shortest_path_test.nim
    title: verify/shortest_path_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':question:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_EXTRA_DIJKSTRA_HPP:\n  const ATCODER_EXTRA_DIJKSTRA_HPP*\
    \ = 1\n  import std/heapqueue, std/sequtils\n  import std/deques, std/options,\
    \ std/sets\n  import atcoder/extra/graph/graph_template\n  import atcoder/extra/other/inf\n\
    \n  type DijkstraObj*[T, U] = object\n    src*, dst*: U\n    weight*: T\n  proc\
    \ `<`*[T, U](a, b:DijkstraObj[T, U]):bool = a.weight < b.weight\n  proc initDijkstraObj[T,\
    \ U](src, dst:U, weight:T):DijkstraObj[T, U] =\n    DijkstraObj[T, U](src:src,\
    \ dst:dst, weight:weight)\n\n  include atcoder/extra/graph/dijkstra_result\n\n\
    \  proc dijkstra01*[G:Graph](g:G, s:G.U or seq[G.U]): auto = \n    var\n     \
    \ n = g.len\n      dist = newSeqWith(n,G.T.inf)\n      Q = initDeque[DijkstraObj[G.T,\
    \ G.U]]()\n      prev_set = newSeqWith(n, false)\n      prev = newSeq[G.U](n)\n\
    \    when s is G.U:\n      dist[g.id(s)] = G.T(0)\n      Q.addFirst(DijkstraObj[G.T,\
    \ G.U](dst:s, weight:G.T(0)))\n    else:\n      for s in s:\n        dist[g.id(s)]\
    \ = G.T(0)\n        Q.addFirst(DijkstraObj[G.T, G.U](dst:s, weight:G.T(0)))\n\
    \    while Q.len > 0:\n      var e = Q.popFirst()\n      let u = g.id(e.dst)\n\
    \      if prev_set[u]: continue\n      prev_set[u] = true\n      prev[u] = e.src\n\
    \      for f in g[e.dst]:\n        var w = e.weight + f.weight\n        let v\
    \ = g.id(f.dst)\n        if dist[v] > w:\n          dist[v] = w;\n          if\
    \ f.weight == 0:\n            Q.addFirst(initDijkstraObj(e.dst, f.dst, w))\n \
    \         else:\n            Q.addLast(initDijkstraObj(e.dst, f.dst, w))\n   \
    \ result = DijkstraResult[G.T, G.U](dist:dist, prev:prev)\n    when G.U isnot\
    \ int: result.id = g.id\n\n  proc dijkstra*[G:Graph](g:G, s:G.U or seq[G.U]):\
    \ auto = \n    var\n      n = g.len\n      dist = newSeqWith(n,g.T.inf)\n    \
    \  Q = initHeapQueue[DijkstraObj[G.T, G.U]]()\n      prev_set = newSeqWith(n,\
    \ false)\n      prev = newSeq[G.U](n)\n    when s is G.U:\n      dist[g.id(s)]\
    \ = g.T(0)\n      Q.push(initDijkstraObj(s,s,g.T(0)))\n    else:\n      for s\
    \ in s:\n        dist[g.id(s)] = g.T(0)\n        Q.push(initDijkstraObj(s,s,g.T(0)))\n\
    \    while Q.len > 0:\n      var e = Q.pop()\n      let eid = g.id(e.dst)\n  \
    \    if prev_set[eid]: continue\n      prev_set[eid] = true\n      prev[eid] =\
    \ e.src\n      for f in g[e.dst]:\n        var w = e.weight + f.weight\n     \
    \   let fid = g.id(f.dst)\n        if dist[fid] > w:\n          dist[fid] = w;\n\
    \          Q.push(initDijkstraObj(e.dst, f.dst, w))\n    result = DijkstraResult[G.T,\
    \ G.U](dist:dist, prev:prev)\n    when G.U isnot int: result.id = g.id\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  isVerificationFile: false
  path: atcoder/extra/graph/dijkstra.nim
  requiredBy:
  - tests/test_shortest_path.nim
  - tests/test_shortest_path.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/shortest_path_test.nim
  - verify/shortest_path_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  - verify/extra/graph/yosupo_shortest_path_test.nim
  - verify/extra/graph/yosupo_shortest_path_test.nim
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
documentation_of: atcoder/extra/graph/dijkstra.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/dijkstra.nim
- /library/atcoder/extra/graph/dijkstra.nim.html
title: atcoder/extra/graph/dijkstra.nim
---
