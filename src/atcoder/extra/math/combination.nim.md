---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# combination {{{\nwhen not declared ATCODER_COMBINATION_HPP:\n  const ATCODER_COMBINATION_HPP*\
    \ = 1\n  import atcoder/extra/math/element_concepts\n\n  type Combination*[T]\
    \ = object\n    fact_a, rfact_a: seq[T]\n  \n  type CombinationC* = concept x\n\
    \    x is typedesc[FieldElem] or x is var Combination\n  \n  proc getVal*[T:FieldElem](cmb:\
    \ var Combination[T], t:static[int], k:int):auto {.discardable.} =\n    if k >=\
    \ cmb.fact_a.len:\n      if cmb.fact_a.len == 0:\n        cmb.fact_a = @[T(1)]\n\
    \        cmb.rfact_a = @[T(1)]\n      let sz_old = cmb.fact_a.len - 1\n      let\
    \ sz = max(sz_old * 2, k)\n      cmb.fact_a.setlen(sz + 1)\n      cmb.rfact_a.setlen(sz\
    \ + 1)\n      for i in sz_old + 1..sz: cmb.fact_a[i] = cmb.fact_a[i-1] * T(i)\n\
    \      cmb.rfact_a[sz] = T(1) / cmb.fact_a[sz]\n      for i in countdown(sz -\
    \ 1, sz_old + 1): cmb.rfact_a[i] = cmb.rfact_a[i + 1] * T(i + 1)\n    when t ==\
    \ 0: return cmb.fact_a[k]\n    elif t == 1: return cmb.rfact_a[k]\n    elif t\
    \ == 2: # reset\n      cmb.fact_a.setLen(0)\n      cmb.rfact_a.setLen(0)\n   \
    \   return T(0)\n  template resetCombination*(T:typedesc[FieldElem] or var Combination)\
    \ = T.getVal(2, 0)\n  \n  proc getVal*(T:typedesc[FieldElem], t:static[int], k:int):auto\
    \ {.discardable.} =\n    var cmb{.global.} = Combination[T]()\n    return cmb.getVal(t,\
    \ k)\n  \n  template zero*(T:typedesc[FieldElem]):T = T(0)\n  template zero*[T](cmb:Combination[T]):T\
    \ = T(0)\n  \n  template fact*(T:CombinationC, k:int):auto = T.getVal(0, k)\n\
    \  template rfact*(T:CombinationC, k:int):auto = T.getVal(1, k)\n  template inv*(T:CombinationC,\
    \ k:int):auto = T.fact_a(k - 1) * T.rfact(k)\n  \n  template P*(T:CombinationC,\
    \ n,r:int):auto =\n    if r < 0 or n < r: T.zero()\n    else: T.fact(n) * T.rfact(n\
    \ - r)\n  template C*(T:CombinationC, n,r:int):auto =\n    if r < 0 or n < r:\
    \ T(0)\n    else: T.fact(n) * T.rfact(r) * T.rfact(n - r)\n  template H*(T:CombinationC,\
    \ n,r:int):auto =\n    if n < 0 or r < 0: T(0)\n    elif r == 0: T(1)\n    else:\
    \ T.C(n + r - 1, r)\n  # }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/extra/math/combination.nim
  requiredBy: []
  timestamp: '2020-09-18 00:06:18+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/extra/math/combination.nim
layout: document
redirect_from:
- /library/src/atcoder/extra/math/combination.nim
- /library/src/atcoder/extra/math/combination.nim.html
title: src/atcoder/extra/math/combination.nim
---
