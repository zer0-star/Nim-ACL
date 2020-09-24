---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: verify/extra/composition_of_formal_power_series_test_backup.nim
    title: verify/extra/composition_of_formal_power_series_test_backup.nim
  - icon: ':warning:'
    path: verify/extra/composition_of_formal_power_series_test_backup.nim
    title: verify/extra/composition_of_formal_power_series_test_backup.nim
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
  code: "when not declared ATCODER_INTERNAL_FFT_HPP:\n  const ATCODER_INTERNAL_FFT_HPP*\
    \ = 1\n  import atcoder/modint\n  import atcoder/extra/math/particular_mod_convolution\n\
    \  import atcoder/extra/math/arbitrary_mod_convolution\n\n  template get_fft_type*[T:ModInt](self:\
    \ typedesc[T]):typedesc =\n    when T is StaticModInt and (T.mod - 1) mod (1 shl\
    \ 20) == 0: ParticularModConvolution\n    else: ArbitraryModConvolution\n\n"
  dependsOn:
  - atcoder/modint.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_math.nim
  - atcoder/convolution.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/modint.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/convolution.nim
  - atcoder/internal_math.nim
  isVerificationFile: false
  path: atcoder/extra/math/internal_fft.nim
  requiredBy:
  - verify/extra/composition_of_formal_power_series_test_backup.nim
  - verify/extra/composition_of_formal_power_series_test_backup.nim
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
documentation_of: atcoder/extra/math/internal_fft.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/internal_fft.nim
- /library/atcoder/extra/math/internal_fft.nim.html
title: atcoder/extra/math/internal_fft.nim
---
