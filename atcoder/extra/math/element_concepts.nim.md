---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':warning:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_ELEMENT_CONCEPTS_HPP:\n  const ATCODER_ELEMENT_CONCEPTS_HPP*\
    \ = 1\n  type AdditiveGroupElem* = concept x, type T\n    x + x\n    x - x\n \
    \   T(0)\n  type MultiplicativeGroupElem* = concept x, type T\n    x * x\n   \
    \ x / x\n    T(1)\n  type RingElem* = concept x, type T\n    x + x\n    x - x\n\
    \    x * x\n    T(0)\n    T(1)\n  type FieldElem* = concept x, type T\n    x +\
    \ x\n    x - x\n    x * x\n    x / x\n    T(0)\n    T(1)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/element_concepts.nim
  requiredBy:
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/combination.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/element_concepts.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/element_concepts.nim
- /library/atcoder/extra/math/element_concepts.nim.html
title: atcoder/extra/math/element_concepts.nim
---
