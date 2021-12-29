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
  code: "when not declared ATCODER_DUAL_CUMULATIVE_SUM_HPP:\n  const ATCODER_DUAL_CUMULATIVE_SUM_HPP*\
    \ = 1\n  import std/sequtils\n\n  type DualCumulativeSum*[T] = object\n    pos:\
    \ int\n    data: seq[T]\n\n  proc initDualCumulativeSum*[T](sz:int = 100):DualCumulativeSum[T]\
    \ =\n    DualCumulativeSum[T](data: newSeqWith(sz, T(0)), pos: -1)\n  proc initDualCumulativeSum*[T](a:seq[T]):DualCumulativeSum[T]\
    \ =\n    var data = a\n    data.add(T(0))\n    for i in 0..<a.len:\n      data[i\
    \ + 1] -= a[i]\n    return DualCumulativeSum[T](data: data, pos: -1)\n  proc add*[T](self:\
    \ var DualCumulativeSum[T], s:Slice[int], x:T) =\n    doAssert self.pos < s.a\n\
    \    if s.a > s.b: return\n    if self.data.len <= s.b + 1:\n      self.data.setlen(s.b\
    \ + 1 + 1)\n    self.data[s.a] += x\n    self.data[s.b + 1] -= x\n\n  proc `[]`*[T](self:\
    \ var DualCumulativeSum[T], k:int):T =\n    if k < 0: return T(0)\n    if self.data.len\
    \ <= k:\n      self.data.setlen(k + 1)\n    while self.pos < k:\n      self.pos\
    \ += 1\n      if self.pos > 0: self.data[self.pos] += self.data[self.pos - 1]\n\
    \    return self.data[k]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/dp/dual_cumulative_sum.nim
  requiredBy: []
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/dp/dual_cumulative_sum.nim
layout: document
redirect_from:
- /library/atcoder/extra/dp/dual_cumulative_sum.nim
- /library/atcoder/extra/dp/dual_cumulative_sum.nim.html
title: atcoder/extra/dp/dual_cumulative_sum.nim
---
