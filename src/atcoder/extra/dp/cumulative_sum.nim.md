---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
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
  code: "when not declared ATCODER_CUMULATIVE_SUM_HPP:\n  const ATCODER_CUMULATIVE_SUM_HPP*\
    \ = 1\n  import std/sequtils\n  import atcoder/rangeutils\n\n  type CumulativeSum*[T;\
    \ reverse:static[bool]] = object\n    len: int\n    pos: int\n    data: seq[T]\n\
    \  proc initCumulativeSum*[T](n:int):CumulativeSum[T, false] =\n    result = CumulativeSum[T,\
    \ false](data: newSeqWith(n + 1, T.default), pos:0, len:n)\n  proc initCumulativeSumReverse*[T](n:int):CumulativeSum[T,\
    \ true] =\n    result = CumulativeSum[T, true](data: newSeqWith(n + 1, T.default),\
    \ pos:0, len:n)\n\n  proc initCumulativeSum*(n:int, T:typedesc, reverse:static[bool]\
    \ = false):CumulativeSum[T, reverse] =\n    result = CumulativeSum[T, reverse](data:\
    \ newSeqWith(n + 1, T.default), pos:0, len:n)\n\n  proc `[]=`*[T;reverse:static[bool]](self:\
    \ var CumulativeSum[T, reverse], k:IndexType, x:T) =\n    var k = self^^k\n  \
    \  when reverse: k = self.len - k\n    if k < self.pos: doAssert(false)\n    if\
    \ self.data.len < k + 2: self.data.setLen(k + 2)\n    self.data[k + 1] = x\n \
    \ proc add*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], k:IndexType,\
    \ x:T) =\n    var k = self^^k\n    when reverse: k = self.len - k\n    if k <\
    \ self.pos: doAssert(false)\n    if self.data.len < k + 2: self.data.setLen(k\
    \ + 2)\n    self.data[k + 1] += x\n\n  proc propagate*[T;reverse:static[bool]](self:\
    \ var CumulativeSum[T, reverse]) =\n    if self.data.len < self.pos + 2: self.data.setLen(self.pos\
    \ + 2)\n    self.data[self.pos + 1] += self.data[self.pos]\n    self.pos.inc\n\
    \  proc initCumulativeSum*[T](data:seq[T], reverse:static[bool] = false):CumulativeSum\
    \ =\n    result = initCumulativeSum[T, reverse]()\n    for i,d in data: result[i]\
    \ = d\n  proc sum*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse],\
    \ k:int):T =\n    if k < 0: return T(0)\n    while self.pos < k: self.propagate()\n\
    \    return self.data[k]\n  proc `[]`*[T;reverse:static[bool]](self: var CumulativeSum[T,\
    \ reverse], s:RangeType):T =\n    var s = s.a .. self^^s.b\n    when reverse:\
    \ s = self.len - s.b .. self.len - s.a\n    if s.a > s.b: return T(0)\n    return\
    \ self.sum(s.b + 1) - self.sum(s.a)\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  isVerificationFile: false
  path: atcoder/extra/dp/cumulative_sum.nim
  requiredBy: []
  timestamp: '2021-08-10 01:29:44+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/dp/cumulative_sum.nim
layout: document
redirect_from:
- /library/atcoder/extra/dp/cumulative_sum.nim
- /library/atcoder/extra/dp/cumulative_sum.nim.html
title: atcoder/extra/dp/cumulative_sum.nim
---
