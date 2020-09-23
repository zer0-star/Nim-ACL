---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: verify/extra/composition_of_formal_power_series_test_backup.nim
    title: verify/extra/composition_of_formal_power_series_test_backup.nim
  - icon: ':warning:'
    path: verify/extra/composition_of_formal_power_series_test_backup.nim
    title: verify/extra/composition_of_formal_power_series_test_backup.nim
  - icon: ':x:'
    path: atcoder/extra/math/internal_fft.nim
    title: atcoder/extra/math/internal_fft.nim
  - icon: ':x:'
    path: atcoder/extra/math/internal_fft.nim
    title: atcoder/extra/math/internal_fft.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/inv_of_formal_power_series_test.nim
    title: verify/extra/inv_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/inv_of_formal_power_series_test.nim
    title: verify/extra/inv_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/arbitrary_mod_convolution_test.nim
    title: verify/extra/arbitrary_mod_convolution_test.nim
  - icon: ':x:'
    path: verify/extra/arbitrary_mod_convolution_test.nim
    title: verify/extra/arbitrary_mod_convolution_test.nim
  - icon: ':x:'
    path: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
    title: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  - icon: ':x:'
    path: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
    title: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  - icon: ':x:'
    path: verify/extra/exp_of_formal_power_series_test.nim
    title: verify/extra/exp_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/exp_of_formal_power_series_test.nim
    title: verify/extra/exp_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/pow_of_formal_power_series_test.nim
    title: verify/extra/pow_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/pow_of_formal_power_series_test.nim
    title: verify/extra/pow_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/log_of_formal_power_series_test.nim
    title: verify/extra/log_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/log_of_formal_power_series_test.nim
    title: verify/extra/log_of_formal_power_series_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_ARBITRARY_MOD_CONVOLUTION:\n  const ATCODER_ARBITRARY_MOD_CONVOLUTION*\
    \ = 1\n  import atcoder/convolution\n  import atcoder/modint\n  import atcoder/extra/math/particular_mod_convolution\n\
    \n  type ArbitraryModConvolution* = object\n    discard\n\n  const\n    m0 = 167772161.uint\n\
    \    m1 = 469762049.uint\n    m2 = 754974721.uint\n  type\n    mint0 = StaticModInt[m0.int]\n\
    \    mint1 = StaticModInt[m1.int]\n    mint2 = StaticModint[m2.int]\n\n  const\n\
    \    r01 = mint1.init(m0).inv().uint\n    r02 = mint2.init(m0).inv().uint\n  \
    \  r12 = mint2.init(m1).inv().uint\n    r02r12 = r02 * r12 mod m2\n\n  proc fft*[T:ModInt](t:typedesc[ArbitraryModConvolution],\
    \ a:seq[T]):auto {.inline.} =\n    type F = ParticularModConvolution\n    var\n\
    \      v0 = newSeq[mint0](a.len)\n      v1 = newSeq[mint1](a.len)\n      v2 =\
    \ newSeq[mint2](a.len)\n    for i in 0..<a.len:\n      v0[i] = mint0.init(a[i].int)\n\
    \      v1[i] = mint1.init(a[i].int)\n      v2[i] = mint2.init(a[i].int)\n    v0\
    \ = F.fft(v0)\n    v1 = F.fft(v1)\n    v2 = F.fft(v2)\n    return (v0,v1,v2)\n\
    \  proc dot*(a, b:(seq[mint0], seq[mint1], seq[mint2])):auto =\n    let N = a[0].len\n\
    \    result = (newSeq[mint0](N), newSeq[mint1](N), newSeq[mint2](N))\n    for\
    \ i in 0..<N:\n      result[0][i] = a[0][i] * b[0][i]\n      result[1][i] = a[1][i]\
    \ * b[1][i]\n      result[2][i] = a[2][i] * b[2][i]\n  \n  proc calc_garner[T:ModInt](a0:seq[mint0],\
    \ a1:seq[mint1], a2:seq[mint2], deg:int):seq[T] =\n    let\n      w1 = m0 mod\
    \ T.umod\n      w2 = w1 * m1 mod T.umod\n    result = newSeq[T](deg)\n    for\
    \ i in 0..<deg:\n      let\n        (n0, n1, n2) = (a0[i].uint, a1[i].uint, a2[i].uint)\n\
    \        b = (n1 + m1 - n0) * r01 mod m1\n        c = ((n2 + m2 - n0) * r02r12\
    \ + (m2 - b) * r12) mod m2\n      result[i] = T.init(n0 + b * w1 + c * w2)\n\n\
    \  proc ifft*[T:ModInt](t:typedesc[ArbitraryModConvolution], a:(seq[mint0], seq[mint1],\
    \ seq[mint2]), deg = -1):auto {.inline.} =\n    type F = ParticularModConvolution\n\
    \    let\n      deg = if deg == -1: a[0].len else: deg\n      a0 = F.ifft(a[0])\n\
    \      a1 = F.ifft(a[1])\n      a2 = F.ifft(a[2])\n    return calc_garner[T, mint0,\
    \ mint1, mint2](a0, a1, a2, deg)\n  proc convolution*[T:ModInt](t:typedesc[ArbitraryModConvolution],\
    \ a, b:seq[T]):seq[T] {.inline.} =\n    var\n      a0 = newSeq[mint0](a.len)\n\
    \      a1 = newSeq[mint1](a.len)\n      a2 = newSeq[mint2](a.len)\n    for i in\
    \ 0..<a.len:\n      a0[i] = mint0.init(a[i].int)\n      a1[i] = mint1.init(a[i].int)\n\
    \      a2[i] = mint2.init(a[i].int)\n    var\n      b0 = newSeq[mint0](b.len)\n\
    \      b1 = newSeq[mint1](b.len)\n      b2 = newSeq[mint2](b.len)\n    for i in\
    \ 0..<b.len:\n      b0[i] = mint0.init(b[i].int)\n      b1[i] = mint1.init(b[i].int)\n\
    \      b2[i] = mint2.init(b[i].int)\n    let\n      c0 = convolution(a0, b0)\n\
    \      c1 = convolution(a1, b1)\n      c2 = convolution(a2, b2)\n    return calc_garner[T](c0,\
    \ c1, c2, a.len + b.len - 1)\n"
  dependsOn:
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_math.nim
  - atcoder/convolution.nim
  - atcoder/internal_math.nim
  - atcoder/convolution.nim
  - atcoder/modint.nim
  - atcoder/modint.nim
  isVerificationFile: false
  path: atcoder/extra/math/arbitrary_mod_convolution.nim
  requiredBy:
  - verify/extra/composition_of_formal_power_series_test_backup.nim
  - verify/extra/composition_of_formal_power_series_test_backup.nim
  - atcoder/extra/math/internal_fft.nim
  - atcoder/extra/math/internal_fft.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/inv_of_formal_power_series_test.nim
  - verify/extra/inv_of_formal_power_series_test.nim
  - verify/extra/arbitrary_mod_convolution_test.nim
  - verify/extra/arbitrary_mod_convolution_test.nim
  - verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  - verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  - verify/extra/exp_of_formal_power_series_test.nim
  - verify/extra/exp_of_formal_power_series_test.nim
  - verify/extra/pow_of_formal_power_series_test.nim
  - verify/extra/pow_of_formal_power_series_test.nim
  - verify/extra/log_of_formal_power_series_test.nim
  - verify/extra/log_of_formal_power_series_test.nim
documentation_of: atcoder/extra/math/arbitrary_mod_convolution.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/arbitrary_mod_convolution.nim
- /library/atcoder/extra/math/arbitrary_mod_convolution.nim.html
title: atcoder/extra/math/arbitrary_mod_convolution.nim
---
