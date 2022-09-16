---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/hopcroft_karp.nim
    title: atcoder/extra/graph/hopcroft_karp.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/hopcroft_karp.nim
    title: atcoder/extra/graph/hopcroft_karp.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/bipartitematching
    links:
    - https://judge.yosupo.jp/problem/bipartitematching
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/bipartitematching\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/hopcroft_karp\n\nproc main()\
    \ =\n  let L, R, M = nextInt()\n  var g = initHopcroftKarp(L, R)\n  for i in 0..<M:\n\
    \    let u, v = nextInt()\n    g.addEdge(u, v)\n  \n  let p = g.maximum_matching()\n\
    \  echo p.len\n  for p in p:\n    echo p[0], \" \", p[1]\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/hopcroft_karp.nim
  - atcoder/extra/graph/hopcroft_karp.nim
  - atcoder/header.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/graph/yosupo_bipartite_matching_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/yosupo_bipartite_matching_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/yosupo_bipartite_matching_test.nim
- /verify/verify/extra/graph/yosupo_bipartite_matching_test.nim.html
title: verify/extra/graph/yosupo_bipartite_matching_test.nim
---
