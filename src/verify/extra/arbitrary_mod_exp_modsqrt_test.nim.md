---
data:
  _extendedDependsOn: []
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
  dependsOn: []
  isVerificationFile: true
  path: src/verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: src/verify/extra/arbitrary_mod_exp_modsqrt_test.nim
layout: document
redirect_from:
- /verify/src/verify/extra/arbitrary_mod_exp_modsqrt_test.nim
- /verify/src/verify/extra/arbitrary_mod_exp_modsqrt_test.nim.html
title: src/verify/extra/arbitrary_mod_exp_modsqrt_test.nim
---
