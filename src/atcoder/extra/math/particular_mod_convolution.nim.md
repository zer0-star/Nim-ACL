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
  code: "when not declared ATCODER_PARTICULAR_MOD_CONVOLUTION:\n  const ATCODER_PARTICULAR_MOD_CONVOLUTION*\
    \ = 1\n  import atcoder/modint\n  import atcoder/convolution\n  import std/sequtils\n\
    \  type ParticularModConvolution* = object\n    discard\n  proc fft*[T:StaticModInt](t:typedesc[ParticularModConvolution],\
    \ a:seq[T]):seq[T] {.inline.} =\n    result = a\n    butterfly(result)\n  proc\
    \ dot*[T:StaticModInt](a, b:seq[T]):seq[T] =\n    result = newSeq[T](a.len)\n\
    \    for i in 0..<a.len:\n      result[i] = a[i] * b[i]\n  proc ifft*[T:StaticModInt](t:typedesc[ParticularModConvolution],\
    \ a:seq[T]):seq[T] {.inline.} =\n    result = a\n    result.butterfly_inv\n  \
    \  let iz = T(a.len).inv()\n    result.applyIt(it * iz)\n  proc convolution*[T:StaticModInt](t:typedesc[ParticularModConvolution],\
    \ a, b:seq[T]):auto {.inline.} = convolution(a, b)\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/extra/math/particular_mod_convolution.nim
  requiredBy: []
  timestamp: '2020-09-22 12:26:15+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/extra/math/particular_mod_convolution.nim
layout: document
redirect_from:
- /library/src/atcoder/extra/math/particular_mod_convolution.nim
- /library/src/atcoder/extra/math/particular_mod_convolution.nim.html
title: src/atcoder/extra/math/particular_mod_convolution.nim
---
