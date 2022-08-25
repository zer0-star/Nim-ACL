---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/forward_compatibility/internal_sugar.nim
    title: atcoder/extra/forward_compatibility/internal_sugar.nim
  - icon: ':question:'
    path: atcoder/extra/forward_compatibility/internal_sugar.nim
    title: atcoder/extra/forward_compatibility/internal_sugar.nim
  - icon: ':question:'
    path: atcoder/extra/forward_compatibility/internal_underscored_calls.nim
    title: atcoder/extra/forward_compatibility/internal_underscored_calls.nim
  - icon: ':question:'
    path: atcoder/extra/forward_compatibility/internal_underscored_calls.nim
    title: atcoder/extra/forward_compatibility/internal_underscored_calls.nim
  - icon: ':x:'
    path: atcoder/extra/structure/sliding_window_aggregation.nim
    title: atcoder/extra/structure/sliding_window_aggregation.nim
  - icon: ':x:'
    path: atcoder/extra/structure/sliding_window_aggregation.nim
    title: atcoder/extra/structure/sliding_window_aggregation.nim
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
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/queue_operate_all_composite
    links:
    - https://judge.yosupo.jp/problem/queue_operate_all_composite
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/queue_operate_all_composite\n\
    \nimport atcoder/header\nimport atcoder/extra/forward_compatibility/internal_sugar\n\
    import atcoder/extra/structure/sliding_window_aggregation\n\nimport atcoder/modint\n\
    type mint = modint998244353\n\nf(p, q:(mint,mint)) => (q[0] + q[1] * p[0], q[1]\
    \ * p[1])\ne() => (mint(0), mint(1))\n\nvar swa = initSlidingWindowAggregation(f,\
    \ e)\n\nlet Q = nextInt()\nfor _ in 0..<Q:\n  let q = nextInt()\n  if q == 0:\n\
    \    let a, b = nextInt().mint\n    swa.push((b, a))\n  elif q == 1:\n    swa.pop()\n\
    \  else:\n    let x = nextInt().mint\n    let (b, a) = swa.fold_all()\n    echo\
    \ a * x + b\n\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/forward_compatibility/internal_sugar.nim
  - atcoder/extra/forward_compatibility/internal_underscored_calls.nim
  - atcoder/internal_math.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/structure/sliding_window_aggregation.nim
  - atcoder/modint.nim
  - atcoder/extra/forward_compatibility/internal_underscored_calls.nim
  - atcoder/modint.nim
  - atcoder/extra/structure/sliding_window_aggregation.nim
  - atcoder/extra/forward_compatibility/internal_sugar.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
- /verify/verify/extra/structure/yosupo_queue_operate_all_composite_test.nim.html
title: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
---
