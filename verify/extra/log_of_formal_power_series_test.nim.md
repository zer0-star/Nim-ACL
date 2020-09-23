---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/internal_fft.nim
    title: atcoder/extra/math/internal_fft.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':x:'
    path: atcoder/extra/math/internal_fft.nim
    title: atcoder/extra/math/internal_fft.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/log_of_formal_power_series
    links:
    - https://judge.yosupo.jp/problem/log_of_formal_power_series
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/log_of_formal_power_series\n\
    \nimport atcoder/header, atcoder/modint\nimport atcoder/extra/math/formal_power_series\n\
    import std/strutils\n\nproc main():void =\n  type mint = modint998244353\n  let\
    \ N = nextInt()\n  var p = initFormalPowerSeries[mint](N)\n  for i in 0..<N: p[i]\
    \ = mint.init(nextInt())\n  echo p.log().join(\" \")\n\nmain()\n"
  dependsOn:
  - atcoder/modint.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/internal_fft.nim
  - atcoder/convolution.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  - atcoder/header.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/internal_fft.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/convolution.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/log_of_formal_power_series_test.nim
  requiredBy: []
  timestamp: '2020-09-22 00:56:23+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/log_of_formal_power_series_test.nim
layout: document
redirect_from:
- /verify/verify/extra/log_of_formal_power_series_test.nim
- /verify/verify/extra/log_of_formal_power_series_test.nim.html
title: verify/extra/log_of_formal_power_series_test.nim
---
