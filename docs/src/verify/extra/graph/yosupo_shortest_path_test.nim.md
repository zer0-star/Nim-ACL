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
    PROBLEM: https://judge.yosupo.jp/problem/shortest_path
    links:
    - https://judge.yosupo.jp/problem/shortest_path
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/shortest_path\n\n\
    include atcoder/header\n\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/dijkstra\n\
    \nproc main() =\n  let N, M, s, t = nextInt()\n  var g = initGraph(N)\n\n  for\
    \ i in 0..<M:\n    var\n      a = nextInt()\n      b = nextInt()\n      c = nextInt()\n\
    \    g.addEdge(a, b, c)\n  \n  var dist = g.dijkstra(s)\n  if dist[t] == int.inf:\n\
    \    echo -1\n  else:\n    let p = dist.path(t)\n    echo dist[t], \" \", p.len\
    \ - 1\n    for i in 0..<p.len - 1:\n      echo p[i], \" \", p[i + 1]\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/graph/yosupo_shortest_path_test.nim
  requiredBy: []
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/yosupo_shortest_path_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/yosupo_shortest_path_test.nim
- /verify/verify/extra/graph/yosupo_shortest_path_test.nim.html
title: verify/extra/graph/yosupo_shortest_path_test.nim
---
