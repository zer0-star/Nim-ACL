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
    path: verify/extra_lazy_segtree_test.nim
    title: verify/extra_lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_lazy_segtree_test.nim
    title: verify/extra_lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_segtree_test.nim
    title: verify/extra_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_segtree_test.nim
    title: verify/extra_segtree_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LAZYSEGTREE_HPP:\n  const ATCODER_LAZYSEGTREE_HPP*\
    \ = 1\n  \n  import std/sugar, std/sequtils, std/bitops\n  import atcoder/internal_bit\n\
    \  type segtree[S,F,useP] = object\n    n, size, log:int\n    when S isnot void:\n\
    \      d:seq[S]\n      op:(S, S)->S\n      e:()->S\n    when F isnot void:\n \
    \     lz:seq[F]\n      composition:(F,F)->F\n      id:()->F\n      when S isnot\
    \ void:\n        mapping:(F,S)->S\n      when useP isnot void:\n        p:(F,Slice[int])->F\n\
    \  proc hasData(ST:typedesc[segtree]):bool {.compileTime.} = ST.S isnot void\n\
    \  proc hasLazy(ST:typedesc[segtree]):bool {.compileTime.} = ST.F isnot void\n\
    \  proc hasP(ST:typedesc[segtree]):bool {.compileTime.} = ST.useP isnot void\n\
    \  \n  proc update*[ST:segtree](self:var ST, k:int) =\n    self.d[k] = self.op(self.d[2\
    \ * k], self.d[2 * k + 1])\n  proc all_apply*[ST:segtree](self:var ST, k:int,\
    \ f:ST.F) =\n    static: assert ST.hasLazy\n    when ST.hasData:\n      self.d[k]\
    \ = self.mapping(f, self.d[k])\n    if k < self.size: self.lz[k] = self.composition(f,\
    \ self.lz[k])\n\n  proc push*[ST:segtree](self: var ST, k:int) =\n    static:\
    \ assert ST.hasLazy\n    when ST.hasP:\n      let m = self.size shr (k.fastLog2\
    \ + 1)\n    self.all_apply(2 * k    , when ST.hasP: self.p(self.lz[k], 0..<m \
    \   ) else: self.lz[k])\n    self.all_apply(2 * k + 1, when ST.hasP: self.p(self.lz[k],\
    \ m..<m + m) else: self.lz[k])\n    self.lz[k] = self.id()\n\n#  segtree(int n)\
    \ : segtree(std::vector<S>(n, e())) {}\n  proc init*[ST:segtree](self: var ST,\
    \ v:int or seq[ST.S] or seq[ST.F]) =\n    when v is int:\n      when ST.hasData:\n\
    \        self.init(newSeqWith(v, self.e()))\n      else:\n        self.init(newSeqWith(v,\
    \ self.id()))\n    else:\n      let\n        n = v.len\n        log = ceil_pow2(n)\n\
    \        size = 1 shl log\n      self.n = n;self.log = log;self.size = size\n\
    \      when ST.hasLazy:\n        self.lz = newSeqWith(size, self.id())\n     \
    \ when ST.hasData:\n        self.d = newSeqWith(2 * size, self.e())\n        for\
    \ i in 0..<n: self.d[size + i] = v[i]\n        for i in countdown(size - 1, 1):\
    \ self.update(i)\n      else:\n        for i in 0..<n: self.lz[size + i] = v[i]\n\
    \        \n  proc init_segtree*[S](v:int or seq[S], op:(S,S)->S, e:()->S):auto\
    \ =\n    result = segtree[S,void,void](op:op,e:e)\n    result.init(v)\n  proc\
    \ init_dual_segtree*[F](v:int or seq[F], composition:(F,F)->F, id:()->F):auto\
    \ =\n    result = segtree[void,F,void](composition:composition,id:id)\n    result.init(v)\n\
    \  proc init_lazy_segtree*[S,F](v:int or seq[S], op:(S,S)->S,e:()->S,mapping:(F,S)->S,composition:(F,F)->F,id:()->F):auto\
    \ =\n    result = segtree[S,F,void](op:op,e:e,mapping:mapping,composition:composition,id:id)\n\
    \    result.init(v)\n  proc init_lazy_segtree*[S,F](v:int or seq[S], op:(S,S)->S,e:()->S,mapping:(F,S)->S,composition:(F,F)->F,id:()->F,\
    \ p:(F,Slice[int])->F):auto =\n    result = segtree[S,F,int](op:op,e:e,mapping:mapping,composition:composition,id:id,\
    \ p:p)\n    result.init(v)\n\n  proc set*[ST:segtree](self: var ST, p:int, x:ST.S\
    \ or ST.F) =\n    assert p in 0..<self.n\n    let p = p + self.size\n    when\
    \ ST.hasLazy:\n      for i in countdown(self.log, 1): self.push(p shr i)\n   \
    \ when ST.hasData:\n      self.d[p] = x\n      for i in 1..self.log: self.update(p\
    \ shr i)\n    else:\n      self.lz[p] = x\n\n  proc get*[ST:segtree](self: var\
    \ ST, p:int):auto =\n    assert p in 0..<self.n\n    let p = p + self.size\n \
    \   when ST.hasLazy:\n      for i in countdown(self.log, 1): self.push(p shr i)\n\
    \    when ST.hasData:\n      return self.d[p]\n    else:\n      return self.lz[p]\n\
    \n  proc prod*[ST:segtree](self:var ST, p:Slice[int]):ST.S =\n    static: assert\
    \ ST.hasData\n    var (l, r) = (p.a, p.b + 1)\n    assert 0 <= l and l <= r and\
    \ r <= self.n\n    if l == r: return self.e()\n    l += self.size;r += self.size\n\
    \    when ST.hasLazy:\n      for i in countdown(self.log, 1):\n        if ((l\
    \ shr i) shl i) != l: self.push(l shr i)\n        if ((r shr i) shl i) != r: self.push(r\
    \ shr i)\n    var sml, smr = self.e()\n    while l < r:\n      if (l and 1) !=\
    \ 0: sml = self.op(sml, self.d[l]);l.inc\n      if (r and 1) != 0: r.dec;smr =\
    \ self.op(self.d[r], smr)\n      l = l shr 1;r = r shr 1\n    return self.op(sml,\
    \ smr)\n\n  proc all_prod*[ST:segtree](self:ST):auto = self.d[1]\n\n  proc getPos[ST:segtree](self:\
    \ ST, k:int, base:int):Slice[int] =\n    static: assert ST.hasP\n    let\n   \
    \   h = fastLog2(k)\n      l = self.size shr h\n      base_n = (k - (1 shl h))\
    \ * l - base\n    return base_n..<base_n + l\n\n  proc apply*[ST:segtree](self:\
    \ var ST, p:int, f:ST.F) =\n    assert p in 0..<self.n\n    let p = p + self.size\n\
    \    when ST.hasLazy:\n      for i in countdown(self.log, 1): self.push(p shr\
    \ i)\n    self.d[p] = self.mapping(when ST.hasP: self.p(f, self.getPos(p, p -\
    \ self.size)) else: f, self.d[p])\n    when ST.hasData:\n      for i in 1..self.log:\
    \ self.update(p shr i)\n  proc apply*[ST:segtree](self: var ST, p:Slice[int],\
    \ f:ST.F) =\n    var (l, r) = (p.a, p.b + 1)\n    assert 0 <= l and l <= r and\
    \ r <= self.n\n    if l == r: return\n\n    l += self.size\n    r += self.size\n\
    \n    when ST.hasLazy:\n      for i in countdown(self.log, 1):\n        if ((l\
    \ shr i) shl i) != l: self.push(l shr i)\n        if ((r shr i) shl i) != r: self.push((r\
    \ - 1) shr i)\n      block:\n        var (l, r) = (l, r)\n        while l < r:\n\
    \          if (l and 1) != 0: self.all_apply(l, when ST.hasP: self.p(f, self.getPos(l,\
    \ p.a)) else: f);l.inc\n          if (r and 1) != 0: r.dec;self.all_apply(r, when\
    \ ST.hasP: self.p(f, self.getPos(r, p.a)) else: f)\n          l = l shr 1; r =\
    \ r shr 1\n\n    when ST.hasData:\n      for i in 1..self.log:\n        if ((l\
    \ shr i) shl i) != l: self.update(l shr i)\n        if ((r shr i) shl i) != r:\
    \ self.update((r - 1) shr i)\n\n#  template <bool (*g)(S)> int max_right(int l)\
    \ {\n#    return max_right(l, [](S x) { return g(x); });\n#  }\n  proc max_right*[ST:segtree](self:var\
    \ ST, l:int, g:(ST.S)->bool):int =\n    static: assert ST.hasData\n    assert\
    \ l in 0..self.n\n    assert g(e())\n    if l == self.n: return self.n\n    var\
    \ l = l + self.size\n    when ST.hasLazy:\n      for i in countdown(self.log,\
    \ 1): self.push(l shr i)\n    var sm = self.e()\n    while true:\n      while\
    \ l mod 2 == 0: l = l shr 1\n      if not g(self.op(sm, self.d[l])):\n       \
    \ while l < self.size:\n          when ST.hasLazy:\n            self.push(l)\n\
    \          l = (2 * l)\n          if g(self.op(sm, self.d[l])):\n            sm\
    \ = self.op(sm, self.d[l])\n            l.inc\n        return l - self.size\n\
    \      sm = self.op(sm, self.d[l])\n      l.inc\n      if not((l & -l) != l):\
    \ break\n    return self.n\n\n#  template <bool (*g)(S)> int min_left(int r) {\n\
    #    return min_left(r, [](S x) { return g(x); });\n#  }\n  proc min_left*[ST:segtree](self:\
    \ var ST, r:int, g:(ST.S)->bool):int =\n    static: assert ST.hasData\n    assert\
    \ r in 0..self.n\n    assert g(self.e())\n    if r == 0: return 0\n    var r =\
    \ r + self.size\n    when ST.hasLazy:\n      for i in countdown(self.log, 1):\
    \ self.push((r - 1) shr i)\n    var sm = self.e()\n    while true:\n      r.dec\n\
    \      while r > 1 and r mod 2 == 1: r = r shr 1\n      if not g(self.op(self.d[r],\
    \ sm)):\n        while r < self.size:\n          when ST.hasLazy:\n          \
    \  self.push(r)\n          r = (2 * r + 1)\n          if g(self.op(self.d[r],\
    \ sm)):\n            sm = self.op(self.d[r], sm)\n            r.dec\n        return\
    \ r + 1 - self.size\n      sm = self.op(self.d[r], sm)\n      if not ((r & -r)\
    \ != r): break\n    return 0\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: atcoder/extra/structure/universal_segtree.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra_lazy_segtree_test.nim
  - verify/extra_lazy_segtree_test.nim
  - verify/extra_segtree_test.nim
  - verify/extra_segtree_test.nim
documentation_of: atcoder/extra/structure/universal_segtree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/universal_segtree.nim
- /library/atcoder/extra/structure/universal_segtree.nim.html
title: atcoder/extra/structure/universal_segtree.nim
---
