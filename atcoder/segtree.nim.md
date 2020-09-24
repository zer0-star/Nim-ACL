---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: test/example/segtree_practice.nim
    title: test/example/segtree_practice.nim
  - icon: ':warning:'
    path: test/example/segtree_practice.nim
    title: test/example/segtree_practice.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/segtree_test.nim
    title: verify/segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/segtree_test.nim
    title: verify/segtree_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SEGTREE_HPP:\n  const ATCODER_SEGTREE_HPP* = 1\n\
    \  import atcoder/internal_bit\n  import std/sugar, std/sequtils\n\n  type segtree[S]\
    \ = object\n    n, size, log:int\n    d:seq[int]\n    op:(S, S)->S\n    e:()->S\n\
    \n  proc update[ST:segtree](self: var ST, k:int) {.inline.} =\n    self.d[k] =\
    \ self.op(self.d[2 * k], self.d[2 * k + 1])\n\n  proc initSegTree*[S](v:seq[S],\
    \ op:(S,S)->S, e:()->S):auto =\n    let\n      n = v.len\n      log = ceil_pow2(n)\n\
    \      size = 1 shl log\n    result = segtree[S](n:n, size:size, log:log, d:newSeqWith(2\
    \ * size, e()), op:op, e:e)\n    for i in 0..<n: result.d[size + i] = v[i]\n \
    \   for i in countdown(size - 1, 1): result.update(i)\n\n  proc initSegTree*[S](n:int,\
    \ op:(S,S)->S, e:()->S):auto =\n    initSegTree(newSeqWith(n, e()), op, e)\n\n\
    \  proc set*[ST:segtree](self:var ST, p:int, x:ST.S) {.inline.} =\n    assert\
    \ p in 0..<self.n\n    var p = p + self.size\n    self.d[p] = x\n    for i in\
    \ 1..self.log: self.update(p shr i)\n\n  proc get*[ST:segtree](self:ST, p:int):ST.S\
    \ {.inline.} =\n    assert p in 0..<self.n\n    return self.d[p + self.size]\n\
    \n  proc prod*[ST:segtree](self:ST, p:Slice[int]):ST.S {.inline.} =\n    var (l,\
    \ r) = (p.a, p.b + 1)\n    assert 0 <= l and l <= r and r <= self.n\n    var sml,\
    \ smr = self.e()\n    l += self.size; r += self.size\n    while l < r:\n     \
    \ if (l and 1) != 0: sml = self.op(sml, self.d[l]);l.inc\n      if (r and 1) !=\
    \ 0: r.dec;smr = self.op(self.d[r], smr)\n      l = l shr 1\n      r = r shr 1\n\
    \    return self.op(sml, smr)\n\n  proc all_prod*[ST:segtree](self:ST):auto =\
    \ self.d[1]\n\n#  proc max_right*[ST:segtree, f:static[proc(s:ST.S):bool]](self:ST,\
    \ l:int):auto = self.max_right(l, f)\n  proc max_right*[ST:segtree](self:ST, l:int,\
    \ f:proc(s:ST.S):bool):int =\n    assert l in 0..self.n\n    assert f(self.e())\n\
    \    if l == self.n: return self.n\n    var\n      l = l + self.size\n      sm\
    \ = self.e()\n    while true:\n      while l mod 2 == 0: l = l shr 1\n      if\
    \ not f(self.op(sm, self.d[l])):\n        while l < self.size:\n          l =\
    \ (2 * l)\n          if f(self.op(sm, self.d[l])):\n            sm = self.op(sm,\
    \ self.d[l])\n            l.inc\n        return l - self.size\n      sm = self.op(sm,\
    \ self.d[l])\n      l.inc\n      if not ((l and -l) != l): break\n    return self.n\n\
    \n#  proc min_left*[ST:segtree, f:static[proc(s:ST.S):bool]](self:ST, r:int):auto\
    \ = self.min_left(r, f)\n  proc min_left*[ST:segtree](self:ST, r:int, f:proc(s:ST.S):bool):int\
    \ =\n    assert r in 0..self.n\n    assert f(self.e())\n    if r == 0: return\
    \ 0\n    var\n      r = r + self.size\n      sm = self.e()\n    while true:\n\
    \      r.dec\n      while r > 1 and (r mod 2 != 0): r = r shr 1\n      if not\
    \ f(self.op(self.d[r], sm)):\n        while r < self.size:\n          r = (2 *\
    \ r + 1)\n          if f(self.op(self.d[r], sm)):\n            sm = self.op(self.d[r],\
    \ sm)\n            r.dec\n        return r + 1 - self.size\n      sm = self.op(self.d[r],\
    \ sm)\n      if not ((r and -r) != r): break\n    return 0\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: atcoder/segtree.nim
  requiredBy:
  - test/example/segtree_practice.nim
  - test/example/segtree_practice.nim
  timestamp: '1970-01-01 00:00:00+00:00'
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
