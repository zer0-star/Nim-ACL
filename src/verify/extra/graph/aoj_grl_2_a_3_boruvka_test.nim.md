---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/boruvka.nim
    title: atcoder/extra/graph/boruvka.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/boruvka.nim
    title: atcoder/extra/graph/boruvka.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_A
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_A
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_A\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/boruvka\n\nproc main() =\n\
    \  let V, E = nextInt()\n  var X, Y, Z = newSeq[int](E)\n  for i in 0..<E:\n \
    \   X[i] = nextint()\n    Y[i] = nextint()\n    Z[i] = nextint()\n\n  var mst\
    \ = initBoruvka[int](V)\n  proc f(ret:var seq[(int,int)]) =\n    for i in 0..<E:\n\
    \      X[i] = mst.find(X[i])\n      Y[i] = mst.find(Y[i])\n      if X[i] == Y[i]:\
    \ continue\n      ret[X[i]] = min(ret[X[i]], (Z[i], Y[i]))\n      ret[Y[i]] =\
    \ min(ret[Y[i]], (Z[i], X[i]))\n  echo mst.build(f)\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/boruvka.nim
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  - atcoder/extra/graph/boruvka.nim
  - atcoder/header.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
- /verify/verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim.html
title: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
---
