---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
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
  code: "include atcoder/header\nimport atcoder/convolution\nimport atcoder/modint\n\
    \nlet\n  n, m = nextInt()\n  a = newSeqWith(n, nextInt())\n  b = newSeqWith(m,\
    \ nextInt())\n\nlet c = convolution[998244353, int](a, b)\n# or: c = convolution<998244353>(a,\
    \ b)\n\necho c.join(\" \")\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/convolution.nim
  - atcoder/modint.nim
  - atcoder/convolution.nim
  - atcoder/header.nim
  - atcoder/internal_math.nim
  - atcoder/internal_bit.nim
  - atcoder/header.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  isVerificationFile: false
  path: test/example/convolution_int_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/convolution_int_practice.nim
layout: document
redirect_from:
- /library/test/example/convolution_int_practice.nim
- /library/test/example/convolution_int_practice.nim.html
title: test/example/convolution_int_practice.nim
---
