---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':question:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':question:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':question:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  _extendedRequiredBy: []
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
  code: "when not declared ATCODER_LAGLANGE_POLYNOMIAL_HPP:\n  const ATCODER_LAGLANGE_POLYNOMIAL_HPP*\
    \ = 1\n  import std/sequtils\n  import atcoder/extra/math/combination\n  proc\
    \ lagrange_polynomial*[T](y:seq[T], t:int):T =\n    let N = y.len - 1\n    if\
    \ t <= N: return y[t]\n    result = 0\n    var dp = newSeqWith(N + 1, T(1))\n\
    \    var pd = newSeqWith(N + 1, T(1))\n    for i in 0..<N: dp[i + 1] = dp[i] *\
    \ (t - i)\n    for i in countdown(N, 1): pd[i - 1] = pd[i] * (t - i)\n    for\
    \ i in 0..N:\n      let tmp = y[i] * dp[i] * pd[i] * T.rfact(i) * T.rfact(N -\
    \ i)\n      if ((N - i) and 1) != 0: result -= tmp\n      else: result += tmp\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/combination.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/combination.nim
  isVerificationFile: false
  path: atcoder/extra/math/lagrange_polynomial.nim
  requiredBy: []
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/lagrange_polynomial.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/lagrange_polynomial.nim
- /library/atcoder/extra/math/lagrange_polynomial.nim.html
title: atcoder/extra/math/lagrange_polynomial.nim
---
