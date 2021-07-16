---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
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
  code: "import std/unittest\nimport atcoder/internal_bit\n\ntest \"BitTest, CeilPow2\"\
    :\n  check 0 == ceil_pow2(0)\n  check 0 == ceil_pow2(1)\n  check 1 == ceil_pow2(2)\n\
    \  check 2 == ceil_pow2(3)\n  check 2 == ceil_pow2(4)\n  check 3 == ceil_pow2(5)\n\
    \  check 3 == ceil_pow2(6)\n  check 3 == ceil_pow2(7)\n  check 3 == ceil_pow2(8)\n\
    \  check 4 == ceil_pow2(9)\n  check 30 == ceil_pow2(1 shl 30)\n  check 31 == ceil_pow2((1\
    \ shl 30) + 1)\n  check 31 == ceil_pow2(int32.high)\n\ntest \"BitTest, BSF\":\n\
    \  check 0 == bsf(1)\n  check 1 == bsf(2)\n  check 0 == bsf(3)\n  check 2 == bsf(4)\n\
    \  check 0 == bsf(5)\n  check 1 == bsf(6)\n  check 0 == bsf(7)\n  check 3 == bsf(8)\n\
    \  check 0 == bsf(9)\n  check 30 == bsf(1.uint shl 30)\n  check 0 == bsf((1.uint\
    \ shl 31) - 1)\n  check 31 == bsf(1.uint shl 31)\n  check 0 == bsf(uint.high)\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: tests/test_bit.nim
  requiredBy: []
  timestamp: '2020-09-25 22:39:15+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_bit.nim
layout: document
redirect_from:
- /library/tests/test_bit.nim
- /library/tests/test_bit.nim.html
title: tests/test_bit.nim
---
