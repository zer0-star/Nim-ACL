---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CONVERT_BASE_HPP:\n  const ATCODER_CONVERT_BASE_HPP*\
    \ = 1\n  proc toInt*(d: seq[int], b = 10):int =\n    result = 0\n    var p = 1\n\
    \    for di in d:\n      result += p * di\n      p *= b\n  proc toSeq*(n: int,\
    \ b = 10, min_digit = -1):seq[int] =\n    result = newSeq[int]()\n    var n =\
    \ n\n    while n > 0:result.add(n mod b); n = n div b\n    if min_digit >= 0:\n\
    \      while result.len < min_digit: result.add(0)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/convert_base.nim
  requiredBy: []
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/convert_base.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/convert_base.nim
- /library/atcoder/extra/math/convert_base.nim.html
title: atcoder/extra/math/convert_base.nim
---
