---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/persistent_array.nim
    title: atcoder/extra/structure/persistent_array.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/persistent_array.nim
    title: atcoder/extra/structure/persistent_array.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/persistent_dsu.nim
    title: atcoder/extra/structure/persistent_dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/persistent_dsu.nim
    title: atcoder/extra/structure/persistent_dsu.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/persistent_unionfind
    links:
    - https://judge.yosupo.jp/problem/persistent_unionfind
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/persistent_unionfind\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/structure/persistent_dsu\n\n\
    proc main() =\n  let N, Q = nextInt()\n  var\n    uf = initPersistentDSU(N)\n\
    \    G = newSeq[PersistentDSU](Q+1)\n  G[0] = uf\n  \n  for i in 0..<Q:\n    var\
    \ t, k, u, v = nextInt()\n    k.inc\n    if t == 0:\n      G[i+1] = G[k].merge(u,\
    \ v)\n    else:\n      echo if G[k].leader(u) == G[k].leader(v): 1 else: 0\n\n\
    main()\n"
  dependsOn:
  - atcoder/extra/structure/persistent_dsu.nim
  - atcoder/extra/structure/persistent_array.nim
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/extra/structure/persistent_dsu.nim
  - atcoder/extra/structure/persistent_array.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_persistent_unionfind_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_persistent_unionfind_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_persistent_unionfind_test.nim
- /verify/verify/extra/structure/yosupo_persistent_unionfind_test.nim.html
title: verify/extra/structure/yosupo_persistent_unionfind_test.nim
---
