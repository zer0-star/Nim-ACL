---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/universal_segtree.nim
    title: atcoder/extra/structure/universal_segtree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/universal_segtree.nim
    title: atcoder/extra/structure/universal_segtree.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum\n\
    \nimport atcoder/header\nimport atcoder/extra/structure/universal_segtree\n\n\
    import std/sequtils, std/sugar\n\nlet N, Q = nextInt()\nlet a = newSeqWith(N,\
    \ nextInt())\n\nvar st = initSegTree(a, (x: int, y: int)=>x+y, ()=>0)\n\nfor _\
    \ in 0 ..< Q:\n  let t = nextInt()\n  if t == 0:\n    let p, x = nextInt()\n \
    \   let a = st.get(p)\n    st.set(p, a + x)\n  else:\n    let l, r = nextInt()\n\
    \    echo st.prod(l..<r)\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/universal_segtree.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/universal_segtree.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/structure/extra_segtree_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/extra_segtree_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/extra_segtree_test.nim
- /verify/verify/extra/structure/extra_segtree_test.nim.html
title: verify/extra/structure/extra_segtree_test.nim
---
