---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_math.nim
    title: src/nim_acl/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_bit.nim
    title: src/nim_acl/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/modint.nim
    title: src/nim_acl/modint.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/extra/structure/universal_segtree.nim
    title: src/nim_acl/extra/structure/universal_segtree.nim
  - icon: ':question:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/extra/structure/universal_segtree.nim
    title: src/nim_acl/extra/structure/universal_segtree.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_bit.nim
    title: src/nim_acl/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/modint.nim
    title: src/nim_acl/modint.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_math.nim
    title: src/nim_acl/internal_math.nim
  - icon: ':question:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
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
    import src/nim_acl/modint\nimport src/nim_acl/header, src/nim_acl/extra/structure/universal_segtree\n\
    \nimport std/sequtils\n\nconst Mod = 998244353\ntype mint = StaticModInt[Mod]\n\
    let n, q = nextInt()\nlet a = newSeqWith(n, (mint(nextInt()), 1))\n\ntype S =\
    \ tuple[a:mint, size:int]\ntype F = tuple[a:mint, b:mint]\n\nproc op(l, r:S):S\
    \ = (l.a + r.a, l.size + r.size)\nproc e():S = (mint(0), 0)\nproc mapping(l:F,\
    \ r:S):S = (r.a * l.a + r.size * l.b, r.size)\nproc composition(l, r:F):F = (r.a\
    \ * l.a, r.b * l.a + l.b)\nproc id():F = (mint(1), mint(0))\n\nvar seg = init_lazy_segtree(a,\
    \ op, e, mapping, composition, id)\n\nfor i in 0..<q:\n  let t = nextInt()\n \
    \ if t == 0:\n    let l, r, c, d = nextInt()\n    seg.apply(l..<r, (mint(c), mint(d)))\n\
    \  else:\n    let l, r = nextInt()\n    echo seg.prod(l..<r)[0]\n"
  dependsOn:
  - src/nim_acl/internal_math.nim
  - src/nim_acl/internal_bit.nim
  - src/nim_acl/modint.nim
  - src/nim_acl/extra/structure/universal_segtree.nim
  - src/nim_acl/header.nim
  - src/nim_acl/extra/structure/universal_segtree.nim
  - src/nim_acl/internal_bit.nim
  - src/nim_acl/modint.nim
  - src/nim_acl/internal_math.nim
  - src/nim_acl/header.nim
  isVerificationFile: true
  path: verify/extra_lazy_segtree_test.nim
  requiredBy: []
  timestamp: '2020-09-17 20:03:53+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra_lazy_segtree_test.nim
layout: document
redirect_from:
- /verify/verify/extra_lazy_segtree_test.nim
- /verify/verify/extra_lazy_segtree_test.nim.html
title: verify/extra_lazy_segtree_test.nim
---
