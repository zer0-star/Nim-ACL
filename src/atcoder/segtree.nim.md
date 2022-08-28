---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/segtree_test.nim
    title: verify/segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/segtree_test.nim
    title: verify/segtree_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SEGTREE_HPP:\n  const ATCODER_SEGTREE_HPP* = 1\n\
    \  import atcoder/internal_bit\n  import std/sequtils, std/algorithm\n  import\
    \ atcoder/rangeutils\n\n  {.push inline.}\n  type SegTree*[S; p:static[tuple]]\
    \ = object\n    len*, size*, log*:int\n    d: seq[S]\n\n  template calc_op[ST:SegTree](self:typedesc[ST],\
    \ a, b:ST.S):auto =\n    block:\n      let u = ST.p.op(a, b)\n      u\n  template\
    \ calc_e[ST:SegTree](self:typedesc[ST]):auto =\n    block:\n      let u = ST.p.e()\n\
    \      u\n  proc update[ST:SegTree](self: var ST, k:int) =\n    self.d[k] = ST.calc_op(self.d[2\
    \ * k], self.d[2 * k + 1])\n\n  proc init*[ST:SegTree](self: var ST, v:seq[ST.S])\
    \ =\n    let\n      n = v.len\n      log = ceil_pow2(n)\n      size = 1 shl log\n\
    \    (self.len, self.size, self.log) = (n, size, log)\n    if self.d.len < 2 *\
    \ size:\n      self.d = newSeqWith(2 * size, ST.calc_e())\n    else:\n      self.d.fill(0,\
    \ 2 * size - 1, ST.calc_e())\n    for i in 0..<n: self.d[size + i] = v[i]\n  \
    \  for i in countdown(size - 1, 1): self.update(i)\n  proc init*[ST:SegTree](self:\
    \ var ST, n:int) =\n    self.init(newSeqWith(n, ST.calc_e()))\n  proc init*[ST:SegTree](self:\
    \ typedesc[ST], v:seq[ST.S]):auto =\n    result = ST()\n    result.init(v)\n \
    \ proc init*[ST:SegTree](self: typedesc[ST], n:int):auto =\n    self.init(newSeqWith(n,\
    \ ST.calc_e()))\n  template SegTreeType*[S](op0, e0:untyped):typedesc[SegTree]\
    \ =\n    SegTree[S, (op:(proc(l:S, r:S):S)(op0), e:(proc():S)(e0))]\n  template\
    \ getType*(ST:typedesc[SegTree], S:typedesc, op, e:untyped):typedesc[SegTree]\
    \ =\n    SegTreeType[S](op, e)\n\n  template initSegTree*[S](v:seq[S] or int,\
    \ op, e:untyped):auto =\n    SegTreeType[S](op, e).init(v)\n\n  proc set*[ST:SegTree](self:var\
    \ ST, p:IndexType, x:ST.S) =\n    var p = self^^p\n    assert p in 0..<self.len\n\
    \    p += self.size\n    self.d[p] = x\n    for i in 1..self.log: self.update(p\
    \ shr i)\n\n  proc get*[ST:SegTree](self:ST, p:IndexType):ST.S =\n    let p =\
    \ self^^p\n    assert p in 0..<self.len\n    return self.d[p + self.size]\n\n\
    \  proc prod*[ST:SegTree](self:ST, p:RangeType):ST.S =\n    var (l, r) = self.halfOpenEndpoints(p)\n\
    \    assert 0 <= l and l <= r and r <= self.len\n    var\n      sml, smr = ST.calc_e()\n\
    \    l += self.size; r += self.size\n    while l < r:\n      if (l and 1) != 0:\
    \ sml = ST.calc_op(sml, self.d[l]);l.inc\n      if (r and 1) != 0: r.dec;smr =\
    \ ST.calc_op(self.d[r], smr)\n      l = l shr 1\n      r = r shr 1\n    return\
    \ ST.calc_op(sml, smr)\n  proc `[]`*[ST:SegTree](self:ST, p:IndexType):auto =\
    \ self.get(p)\n  proc `[]`*[ST:SegTree](self:ST, p:RangeType):auto = self.prod(p)\n\
    \  proc `[]=`*[ST:SegTree](self:var ST, p:IndexType, x:ST.S) = self.set(p, x)\n\
    \n  proc all_prod*[ST:SegTree](self:ST):ST.S = self.d[1]\n\n#  proc max_right*[ST:SegTree,\
    \ f:static[proc(s:ST.S):bool]](self:ST, l:int):auto = self.max_right(l, f)\n \
    \ proc max_right*[ST:SegTree](self:ST, l:IndexType, f:proc(s:ST.S):bool):int =\n\
    \    var l = self^^l\n    assert l in 0..self.len\n    assert f(ST.calc_e())\n\
    \    if l == self.len: return self.len\n    l += self.size\n    var sm = ST.calc_e()\n\
    \    while true:\n      while l mod 2 == 0: l = l shr 1\n      if not f(ST.calc_op(sm,\
    \ self.d[l])):\n        while l < self.size:\n          l = (2 * l)\n        \
    \  if f(ST.calc_op(sm, self.d[l])):\n            sm = ST.calc_op(sm, self.d[l])\n\
    \            l.inc\n        return l - self.size\n      sm = ST.calc_op(sm, self.d[l])\n\
    \      l.inc\n      if not ((l and -l) != l): break\n    return self.len\n\n#\
    \  proc min_left*[ST:SegTree, f:static[proc(s:ST.S):bool]](self:ST, r:int):auto\
    \ = self.min_left(r, f)\n  proc min_left*[ST:SegTree](self:ST, r:IndexType, f:proc(s:ST.S):bool):int\
    \ =\n    var r = self^^r\n    assert r in 0..self.len\n    assert f(ST.calc_e())\n\
    \    if r == 0: return 0\n    r += self.size\n    var sm = ST.calc_e()\n    while\
    \ true:\n      r.dec\n      while r > 1 and (r mod 2 != 0): r = r shr 1\n    \
    \  if not f(ST.calc_op(self.d[r], sm)):\n        while r < self.size:\n      \
    \    r = (2 * r + 1)\n          if f(ST.calc_op(self.d[r], sm)):\n           \
    \ sm = ST.calc_op(self.d[r], sm)\n            r.dec\n        return r + 1 - self.size\n\
    \      sm = ST.calc_op(self.d[r], sm)\n      if not ((r and -r) != r): break\n\
    \    return 0\n  {.pop.}\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: atcoder/segtree.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:00+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/segtree_test.nim
  - verify/segtree_test.nim
documentation_of: atcoder/segtree.nim
layout: document
redirect_from:
- /library/atcoder/segtree.nim
- /library/atcoder/segtree.nim.html
title: atcoder/segtree.nim
---
