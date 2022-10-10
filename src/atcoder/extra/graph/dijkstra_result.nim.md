---
data:
  _extendedDependsOn:
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
  _extendedRequiredBy:
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
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
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra_radix_heap.nim
    title: atcoder/extra/graph/dijkstra_radix_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra_radix_heap.nim
    title: atcoder/extra/graph/dijkstra_radix_heap.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
    title: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
    title: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
    title: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
    title: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DIJKSTRA_RESULT_HPP:\n  const ATCODER_DIJKSTRA_RESULT_HPP*\
    \ = 1\n  import std/algorithm\n  import atcoder/extra/graph/graph_template\n \
    \ type DijkstraResult*[T, U, useId] = object\n    a*: NodeArray[U, tuple[dist:T,\
    \ prev_set:bool, prev:U], useId]\n  proc contains*[T, U, useId](d:var DijkstraResult[T,\
    \ U, useId], u:U):bool =\n    u in d.a\n  proc `[]`*[T, U, useId](d:var DijkstraResult[T,\
    \ U, useId], u:U):T =\n    d.a[u][].dist\n  proc prev*[T, U, useId](d:var DijkstraResult[T,\
    \ U, useId], u:U):U =\n    d.a[u][].prev\n  proc path*[T, U, useId](d:var DijkstraResult[T,\
    \ U, useId], t:U): seq[U] = \n    var u = t\n    while true:\n      result.add(u)\n\
    #      if u == d.s: break\n      var p = d.prev(u)\n      if u == p: break\n \
    \     u = p\n    result.reverse()\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/dijkstra_result.nim
  requiredBy:
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/dijkstra.nim
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/shortest_path_test.nim
  - verify/shortest_path_test.nim
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  - verify/extra/graph/yosupo_shortest_path_test.nim
  - verify/extra/graph/yosupo_shortest_path_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
documentation_of: atcoder/extra/graph/dijkstra_result.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/dijkstra_result.nim
- /library/atcoder/extra/graph/dijkstra_result.nim.html
title: atcoder/extra/graph/dijkstra_result.nim
---
