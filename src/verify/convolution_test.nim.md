---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/convolution_mod
    links:
    - https://judge.yosupo.jp/problem/convolution_mod
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: '# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod


    import atcoder/header, atcoder/modint

    import atcoder/convolution

    import sequtils, strutils


    let N, M = nextInt()

    let a = newSeqWith(N, nextInt())

    let b = newSeqWith(M, nextInt())

    echo convolution(a, b).join(" ")

    #echo convolution(a, b, 998244353).join(" ")

    '
  dependsOn: []
  isVerificationFile: true
  path: src/verify/convolution_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: src/verify/convolution_test.nim
layout: document
redirect_from:
- /verify/src/verify/convolution_test.nim
- /verify/src/verify/convolution_test.nim.html
title: src/verify/convolution_test.nim
---
