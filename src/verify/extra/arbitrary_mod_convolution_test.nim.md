---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/convolution_mod_1000000007
    links:
    - https://judge.yosupo.jp/problem/convolution_mod_1000000007
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: '# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod_1000000007


    import atcoder/header, atcoder/modint

    import atcoder/extra/math/formal_power_series

    import sequtils, strutils


    type mint = modint1000000007


    let N, M = nextInt()

    let a = newSeqWith(N, nextInt().mint)

    let b = newSeqWith(M, nextInt().mint)

    echo (a * b).join(" ")

    '
  dependsOn: []
  isVerificationFile: true
  path: src/verify/extra/arbitrary_mod_convolution_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: src/verify/extra/arbitrary_mod_convolution_test.nim
layout: document
redirect_from:
- /verify/src/verify/extra/arbitrary_mod_convolution_test.nim
- /verify/src/verify/extra/arbitrary_mod_convolution_test.nim.html
title: src/verify/extra/arbitrary_mod_convolution_test.nim
---
