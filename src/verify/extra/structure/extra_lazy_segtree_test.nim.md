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
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
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
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/range_affine_range_sum
    links:
    - https://judge.yosupo.jp/problem/range_affine_range_sum
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/range_affine_range_sum\n\
    import atcoder/modint\nimport atcoder/header, atcoder/extra/structure/universal_segtree\n\
    \nimport std/sequtils\n\nconst Mod = 998244353\ntype mint = StaticModInt[Mod]\n\
    let n, q = nextInt()\nlet a = newSeqWith(n, (mint(nextInt()), 1))\n\ntype S =\
    \ tuple[a: mint, size: int]\ntype F = tuple[a: mint, b: mint]\n\nproc op(l, r:\
    \ S): S = (l.a + r.a, l.size + r.size)\nproc e(): S = (mint(0), 0)\nproc mapping(l:\
    \ F, r: S): S = (r.a * l.a + r.size * l.b, r.size)\nproc composition(l, r: F):\
    \ F = (r.a * l.a, r.b * l.a + l.b)\nproc id(): F = (mint(1), mint(0))\n\nvar seg\
    \ = init_lazy_segtree[S, F](a, op, e, mapping, composition, id)\n\nfor i in 0..<q:\n\
    \  let t = nextInt()\n  if t == 0:\n    let l, r, c, d = nextInt()\n    seg.apply(l..<r,\
    \ (mint(c), mint(d)))\n  else:\n    let l, r = nextInt()\n    echo seg.prod(l..<r)[0]\n"
  dependsOn:
  - atcoder/extra/structure/universal_segtree.nim
  - atcoder/internal_math.nim
  - atcoder/header.nim
  - atcoder/modint.nim
  - atcoder/rangeutils.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/internal_bit.nim
  - atcoder/rangeutils.nim
  - atcoder/generate_definitions.nim
  - atcoder/header.nim
  - atcoder/extra/structure/universal_segtree.nim
  - atcoder/modint.nim
  - atcoder/internal_bit.nim
  isVerificationFile: true
  path: verify/extra/structure/extra_lazy_segtree_test.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:00+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/extra_lazy_segtree_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/extra_lazy_segtree_test.nim
- /verify/verify/extra/structure/extra_lazy_segtree_test.nim.html
title: verify/extra/structure/extra_lazy_segtree_test.nim
---
