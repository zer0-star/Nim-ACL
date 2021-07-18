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
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':warning:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':warning:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  - icon: ':warning:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
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
  code: "include atcoder/header\nimport atcoder/maxflow\n\nlet n, m = nextInt()\n\
    var grid = newSeqWith(n, nextString())\n\n# generate (s -> even grid -> odd grid\
    \ -> t) graph\n# grid(i, j) correspond to vertex (i * m + j)\nvar g = initMFGraph[int](n\
    \ * m + 2)\nlet\n  s = n * m\n  t = n * m + 1;\n\n# s -> even / odd -> t\nfor\
    \ i in 0..<n:\n  for j in 0..<m:\n    if grid[i][j] == '#': continue\n    let\
    \ v = i * m + j\n    if (i + j) mod 2 == 0:\n      g.add_edge(s, v, 1)\n    else:\n\
    \      g.add_edge(v, t, 1)\n\n# even -> odd\nfor i in 0..<n:\n  for j in 0..<m:\n\
    \    if (i + j) mod 2 == 1 or grid[i][j] == '#': continue\n    let v0 = i * m\
    \ + j\n    if i != 0 and grid[i - 1][j] == '.':\n      let v1 = (i - 1) * m +\
    \ j\n      g.add_edge(v0, v1, 1)\n    if j != 0 and grid[i][j - 1] == '.':\n \
    \     let v1 = i * m + (j - 1)\n      g.add_edge(v0, v1, 1)\n    if i + 1 < n\
    \ and grid[i + 1][j] == '.':\n      let v1 = (i + 1) * m + j\n      g.add_edge(v0,\
    \ v1, 1)\n    if j + 1 < m and grid[i][j + 1] == '.':\n      let v1 = i * m +\
    \ (j + 1)\n      g.add_edge(v0, v1, 1)\n\necho g.flow(s, t)\n\nlet edges = g.edges()\n\
    for e in edges:\n  if e.src == s or e.dst == t or e.flow == 0: continue\n  let\n\
    \    i0 = e.src div m\n    j0 = e.src mod m\n    i1 = e.dst div m\n    j1 = e.dst\
    \ mod m\n\n  if i0 == i1 + 1:\n    grid[i1][j1] = 'v'; grid[i0][j0] = '^'\n  elif\
    \ j0 == j1 + 1:\n    grid[i1][j1] = '>'; grid[i0][j0] = '<'\n  elif i0 == i1 -\
    \ 1:\n    grid[i0][j0] = 'v'; grid[i1][j1] = '^'\n  else:\n    grid[i0][j0] =\
    \ '>'; grid[i1][j1] = '<'\n\necho grid.join(\"\\n\")\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/maxflow.nim
  - atcoder/maxflow.nim
  - atcoder/internal_queue.nim
  - atcoder/internal_queue.nim
  - atcoder/header.nim
  isVerificationFile: false
  path: test/example/maxflow_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/maxflow_practice.nim
layout: document
redirect_from:
- /library/test/example/maxflow_practice.nim
- /library/test/example/maxflow_practice.nim.html
title: test/example/maxflow_practice.nim
---
