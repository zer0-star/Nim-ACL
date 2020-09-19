---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_dynamicmodint_test.nim
    title: verify/lazy_segtree_dynamicmodint_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_dynamicmodint_test.nim
    title: verify/lazy_segtree_dynamicmodint_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LAZYSEGTREE_HPP:\n  const ATCODER_LAZYSEGTREE_HPP*\
    \ = 1\n  \n  import std/sugar, std/sequtils, atcoder/internal_bit\n  type lazy_segtree*[S,F]\
    \ = object\n    n, size, log:int\n    d:seq[S]\n    lz:seq[F]\n    op:(S, S)->S\n\
    \    e:()->S\n    mapping:(F,S)->S\n    composition:(F,F)->F\n    id:()->F\n \
    \ \n  proc update*[ST:lazy_segtree](self:var ST, k:int) = self.d[k] = self.op(self.d[2\
    \ * k], self.d[2 * k + 1])\n  proc all_apply*[ST:lazy_segtree](self:var ST, k:int,\
    \ f:ST.F) =\n    self.d[k] = self.mapping(f, self.d[k])\n    if k < self.size:\
    \ self.lz[k] = self.composition(f, self.lz[k])\n  proc push*[ST:lazy_segtree](self:\
    \ var ST, k:int) =\n    self.all_apply(2 * k, self.lz[k])\n    self.all_apply(2\
    \ * k + 1, self.lz[k])\n    self.lz[k] = self.id()\n\n#  lazy_segtree(int n) :\
    \ lazy_segtree(std::vector<S>(n, e())) {}\n  proc init_lazy_segtree*[S, F](v:seq[S],\
    \ op:(S,S)->S,e:()->S,mapping:(F,S)->S,composition:(F,F)->F,id:()->F):auto =\n\
    \    let\n      n = v.len\n      log = ceil_pow2(n)\n      size = 1 shl log\n\
    \    var d = newSeqWith(2 * size, e())\n    for i in 0..<n:\n      d[size + i]\
    \ = v[i]\n    result = lazy_segtree[S,F](n:n,log:log,size:size,d:d,lz:newSeqWith(size,\
    \ id()),op:op,e:e,mapping:mapping,composition:composition,id:id)\n    for i in\
    \ countdown(size - 1, 1):\n      result.update(i)\n  proc init_lazy_segtree*[S,\
    \ F](n:int, op:(S,S)->S,e:()->S,mapping:(F,S)->S,composition:(F,F)->F,id:()->F):auto\
    \ =\n    init_lazy_segtree(newSeqWith(n, e()),op,e,mapping,composition,id)\n\n\
    \n  proc set*[ST:lazy_segtree](self: var ST, p:int, x:ST.S) =\n    assert p in\
    \ 0..<self.n\n    let p = p + self.size\n    for i in countdown(self.log, 1):\
    \ self.push(p shr i)\n    self.d[p] = x\n    for i in 1..self.log: self.update(p\
    \ shr i)\n\n  proc get*[ST:lazy_segtree](self: var ST, p:int):ST.S =\n    assert\
    \ p in 0..<self.n\n    let p = p + self.size\n    for i in countdown(self.log,\
    \ 1): self.push(p shr i)\n    return self.d[p]\n\n  proc prod*[ST:lazy_segtree](self:var\
    \ ST, p:Slice[int]):ST.S =\n    var (l, r) = (p.a, p.b + 1)\n    assert 0 <= l\
    \ and l <= r and r <= self.n\n    if l == r: return self.e()\n\n    l += self.size\n\
    \    r += self.size\n\n    for i in countdown(self.log, 1):\n      if ((l shr\
    \ i) shl i) != l: self.push(l shr i)\n      if ((r shr i) shl i) != r: self.push(r\
    \ shr i)\n\n    var sml, smr = self.e()\n    while l < r:\n      if (l and 1)\
    \ != 0: sml = self.op(sml, self.d[l]);l.inc\n      if (r and 1) != 0: r.dec;smr\
    \ = self.op(self.d[r], smr)\n      l = l shr 1\n      r = r shr 1\n    return\
    \ self.op(sml, smr)\n\n  proc all_prod*[ST:lazy_segtree](self:ST):auto = self.d[1]\n\
    \n  proc apply*[ST:lazy_segtree](self: var ST, p:int, f:ST.F) =\n    assert p\
    \ in 0..<self.n\n    let p = p + self.size\n    for i in countdown(self.log, 1):\
    \ self.push(p shr i)\n    self.d[p] = self.mapping(f, self.d[p])\n    for i in\
    \ 1..self.log: self.update(p shr i)\n  proc apply*[ST:lazy_segtree](self: var\
    \ ST, p:Slice[int], f:ST.F) =\n    var (l, r) = (p.a, p.b + 1)\n    assert 0 <=\
    \ l and l <= r and r <= self.n\n    if l == r: return\n\n    l += self.size\n\
    \    r += self.size\n\n    for i in countdown(self.log, 1):\n      if ((l shr\
    \ i) shl i) != l: self.push(l shr i)\n      if ((r shr i) shl i) != r: self.push((r\
    \ - 1) shr i)\n\n    block:\n      var (l, r) = (l, r)\n      while l < r:\n \
    \       if (l and 1) != 0: self.all_apply(l, f);l.inc\n        if (r and 1) !=\
    \ 0: r.dec;self.all_apply(r, f)\n        l = l shr 1\n        r = r shr 1\n\n\
    \    for i in 1..self.log:\n      if ((l shr i) shl i) != l: self.update(l shr\
    \ i)\n      if ((r shr i) shl i) != r: self.update((r - 1) shr i)\n\n#  template\
    \ <bool (*g)(S)> int max_right(int l) {\n#    return max_right(l, [](S x) { return\
    \ g(x); });\n#  }\n  proc max_right*[ST:lazysegtree](self:var ST, l:int, g:(ST.S)->bool):int\
    \ =\n    assert l in 0..self.n\n    assert g(e())\n    if l == self.n: return\
    \ self.n\n    var l = l + self.size\n    for i in countdown(self.log, 1): self.push(l\
    \ shr i)\n    var sm = self.e()\n    while true:\n      while l mod 2 == 0: l\
    \ = l shr 1\n      if not g(self.op(sm, self.d[l])):\n        while l < self.size:\n\
    \          self.push(l)\n          l = (2 * l)\n          if g(self.op(sm, self.d[l])):\n\
    \            sm = self.op(sm, self.d[l])\n            l.inc\n        return l\
    \ - self.size\n      sm = self.op(sm, self.d[l])\n      l.inc\n      if not((l\
    \ & -l) != l): break\n    return self.n\n\n#  template <bool (*g)(S)> int min_left(int\
    \ r) {\n#    return min_left(r, [](S x) { return g(x); });\n#  }\n  proc min_left*[ST:lazy_segtree](self:\
    \ var ST, r:int, g:(ST.S)->bool):int =\n    assert r in 0..self.n\n    assert(g(self.e()))\n\
    \    if r == 0: return 0\n    var r = r + self.size\n    for i in countdown(self.log,\
    \ 1): self.push((r - 1) shr i)\n    var sm = self.e()\n    while true:\n     \
    \ r.dec\n      while r > 1 and r mod 2 == 1: r = r shr 1\n      if not g(self.op(self.d[r],\
    \ sm)):\n        while r < self.size:\n          self.push(r)\n          r = (2\
    \ * r + 1)\n          if g(self.op(self.d[r], sm)):\n            sm = self.op(self.d[r],\
    \ sm)\n            r.dec\n        return r + 1 - self.size\n      sm = self.op(self.d[r],\
    \ sm)\n      if not ((r & -r) != r): break\n    return 0\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: atcoder/lazysegtree.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/lazy_segtree_test.nim
  - verify/lazy_segtree_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
documentation_of: atcoder/lazysegtree.nim
layout: document
redirect_from:
- /library/atcoder/lazysegtree.nim
- /library/atcoder/lazysegtree.nim.html
title: atcoder/lazysegtree.nim
---
