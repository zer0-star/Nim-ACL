---
data:
  _extendedDependsOn:
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
  - icon: ':x:'
    path: atcoder/lazysegtree.nim
    title: atcoder/lazysegtree.nim
  - icon: ':x:'
    path: atcoder/lazysegtree.nim
    title: atcoder/lazysegtree.nim
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/range_affine_range_sum\n\
    import atcoder/modint\nimport atcoder/header, atcoder/lazysegtree\n\nimport std/sequtils\n\
    \nconst Mod = 998244353\ntype mint = DynamicModInt[-1]\nmint.setMod(Mod)\nlet\
    \ n, q = nextInt()\nlet a = newSeqWith(n, (mint(nextInt()), 1))\n\ntype S = tuple[a:mint,\
    \ size:int]\ntype F = tuple[a:mint, b:mint]\n\nproc op(l, r:S):S = (l.a + r.a,\
    \ l.size + r.size)\nproc e():S = (mint(0), 0)\nproc mapping(l:F, r:S):S = (r.a\
    \ * l.a + r.size * l.b, r.size)\nproc composition(l, r:F):F = (r.a * l.a, r.b\
    \ * l.a + l.b)\nproc id():F = (mint(1), mint(0))\n\nvar seg = init_lazy_segtree(a,\
    \ op, e, mapping, composition, id)\n\nfor i in 0..<q:\n  let t = nextInt()\n \
    \ if t == 0:\n    let l, r, c, d = nextInt()\n    seg.apply(l..<r, (mint(c), mint(d)))\n\
    \  else:\n    let l, r = nextInt()\n    echo seg.prod(l..<r)[0]\n"
  dependsOn:
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/rangeutils.nim
  - atcoder/lazysegtree.nim
  - atcoder/internal_bit.nim
  - atcoder/header.nim
  - atcoder/modint.nim
  - atcoder/generate_definitions.nim
  - atcoder/rangeutils.nim
  - atcoder/lazysegtree.nim
  - atcoder/internal_bit.nim
  - atcoder/header.nim
  - atcoder/generate_definitions.nim
  isVerificationFile: true
  path: verify/lazy_segtree_dynamicmodint_test.nim
  requiredBy: []
  timestamp: '2022-02-05 00:42:13+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/lazy_segtree_dynamicmodint_test.nim
layout: document
redirect_from:
- /verify/verify/lazy_segtree_dynamicmodint_test.nim
- /verify/verify/lazy_segtree_dynamicmodint_test.nim.html
title: verify/lazy_segtree_dynamicmodint_test.nim
---
