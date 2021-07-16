---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/math/yosupo_factorization_test.nim
    title: verify/extra/math/yosupo_factorization_test.nim
  - icon: ':x:'
    path: verify/extra/math/yosupo_factorization_test.nim
    title: verify/extra/math/yosupo_factorization_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_FACTORIZATION_HPP:\n  const ATCODER_FACTORIZATION_HPP*\
    \ = 1\n  import math, bitops\n  proc mul(a, b, m:int):int {.importcpp: \"(__int128)(#)\
    \ * (#) % (#)\", nodecl.}\n  proc power(a, b, m:int):int =\n    var (a, b) = (a,\
    \ b)\n    result = 1\n    while b != 0:\n      if (b and 1) != 0: result = mul(result,\
    \ a, m)\n      a = mul(a, a, m)\n      b = b shr 1\n  proc isPrime*(n:int):bool\
    \ =\n    if n != 2 and n mod 2 == 0: return false\n    var\n      d = n - 1\n\
    \      s = countTrailingZeroBits(d)\n    d = d shr s\n    var A:seq[int]\n   \
    \ if n <= 10^9:\n      A = @[2, 3, 5, 7]\n    else:\n      A = @[2, 3, 5, 7, 11,\
    \ 13, 17, 19, 23, 29, 31, 37]\n    for a in A:\n      var\n        p = power(a,\
    \ d, n)\n        i = s\n      while p != 1 and p != n - 1 and a mod n != 0:\n\
    \        i.dec\n        if i == 0: break\n        p = mul(p, p, n);\n      if\
    \ p != n - 1 and i != s: return false\n    return true\n  \n  proc rho(n:int):int\
    \ =\n    proc f(a:int):auto = mul(a, a, n) + 1\n    var\n      (x,y,p,i,t) = (0,0,2,1,0)\n\
    \      q:int\n    while t mod 40 != 0 or gcd(p, n) == 1:\n      t.inc\n      if\
    \ x == y:\n        i.inc\n        x = i\n        y = f(x)\n      q = mul(p, abs(y\
    \ - x), n)\n      if q != 0:p = q\n      x = f(x)\n      y = f(f(y))\n    return\
    \ gcd(p, n)\n  \n  proc factor*(n:int):seq[int] =\n    if n == 1: return @[]\n\
    \    if isPrime(n): return @[n]\n    var a = rho(n)\n    assert a != n and a !=\
    \ 1\n    result = factor(a)\n    result &= factor(n div a)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/factorization.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/math/yosupo_factorization_test.nim
  - verify/extra/math/yosupo_factorization_test.nim
documentation_of: atcoder/extra/math/factorization.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/factorization.nim
- /library/atcoder/extra/math/factorization.nim.html
title: atcoder/extra/math/factorization.nim
---
