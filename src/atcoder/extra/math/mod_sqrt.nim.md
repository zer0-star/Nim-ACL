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
  code: "# modSqrt {{{\nwhen not declared ATCODER_MODSQRT_HPP:\n  const ATCODER_MODSQRT_HPP*\
    \ = 1\n  import atcoder/modint\n  import std/options\n  \n  proc modSqrt*[T:ModInt](a:T):Option[T]\
    \ =\n    let p = a.umod.int\n    if a == 0: return T(0).some\n    if p == 2: return\
    \ T(a).some\n    if a.pow((p - 1) shr 1) != 1: return none(T)\n    var b = T(1)\n\
    \    while b.pow((p - 1) shr 1) == 1: b += 1\n    var\n      e = 0\n      m =\
    \ p - 1\n    while m mod 2 == 0: m = m shr 1; e.inc\n    var\n      x = a.pow((m\
    \ - 1) shr 1)\n      y = a * x * x\n    x *= a\n    var z = b.pow(m)\n    while\
    \ y != 1:\n      var\n        j = 0\n        t = y\n      while t != 1:\n    \
    \    j.inc\n        t *= t\n      z = z.pow(1 shl (e - j - 1))\n      x *= z\n\
    \      z *= z\n      y *= z\n      e = j\n    return T(x).some\n#}}}\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/extra/math/mod_sqrt.nim
  requiredBy: []
  timestamp: '2020-09-22 00:56:23+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/extra/math/mod_sqrt.nim
layout: document
redirect_from:
- /library/src/atcoder/extra/math/mod_sqrt.nim
- /library/src/atcoder/extra/math/mod_sqrt.nim.html
title: src/atcoder/extra/math/mod_sqrt.nim
---
