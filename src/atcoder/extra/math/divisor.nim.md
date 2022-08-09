---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/math/eratosthenes.nim
    title: atcoder/extra/math/eratosthenes.nim
  - icon: ':warning:'
    path: atcoder/extra/math/eratosthenes.nim
    title: atcoder/extra/math/eratosthenes.nim
  - icon: ':warning:'
    path: atcoder/extra/math/eratosthenes.nim
    title: atcoder/extra/math/eratosthenes.nim
  - icon: ':warning:'
    path: atcoder/extra/math/eratosthenes.nim
    title: atcoder/extra/math/eratosthenes.nim
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links:
    - https://atcoder.jp/contests/abc212/submissions/24699873
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DEVISOR_HPP:\n  const ATCODER_DEVISOR_HPP* = 1\n\
    \  import std/algorithm\n  proc divisor*(n:int):seq[int] =\n    result = newSeq[int]()\n\
    \    var i = 1\n    while i * i <= n:\n      if n mod i == 0:\n        result.add(i)\n\
    \        if i * i != n: result.add(n div i)\n      i += 1\n    result.sort()\n\
    \  proc prime_factorization*(n:int):seq[(int, int)] =\n    var\n      n = n\n\
    \      p = 2\n    while true:\n      if p * p > n:\n        if n > 1:\n      \
    \    result.add((n, 1))\n        break\n      if n mod p == 0:\n        var e\
    \ = 0\n        while n mod p == 0:\n          e.inc;n = n div p\n        result.add((p,\
    \ e))\n      if p == 2: p = 3\n      else: p += 2\n  # \u3069\u3053\u304B\u306B\
    \u30D0\u30B0\u304C\u3042\u308B\u304B\u3082? https://atcoder.jp/contests/abc212/submissions/24699873\n\
    \  proc divisor*(f:openArray[(int,int)]):seq[int] = # prime_factorization => divisor\n\
    \    result = @[1]\n    for (p, e) in f:\n      let s = result.len\n      result.setLen(s\
    \ * (e + 1))\n      var (j, t) = (s, p)\n      for i in 1..e:\n        for k in\
    \ 0..<s:\n          result[j] = result[k] * t\n          j.inc\n        t *= p\n\
    \    result.sort()\n  proc divisor*(f:openArray[int]):seq[int] = # primes => divisor\n\
    \    var f = sorted(f)\n    var v = newSeq[(int,int)]()\n    var i = 0\n    while\
    \ i < f.len:\n      var j = i\n      while j < f.len and f[i] == f[j]: j.inc\n\
    \      v.add((f[i], j - i))\n      i = j\n    return v.divisor\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/divisor.nim
  requiredBy:
  - atcoder/extra/math/eratosthenes.nim
  - atcoder/extra/math/eratosthenes.nim
  - atcoder/extra/math/eratosthenes.nim
  - atcoder/extra/math/eratosthenes.nim
  timestamp: '2021-08-10 01:29:44+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/divisor.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/divisor.nim
- /library/atcoder/extra/math/divisor.nim.html
title: atcoder/extra/math/divisor.nim
---
