---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
  - icon: ':x:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/fenwick_tree_test.nim
    title: verify/fenwick_tree_test.nim
  - icon: ':x:'
    path: verify/fenwick_tree_test.nim
    title: verify/fenwick_tree_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links:
    - https://en.wikipedia.org/wiki/Fenwick_tree
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_FENWICKTREE_HPP:\n  const ATCODER_FENWICKTREE_HPP*\
    \ = 1\n  import std/sequtils\n  import atcoder/internal_type_traits\n  import\
    \ atcoder/rangeutils\n\n  # Reference: https://en.wikipedia.org/wiki/Fenwick_tree\n\
    \  type FenwickTree*[T, U] = object\n    len*:int\n    data*:seq[U]\n\n  proc\
    \ init*(self:typedesc[FenwickTree], n:int):auto =\n    return self(len:n, data:newSeqWith(n,\
    \ self.U(0)))\n  proc init*(self:var FenwickTree, n:int) =\n    if self.data.len\
    \ < n: self.data.setLen(n)\n    self.data.fill(0, n - 1, self.U(0))\n    self.len\
    \ = n\n\n  template FenwickTreeType*(T:typedesc):typedesc[FenwickTree] =\n   \
    \ type U = to_unsigned(T)\n    typedesc[FenwickTree[T, U]]\n  template getType*(FT:typedesc[FenwickTree],\
    \ T:typedesc):typedesc[FenwickTree] =\n    FenwickTreeType(T)\n  proc initFenwickTree*[T](n:int):auto\
    \ = FenwickTreeType(T).init(n)\n\n  proc add*[FT:FenwickTree](self: var FT, p:IndexType,\
    \ x:FT.T) =\n    var p = self^^p\n    assert p in 0..<self.len\n    p.inc\n  \
    \  while p <= self.len:\n      self.data[p - 1] += FT.U(x)\n      p += p and -p\n\
    \  proc sum[FT:FenwickTree](self: FT, r:int):auto =\n    result = FT.U(0)\n  \
    \  var r = r\n    while r > 0:\n      result += self.data[r - 1]\n      r -= r\
    \ and -r\n  proc sum*[FT:FenwickTree](self: FT, p:RangeType):FT.T =\n    let (l,\
    \ r) = self.halfOpenEndpoints(p)\n    assert 0 <= l and l <= r and r <= self.len\n\
    \    return cast[FT.T](self.sum(r) - self.sum(l))\n  proc `[]`*[FT:FenwickTree](self:\
    \ FT, p:RangeType):FT.T = self.sum(p)\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_type_traits.nim
  - atcoder/internal_type_traits.nim
  isVerificationFile: false
  path: atcoder/fenwicktree.nim
  requiredBy: []
  timestamp: '2022-09-24 20:04:56+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/fenwick_tree_test.nim
  - verify/fenwick_tree_test.nim
documentation_of: atcoder/fenwicktree.nim
layout: document
redirect_from:
- /library/atcoder/fenwicktree.nim
- /library/atcoder/fenwicktree.nim.html
title: atcoder/fenwicktree.nim
---
