---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/scc
    links:
    - https://judge.yosupo.jp/problem/scc
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/scc\n\ninclude atcoder/header\n\
    include atcoder/scc\n\nblock:\n  let N, M = nextInt()\n  var\n    scc = initSccGraph(N)\n\
    \  for i in 0..<M:\n    let a, b = nextInt()\n    scc.add_edge(a, b)\n  var a\
    \ = scc.scc()\n  echo a.len\n  for a in a:\n    echo a.len, \" \", a.join(\" \"\
    )\n"
  dependsOn:
  - atcoder/scc.nim
  - atcoder/internal_csr.nim
  - atcoder/internal_scc.nim
  - atcoder/internal_csr.nim
  - atcoder/header.nim
  - atcoder/internal_scc.nim
  - atcoder/header.nim
  - atcoder/scc.nim
  isVerificationFile: true
  path: verify/scc_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/scc_test.nim
layout: document
redirect_from:
- /verify/verify/scc_test.nim
- /verify/verify/scc_test.nim.html
title: verify/scc_test.nim
---
