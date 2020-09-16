---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/fenwicktree.nim
    title: src/nim_acl/fenwicktree.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/fenwicktree.nim
    title: src/nim_acl/fenwicktree.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/point_add_range_sum
    links:
    - https://judge.yosupo.jp/problem/point_add_range_sum
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum\n\
    \nimport src/nim_acl/header\nimport src/nim_acl/fenwicktree\n\nimport sequtils,\
    \ strutils\n\nlet N, Q = nextInt()\nlet a = newSeqWith(N, nextInt())\n\nvar st\
    \ = initFenwickTree[int](N)\n\nfor i in 0..<N:st.add(i, a[i])\nfor _ in 0 ..<\
    \ Q:\n  let t = nextInt()\n  if t == 0:\n    let p, x = nextInt()\n    st.add(p,\
    \ x)\n  else:\n    let l, r = nextInt()\n    echo st.sum(l..<r)\n"
  dependsOn:
  - src/nim_acl/header.nim
  - src/nim_acl/fenwicktree.nim
  - src/nim_acl/header.nim
  - src/nim_acl/fenwicktree.nim
  isVerificationFile: true
  path: verify/fenwick_tree_test.nim
  requiredBy: []
  timestamp: '2020-09-16 18:22:00+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/fenwick_tree_test.nim
layout: document
redirect_from:
- /verify/verify/fenwick_tree_test.nim
- /verify/verify/fenwick_tree_test.nim.html
title: verify/fenwick_tree_test.nim
---
