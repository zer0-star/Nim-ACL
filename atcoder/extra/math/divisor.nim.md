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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DEVISOR_HPP:\n  const ATCODER_DEVISOR_HPP* = 1\n\
    \  import std/algorithm\n  proc divisor*(n:int):seq[int] =\n    result = newSeq[int]()\n\
    \    var i = 1\n    while i * i <= n:\n      if n mod i == 0:\n        result.add(i)\n\
    \        if i * i != n: result.add(n div i)\n      i += 1\n    result.sort()\n\
    \  proc divisor*(f:openArray[(int,int)]):seq[int] =\n    result = @[1]\n    for\
    \ (p, e) in f:\n      let s = result.len\n      result.setLen(s * (e + 1))\n \
    \     var (j, t) = (s, p)\n      for i in 1..e:\n        for k in 0..<s:\n   \
    \       result[j] = result[k] * t\n          j.inc\n        t *= p\n    result.sort()\n\
    \  proc divisor*(f:openArray[int]):seq[int] =\n    var f = sorted(f)\n    var\
    \ v = newSeq[(int,int)]()\n    var i = 0\n    while i < f.len:\n      var j =\
    \ i\n      while j < f.len and f[i] == f[j]: j.inc\n      v.add((f[i], j - i))\n\
    \      i = j\n    return v.divisor\n"
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