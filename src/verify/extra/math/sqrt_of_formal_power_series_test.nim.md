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
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series_sqrt.nim
    title: atcoder/extra/math/formal_power_series_sqrt.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series_sqrt.nim
    title: atcoder/extra/math/formal_power_series_sqrt.nim
  - icon: ':x:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
  - icon: ':x:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
  - icon: ':x:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':x:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':x:'
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
    PROBLEM: https://judge.yosupo.jp/problem/sqrt_of_formal_power_series
    links:
    - https://judge.yosupo.jp/problem/sqrt_of_formal_power_series
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/sqrt_of_formal_power_series\n\
    \nimport atcoder/header, atcoder/modint\nimport atcoder/extra/math/ntt\nimport\
    \ atcoder/extra/math/formal_power_series\nimport atcoder/extra/math/formal_power_series_sqrt\n\
    import std/strutils, std/options\n\nproc main():void =\n  type mint = modint998244353\n\
    \  let N = nextInt()\n  var p = initFormalPowerSeries[mint](N)\n  for i in 0..<N:\n\
    \    p[i] = mint(nextInt())\n  let q = p.sqrt()\n  echo if q.isSome: q.get.join(\"\
    \ \") else: \"-1\"\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/convolution.nim
  - atcoder/modint.nim
  - atcoder/header.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series_sqrt.nim
  - atcoder/convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/extra/math/mod_sqrt.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series_sqrt.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/mod_sqrt.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/modint.nim
  isVerificationFile: true
  path: verify/extra/math/sqrt_of_formal_power_series_test.nim
  requiredBy: []
  timestamp: '2021-12-11 18:27:17+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/math/sqrt_of_formal_power_series_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/sqrt_of_formal_power_series_test.nim
- /verify/verify/extra/math/sqrt_of_formal_power_series_test.nim.html
title: verify/extra/math/sqrt_of_formal_power_series_test.nim
---
