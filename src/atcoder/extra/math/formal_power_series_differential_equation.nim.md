---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/math/yukicoder_0963_differential_equation_test.nim
    title: verify/extra/math/yukicoder_0963_differential_equation_test.nim
  - icon: ':x:'
    path: verify/extra/math/yukicoder_0963_differential_equation_test.nim
    title: verify/extra/math/yukicoder_0963_differential_equation_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DIFFERENTIAL_EQUATION_HPP:\n  const ATCODER_DIFFERENTIAL_EQUATION_HPP*\
    \ = 1\n  import atcoder/extra/math/formal_power_series\n\n  # find f, saitsfying\
    \ equation f' = g(f) mod x ^ deg\n  proc DifferentialEquation*[T](g, gprime:proc(f:\
    \ FormalPowerSeries[T], n:int):FormalPowerSeries[T], f0:T, deg:int):FormalPowerSeries[T]\
    \ =\n    var\n      f = initFormalPowerSeries[T](@[f0])\n      i = 1\n    while\
    \ i < deg:\n      var \n        r = (-gprime(f, i shl 1)).integral().exp(i shl\
    \ 1)\n        h = ((g(f, i shl 1) - gprime(f, i shl 1) * f) * r).pre(i shl 1).integral()\n\
    \      f = ((h + f0) * r.inv(i shl 1)).pre(i shl 1)\n      i = i shl 1\n    return\
    \ f.pre(deg)\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  isVerificationFile: false
  path: atcoder/extra/math/formal_power_series_differential_equation.nim
  requiredBy: []
  timestamp: '2022-09-17 04:52:33+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/math/yukicoder_0963_differential_equation_test.nim
  - verify/extra/math/yukicoder_0963_differential_equation_test.nim
documentation_of: atcoder/extra/math/formal_power_series_differential_equation.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/formal_power_series_differential_equation.nim
- /library/atcoder/extra/math/formal_power_series_differential_equation.nim.html
title: atcoder/extra/math/formal_power_series_differential_equation.nim
---
