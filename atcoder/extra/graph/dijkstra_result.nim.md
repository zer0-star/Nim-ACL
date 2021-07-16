---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
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
  code: "when not declared ATCODER_DIJKSTRA_RESULT_HPP:\n  const ATCODER_DIJKSTRA_RESULT_HPP*\
    \ = 1\n  import std/algorithm\n  type DijkstraResult*[T, U] = object\n    dist*:\
    \ seq[T]\n    prev*: seq[U]\n    when U isnot int:\n      id*: proc(u:U):int\n\
    \  proc `[]`*[T, U](d:DijkstraResult[T, U], u:U):T =\n    let u = when U isnot\
    \ int: d.id(u) else: u\n    d.dist[u]\n  proc path*[T, U](d:DijkstraResult[T,\
    \ U], t:U): seq[U] = \n    var u = t\n    while u >= 0:\n      result.add(u)\n\
    #      if u == d.s: break\n      if u == d.prev[u]: break\n      u = d.prev[u]\n\
    \    result.reverse()\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/dijkstra_result.nim
  requiredBy:
  - tests/test_shortest_path.nim
  - tests/test_shortest_path.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/shortest_path_test.nim
  - verify/shortest_path_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  - verify/extra/graph/yosupo_shortest_path_test.nim
  - verify/extra/graph/yosupo_shortest_path_test.nim
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
documentation_of: atcoder/extra/graph/dijkstra_result.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/dijkstra_result.nim
- /library/atcoder/extra/graph/dijkstra_result.nim.html
title: atcoder/extra/graph/dijkstra_result.nim
---
