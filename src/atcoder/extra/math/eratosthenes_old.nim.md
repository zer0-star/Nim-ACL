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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_ERATOSTHENES_HPP:\n  const ATCODER_ERATOSTHENES_HPP*\
    \ = 1\n  type Eratosthenes* = object\n    pdiv:seq[int]\n  \n  proc initEratosthenes*(n:int):Eratosthenes\
    \ =\n    var pdiv = newSeq[int](n + 1)\n    for i in 2..n:\n      pdiv[i] = i;\n\
    \    for i in 2..n:\n      if i * i > n: break\n      if pdiv[i] == i:\n     \
    \   for j in countup(i*i,n,i):\n          pdiv[j] = i;\n    return Eratosthenes(pdiv:pdiv)\n\
    \  proc isPrime*(self:Eratosthenes, n:int): bool =\n    return n != 1 and self.pdiv[n]\
    \ == n\n  proc factor*(self:Eratosthenes, n:int): seq[(int,int)] =\n    result\
    \ = newSeq[(int,int)]()\n    var n = n\n    while n > 1:\n      let p = self.pdiv[n]\n\
    \      var e = 0\n      while n mod p == 0: e.inc;n = n div p\n      result.add\
    \ (p, e)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/eratosthenes_old.nim
  requiredBy: []
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/eratosthenes_old.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/eratosthenes_old.nim
- /library/atcoder/extra/math/eratosthenes_old.nim.html
title: atcoder/extra/math/eratosthenes_old.nim
---
