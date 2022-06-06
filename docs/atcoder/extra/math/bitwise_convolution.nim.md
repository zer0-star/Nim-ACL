---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/math/yosupo_bitwise_and_convolution_test.nim
    title: verify/extra/math/yosupo_bitwise_and_convolution_test.nim
  - icon: ':x:'
    path: verify/extra/math/yosupo_bitwise_and_convolution_test.nim
    title: verify/extra/math/yosupo_bitwise_and_convolution_test.nim
  - icon: ':x:'
    path: verify/extra/math/yosupo_bitwise_or_convolution_test.nim
    title: verify/extra/math/yosupo_bitwise_or_convolution_test.nim
  - icon: ':x:'
    path: verify/extra/math/yosupo_bitwise_or_convolution_test.nim
    title: verify/extra/math/yosupo_bitwise_or_convolution_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_BITWISE_CONVOLUTION_HPP:\n  const ATCODER_BITWISE_CONVOLUTION_HPP*\
    \ = 1\n\n  # result_k = sum a_i * b_j, i&j=k \n  proc AndConvolution*[T](a, b:seq[T]):seq[T]\
    \ =\n    assert a.len == b.len\n    let n = a.len\n    var (a, b) = (a, b)\n \
    \   result = newSeq[T](n)\n    # FWT\n    block:\n      var i = 1\n      while\
    \ i < n:\n        for j in 0..<n:\n          if (i and j) == 0: a[j] += a[j or\
    \ i];b[j] += b[j or i]\n        i = i shl 1\n    for i in 0..<n: result[i] = a[i]\
    \ * b[i]\n    # IFWT\n    block:\n      var i = 1\n      while i < n:\n      \
    \  for j in 0..<n:\n          if (i and j) == 0: result[j] -= result[j or i]\n\
    \        i = i shl 1\n\n  # result_k = sum a_i * b_j, i|j=k \n  proc OrConvolution*[T](a,\
    \ b:seq[T]):seq[T] =\n    assert a.len == b.len\n    let n = a.len\n    var (a,\
    \ b) = (a, b)\n    result = newSeq[T](n)\n    # FWT\n    block:\n      var i =\
    \ 1\n      while i < n:\n        for j in 0..<n:\n          if (i and j) == 0:\
    \ a[i or j] += a[j]; b[i or j] += b[j]\n        i = i shl 1\n    for i in 0..<n:\
    \ result[i] = a[i]*b[i]\n    # IFWT\n    block:\n      var i = 1\n      while\
    \ i < n:\n        for j in 0..<n:\n          if (i and j) == 0: result[j or i]\
    \ -= result[j]\n        i = i shl 1\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/bitwise_convolution.nim
  requiredBy: []
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/math/yosupo_bitwise_and_convolution_test.nim
  - verify/extra/math/yosupo_bitwise_and_convolution_test.nim
  - verify/extra/math/yosupo_bitwise_or_convolution_test.nim
  - verify/extra/math/yosupo_bitwise_or_convolution_test.nim
documentation_of: atcoder/extra/math/bitwise_convolution.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/bitwise_convolution.nim
- /library/atcoder/extra/math/bitwise_convolution.nim.html
title: atcoder/extra/math/bitwise_convolution.nim
---
