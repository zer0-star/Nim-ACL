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
  code: "# {{{ divisor\nwhen not declared ATCODER_DEVISOR_HPP:\n  const ATCODER_DEVISOR_HPP*\
    \ = 1\n  import std/algorithm\n  proc divisor*(n:int):seq[int] =\n    result =\
    \ newSeq[int]()\n    var i = 1\n    while i * i <= n:\n      if n mod i == 0:\n\
    \        result.add(i)\n        if i * i != n: result.add(n div i)\n      i +=\
    \ 1\n    result.sort(cmp[int])\n# }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/divisor.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/divisor.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/divisor.nim
- /library/atcoder/extra/math/divisor.nim.html
title: atcoder/extra/math/divisor.nim
---
