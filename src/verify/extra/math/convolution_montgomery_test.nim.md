---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/modint_montgomery.nim
    title: atcoder/extra/math/modint_montgomery.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/modint_montgomery.nim
    title: atcoder/extra/math/modint_montgomery.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/convolution_mod
    links:
    - https://judge.yosupo.jp/problem/convolution_mod
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: '# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod


    import atcoder/header, atcoder/extra/math/modint_montgomery

    import atcoder/convolution

    import sequtils, strutils


    type mint = modint_montgomery_998244353


    let N, M = nextInt()

    let a = newSeqWith(N, mint(nextInt()))

    let b = newSeqWith(M, mint(nextInt()))

    echo convolution(a, b).join(" ")

    #echo convolution(a, b, 998244353).join(" ")

    '
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/modint_montgomery.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/modint_montgomery.nim
  - atcoder/header.nim
  - atcoder/modint.nim
  - atcoder/element_concepts.nim
  - atcoder/convolution.nim
  - atcoder/header.nim
  - atcoder/modint.nim
  - atcoder/element_concepts.nim
  - atcoder/convolution.nim
  - atcoder/internal_math.nim
  isVerificationFile: true
  path: verify/extra/math/convolution_montgomery_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/math/convolution_montgomery_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/convolution_montgomery_test.nim
- /verify/verify/extra/math/convolution_montgomery_test.nim.html
title: verify/extra/math/convolution_montgomery_test.nim
---
