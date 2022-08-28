---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/forward_compatibility/internal_sugar.nim
    title: atcoder/extra/forward_compatibility/internal_sugar.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/forward_compatibility/internal_sugar.nim
    title: atcoder/extra/forward_compatibility/internal_sugar.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/forward_compatibility/internal_underscored_calls.nim
    title: atcoder/extra/forward_compatibility/internal_underscored_calls.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/forward_compatibility/internal_underscored_calls.nim
    title: atcoder/extra/forward_compatibility/internal_underscored_calls.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
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
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/point_set_range_composite
    links:
    - https://judge.yosupo.jp/problem/point_set_range_composite
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_set_range_composite\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/structure/splay_tree\nimport\
    \ atcoder/modint\nimport atcoder/extra/forward_compatibility/internal_sugar\n\n\
    type mint = modint998244353\n\nblock:\n  let N, Q = nextInt()\n  proc f(a, b:(mint,mint)):(mint,mint)\
    \ = (a[0] * b[0], a[1] * b[0] + b[1])\n  \n  var seg = initReversibleSplayTree(f,\
    \ (a:(mint, mint)) => a, (mint(1), mint(0)))\n  \n  var V = newSeqWith(N, (mint(nextInt()),\
    \ mint(nextInt())))\n  \n  seg.build(V)\n\n  for i in 0..<Q:\n    let t = nextInt()\n\
    \    if t == 0:\n      let p = nextInt()\n      let a, b = mint(nextInt())\n \
    \     seg.set(p, (a, b))\n    else:\n      let l, r = nextInt()\n      let x =\
    \ nextInt().mint\n      let ret = seg.prod(l..<r)\n      echo ret[0] * x + ret[1]\n"
  dependsOn:
  - atcoder/modint.nim
  - atcoder/extra/forward_compatibility/internal_sugar.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/forward_compatibility/internal_underscored_calls.nim
  - atcoder/generate_definitions.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_math.nim
  - atcoder/extra/forward_compatibility/internal_sugar.nim
  - atcoder/modint.nim
  - atcoder/header.nim
  - atcoder/extra/forward_compatibility/internal_underscored_calls.nim
  - atcoder/generate_definitions.nim
  - atcoder/header.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_math.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
- /verify/verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim.html
title: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
---
