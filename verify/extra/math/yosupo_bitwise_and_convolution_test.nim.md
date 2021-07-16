---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/math/bitwise_convolution.nim
    title: atcoder/extra/math/bitwise_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/bitwise_convolution.nim
    title: atcoder/extra/math/bitwise_convolution.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/bitwise_and_convolution
    links:
    - https://judge.yosupo.jp/problem/bitwise_and_convolution
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/bitwise_and_convolution\n\
    \ninclude atcoder/header\nimport atcoder/modint\nimport atcoder/extra/math/bitwise_convolution\n\
    import sequtils, strutils\n\nproc main():void =\n  type mint = modint998244353\n\
    \  let N = nextInt()\n  var a = newSeqWith(2^N, mint(nextInt()))\n  var b = newSeqWith(2^N,\
    \ mint(nextInt()))\n  echo AndConvolution(a, b).join(\" \")\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/bitwise_convolution.nim
  - atcoder/modint.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/bitwise_convolution.nim
  - atcoder/generate_definitions.nim
  - atcoder/header.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  isVerificationFile: true
  path: verify/extra/math/yosupo_bitwise_and_convolution_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/math/yosupo_bitwise_and_convolution_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/yosupo_bitwise_and_convolution_test.nim
- /verify/verify/extra/math/yosupo_bitwise_and_convolution_test.nim.html
title: verify/extra/math/yosupo_bitwise_and_convolution_test.nim
---
