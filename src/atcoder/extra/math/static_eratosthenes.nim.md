---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/extra/math/divisor.nim
    title: atcoder/extra/math/divisor.nim
  - icon: ':warning:'
    path: atcoder/extra/math/divisor.nim
    title: atcoder/extra/math/divisor.nim
  - icon: ':warning:'
    path: atcoder/extra/math/divisor.nim
    title: atcoder/extra/math/divisor.nim
  - icon: ':warning:'
    path: atcoder/extra/math/divisor.nim
    title: atcoder/extra/math/divisor.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_STATIC_ERATOSTHENES_HPP:\n  const ATCODER_STATIC_ERATOSTHENES_HPP*\
    \ = 1\n  import atcoder/extra/math/divisor\n  type Eratosthenes*[n:static[int]]\
    \ = object\n    pdiv*: array[n + 1, int32]\n  proc init*(self: var Eratosthenes)\
    \ =\n    let n = self.n\n    for i in 1 .. n:\n      self.pdiv[i] = i.int32\n\
    \    for i in 2 .. n:\n      if self.pdiv[i] == i:\n        var m = i * i\n  \
    \      while m <= n:\n          self.pdiv[m] = i.int32\n          m += i\n  proc\
    \ initEratosthenes*(n:static[int]):Eratosthenes[n] =\n    result.init()\n  proc\
    \ isPrime*(self:Eratosthenes, n:int): bool =\n    return n != 1 and self.pdiv[n]\
    \ == n\n  proc primeDivisor*(self:Eratosthenes, n:int):int =\n    return self.pdiv[n]\n\
    \  proc factor*(self:var Eratosthenes, n:int): seq[(int,int)] =\n    result =\
    \ newSeq[(int,int)]()\n    var n = n\n    while n > 1:\n      let p = self.primeDivisor(n)\n\
    \      var e = 0\n      while n mod p == 0: e.inc;n = n div p\n      result.add\
    \ (p, e)\n  #proc getPrime*(self:var Eratosthenes, i:int):int =\n  #  while i\
    \ >= self.prime.len: self.expand()\n  #  return self.prime[i]\n  #proc `[]`*(self:var\
    \ Eratosthenes, i:int):int = self.getPrime(i)\n  proc divisor*(self: var Eratosthenes,\
    \ n:int):seq[int] =\n    var f = self.factor(n)\n    return f.divisor()\n\n"
  dependsOn:
  - atcoder/extra/math/divisor.nim
  - atcoder/extra/math/divisor.nim
  - atcoder/extra/math/divisor.nim
  - atcoder/extra/math/divisor.nim
  isVerificationFile: false
  path: atcoder/extra/math/static_eratosthenes.nim
  requiredBy: []
  timestamp: '2022-09-24 20:04:56+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/static_eratosthenes.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/static_eratosthenes.nim
- /library/atcoder/extra/math/static_eratosthenes.nim.html
title: atcoder/extra/math/static_eratosthenes.nim
---
