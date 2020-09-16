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
  code: "#{{{ eratosthenes\nwhen not declared ATCODER_ERATOSTHENES_HPP:\n  const ATCODER_ERATOSTHENES_HPP\
    \ = 1\n  type Eratosthenes* = object\n    pdiv:seq[int]\n  \n  proc initEratosthenes*(n:int):Eratosthenes\
    \ =\n    var pdiv = newSeq[int](n + 1)\n    for i in 2..n:\n      pdiv[i] = i;\n\
    \    for i in 2..n:\n      if i * i > n: break\n      if pdiv[i] == i:\n     \
    \   for j in countup(i*i,n,i):\n          pdiv[j] = i;\n    return Eratosthenes(pdiv:pdiv)\n\
    \  proc isPrime*(self:Eratosthenes, n:int): bool =\n    return n != 1 and self.pdiv[n]\
    \ == n\n  proc factor*(self:Eratosthenes, n:int): seq[(int,int)] =\n    result\
    \ = newSeq[(int,int)]()\n    var n = n\n    while n > 1:\n      let p = self.pdiv[n]\n\
    \      var e = 0\n      while n mod p == 0: e.inc;n = n div p\n      result.add\
    \ (p, e)\n#}}}\n"
  dependsOn: []
  isVerificationFile: false
  path: src/nim_acl/extra/math/eratosthenes.nim
  requiredBy: []
  timestamp: '2020-09-14 00:37:28+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/nim_acl/extra/math/eratosthenes.nim
layout: document
redirect_from:
- /library/src/nim_acl/extra/math/eratosthenes.nim
- /library/src/nim_acl/extra/math/eratosthenes.nim.html
title: src/nim_acl/extra/math/eratosthenes.nim
---
