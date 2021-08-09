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
  - icon: ':x:'
    path: atcoder/extra/math/modint_montgomery.nim
    title: atcoder/extra/math/modint_montgomery.nim
  - icon: ':x:'
    path: atcoder/extra/math/modint_montgomery.nim
    title: atcoder/extra/math/modint_montgomery.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/convolution_mod
    links:
    - https://judge.yosupo.jp/problem/convolution_mod
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: '# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod


    import atcoder/header, atcoder/extra/math/modint_montgomery

    import atcoder/convolution

    import sequtils, strutils


    type mint = modint998244353


    let N, M = nextInt()

    let a = newSeqWith(N, mint(nextInt()))

    let b = newSeqWith(M, mint(nextInt()))

    echo convolution(a, b).join(" ")

    #echo convolution(a, b, 998244353).join(" ")

    '
  dependsOn:
  - atcoder/extra/math/modint_montgomery.nim
  - atcoder/generate_definitions.nim
  - atcoder/header.nim
  - atcoder/element_concepts.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/modint_montgomery.nim
  - atcoder/generate_definitions.nim
  - atcoder/convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/modint.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/header.nim
  - atcoder/convolution.nim
  - atcoder/internal_bit.nim
  isVerificationFile: true
  path: verify/extra/math/convolution_montgomery_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/math/convolution_montgomery_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/convolution_montgomery_test.nim
- /verify/verify/extra/math/convolution_montgomery_test.nim.html
title: verify/extra/math/convolution_montgomery_test.nim
---
