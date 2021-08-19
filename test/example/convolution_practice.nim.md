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
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "include atcoder/header\nimport atcoder/modint\nimport atcoder/convolution\n\
    \ntype mint = modint998244353\n\nlet\n  n, m = nextInt()\n  a = newSeqWith(n,\
    \ mint(nextInt()))\n  b = newSeqWith(m, mint(nextInt()))\n  c = convolution(a,\
    \ b)\n\necho c.join(\" \")\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/convolution.nim
  - atcoder/header.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  - atcoder/modint.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/internal_bit.nim
  - atcoder/generate_definitions.nim
  - atcoder/convolution.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: test/example/convolution_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/convolution_practice.nim
layout: document
redirect_from:
- /library/test/example/convolution_practice.nim
- /library/test/example/convolution_practice.nim.html
title: test/example/convolution_practice.nim
---
