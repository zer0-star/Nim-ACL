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
  _extendedRequiredBy:
  - icon: ':x:'
    path: atcoder/extra/math/factorial.nim
    title: atcoder/extra/math/factorial.nim
  - icon: ':x:'
    path: atcoder/extra/math/factorial.nim
    title: atcoder/extra/math/factorial.nim
  - icon: ':x:'
    path: atcoder/extra/math/factorial.nim
    title: atcoder/extra/math/factorial.nim
  - icon: ':x:'
    path: atcoder/extra/math/factorial.nim
    title: atcoder/extra/math/factorial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/lagrange_polynomial.nim
    title: atcoder/extra/math/lagrange_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/lagrange_polynomial.nim
    title: atcoder/extra/math/lagrange_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/lagrange_polynomial.nim
    title: atcoder/extra/math/lagrange_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/lagrange_polynomial.nim
    title: atcoder/extra/math/lagrange_polynomial.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/polynomial_taylor_shift.nim
    title: atcoder/extra/math/polynomial_taylor_shift.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/polynomial_taylor_shift.nim
    title: atcoder/extra/math/polynomial_taylor_shift.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/polynomial_taylor_shift.nim
    title: atcoder/extra/math/polynomial_taylor_shift.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/polynomial_taylor_shift.nim
    title: atcoder/extra/math/polynomial_taylor_shift.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/polynomial_taylor_shift_test.nim
    title: verify/extra/math/polynomial_taylor_shift_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/polynomial_taylor_shift_test.nim
    title: verify/extra/math/polynomial_taylor_shift_test.nim
  - icon: ':x:'
    path: verify/extra/math/yukicoder_factorial_test.nim
    title: verify/extra/math/yukicoder_factorial_test.nim
  - icon: ':x:'
    path: verify/extra/math/yukicoder_factorial_test.nim
    title: verify/extra/math/yukicoder_factorial_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':question:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not defined ATCODER_COMBINATION_HPP:\n  const ATCODER_COMBINATION_HPP*\
    \ = 1\n  import atcoder/element_concepts\n\n  type Combination*[T] = object\n\
    \    fact_a, rfact_a: seq[T]\n\n  type CombinationC* = concept x\n    x is typedesc[FieldElem]\
    \ or x is var Combination\n\n  proc enhance[T:FieldElem](cmb: var Combination[T],\
    \ k:int):auto =\n    if k >= cmb.fact_a.len:\n      if cmb.fact_a.len == 0:\n\
    \        cmb.fact_a = @[T(1)]\n        cmb.rfact_a = @[T(1)]\n      let sz_old\
    \ = cmb.fact_a.len - 1\n      let sz = max(sz_old * 2, k)\n      cmb.fact_a.setlen(sz\
    \ + 1)\n      cmb.rfact_a.setlen(sz + 1)\n      for i in sz_old + 1..sz: cmb.fact_a[i]\
    \ = cmb.fact_a[i-1] * T(i)\n      cmb.rfact_a[sz] = T(1) / cmb.fact_a[sz]\n  \
    \    for i in countdown(sz - 1, sz_old + 1): cmb.rfact_a[i] = cmb.rfact_a[i +\
    \ 1] * T(i + 1)\n    return cmb.addr\n\n  proc enhance(T:typedesc[FieldElem],\
    \ k:int):auto {.discardable.} =\n    var cmb{.global.} = Combination[T]()\n  \
    \  return cmb.enhance(k)\n\n  template zero*(T:typedesc[FieldElem]):T = T(0)\n\
    \  template zero*[T:FieldElem](cmb:Combination[T]):T = T(0)\n  \n  template fact*(T:CombinationC,\
    \ k:int):auto = T.enhance(k)[].fact_a[k]\n  template rfact*(T:CombinationC, k:int):auto\
    \ = T.enhance(k)[].rfact_a[k]\n  template inv*(T:CombinationC, k:int):auto = T.fact(k\
    \ - 1) * T.rfact(k)\n\n  template resetCombination*(T:typedesc[FieldElem] or var\
    \ Combination) =\n    var p = T.enhance(-1)\n    p[].fact_a.setLen(0)\n    p[].rfact_a.setLen(0)\n\
    \n  template P*(T:CombinationC, n,r:int):auto =\n    if r < 0 or n < r: T.zero()\n\
    \    else: T.fact(n) * T.rfact(n - r)\n  template C_impl*(T:CombinationC, n, r:int):auto\
    \ =\n    if r < 0 or n < r: T.zero()\n    else: T.fact(n) * T.rfact(r) * T.rfact(n\
    \ - r)\n  template C*(T:CombinationC, n,r:int):auto =\n    if n >= 0:\n      T.C_impl(n,\
    \ r)\n    else:\n      let N = -n\n      var a = T.C_impl(N + r - 1, N - 1)\n\
    \      if r mod 2 != 0: a *= -1\n      a\n  template H*(T:CombinationC, n,r:int):auto\
    \ =\n    if n < 0 or r < 0: T.zero()\n    elif r == 0: T.zero() + 1\n    else:\
    \ T.C(n + r - 1, r)\n  template P_large*(T:CombinationC, n,r:int):auto =\n   \
    \ if r < 0 or n < r: T.zero()\n    else:\n      var a = T(1)\n      for i in 0..<r:a\
    \ *= n - i\n      a\n  template C_large_impl*(T:CombinationC, n,r:int):auto =\n\
    \    if r < 0 or n < r: T.zero()\n    else: T.P_large(n, r) * T.rfact(r)\n  template\
    \ C_large*(T:CombinationC, n,r:int):auto =\n    if n >= 0:\n      T.C_large_impl(n,\
    \ r)\n    else:\n      let N = -n\n      var a = T.C_large_impl(N + r - 1, N -\
    \ 1)\n      if r mod 2 != 0: a *= -1\n      a\n  template H_large*(T:CombinationC,\
    \ n,r:int):auto =\n    if n < 0 or r < 0: T.zero()\n    elif r == 0: T.zero()\
    \ + 1\n    else: T.C_large(n + r - 1, r)\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  isVerificationFile: false
  path: atcoder/extra/math/combination.nim
  requiredBy:
  - atcoder/extra/math/factorial.nim
  - atcoder/extra/math/factorial.nim
  - atcoder/extra/math/lagrange_polynomial.nim
  - atcoder/extra/math/lagrange_polynomial.nim
  - atcoder/extra/math/polynomial_taylor_shift.nim
  - atcoder/extra/math/polynomial_taylor_shift.nim
  - atcoder/extra/math/factorial.nim
  - atcoder/extra/math/factorial.nim
  - atcoder/extra/math/lagrange_polynomial.nim
  - atcoder/extra/math/lagrange_polynomial.nim
  - atcoder/extra/math/polynomial_taylor_shift.nim
  - atcoder/extra/math/polynomial_taylor_shift.nim
  timestamp: '2021-05-19 22:57:49+09:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/extra/math/yukicoder_factorial_test.nim
  - verify/extra/math/yukicoder_factorial_test.nim
  - verify/extra/math/polynomial_taylor_shift_test.nim
  - verify/extra/math/polynomial_taylor_shift_test.nim
documentation_of: atcoder/extra/math/combination.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/combination.nim
- /library/atcoder/extra/math/combination.nim.html
title: atcoder/extra/math/combination.nim
---
