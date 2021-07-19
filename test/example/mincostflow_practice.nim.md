---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':warning:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  - icon: ':warning:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "include atcoder/header\nimport atcoder/mincostflow\n\nlet n, k = nextInt()\n\
    var g = initMCFGraph[int,int](n * 2 + 2)\nlet (s, t) = (n * 2, n * 2 + 1)\nlet\
    \ BIG = 1000000000\n\ng.add_edge(s, t, n * k, BIG)\n\nfor i in 0..<n:\n  g.add_edge(s,\
    \ i, k, 0)\n  g.add_edge(n + i, t, k, 0)\n\nfor i in 0..<n:\n  for j in 0..<n:\n\
    \    let a = nextInt()\n    g.add_edge(i, n + j, 1, BIG - a)\n\nvar result = g.flow(s,\
    \ t, n * k)\necho n * k * BIG - result[1]\n\nvar grid = newSeqWith(n, '.'.repeat(n))\n\
    let es = g.edges()\nfor e in es:\n  if e.src == s or e.dst == t or e.flow == 0:\
    \ continue\n  grid[e.src][e.dst - n] = 'X'\n\nfor i in 0..<n:\n  echo grid[i]\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/mincostflow.nim
  - atcoder/header.nim
  - atcoder/mincostflow.nim
  isVerificationFile: false
  path: test/example/mincostflow_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/mincostflow_practice.nim
layout: document
redirect_from:
- /library/test/example/mincostflow_practice.nim
- /library/test/example/mincostflow_practice.nim.html
title: test/example/mincostflow_practice.nim
---
