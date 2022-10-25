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
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
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
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/1080
    links:
    - https://yukicoder.me/problems/no/1080
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://yukicoder.me/problems/no/1080\n\nimport\
    \ atcoder/header\nimport atcoder/modint\nimport atcoder/extra/math/mod_sqrt\n\
    import atcoder/extra/math/ntt\nimport atcoder/extra/math/formal_power_series\n\
    import std/options\n\nuseStaticModInt(mint, 1000000009)\n\nlet N = nextInt()\n\
    let im = modSqrt(mint.init(-1)).get()\n\nvar\n  f = mint(1)\n  P = initFormalPowerSeries[mint](N\
    \ + 1)\nfor i in 1..N:\n  f *= mint(i)\n  P[i] = mint(i + 1).pow(2)\n\nlet\n \
    \ e1 = exp(P * im)\n  e2 = exp(P * (-im))\n  sinP = (e1 - e2) / (im * 2)\n  cosP\
    \ = (e1 + e2) / mint(2)\n  ans = (sinP + cosP) * f\n\nfor i,a in ans:\n  if i\
    \ > 0:\n    echo a\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/convolution.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/mod_sqrt.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/mod_sqrt.nim
  - atcoder/convolution.nim
  - atcoder/header.nim
  - atcoder/modint.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/element_concepts.nim
  - atcoder/header.nim
  - atcoder/modint.nim
  isVerificationFile: true
  path: verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
  requiredBy: []
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
- /verify/verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim.html
title: verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
---
