---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/fenwicktree.nim
    title: atcoder/fenwicktree.nim
  - icon: ':x:'
    path: atcoder/fenwicktree.nim
    title: atcoder/fenwicktree.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':x:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
  - icon: ':x:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/point_add_range_sum
    links:
    - https://judge.yosupo.jp/problem/point_add_range_sum
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum\n\
    \nimport atcoder/header, atcoder/fenwicktree\nimport std/sequtils\n\nlet N, Q\
    \ = nextInt()\nlet a = newSeqWith(N, nextInt())\n\nvar st = initFenwickTree[int](N)\n\
    \nfor i in 0..<N: st.add(i, a[i])\nfor _ in 0 ..< Q:\n  let t = nextInt()\n  if\
    \ t == 0:\n    let p, x = nextInt()\n    st.add(p, x)\n  else:\n    let l, r =\
    \ nextInt()\n    echo st.sum(l..<r)\n"
  dependsOn:
  - atcoder/fenwicktree.nim
  - atcoder/header.nim
  - atcoder/internal_type_traits.nim
  - atcoder/fenwicktree.nim
  - atcoder/internal_type_traits.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/fenwick_tree_test.nim
  requiredBy: []
  timestamp: '2021-12-12 01:47:43+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/fenwick_tree_test.nim
layout: document
redirect_from:
- /verify/verify/fenwick_tree_test.nim
- /verify/verify/fenwick_tree_test.nim.html
title: verify/fenwick_tree_test.nim
---
