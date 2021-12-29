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
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/point_add_range_sum
    links:
    - https://judge.yosupo.jp/problem/point_add_range_sum
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum\n\
    \nimport atcoder/header\nimport atcoder/segtree\n\nimport std/sequtils, std/sugar\n\
    \nlet N, Q = nextInt()\nlet a = newSeqWith(N, nextInt())\n\nvar st = initSegTree(a,\
    \ (x:int,y:int)=>x+y, ()=>0)\n\nfor _ in 0 ..< Q:\n  let t = nextInt()\n  if t\
    \ == 0:\n    let p, x = nextInt()\n    let a = st.get(p)\n    st.set(p, a + x)\n\
    \  else:\n    let l, r = nextInt()\n    echo st.prod(l..<r)\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  - atcoder/header.nim
  - atcoder/rangeutils.nim
  - atcoder/segtree.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/segtree_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/segtree_test.nim
layout: document
redirect_from:
- /verify/verify/segtree_test.nim
- /verify/verify/segtree_test.nim.html
title: verify/segtree_test.nim
---
