---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/lazy_segtree_dynamicmodint_test.nim
    title: verify/lazy_segtree_dynamicmodint_test.nim
  - icon: ':x:'
    path: verify/lazy_segtree_dynamicmodint_test.nim
    title: verify/lazy_segtree_dynamicmodint_test.nim
  - icon: ':x:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
  - icon: ':x:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LAZYSEGTREE_HPP:\n  const ATCODER_LAZYSEGTREE_HPP*\
    \ = 1\n  \n  import atcoder/internal_bit, atcoder/rangeutils\n  import std/sugar,\
    \ std/sequtils, std/algorithm\n  {.push inline.}\n  type LazySegTree*[S,F;p:static[tuple]]\
    \ = object\n    len*, size*, log*:int\n    d:seq[S]\n    lz:seq[F]\n\n  template\
    \ calc_op[ST:LazySegTree](self:typedesc[ST], a, b:ST.S):auto =\n    block:\n \
    \     let op = ST.p.op\n      op(a, b)\n  template calc_e[ST:LazySegTree](self:typedesc[ST]):auto\
    \ =\n    block:\n      let e = ST.p.e\n      e()\n  template calc_mapping[ST:LazySegTree](self:typedesc[ST],\
    \ a:ST.F, b:ST.S):auto =\n    block:\n      let mapping = ST.p.mapping\n     \
    \ mapping(a, b)\n  template calc_composition[ST:LazySegTree](self:typedesc[ST],\
    \ a, b:ST.F):auto =\n    block:\n      let composition = ST.p.composition\n  \
    \    composition(a, b)\n  template calc_id[ST:LazySegTree](self:typedesc[ST]):auto\
    \ =\n    block:\n      let id = ST.p.id\n      id()\n\n  proc update[ST:LazySegTree](self:var\
    \ ST, k:int) =\n    self.d[k] = ST.calc_op(self.d[2 * k], self.d[2 * k + 1])\n\
    \  proc all_apply*[ST:LazySegTree](self:var ST, k:int, f:ST.F) =\n    self.d[k]\
    \ = ST.calc_mapping(f, self.d[k])\n    if k < self.size: self.lz[k] = ST.calc_composition(f,\
    \ self.lz[k])\n  proc all_apply*[ST:LazySegTree](self:var ST, f:ST.F) =\n    self.all_apply(1,\
    \ f)\n  proc push*[ST:LazySegTree](self: var ST, k:int) =\n    self.all_apply(2\
    \ * k, self.lz[k])\n    self.all_apply(2 * k + 1, self.lz[k])\n    self.lz[k]\
    \ = ST.calc_id()\n\n  proc init[ST:LazySegTree](self:var ST, v:seq[ST.S]) =\n\
    \    let\n      n = v.len\n      log = ceil_pow2(n)\n      size = 1 shl log\n\
    \    (self.len, self.size, self.log) = (n, size, log)\n    if self.d.len < 2 *\
    \ size:\n      self.d = newSeqWith(2 * size, ST.calc_e())\n    else:\n      self.d.fill(0,\
    \ 2 * size - 1, ST.calc_e())\n    for i in 0..<n:\n      self.d[size + i] = v[i]\n\
    \    if self.lz.len < size:\n      self.lz = newSeqWith(size, ST.calc_id())\n\
    \    else:\n      self.lz.fill(0, size - 1, ST.calc_id())\n    for i in countdown(size\
    \ - 1, 1): self.update(i)\n  proc init[ST:LazySegTree](self: var ST, n:int) =\n\
    \    self.init(newSeqWith(n, ST.calc_e()))\n  proc init[ST:LazySegTree](self:\
    \ typedesc[ST], v:seq[ST.S]):ST = result.init(v)\n  proc init[ST:LazySegTree](self:\
    \ typedesc[ST], n:int):ST = result.init(n)\n\n  template getType*(ST:typedesc[LazySegTree],\
    \ S, F:typedesc, op0:static[(S,S)->S],e0:static[()->S],mapping0:static[(F,S)->S],composition0:static[(F,F)->F],id0:static[()->F]):typedesc[LazySegTree]\
    \ =\n    LazySegTree[S, F, (op:op0, e:e0, mapping:mapping0, composition:composition0,\
    \ id:id0)]\n  template LazySegTreeType*(S, F:typedesc, op0:static[(S,S)->S],e0:static[()->S],mapping0:static[(F,S)->S],composition0:static[(F,F)->F],id0:static[()->F]):typedesc[LazySegTree]\
    \ =\n    LazySegTree[S, F, (op:op0, e:e0, mapping:mapping0, composition:composition0,\
    \ id:id0)]\n#    LazySegTree.getType(S, F, op, e, mapping, composition, id)\n\n\
    \  proc initLazySegTree*[S, F](v:seq[S], op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F]):auto\
    \ =\n    LazySegTreeType(S, F, op, e, mapping, composition, id).init(v)\n  proc\
    \ initLazySegTree*[S, F](n:int, op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F]):auto\
    \ =\n    LazySegTreeType(S, F, op, e, mapping, composition, id).init(n)\n\n  proc\
    \ set*[ST:LazySegTree](self: var ST, p:IndexType, x:ST.S) =\n    var p = self^^p\n\
    \    assert p in 0..<self.len\n    p += self.size\n    for i in countdown(self.log,\
    \ 1): self.push(p shr i)\n    self.d[p] = x\n    for i in 1..self.log: self.update(p\
    \ shr i)\n\n  proc get*[ST:LazySegTree](self: var ST, p:IndexType):ST.S =\n  \
    \  var p = self^^p\n    assert p in 0..<self.len\n    p += self.size\n    for\
    \ i in countdown(self.log, 1): self.push(p shr i)\n    return self.d[p]\n\n  proc\
    \ `[]=`*[ST:LazySegTree](self: var ST, p:IndexType, x:ST.S) = self.set(p, x)\n\
    \  proc `[]`*[ST:LazySegTree](self: var ST, p:IndexType):ST.S = self.get(p)\n\n\
    \  proc prod*[ST:LazySegTree](self:var ST, p:RangeType):ST.S =\n    var (l, r)\
    \ = self.halfOpenEndpoints(p)\n    assert 0 <= l and l <= r and r <= self.len\n\
    \    if l == r: return ST.calc_e()\n\n    l += self.size\n    r += self.size\n\
    \n    for i in countdown(self.log, 1):\n      if ((l shr i) shl i) != l: self.push(l\
    \ shr i)\n      if ((r shr i) shl i) != r: self.push(r shr i)\n\n    var sml,\
    \ smr = ST.calc_e()\n    while l < r:\n      if (l and 1) != 0: sml = ST.calc_op(sml,\
    \ self.d[l]);l.inc\n      if (r and 1) != 0: r.dec;smr = ST.calc_op(self.d[r],\
    \ smr)\n      l = l shr 1\n      r = r shr 1\n    return ST.calc_op(sml, smr)\n\
    \n  proc `[]`*[ST:LazySegTree](self: var ST, p:RangeType):ST.S = self.prod(p)\n\
    \n  proc all_prod*[ST:LazySegTree](self:ST):auto = self.d[1]\n\n  proc apply*[ST:LazySegTree](self:\
    \ var ST, p:IndexType, f:ST.F) =\n    var p = self^^p\n    assert p in 0..<self.len\n\
    \    p += self.size\n    for i in countdown(self.log, 1): self.push(p shr i)\n\
    \    self.d[p] = ST.calc_mapping(f, self.d[p])\n    for i in 1..self.log: self.update(p\
    \ shr i)\n  proc apply*[ST:LazySegTree](self: var ST, p:RangeType, f:ST.F) =\n\
    \    var (l, r) = self.halfOpenEndpoints(p)\n    assert 0 <= l and l <= r and\
    \ r <= self.len\n    if l == r: return\n\n    l += self.size\n    r += self.size\n\
    \n    for i in countdown(self.log, 1):\n      if ((l shr i) shl i) != l: self.push(l\
    \ shr i)\n      if ((r shr i) shl i) != r: self.push((r - 1) shr i)\n\n    block:\n\
    \      var (l, r) = (l, r)\n      while l < r:\n        if (l and 1) != 0: self.all_apply(l,\
    \ f);l.inc\n        if (r and 1) != 0: r.dec;self.all_apply(r, f)\n        l =\
    \ l shr 1\n        r = r shr 1\n\n    for i in 1..self.log:\n      if ((l shr\
    \ i) shl i) != l: self.update(l shr i)\n      if ((r shr i) shl i) != r: self.update((r\
    \ - 1) shr i)\n\n#  template <bool (*g)(S)> int max_right(int l) {\n#    return\
    \ max_right(l, [](S x) { return g(x); });\n#  }\n  proc max_right*[ST:LazySegTree](self:var\
    \ ST, l:IndexType, g:(ST.S)->bool):int =\n    var l = self^^l\n    assert l in\
    \ 0..self.len\n    assert g(ST.calc_e())\n    if l == self.len: return self.len\n\
    \    l += self.size\n    for i in countdown(self.log, 1): self.push(l shr i)\n\
    \    var sm = ST.calc_e()\n    while true:\n      while l mod 2 == 0: l = l shr\
    \ 1\n      if not g(ST.calc_op(sm, self.d[l])):\n        while l < self.size:\n\
    \          self.push(l)\n          l = (2 * l)\n          if g(ST.calc_op(sm,\
    \ self.d[l])):\n            sm = ST.calc_op(sm, self.d[l])\n            l.inc\n\
    \        return l - self.size\n      sm = ST.calc_op(sm, self.d[l])\n      l.inc\n\
    \      if not((l and -l) != l): break\n    return self.len\n\n#  template <bool\
    \ (*g)(S)> int min_left(int r) {\n#    return min_left(r, [](S x) { return g(x);\
    \ });\n#  }\n  proc min_left*[ST:LazySegTree](self: var ST, r:IndexType, g:(ST.S)->bool):int\
    \ =\n    var r = self^^r\n    assert r in 0..self.len\n    assert(g(ST.calc_e()))\n\
    \    if r == 0: return 0\n    r += self.size\n    for i in countdown(self.log,\
    \ 1): self.push((r - 1) shr i)\n    var sm = ST.calc_e()\n    while true:\n  \
    \    r.dec\n      while r > 1 and r mod 2 == 1: r = r shr 1\n      if not g(ST.calc_op(self.d[r],\
    \ sm)):\n        while r < self.size:\n          self.push(r)\n          r = (2\
    \ * r + 1)\n          if g(ST.calc_op(self.d[r], sm)):\n            sm = ST.calc_op(self.d[r],\
    \ sm)\n            r.dec\n        return r + 1 - self.size\n      sm = ST.calc_op(self.d[r],\
    \ sm)\n      if not ((r and -r) != r): break\n    return 0\n  {.pop.}\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  isVerificationFile: false
  path: atcoder/lazysegtree.nim
  requiredBy: []
  timestamp: '2021-12-11 18:27:17+09:00'
  verificationStatus: LIBRARY_ALL_WA
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
