---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':x:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':x:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':x:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':x:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CHARACTERISTIC_POLYNOMIAL_HPP:\n  const ATCODER_CHARACTERISTIC_POLYNOMIAL_HPP*\
    \ = 1\n  import atcoder/extra/math/matrix\n  import std/random\n\n  # \u7279\u6027\
    \u591A\u9805\u5F0F\u3092\u8A08\u7B97\u3059\u308B\n  proc characteristicPolynomial*[M:SomeMatrix](A:M):seq[M.T]\
    \ =\n    let n = A.height\n    doAssert A.width == n\n    var b = M.initVector(n)\n\
    \    for i in 0 ..< n:\n      b[i] = random.rand(0 ..< A.T.mod)\n    var P = M.init(n,\
    \ n + 1)\n    for i in 0 .. n:\n      for j in 0 ..< n:\n        P[j, i] = b[j]\n\
    \      b = A * b\n    var\n      z = M.initVector(n + 1)\n      o = P.linearEquations(z)\n\
    \      v = o.get()[1]\n    #doAssert v.len == 1\n    for j in v.len:\n      if\
    \ v[j][^1] != 0:\n        result = v[j]\n        break\n    block:\n      let\
    \ p = 1 / result[^1]\n      for t in result.mitems: t *= p\n\n\n"
  dependsOn:
  - atcoder/extra/other/operator.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/extra/other/operator.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/generate_definitions.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/other/operator.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/extra/other/operator.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/generate_definitions.nim
  - atcoder/generate_definitions.nim
  isVerificationFile: false
  path: atcoder/extra/math/characteristic_polynomial.nim
  requiredBy:
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/kitamasa.nim
  timestamp: '2022-10-23 18:37:31+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/characteristic_polynomial.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/characteristic_polynomial.nim
- /library/atcoder/extra/math/characteristic_polynomial.nim.html
title: atcoder/extra/math/characteristic_polynomial.nim
---
