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
  code: "when not declared ATCODER_INTERNAL_FFT_HPP:\n  const ATCODER_INTERNAL_FFT_HPP*\
    \ = 1\n  import atcoder/modint\n  import atcoder/extra/math/particular_mod_convolution\n\
    \  import atcoder/extra/math/arbitrary_mod_convolution\n\n  template get_fft_type*[T:ModInt](self:\
    \ typedesc[T]):typedesc =\n    when T is StaticModInt and (T.mod - 1) mod (1 shl\
    \ 20) == 0: ParticularModConvolution\n    else: ArbitraryModConvolution\n\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/extra/math/internal_fft.nim
  requiredBy: []
  timestamp: '2020-09-23 20:38:11+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/extra/math/internal_fft.nim
layout: document
redirect_from:
- /library/src/atcoder/extra/math/internal_fft.nim
- /library/src/atcoder/extra/math/internal_fft.nim.html
title: src/atcoder/extra/math/internal_fft.nim
---
