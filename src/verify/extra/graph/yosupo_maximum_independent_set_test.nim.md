---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/maximum_independent_set.nim
    title: atcoder/extra/graph/maximum_independent_set.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/maximum_independent_set.nim
    title: atcoder/extra/graph/maximum_independent_set.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/maximum_independent_set
    links:
    - https://judge.yosupo.jp/problem/maximum_independent_set
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/maximum_independent_set\n\
    \ninclude atcoder/header\n\ninclude atcoder/extra/graph/maximum_independent_set\n\
    \nproc main() =\n  var\n    N = nextInt()\n    M = nextInt()\n    g = newSeqWith(N,\
    \ newSeqWith(N, 0))\n  for i in 0..<M:\n    let u, v = nextInt()\n    g[u][v]\
    \ = 1\n    g[v][u] = 1\n  \n  let p = g.maximum_independent_set()\n  echo p.len\n\
    \  for i in 0..<p.len:\n    stdout.write p[i]\n    if i < p.len - 1: stdout.write\
    \ \" \"\n  echo \"\"\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/maximum_independent_set.nim
  - atcoder/extra/graph/maximum_independent_set.nim
  - atcoder/header.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/graph/yosupo_maximum_independent_set_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/yosupo_maximum_independent_set_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/yosupo_maximum_independent_set_test.nim
- /verify/verify/extra/graph/yosupo_maximum_independent_set_test.nim.html
title: verify/extra/graph/yosupo_maximum_independent_set_test.nim
---
