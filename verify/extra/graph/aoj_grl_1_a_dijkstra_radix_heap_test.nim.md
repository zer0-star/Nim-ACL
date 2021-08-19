---
data:
  _extendedDependsOn:
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
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/dijkstra_radix_heap\n\
    \nproc main() =\n  var\n    V = nextInt()\n    E = nextInt()\n    R = nextInt()\n\
    \    g = initGraph(V, int32)\n\n  for i in 0..<E:\n    var\n      a = nextInt()\n\
    \      b = nextInt()\n      c = nextInt().int32\n    g.addEdge(a, b, c)\n  \n\
    \  let dist = dijkstra_radix_heap(g, R)\n  for u in 0..<V:\n    if dist[u] ==\
    \ int32.inf: echo \"INF\"\n    else: echo dist[u]\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/structure/radix_heap.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/structure/radix_heap.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
- /verify/verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim.html
title: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
---
