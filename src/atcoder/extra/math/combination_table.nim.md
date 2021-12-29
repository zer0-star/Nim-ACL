---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not defined ATCODER_COMBINATION_HPP:\n  const ATCODER_COMBINATION_HPP*\
    \ = 1\n  import atcoder/element_concepts\n\n  type Combination*[T:RingElem] =\
    \ object\n    cmb_a: seq[seq[T]]\n    fact_a: seq[T]\n\n  type CombinationC* =\
    \ concept x\n    x is typedesc[RingElem] or x is var Combination\n\n  proc getAddr(T:typedesc[RingElem]):auto\
    \ {.discardable.} =\n    var cmb_a{.global.} = Combination[T]()\n    return cmb_a.addr\n\
    \n  template zero*(T:typedesc[RingElem]):T = T(0)\n  template zero*[T:RingElem](cmb:Combination[T]):T\
    \ = T(0)\n  \n  template fact*(T:CombinationC, k:int):auto =\n    var p = T.getAddr\n\
    \    while p[].fact_a.len <= k:\n      if p[].fact_a.len == 0:\n        p[].fact_a.add(T(1))\n\
    \      else:\n        let n = p[].fact_a.len\n        p[].fact_a.add(p[].fact_a[^1]\
    \ * n)\n    p[].fact_a[k]\n\n  template resetCombination*(T:typedesc[RingElem]\
    \ or var Combination) =\n    var p = T.getAddr()\n    p[].fact_a.setLen(0)\n \
    \   p[].cmb_a.setLen(0)\n\n  template C_impl*(C:CombinationC, n, r:int):auto =\n\
    \    when C is Combination:\n      type T = C.T\n    else:\n      type T = C\n\
    \    if r < 0 or n < r: C.zero()\n    else:\n      var p = getAddr(C)\n      while\
    \ p[].cmb_a.len <= n:\n        if p[].cmb_a.len == 0:\n          p[].cmb_a.add(@[T(1)])\n\
    \        else:\n          let k = p[].cmb_a.len\n          var v = newSeq[T](k\
    \ + 1)\n          v[0] = T(1)\n          for i in 1..k - 1:\n            v[i]\
    \ = p[].cmb_a[^1][i - 1] + p[].cmb_a[^1][i]\n          v[k] = T(1)\n         \
    \ p[].cmb_a.add(v)\n      p[].cmb_a[n][r]\n  template C*(T:CombinationC, n,r:int):auto\
    \ =\n    if n >= 0:\n      T.C_impl(n, r)\n    else:\n      let N = -n\n     \
    \ var a = T.C_impl(N + r - 1, N - 1)\n      if r mod 2 != 0: a *= -1\n      a\n\
    \  template H*(T:CombinationC, n,r:int):auto =\n    if n < 0 or r < 0: T.zero()\n\
    \    elif r == 0: T.zero() + 1\n    else: T.C(n + r - 1, r)\n\n  template P*(T:CombinationC,\
    \ n,r:int):auto =\n    if r < 0 or n < r: T.zero()\n    elif n - r >= r:\n   \
    \   T.C(n, r) * T.fact(r)\n    else:\n      T.C(n, r) * T.fact(n - r)\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  isVerificationFile: false
  path: atcoder/extra/math/combination_table.nim
  requiredBy: []
  timestamp: '2021-05-19 22:57:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/combination_table.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/combination_table.nim
- /library/atcoder/extra/math/combination_table.nim.html
title: atcoder/extra/math/combination_table.nim
---
