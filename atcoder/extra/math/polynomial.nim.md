---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_POLYNOMIAL_HPP:\n  const ATCODER_POLYNOMIAL_HPP*\
    \ = 1\n\n  #import atcoder/extra/math/combination\n  import std/sequtils\n  \n\
    \  type poly*[T] = seq[T]\n  \n  proc `+=`*[T](a:var poly[T], b:poly[T]) =\n \
    \   while a.len < b.len: a.add T(0)\n    for i in 0..<b.len:a[i] += b[i]\n\n \
    \ proc `+`*[T](a, b:poly[T]):poly[T] =\n    result = a\n    result += b\n\n  proc\
    \ `-=`*[T](a:var poly[T], b:poly[T]) =\n    while a.len < b.len: a.add T(0)\n\
    \    for i in 0..<b.len:a[i] -= b[i]\n\n  proc `-`*[T](a, b:poly[T]):poly[T] =\n\
    \    result = a\n    result -= b\n\n  proc `*`*[T](a, b:poly[T]):poly[T] =\n \
    \   result = newSeqWith(a.len + b.len - 1, T(0))\n    for i in 0..<a.len:\n  \
    \    for j in 0..<b.len:\n        result[i + j] += a[i] * b[j]\n  \n  proc `*`*[T](a:poly[T],\
    \ d:T):poly[T] =\n    result = a\n    for a in result.mitems: a *= d\n  \n  proc\
    \ eval*[T](p:poly[T], x:T):T =\n    result = T(0)\n    for i in countdown(p.len\
    \ - 1, 0):\n      result *= x\n      result += p[i]\n  \n  proc integral*[T](p:poly[T]):poly[T]\
    \ =\n    result = newSeq[T](p.len + 1)\n    for i in 0..<p.len:\n      result[i\
    \ + 1] = p[i] / (i + 1)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/polynomial.nim
  requiredBy: []
  timestamp: '2021-12-11 18:27:17+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/polynomial.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/polynomial.nim
- /library/atcoder/extra/math/polynomial.nim.html
title: atcoder/extra/math/polynomial.nim
---
