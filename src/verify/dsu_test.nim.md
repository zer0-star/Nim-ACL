---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/unionfind
    links:
    - https://judge.yosupo.jp/problem/unionfind
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind\n\nimport\
    \ atcoder/header\nimport atcoder/dsu\n\nlet N, Q = nextInt()\nvar uf = initDSU(N)\n\
    \nfor _ in 0 ..< Q:\n  let t, u, v = nextInt()\n\n  if t == 0:\n    uf.merge(u,\
    \ v)\n  elif t == 1:\n    echo(\n      if uf.same(u, v):\n        1\n      else:\n\
    \        0\n    )\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  isVerificationFile: true
  path: verify/dsu_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/dsu_test.nim
layout: document
redirect_from:
- /verify/verify/dsu_test.nim
- /verify/verify/dsu_test.nim.html
title: verify/dsu_test.nim
---
