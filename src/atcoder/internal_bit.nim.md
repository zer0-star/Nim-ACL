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
  code: "when not declared ATCODER_INTERNAL_BITOP_HPP:\n  const ATCODER_INTERNAL_BITOP_HPP*\
    \ = 1\n  import std/bitops\n\n#ifdef _MSC_VER\n#include <intrin.h>\n#endif\n\n\
    # @param n `0 <= n`\n# @return minimum non-negative `x` s.t. `n <= 2**x`\n  proc\
    \ ceil_pow2*(n:int):int =\n    var x = 0\n    while (1'u shl x) < n.uint: x.inc\n\
    \    return x\n# @param n `1 <= n`\n# @return minimum non-negative `x` s.t. `(n\
    \ & (1 << x)) != 0`\n  proc bsf*(n:uint):int =\n    return countTrailingZeroBits(n)\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/internal_bit.nim
  requiredBy: []
  timestamp: '2020-09-18 00:06:18+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/internal_bit.nim
layout: document
redirect_from:
- /library/src/atcoder/internal_bit.nim
- /library/src/atcoder/internal_bit.nim.html
title: src/atcoder/internal_bit.nim
---
