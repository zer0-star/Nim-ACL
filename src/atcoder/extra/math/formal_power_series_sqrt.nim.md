---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/mod_sqrt.nim
    title: atcoder/extra/math/mod_sqrt.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_FORMAL_POWER_SERIES_SQRT:\n  const ATCODER_FORMAL_POWER_SERIES_SQRT*\
    \ = 1\n  import atcoder/extra/math/formal_power_series\n  import atcoder/extra/math/mod_sqrt\n\
    \  import std/options\n\n  proc sqrt*[T](self: FormalPowerSeries[T], deg = -1):Option[FormalPowerSeries[T]]\
    \ =\n    let n = self.len\n    deg.revise(n)\n    if self[0] == 0:\n      for\
    \ i in 1..<n:\n        if self[i] != 0:\n          if (i and 1) > 0: return FormalPowerSeries[T].none\n\
    \          if deg - i div 2 <= 0: break\n          var opt = (self shr i).sqrt(deg\
    \ - i div 2)\n          if not opt.isSome: return FormalPowerSeries[T].none\n\
    \          var ret = opt.get shl (i div 2)\n          if ret.len < deg: ret.setlen(deg)\n\
    \          return ret.some\n      return initFormalPowerSeries[T](deg).some\n\
    \  \n    var ret:FormalPowerSeries[T]\n#    if self.isSetSqrt:\n    let opt =\
    \ modSqrt(self[0])\n    if not opt.isSome: return FormalPowerSeries[T].none\n\
    \    ret = initFormalPowerSeries[T](@[T(opt.get)])\n  \n    let inv2 = T(1) /\
    \ T(2)\n    var i = 1\n    while i < deg:\n      ret = (ret + self.pre(i shl 1)\
    \ * ret.inv(i shl 1)) * inv2\n      i = i shl 1\n    return ret.pre(deg).some\n"
  dependsOn:
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/element_concepts.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/modint.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/mod_sqrt.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/mod_sqrt.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/element_concepts.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/modint.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/mod_sqrt.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/mod_sqrt.nim
  isVerificationFile: false
  path: atcoder/extra/math/formal_power_series_sqrt.nim
  requiredBy: []
  timestamp: '2021-12-11 18:27:17+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/math/sqrt_of_formal_power_series_test.nim
  - verify/extra/math/sqrt_of_formal_power_series_test.nim
documentation_of: atcoder/extra/math/formal_power_series_sqrt.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/formal_power_series_sqrt.nim
- /library/atcoder/extra/math/formal_power_series_sqrt.nim.html
title: atcoder/extra/math/formal_power_series_sqrt.nim
---
