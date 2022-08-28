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
    PROBLEM: https://judge.yosupo.jp/problem/convolution_mod_1000000007
    links:
    - https://judge.yosupo.jp/problem/convolution_mod_1000000007
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: '# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod_1000000007


    import atcoder/header, atcoder/modint

    import atcoder/extra/math/ntt

    import atcoder/extra/math/formal_power_series

    import sequtils, strutils


    type mint = modint1000000007


    let N, M = nextInt()

    let a = newSeqWith(N, nextInt().mint)

    let b = newSeqWith(M, nextInt().mint)

    echo (a * b).join(" ")

    '
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/element_concepts.nim
  - atcoder/modint.nim
  - atcoder/convolution.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/header.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/element_concepts.nim
  - atcoder/modint.nim
  - atcoder/convolution.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/header.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  isVerificationFile: true
  path: verify/extra/math/arbitrary_mod_convolution_test.nim
  requiredBy: []
  timestamp: '2022-08-08 21:23:55+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/math/arbitrary_mod_convolution_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/arbitrary_mod_convolution_test.nim
- /verify/verify/extra/math/arbitrary_mod_convolution_test.nim.html
title: verify/extra/math/arbitrary_mod_convolution_test.nim
---