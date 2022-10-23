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
  _extendedRequiredBy: []
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
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_shortest_path_test.nim
    title: verify/extra/graph/yosupo_shortest_path_test.nim
  - icon: ':heavy_check_mark:'
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_EXTRA_DIJKSTRA_HPP:\n  const ATCODER_EXTRA_DIJKSTRA_HPP*\
    \ = 1\n  import std/heapqueue, std/sequtils\n  import std/deques, std/options,\
    \ std/sets, std/tables\n  import atcoder/extra/graph/graph_template\n  import\
    \ atcoder/extra/other/inf\n\n\n  type DijkstraObj*[T, U] = object\n    src*, dst*:\
    \ U\n    weight*: T\n  proc `<`*[T, U](a, b:DijkstraObj[T, U]):bool = a.weight\
    \ < b.weight\n  proc initDijkstraObj[T, U](src, dst:U, weight:T):DijkstraObj[T,\
    \ U] =\n    DijkstraObj[T, U](src:src, dst:dst, weight:weight)\n\n  include atcoder/extra/graph/dijkstra_result\n\
    \n  proc dijkstra01*[G:Graph](g:G, s:G.U or seq[G.U]): auto = \n    var default_val:\
    \ tuple[dist:G.T, prev_set:bool, prev:G.U]\n    default_val.dist = G.T.inf\n \
    \   default_val.prev_set = false\n    var\n      a = initNodeArray(g, default_val,\
    \ g.len)\n      Q = initDeque[DijkstraObj[G.T, G.U]]()\n    when s is G.U:\n \
    \     var p = a[s]\n      p[].dist = G.T(0)\n      p[].prev = s\n      Q.addFirst(DijkstraObj[G.T,\
    \ G.U](src:s, dst:s, weight:G.T(0)))\n    else:\n      for s in s:\n        var\
    \ p = a[s]\n        p[].dist = G.T(0)\n        p[].prev = s\n        Q.addFirst(DijkstraObj[G.T,\
    \ G.U](src: s, dst:s, weight:G.T(0)))\n    while Q.len > 0:\n      var e = Q.popFirst()\n\
    \      var p = a[e.dst]\n      if p[].prev_set: continue\n      p[].prev_set =\
    \ true\n      p[].prev = e.src\n      for f in g[e.dst]:\n        var w = e.weight\
    \ + f.weight\n        var p = a[f.dst]\n        if p[].dist > w:\n          p[].dist\
    \ = w;\n          if f.weight == 0:\n            Q.addFirst(initDijkstraObj(e.dst,\
    \ f.dst, w))\n          else:\n            Q.addLast(initDijkstraObj(e.dst, f.dst,\
    \ w))\n    result = DijkstraResult[G.T, G.U, G.useId](a:a)\n\n  proc dijkstra*[G:Graph](g:var\
    \ G, s:G.U or seq[G.U]): auto = \n    var default_val: tuple[dist:G.T, prev_set:bool,\
    \ prev:G.U]\n    default_val.dist = G.T.inf\n    default_val.prev_set = false\n\
    \    var\n      a = initNodeArray(g, default_val, g.len)\n      Q = initHeapQueue[DijkstraObj[G.T,\
    \ G.U]]()\n    when s is G.U:\n      var p = a[s]\n      p[].dist = g.T(0)\n \
    \     Q.push(initDijkstraObj(s,s,g.T(0)))\n    else:\n      for s in s:\n    \
    \    var p = a[s]\n        p[].dist = g.T(0)\n        Q.push(initDijkstraObj(s,s,g.T(0)))\n\
    \    while Q.len > 0:\n      var e = Q.pop()\n      var p = a[e.dst]\n      if\
    \ p.prev_set: continue\n      p[].prev_set = true\n      p[].prev = e.src\n  \
    \    for f in g[e.dst]:\n        var w = e.weight + f.weight\n        var p =\
    \ a[f.dst]\n        if p[].dist > w:\n          p[].dist = w;\n          Q.push(initDijkstraObj(e.dst,\
    \ f.dst, w))\n    result = DijkstraResult[G.T, G.U, G.useId](a:a)\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/other/inf.nim
  isVerificationFile: false
  path: atcoder/extra/graph/dijkstra.nim
  requiredBy: []
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  - verify/extra/graph/yosupo_shortest_path_test.nim
  - verify/extra/graph/yosupo_shortest_path_test.nim
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - verify/shortest_path_test.nim
  - verify/shortest_path_test.nim
documentation_of: atcoder/extra/graph/dijkstra.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/dijkstra.nim
- /library/atcoder/extra/graph/dijkstra.nim.html
title: atcoder/extra/graph/dijkstra.nim
---
