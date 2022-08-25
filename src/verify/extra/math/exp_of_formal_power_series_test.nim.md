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
    PROBLEM: https://judge.yosupo.jp/problem/exp_of_formal_power_series
    links:
    - https://judge.yosupo.jp/problem/exp_of_formal_power_series
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/exp_of_formal_power_series\n\
    \nimport atcoder/header\nimport atcoder/modint\nimport atcoder/extra/math/ntt\n\
    import atcoder/extra/math/formal_power_series\nimport std/strutils\n\nproc main():void\
    \ =\n  type mint = modint998244353\n  let N = nextInt()\n  var p = initFormalPowerSeries[mint](N)\n\
    \  for i in 0..<N:\n    p[i] = mint.init(nextInt())\n  let q = p.exp()\n  echo\
    \ q.join(\" \")\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/modint.nim
  - atcoder/modint.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/convolution.nim
  - atcoder/convolution.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_bit.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_bit.nim
  - atcoder/header.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/internal_math.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/element_concepts.nim
  isVerificationFile: true
  path: verify/extra/math/exp_of_formal_power_series_test.nim
  requiredBy: []
  timestamp: '2022-08-08 21:23:55+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/math/exp_of_formal_power_series_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/exp_of_formal_power_series_test.nim
- /verify/verify/extra/math/exp_of_formal_power_series_test.nim.html
title: verify/extra/math/exp_of_formal_power_series_test.nim
---
