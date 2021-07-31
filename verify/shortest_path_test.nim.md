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
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/shortest_path
    links:
    - https://judge.yosupo.jp/problem/shortest_path
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/shortest_path\n\n\
    include atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/dijkstra\n\
    \nproc main() =\n  let N, M, s, t = nextInt()\n  var g = initGraph(N)\n\n  for\
    \ i in 0..<M:\n    var\n      a = nextInt()\n      b = nextInt()\n      c = nextInt()\n\
    \    g.addEdge(a, b, c)\n  \n  let dist = g.dijkstra(s)\n  if dist[t] == int.inf:\n\
    \    echo -1\n  else:\n    var\n      u = t\n      ans = newSeq[int]()\n    while\
    \ true:\n      ans.add(u)\n      if u == s: break\n      u = dist.prev[u]\n  \
    \  ans.reverse\n    echo dist[t], \" \", ans.len - 1\n    for i in 0..<ans.len\
    \ - 1:\n      echo ans[i], \" \", ans[i+1]\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: true
  path: verify/shortest_path_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/shortest_path_test.nim
layout: document
redirect_from:
- /verify/verify/shortest_path_test.nim
- /verify/verify/shortest_path_test.nim.html
title: verify/shortest_path_test.nim
---
