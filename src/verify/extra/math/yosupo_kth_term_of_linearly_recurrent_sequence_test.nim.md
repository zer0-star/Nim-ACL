---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/coef_of_generating_function.nim
    title: atcoder/extra/math/coef_of_generating_function.nim
  - icon: ':x:'
    path: atcoder/extra/math/coef_of_generating_function.nim
    title: atcoder/extra/math/coef_of_generating_function.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':question:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':question:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
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
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/kth_term_of_linearly_recurrent_sequence
    links:
    - https://judge.yosupo.jp/problem/kth_term_of_linearly_recurrent_sequence
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/kth_term_of_linearly_recurrent_sequence\n\
    \nimport atcoder/header\nimport atcoder/modint\nimport atcoder/extra/math/ntt\n\
    import atcoder/extra/math/formal_power_series\nimport atcoder/extra/math/coef_of_generating_function\n\
    import std/sequtils\n\nproc main():void =\n  type mint = modint998244353\n  let\
    \ d, k = nextInt()\n  var a0 = newSeqWith(d, nextInt())\n  var c = newSeqWith(d,\
    \ nextInt())\n  var a = initFormalPowerSeries[mint](a0)\n  var Q = initFormalPowerSeries[mint](d\
    \ + 1)\n  Q[0] = 1\n  for i in 0..<d: Q[i + 1] -= c[i]\n  var P = (a * Q)[0..<d]\n\
    \  echo (P // Q)[k]\n\nmain()\n"
  dependsOn:
  - atcoder/modint.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/convolution.nim
  - atcoder/header.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/modint.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/coef_of_generating_function.nim
  - atcoder/internal_bit.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/element_concepts.nim
  - atcoder/convolution.nim
  - atcoder/header.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/coef_of_generating_function.nim
  isVerificationFile: true
  path: verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
- /verify/verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim.html
title: verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
---
