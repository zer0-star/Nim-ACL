---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/unionfind
    links:
    - https://judge.yosupo.jp/problem/unionfind
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind\n\nimport\
    \ atcoder/dsu\nimport std/sequtils, std/strutils\n\nlet\n  nq = stdin.readLine.split.map(parseInt)\n\
    \nvar\n  uf = initDSU(nq[0])\n\nfor _ in 0 ..< nq[1]:\n  let\n    tuv = stdin.readLine.split.map(parseInt)\n\
    \n  if tuv[0] == 0:\n    uf.merge(tuv[1], tuv[2])\n  elif tuv[0] == 1:\n    echo(\n\
    \      if uf.same(tuv[1], tuv[2]):\n        1\n      else:\n        0\n    )\n"
  dependsOn:
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  isVerificationFile: true
  path: verify/dsu_test.nim
  requiredBy: []
  timestamp: '2020-09-18 00:06:18+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/dsu_test.nim
layout: document
redirect_from:
- /verify/verify/dsu_test.nim
- /verify/verify/dsu_test.nim.html
title: verify/dsu_test.nim
---