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
  code: "when not declared ATCODER_ERATOSTHENES_HPP:\n  const ATCODER_ERATOSTHENES_HPP*\
    \ = 1\n  import atcoder/extra/math/divisor\n  type Eratosthenes* = object\n  \
    \  n*:int\n    pdiv*, prime*, index:seq[int]\n  proc propagate(self:var Eratosthenes,\
    \ i:int) =\n    let p = self.prime[i]\n    while self.index[i] < self.n:\n   \
    \   self.pdiv[self.index[i]] = p\n      self.index[i] += p\n  proc expand(self:var\
    \ Eratosthenes, n = -1) =\n    if n != -1 and n < self.n: return\n    let n =\
    \ if n == -1: self.n * 2 else: max(self.n * 2, n)\n    self.pdiv.setLen(n)\n \
    \   let old_n = self.n\n    self.n = n\n    for i in old_n ..< self.n:self.pdiv[i]\
    \ = i\n    for i,p in self.prime:\n      if p * p > self.n: break\n      self.propagate(i)\n\
    \    for p in old_n ..< self.n:\n      if self.pdiv[p] == p:\n        self.prime.add(p)\n\
    \        self.index.add(p * p)\n        self.propagate(self.prime.len - 1)\n \
    \   self.n = n\n  proc initEratosthenes*(n = 10000):Eratosthenes =\n    result\
    \ = Eratosthenes(n: 2, pdiv: @[0,0])\n    result.expand(n)\n  proc isPrime*(self:var\
    \ Eratosthenes, n:int): bool =\n    self.expand(n + 1)\n    return n != 1 and\
    \ self.pdiv[n] == n\n  proc primeDivisor*(self:var Eratosthenes, n:int):int =\n\
    \    self.expand(n + 1)\n    return self.pdiv[n]\n  proc factor*(self:var Eratosthenes,\
    \ n:int): seq[(int,int)] =\n    result = newSeq[(int,int)]()\n    var n = n\n\
    \    while n > 1:\n      let p = self.primeDivisor(n)\n      var e = 0\n     \
    \ while n mod p == 0: e.inc;n = n div p\n      result.add (p, e)\n  proc getPrime*(self:var\
    \ Eratosthenes, i:int):int =\n    while i >= self.prime.len: self.expand()\n \
    \   return self.prime[i]\n  proc `[]`*(self:var Eratosthenes, i:int):int = self.getPrime(i)\n\
    \  proc divisor*(self: var Eratosthenes, n:int):seq[int] =\n    var f = self.factor(n)\n\
    \    return f.divisor()\n"
  dependsOn:
  - atcoder/extra/math/divisor.nim
  - atcoder/extra/math/divisor.nim
  - atcoder/extra/math/divisor.nim
  - atcoder/extra/math/divisor.nim
  isVerificationFile: false
  path: atcoder/extra/math/eratosthenes.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/eratosthenes.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/eratosthenes.nim
- /library/atcoder/extra/math/eratosthenes.nim.html
title: atcoder/extra/math/eratosthenes.nim
---
