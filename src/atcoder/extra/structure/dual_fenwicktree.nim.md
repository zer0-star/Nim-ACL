---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
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
    links:
    - https://en.wikipedia.org/wiki/Fenwick_tree
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_FENWICKTREE_HPP:\n  const ATCODER_FENWICKTREE_HPP*\
    \ = 1\n  import std/sequtils\n  import atcoder/internal_type_traits\n  import\
    \ atcoder/rangeutils\n\n  # Reference: https://en.wikipedia.org/wiki/Fenwick_tree\n\
    \  type DualFenwickTree*[T, U] = object\n    len*:int\n    data*:seq[U]\n\n  proc\
    \ init*(self:typedesc[DualFenwickTree], n:int):auto =\n    return self(len:n,\
    \ data:newSeqWith(n, self.U(0)))\n  proc init*(self:var DualFenwickTree, n:int)\
    \ =\n    if self.data.len < n: self.data.setLen(n)\n    self.data.fill(0, n -\
    \ 1, self.U(0))\n    self.len = n\n\n  template DualFenwickTreeType*(T:typedesc):typedesc[DualFenwickTree]\
    \ =\n    type U = to_unsigned(T)\n    typedesc[DualFenwickTree[T, U]]\n  template\
    \ getType*(FT:typedesc[DualFenwickTree], T:typedesc):typedesc[DualFenwickTree]\
    \ =\n    DualFenwickTreeType(T)\n  proc initDualFenwickTree*[T](n:int):auto =\
    \ DualFenwickTreeType(T).init(n)\n\n  proc `[]`*[FT:DualFenwickTree](self: FT,\
    \ p:IndexType):auto =\n    var p = self^^p\n    assert p in 0..<self.len\n   \
    \ p.inc\n    result = FT.U(0)\n    while p <= self.len:\n      result += self.data[p\
    \ - 1]\n      p += p and -p\n  proc add*[FT:DualFenwickTree](self: var FT, r:int,\
    \ x:FT.T) =\n    var r = r\n    while r > 0:\n      self.data[r - 1] += FT.U(x)\n\
    \      r -= r and -r\n  proc add*[FT:DualFenwickTree](self: var FT, p:RangeType,\
    \ x:FT.T) =\n    let (l, r) = self.halfOpenEndpoints(p)\n    assert 0 <= l and\
    \ l <= r and r <= self.len\n    self.add(r, x)\n    self.add(l, -x)\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_type_traits.nim
  - atcoder/internal_type_traits.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_type_traits.nim
  - atcoder/internal_type_traits.nim
  isVerificationFile: false
  path: atcoder/extra/structure/dual_fenwicktree.nim
  requiredBy: []
  timestamp: '2021-07-15 21:51:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/dual_fenwicktree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/dual_fenwicktree.nim
- /library/atcoder/extra/structure/dual_fenwicktree.nim.html
title: atcoder/extra/structure/dual_fenwicktree.nim
---
