---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series_sqrt.nim
    title: atcoder/extra/math/formal_power_series_sqrt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series_sqrt.nim
    title: atcoder/extra/math/formal_power_series_sqrt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series_sqrt.nim
    title: atcoder/extra/math/formal_power_series_sqrt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series_sqrt.nim
    title: atcoder/extra/math/formal_power_series_sqrt.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
    title: verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
    title: verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/sqrt_of_formal_power_series_test.nim
    title: verify/extra/math/sqrt_of_formal_power_series_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/sqrt_of_formal_power_series_test.nim
    title: verify/extra/math/sqrt_of_formal_power_series_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
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
  dependsOn:
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  isVerificationFile: false
  path: atcoder/extra/math/mod_sqrt.nim
  requiredBy:
  - atcoder/extra/math/formal_power_series_sqrt.nim
  - atcoder/extra/math/formal_power_series_sqrt.nim
  - atcoder/extra/math/formal_power_series_sqrt.nim
  - atcoder/extra/math/formal_power_series_sqrt.nim
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
  - verify/extra/math/arbitrary_mod_exp_modsqrt_test.nim
  - verify/extra/math/sqrt_of_formal_power_series_test.nim
  - verify/extra/math/sqrt_of_formal_power_series_test.nim
documentation_of: atcoder/extra/math/mod_sqrt.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/mod_sqrt.nim
- /library/atcoder/extra/math/mod_sqrt.nim.html
title: atcoder/extra/math/mod_sqrt.nim
---
