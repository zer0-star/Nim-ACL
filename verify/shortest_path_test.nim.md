---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/template.nim
    title: atcoder/extra/graph/template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/template.nim
    title: atcoder/extra/graph/template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/shortest_path
    links:
    - https://judge.yosupo.jp/problem/shortest_path
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/shortest_path\n\n\
    include atcoder/header\nimport \"atcoder/extra/graph/template.nim\"\nimport atcoder/extra/graph/dijkstra\n\
    \nproc main() =\n  let N, M, s, t = nextInt()\n  var g = initGraph[int](N)\n\n\
    \  for i in 0..<M:\n    var\n      a = nextInt()\n      b = nextInt()\n      c\
    \ = nextInt()\n    g.addEdge(a, b, c)\n  \n  let (dist, prev) = g.dijkstra(s)\n\
    \  if dist[t] == int.inf:\n    echo -1\n  else:\n    var\n      u = t\n      ans\
    \ = newSeq[int]()\n    while true:\n      ans.add(u)\n      if u == s: break\n\
    \      u = prev[u]\n    ans.reverse\n    echo dist[t], \" \", ans.len - 1\n  \
    \  for i in 0..<ans.len - 1:\n      echo ans[i], \" \", ans[i+1]\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/graph/template.nim
  - atcoder/extra/graph/template.nim
  - atcoder/header.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/shortest_path_test.nim
  requiredBy: []
  timestamp: '2020-09-18 00:06:18+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/shortest_path_test.nim
layout: document
redirect_from:
- /verify/verify/shortest_path_test.nim
- /verify/verify/shortest_path_test.nim.html
title: verify/shortest_path_test.nim
---
