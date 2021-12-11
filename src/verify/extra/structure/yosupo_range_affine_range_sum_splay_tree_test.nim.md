---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
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
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/range_affine_range_sum
    links:
    - https://judge.yosupo.jp/problem/range_affine_range_sum
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/range_affine_range_sum\n\
    import atcoder/header, atcoder/modint\nimport std/sequtils\n\nimport atcoder/extra/structure/splay_tree\n\
    \ntype mint = modint998244353\nlet n, q = nextInt()\nlet a = newSeqWith(n, (mint(nextInt()),\
    \ 1))\n\ntype S = tuple[a:mint, size:int]\ntype F = tuple[a:mint, b:mint]\n\n\
    proc op(l, r:S):S = (l.a + r.a, l.size + r.size)\nproc e():S = (mint(0), 0)\n\
    proc mapping(l:F, r:S):S = (r.a * l.a + r.size * l.b, r.size)\nproc composition(l,\
    \ r:F):F = (r.a * l.a, r.b * l.a + l.b)\nproc id():F = (mint(1), mint(0))\n\n\
    var seg = initLazySplayTree(op, mapping, composition, e(), id())\nseg.build(a)\n\
    \nfor i in 0..<q:\n  let t = nextInt()\n  if t == 0:\n    let l, r, c, d = nextInt()\n\
    \    seg.apply(l..<r, (mint(c), mint(d)))\n  else:\n    let l, r = nextInt()\n\
    \    echo seg.prod(l..<r)[0]\n"
  dependsOn:
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/header.nim
  - atcoder/modint.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/modint.nim
  - atcoder/header.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_math.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
- /verify/verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim.html
title: verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
---
