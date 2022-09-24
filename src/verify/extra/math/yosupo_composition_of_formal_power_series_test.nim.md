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
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/composition.nim
    title: atcoder/extra/math/composition.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/composition.nim
    title: atcoder/extra/math/composition.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/composition_of_formal_power_series
    links:
    - https://judge.yosupo.jp/problem/composition_of_formal_power_series
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/composition_of_formal_power_series\n\
    \nconst Mod = 998244353\n\ninclude atcoder/header\nimport atcoder/modint\nimport\
    \ atcoder/extra/math/ntt\nimport atcoder/extra/math/formal_power_series\nimport\
    \ atcoder/extra/math/composition\n\ntype mint = modint998244353\n\nproc main():void\
    \ =\n  let\n    N = nextInt()\n    a = newSeqWith(N, mint(nextInt()))\n    b =\
    \ newSeqWith(N, mint(nextInt()))\n  echo composition(b, a).join(\" \")\n\nmain()\n"
  dependsOn:
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/composition.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/header.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/convolution.nim
  - atcoder/generate_definitions.nim
  - atcoder/header.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/composition.nim
  - atcoder/convolution.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  isVerificationFile: true
  path: verify/extra/math/yosupo_composition_of_formal_power_series_test.nim
  requiredBy: []
  timestamp: '2022-09-17 04:52:33+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/math/yosupo_composition_of_formal_power_series_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/yosupo_composition_of_formal_power_series_test.nim
- /verify/verify/extra/math/yosupo_composition_of_formal_power_series_test.nim.html
title: verify/extra/math/yosupo_composition_of_formal_power_series_test.nim
---
