---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_math.nim
    title: src/nim_acl/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_bit.nim
    title: src/nim_acl/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/modint.nim
    title: src/nim_acl/modint.nim
  - icon: ':question:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_math.nim
    title: src/nim_acl/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/modint.nim
    title: src/nim_acl/modint.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_bit.nim
    title: src/nim_acl/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/convolution.nim
    title: src/nim_acl/convolution.nim
  - icon: ':question:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/convolution.nim
    title: src/nim_acl/convolution.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/convolution_mod
    links:
    - https://judge.yosupo.jp/problem/convolution_mod
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: '# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod


    include src/nim_acl/header, src/nim_acl/modint

    import src/nim_acl/convolution


    let N, M = nextInt()

    let a = newSeqWith(N, nextInt())

    let b = newSeqWith(M, nextInt())

    echo convolution[998244353, int](a, b).join(" ")

    '
  dependsOn:
  - src/nim_acl/internal_math.nim
  - src/nim_acl/internal_bit.nim
  - src/nim_acl/modint.nim
  - src/nim_acl/header.nim
  - src/nim_acl/internal_math.nim
  - src/nim_acl/modint.nim
  - src/nim_acl/internal_bit.nim
  - src/nim_acl/convolution.nim
  - src/nim_acl/header.nim
  - src/nim_acl/convolution.nim
  isVerificationFile: true
  path: verify/convolution_test.nim
  requiredBy: []
  timestamp: '2020-09-17 20:03:53+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/convolution_test.nim
layout: document
redirect_from:
- /verify/verify/convolution_test.nim
- /verify/verify/convolution_test.nim.html
title: verify/convolution_test.nim
---
