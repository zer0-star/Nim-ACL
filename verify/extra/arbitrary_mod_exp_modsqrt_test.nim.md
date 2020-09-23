---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/internal_fft.nim
    title: atcoder/extra/math/internal_fft.nim
  - icon: ':x:'
    path: atcoder/extra/math/internal_fft.nim
    title: atcoder/extra/math/internal_fft.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':x:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
  - icon: ':x:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/1080
    links:
    - https://yukicoder.me/problems/no/1080
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://yukicoder.me/problems/no/1080\n\nimport\
    \ atcoder/header\nimport atcoder/extra/math/mod_sqrt\nimport atcoder/modint\n\
    import atcoder/extra/math/formal_power_series\nimport std/options\n\ntype mint\
    \ = StaticModInt[1000000009]\n\nlet N = nextInt()\nlet im = modSqrt(mint.init(-1)).get()\n\
    \nvar\n  f = mint(1)\n  P = initFormalPowerSeries[mint](N + 1)\nfor i in 1..N:\n\
    \  f *= mint(i)\n  P[i] = mint(i + 1).pow(2)\n\nlet\n  e1 = exp(P * im)\n  e2\
    \ = exp(P * (-im))\n  sinP = (e1 - e2) / (im * 2)\n  cosP = (e1 + e2) / mint(2)\n\
    \  ans = (sinP + cosP) * f\n\nfor i,a in ans:\n  if i > 0:\n    echo a\n"
  dependsOn:
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/modint.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/header.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/header.nim
  - atcoder/modint.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/internal_fft.nim
  - atcoder/extra/math/internal_fft.nim
  - atcoder/convolution.nim
  - atcoder/convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/mod_sqrt.nim
  - atcoder/extra/math/mod_sqrt.nim
  - atcoder/internal_bit.nim
  isVerificationFile: true
  path: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  requiredBy: []
  timestamp: '2020-09-22 12:26:15+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
layout: document
redirect_from:
- /verify/verify/extra/arbitrary_mod_exp_modsqrt_test.nim
- /verify/verify/extra/arbitrary_mod_exp_modsqrt_test.nim.html
title: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
---
