---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':x:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':x:'
    path: atcoder/extra/math/factorial.nim
    title: atcoder/extra/math/factorial.nim
  - icon: ':x:'
    path: atcoder/extra/math/factorial.nim
    title: atcoder/extra/math/factorial.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':x:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
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
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/502
    links:
    - https://yukicoder.me/problems/no/502
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: '# verify-helper: PROBLEM https://yukicoder.me/problems/no/502


    include atcoder/header

    import atcoder/modint

    import atcoder/extra/math/ntt

    import atcoder/extra/math/factorial


    echo factorial[modint1000000007](nextInt())

    '
  dependsOn:
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/modint.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/factorial.nim
  - atcoder/header.nim
  - atcoder/generate_definitions.nim
  - atcoder/convolution.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/modint.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/factorial.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_math.nim
  - atcoder/convolution.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/math/yukicoder_factorial_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/math/yukicoder_factorial_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/yukicoder_factorial_test.nim
- /verify/verify/extra/math/yukicoder_factorial_test.nim.html
title: verify/extra/math/yukicoder_factorial_test.nim
---
