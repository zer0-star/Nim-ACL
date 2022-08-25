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
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series_differential_equation.nim
    title: atcoder/extra/math/formal_power_series_differential_equation.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series_differential_equation.nim
    title: atcoder/extra/math/formal_power_series_differential_equation.nim
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
    PROBLEM: https://yukicoder.me/problems/no/963
    links:
    - https://yukicoder.me/problems/no/963
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://yukicoder.me/problems/no/963\n\ninclude\
    \ atcoder/header\n\nimport atcoder/modint\nimport atcoder/extra/math/ntt\nimport\
    \ atcoder/extra/math/formal_power_series\nimport atcoder/extra/math/formal_power_series_differential_equation\n\
    \nuseStaticModInt(mint, 1012924417)\n\ntype fps = FormalPowerSeries[mint]\n\n\
    block solve:\n  var N = nextInt()\n  proc g(f:fps, deg:int):fps =\n    return\
    \ ((f * f + 1) * mint(2).inv()).pre(deg)\n  proc gp(f:fps, deg:int):fps = f.pre(deg)\n\
    \  var f = DifferentialEquation(g, gp, mint(1), N + 1)\n  for i in 1 .. N: f[N]\
    \ *= mint(i)\n  echo f[N] * 2\n"
  dependsOn:
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/element_concepts.nim
  - atcoder/convolution.nim
  - atcoder/header.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/formal_power_series_differential_equation.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/convolution.nim
  - atcoder/modint.nim
  - atcoder/generate_definitions.nim
  - atcoder/header.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_math.nim
  - atcoder/element_concepts.nim
  - atcoder/modint.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series_differential_equation.nim
  - atcoder/internal_bit.nim
  isVerificationFile: true
  path: verify/extra/math/yukicoder_0963_differential_equation_test.nim
  requiredBy: []
  timestamp: '2022-08-08 21:23:55+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/math/yukicoder_0963_differential_equation_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/yukicoder_0963_differential_equation_test.nim
- /verify/verify/extra/math/yukicoder_0963_differential_equation_test.nim.html
title: verify/extra/math/yukicoder_0963_differential_equation_test.nim
---
