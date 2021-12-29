---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/polynomial_taylor_shift.nim
    title: atcoder/extra/math/polynomial_taylor_shift.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/polynomial_taylor_shift.nim
    title: atcoder/extra/math/polynomial_taylor_shift.nim
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
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/polynomial_taylor_shift
    links:
    - https://judge.yosupo.jp/problem/polynomial_taylor_shift
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/polynomial_taylor_shift\n\
    \nimport atcoder/header\nimport atcoder/modint\nimport atcoder/extra/math/ntt\n\
    import atcoder/extra/math/formal_power_series\nimport atcoder/extra/math/polynomial_taylor_shift\n\
    import std/strutils, std/sequtils\n\nproc main():void =\n  type mint = modint998244353\n\
    \  let N, c = nextInt()\n  var a = initFormalPowerSeries[mint](newSeqWith(N, mint.init(nextInt())))\n\
    \  let b = a.taylor_shift(c)\n  echo b.join(\" \")\n\nmain()\n"
  dependsOn:
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/convolution.nim
  - atcoder/modint.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/extra/math/polynomial_taylor_shift.nim
  - atcoder/generate_definitions.nim
  - atcoder/header.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/combination.nim
  - atcoder/internal_bit.nim
  - atcoder/modint.nim
  - atcoder/extra/math/polynomial_taylor_shift.nim
  - atcoder/header.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/convolution.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/element_concepts.nim
  isVerificationFile: true
  path: verify/extra/math/polynomial_taylor_shift_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/math/polynomial_taylor_shift_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/polynomial_taylor_shift_test.nim
- /verify/verify/extra/math/polynomial_taylor_shift_test.nim.html
title: verify/extra/math/polynomial_taylor_shift_test.nim
---
