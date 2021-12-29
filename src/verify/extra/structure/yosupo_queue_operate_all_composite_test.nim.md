---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/sliding_window_aggregation.nim
    title: atcoder/extra/structure/sliding_window_aggregation.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/sliding_window_aggregation.nim
    title: atcoder/extra/structure/sliding_window_aggregation.nim
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
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/queue_operate_all_composite
    links:
    - https://judge.yosupo.jp/problem/queue_operate_all_composite
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/queue_operate_all_composite\n\
    \nimport atcoder/header\nimport atcoder/extra/other/internal_sugar\nimport atcoder/extra/structure/sliding_window_aggregation\n\
    \nimport atcoder/modint\ntype mint = modint998244353\n\nf(p, q:(mint,mint)) =>\
    \ (q[0] + q[1] * p[0], q[1] * p[1])\ne() => (mint(0), mint(1))\n\nvar swa = initSlidingWindowAggregation(f,\
    \ e)\n\nlet Q = nextInt()\nfor _ in 0..<Q:\n  let q = nextInt()\n  if q == 0:\n\
    \    let a, b = nextInt().mint\n    swa.push((b, a))\n  elif q == 1:\n    swa.pop()\n\
    \  else:\n    let x = nextInt().mint\n    let (b, a) = swa.fold_all()\n    echo\
    \ a * x + b\n\n"
  dependsOn:
  - atcoder/extra/structure/sliding_window_aggregation.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/other/internal_underscored_calls.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/structure/sliding_window_aggregation.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/header.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/modint.nim
  - atcoder/modint.nim
  - atcoder/header.nim
  - atcoder/extra/other/internal_underscored_calls.nim
  - atcoder/internal_math.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
- /verify/verify/extra/structure/yosupo_queue_operate_all_composite_test.nim.html
title: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
---
