---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/dijkstra\n\
    \nproc main() =\n  var\n    V = nextInt()\n    E = nextInt()\n    R = nextInt()\n\
    \    g = initGraph(V)\n\n  for i in 0..<E:\n    var\n      a = nextInt()\n   \
    \   b = nextInt()\n      c = nextInt()\n    g.addEdge(a, b, c)\n  \n  var dist\
    \ = dijkstra(g, R)\n  for u in 0..<V:\n    if dist[u] == int.inf: echo \"INF\"\
    \n    else: echo dist[u]\n\nmain()\n"
  dependsOn:
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/dijkstra_result.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
  requiredBy: []
  timestamp: '2022-09-17 04:52:33+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
- /verify/verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim.html
title: verify/extra/graph/aoj_grl_1_a_dijkstra_test.nim
---
