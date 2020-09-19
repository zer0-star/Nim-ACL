---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/lazysegtree.nim
    title: atcoder/lazysegtree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/lazysegtree.nim
    title: atcoder/lazysegtree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/range_affine_range_sum
    links:
    - https://judge.yosupo.jp/problem/range_affine_range_sum
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/range_affine_range_sum\n\
    \nimport atcoder/header, atcoder/lazysegtree, atcoder/modint\nimport std/sequtils\n\
    \nconst Mod = 998244353\ntype mint = StaticModInt[Mod]\nlet n, q = nextInt()\n\
    let a = newSeqWith(n, (mint(nextInt()), 1))\n\ntype S = tuple[a:mint, size:int]\n\
    type F = tuple[a:mint, b:mint]\n\nproc op(l, r:S):S = (l.a + r.a, l.size + r.size)\n\
    proc e():S = (mint(0), 0)\nproc mapping(l:F, r:S):S = (r.a * l.a + r.size * l.b,\
    \ r.size)\nproc composition(l, r:F):F = (r.a * l.a, r.b * l.a + l.b)\nproc id():F\
    \ = (mint(1), mint(0))\n\nvar seg = init_lazy_segtree(a, op, e, mapping, composition,\
    \ id)\n\nfor i in 0..<q:\n  let t = nextInt()\n  if t == 0:\n    let l, r, c,\
    \ d = nextInt()\n    seg.apply(l..<r, (mint(c), mint(d)))\n  else:\n    let l,\
    \ r = nextInt()\n    echo seg.prod(l..<r)[0]\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/lazysegtree.nim
  - atcoder/internal_math.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  - atcoder/modint.nim
  - atcoder/header.nim
  - atcoder/internal_bit.nim
  - atcoder/lazysegtree.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/lazy_segtree_test.nim
  requiredBy: []
  timestamp: '2020-09-18 23:26:10+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/lazy_segtree_test.nim
layout: document
redirect_from:
- /verify/verify/lazy_segtree_test.nim
- /verify/verify/lazy_segtree_test.nim.html
title: verify/lazy_segtree_test.nim
---
