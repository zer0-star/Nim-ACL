---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/segtree_2d.nim
    title: atcoder/extra/structure/segtree_2d.nim
  - icon: ':x:'
    path: atcoder/extra/structure/segtree_2d.nim
    title: atcoder/extra/structure/segtree_2d.nim
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
  - icon: ':x:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
  - icon: ':x:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/point_add_rectangle_sum
    links:
    - https://judge.yosupo.jp/problem/point_add_rectangle_sum
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_rectangle_sum\n\
    \ninclude atcoder/header\nimport atcoder/extra/structure/segtree_2d\n\nlet N,\
    \ Q = nextInt()\n\nvar x, y, w = newSeq[int](N)\nvar v0: seq[(int, int)]\n\nfor\
    \ i in 0 ..< N:\n  x[i] = nextInt()\n  y[i] = nextInt()\n  w[i] = nextInt()\n\
    \  v0.add (x[i], y[i])\n\nvar qv:seq[seq[int]]\n\nfor _ in 0 ..< Q:\n  let t =\
    \ nextInt()\n  if t == 0:\n    let x, y, w = nextInt()\n    v0.add (x, y)\n  \
    \  qv.add @[t, x, y, w]\n  else:\n    let l, d, r, u = nextInt()\n    qv.add @[t,\
    \ l, d, r, u]\n\nvar st = initSegTree2D(v0, proc(a, b:int):int = a + b, proc():int\
    \ = 0)\n\nfor i in 0 ..< N:\n  st.add(x[i], y[i], w[i])\n\nfor v in qv:\n  let\
    \ t = v[0]\n  if t == 0:\n    let\n      x = v[1]\n      y = v[2]\n      w = v[3]\n\
    \    st.add(x, y, w)\n  else:\n    let\n      l = v[1]\n      d = v[2]\n     \
    \ r = v[3]\n      u = v[4]\n    echo st[l ..< r, d ..< u]\n\n\n"
  dependsOn:
  - atcoder/extra/structure/segtree_2d.nim
  - atcoder/segtree.nim
  - atcoder/rangeutils.nim
  - atcoder/segtree.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/rangeutils.nim
  - atcoder/header.nim
  - atcoder/extra/structure/segtree_2d.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
  requiredBy: []
  timestamp: '2022-09-24 20:04:56+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
- /verify/verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim.html
title: verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
---
