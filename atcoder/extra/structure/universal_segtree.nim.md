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
  _extendedRequiredBy:
  - icon: ':warning:'
    path: tests/test_extra_universal_segtree_stress.nim
    title: tests/test_extra_universal_segtree_stress.nim
  - icon: ':warning:'
    path: tests/test_extra_universal_segtree_stress.nim
    title: tests/test_extra_universal_segtree_stress.nim
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/structure/extra_lazy_segtree_test.nim
    title: verify/extra/structure/extra_lazy_segtree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/extra_lazy_segtree_test.nim
    title: verify/extra/structure/extra_lazy_segtree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/extra_segtree_test.nim
    title: verify/extra/structure/extra_segtree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/extra_segtree_test.nim
    title: verify/extra/structure/extra_segtree_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LAZYSEGTREE_HPP:\n  const ATCODER_LAZYSEGTREE_HPP*\
    \ = 1\n  \n  import std/sugar, std/sequtils, std/bitops\n  import atcoder/internal_bit,\
    \ atcoder/rangeutils\n  type segtree[S,F;useP:static[bool];p:static[tuple]] =\
    \ object\n    len, size, log:int\n    when S isnot void:\n      d:seq[S]\n   \
    \ when F isnot void:\n      lz:seq[F]\n      when useP:\n        p:(F,Slice[int])->F\n\
    \  proc hasData(ST:typedesc[segtree]):bool {.compileTime.} = ST.S isnot void\n\
    \  proc hasLazy(ST:typedesc[segtree]):bool {.compileTime.} = ST.F isnot void\n\
    #  proc hasP(ST:typedesc[segtree]):bool {.compileTime.} = ST.useP\n\n  template\
    \ calc_op[ST:segtree](self:typedesc[ST], a, b:ST.S):auto =\n    block:\n     \
    \ let op = ST.p.op\n      op(a, b)\n  template calc_e[ST:segtree](self:typedesc[ST]):auto\
    \ =\n    block:\n      let e = ST.p.e\n      e()\n  template calc_mapping[ST:segtree](self:typedesc[ST],\
    \ a:ST.F, b:ST.S):auto =\n    block:\n      let mapping = ST.p.mapping\n     \
    \ mapping(a, b)\n  template calc_composition[ST:segtree](self:typedesc[ST], a,\
    \ b:ST.F):auto =\n    block:\n      let composition = ST.p.composition\n     \
    \ composition(a, b)\n  template calc_id[ST:segtree](self:typedesc[ST]):auto =\n\
    \    block:\n      let id = ST.p.id\n      id()\n  template calc_p[ST:segtree](self:typedesc[ST],\
    \ a:ST.F, s:Slice[int]):auto =\n    block:\n      let p = ST.p.p\n      p(a, s)\n\
    \n  proc update*[ST:segtree](self:var ST, k:int) =\n    self.d[k] = ST.calc_op(self.d[2\
    \ * k], self.d[2 * k + 1])\n  proc all_apply*[ST:segtree](self:var ST, k:int,\
    \ f:ST.F) =\n    static: assert ST.hasLazy\n    when ST.hasData:\n      self.d[k]\
    \ = ST.calc_mapping(f, self.d[k])\n      if k < self.size: self.lz[k] = ST.calc_composition(f,\
    \ self.lz[k])\n    else:\n      self.lz[k] = ST.calc_composition(f, self.lz[k])\n\
    \n  proc push*[ST:segtree](self: var ST, k:int) =\n    static: assert ST.hasLazy\n\
    \    when ST.useP:\n      let m = self.size shr (k.fastLog2 + 1)\n    self.all_apply(2\
    \ * k    , when ST.useP: ST.calc_p(self.lz[k], 0..<m    ) else: self.lz[k])\n\
    \    self.all_apply(2 * k + 1, when ST.useP: ST.calc_p(self.lz[k], m..<m + m)\
    \ else: self.lz[k])\n    self.lz[k] = ST.calc_id()\n\n#  segtree(int n) : segtree(std::vector<S>(n,\
    \ e())) {}\n  proc init*[ST:segtree](self: var ST, v:int or seq[ST.S] or seq[ST.F])\
    \ =\n    when v is int:\n      when ST.hasData:\n        self.init(newSeqWith(v,\
    \ ST.calc_e()))\n      else:\n        self.init(newSeqWith(v, ST.calc_id()))\n\
    \    else:\n      let\n        n = v.len\n        log = ceil_pow2(n)\n       \
    \ size = 1 shl log\n      self.len = n;self.log = log;self.size = size\n     \
    \ when ST.hasLazy:\n        when ST.hasData:\n          self.lz = newSeqWith(size,\
    \ ST.calc_id())\n        else:\n          self.lz = newSeqWith(size * 2, ST.calc_id())\n\
    \      when ST.hasData:\n        self.d = newSeqWith(2 * size, ST.calc_e())\n\
    \        for i in 0..<n: self.d[size + i] = v[i]\n        for i in countdown(size\
    \ - 1, 1): self.update(i)\n      else:\n        for i in 0..<n: self.lz[size +\
    \ i] = v[i]\n\n  proc init_segtree*[S](v:seq[S], op:static[(S,S)->S], e:static[()->S]):auto\
    \ =\n    result = segtree[S,void,false, (op:op,e:e)]()\n    result.init(v)\n \
    \ proc init_segtree*[S](n:int, op:static[(S,S)->S], e:static[()->S]):auto =\n\
    \    let e0 = e\n    var v = newSeqWith(n, e0())\n    return init_segtree(v, op,\
    \ e)\n  proc init_dual_segtree*[F](v:seq[F], composition:static[(F,F)->F], id:static[()->F]):auto\
    \ =\n    result = segtree[void,F,false, (composition:composition,id:id)]()\n \
    \   result.init(v)\n  proc init_dual_segtree*[F](n:int, composition:static[(F,F)->F],\
    \ id:static[()->F]):auto =\n    let id0 = id\n    init_dual_segtree[F](newSeqWith(n,\
    \ id0()), composition, id)\n  proc init_lazy_segtree*[S,F](v:seq[S], op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F]):auto\
    \ =\n    result = segtree[S,F,false,(op:op,e:e,mapping:mapping,composition:composition,id:id)]()\n\
    \    result.init(v)\n  proc init_lazy_segtree*[S,F](n:int, op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F]):auto\
    \ =\n    let e0 = e\n    init_lazy_segtree[S,F](newSeqWith(n, e0()), op,e,mapping,composition,id)\n\
    \  proc init_lazy_segtree*[S,F](v:seq[S], op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F],\
    \ p:static[(F,Slice[int])->F]):auto =\n    result = segtree[S,F,true,(op:op,e:e,mapping:mapping,composition:composition,id:id,\
    \ p:p)]()\n    result.init(v)\n  proc init_lazy_segtree*[S,F](n:int, op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F],\
    \ p:static[(F,Slice[int])->F]):auto =\n    let e0 = e\n    init_lazy_segtree[S,F](newSeqWith(n,\
    \ e0()), op,e,mapping,composition,id,p)\n\n#  proc set*[ST:segtree](self: var\
    \ ST, p:int, x:ST.S or ST.F) =\n  proc set*[ST:segtree](self: var ST, p:IndexType,\
    \ x:auto) =\n    var p = self^^p\n    assert p in 0..<self.len\n    p += self.size\n\
    \    when ST.hasLazy:\n      for i in countdown(self.log, 1): self.push(p shr\
    \ i)\n    when ST.hasData:\n      self.d[p] = x\n      for i in 1..self.log: self.update(p\
    \ shr i)\n    else:\n      self.lz[p] = x\n  proc `[]=`*[ST:segtree](self: var\
    \ ST, p:int, x:auto) = self.set(p, x)\n\n  proc get*[ST:segtree](self: var ST,\
    \ p:IndexType):auto =\n    var p = self^^p\n    assert p in 0..<self.len\n   \
    \ p += self.size\n    when ST.hasLazy:\n      for i in countdown(self.log, 1):\
    \ self.push(p shr i)\n    when ST.hasData:\n      return self.d[p]\n    else:\n\
    \      return self.lz[p]\n  proc `[]`*[ST:segtree](self: var ST, p:IndexType):auto\
    \ = self.get(p)\n\n  proc prod*[ST:segtree](self:var ST, p:RangeType):ST.S =\n\
    \    static: assert ST.hasData\n    var (l, r) = self.halfOpenEndpoints(p)\n \
    \   assert 0 <= l and l <= r and r <= self.len\n    if l == r: return ST.calc_e()\n\
    \    l += self.size;r += self.size\n    when ST.hasLazy:\n      for i in countdown(self.log,\
    \ 1):\n        if ((l shr i) shl i) != l: self.push(l shr i)\n        if ((r shr\
    \ i) shl i) != r: self.push(r shr i)\n    var sml, smr = ST.calc_e()\n    while\
    \ l < r:\n      if (l and 1) != 0: sml = ST.calc_op(sml, self.d[l]);l.inc\n  \
    \    if (r and 1) != 0: r.dec;smr = ST.calc_op(self.d[r], smr)\n      l = l shr\
    \ 1;r = r shr 1\n    return ST.calc_op(sml, smr)\n  proc `[]`*[ST:segtree](self:var\
    \ ST, p:RangeType):ST.S = self.prod(p)\n\n  proc all_prod*[ST:segtree](self:ST):auto\
    \ = self.d[1]\n\n  proc getPos[ST:segtree](self: ST, k:int, base:int):Slice[int]\
    \ =\n    static: assert ST.useP\n    let\n      h = fastLog2(k)\n      l = self.size\
    \ shr h\n      base_n = (k - (1 shl h)) * l - base\n    return base_n..<base_n\
    \ + l\n\n  proc apply*[ST:segtree](self: var ST, p:IndexType, f:ST.F) =\n    var\
    \ p = self^^p\n    assert p in 0..<self.len\n    p += self.size\n    when ST.hasLazy:\n\
    \      for i in countdown(self.log, 1): self.push(p shr i)\n    when ST.hasData:\n\
    \      self.d[p] = ST.calc_mapping(when ST.useP: ST.calc_p(f, self.getPos(p, p\
    \ - self.size)) else: f, self.d[p])\n      for i in 1..self.log: self.update(p\
    \ shr i)\n    else:\n      self.lz[p] = when ST.useP: ST.calc_p(f, self.getPos(p,\
    \ p - self.size)) else: f\n  proc apply*[ST:segtree](self: var ST, p:RangeType,\
    \ f:ST.F) =\n    var (l, r) = self.halfOpenEndpoints(p)\n    assert 0 <= l and\
    \ l <= r and r <= self.len\n    if l == r: return\n\n    l += self.size\n    r\
    \ += self.size\n\n    when ST.hasLazy:\n      for i in countdown(self.log, 1):\n\
    \        if ((l shr i) shl i) != l: self.push(l shr i)\n        if ((r shr i)\
    \ shl i) != r: self.push((r - 1) shr i)\n      block:\n        var (l, r) = (l,\
    \ r)\n        while l < r:\n          if (l and 1) != 0: self.all_apply(l, when\
    \ ST.useP: ST.calc_p(f, self.getPos(l, p.a)) else: f);l.inc\n          if (r and\
    \ 1) != 0: r.dec;self.all_apply(r, when ST.useP: ST.calc_p(f, self.getPos(r, p.a))\
    \ else: f)\n          l = l shr 1; r = r shr 1\n\n    when ST.hasData:\n     \
    \ for i in 1..self.log:\n        if ((l shr i) shl i) != l: self.update(l shr\
    \ i)\n        if ((r shr i) shl i) != r: self.update((r - 1) shr i)\n\n#  template\
    \ <bool (*g)(S)> int max_right(int l) {\n#    return max_right(l, [](S x) { return\
    \ g(x); });\n#  }\n  proc max_right*[ST:segtree](self:var ST, l:IndexType, g:(ST.S)->bool):int\
    \ =\n    static: assert ST.hasData\n    var l = self^^l\n    assert l in 0..self.len\n\
    \    assert g(ST.calc_e())\n    if l == self.len: return self.len\n    l += self.size\n\
    \    when ST.hasLazy:\n      for i in countdown(self.log, 1): self.push(l shr\
    \ i)\n    var sm = ST.calc_e()\n    while true:\n      while l mod 2 == 0: l =\
    \ l shr 1\n      if not g(ST.calc_op(sm, self.d[l])):\n        while l < self.size:\n\
    \          when ST.hasLazy:\n            self.push(l)\n          l = (2 * l)\n\
    \          if g(ST.calc_op(sm, self.d[l])):\n            sm = ST.calc_op(sm, self.d[l])\n\
    \            l.inc\n        return l - self.size\n      sm = ST.calc_op(sm, self.d[l])\n\
    \      l.inc\n      if not((l and -l) != l): break\n    return self.len\n\n# \
    \ template <bool (*g)(S)> int min_left(int r) {\n#    return min_left(r, [](S\
    \ x) { return g(x); });\n#  }\n  proc min_left*[ST:segtree](self: var ST, r:IndexType,\
    \ g:(ST.S)->bool):int =\n    var r = self^^r\n    static: assert ST.hasData\n\
    \    assert r in 0..self.len\n    assert g(ST.calc_e())\n    if r == 0: return\
    \ 0\n    r += self.size\n    when ST.hasLazy:\n      for i in countdown(self.log,\
    \ 1): self.push((r - 1) shr i)\n    var sm = ST.calc_e()\n    while true:\n  \
    \    r.dec\n      while r > 1 and r mod 2 == 1: r = r shr 1\n      if not g(ST.calc_op(self.d[r],\
    \ sm)):\n        while r < self.size:\n          when ST.hasLazy:\n          \
    \  self.push(r)\n          r = (2 * r + 1)\n          if g(ST.calc_op(self.d[r],\
    \ sm)):\n            sm = ST.calc_op(self.d[r], sm)\n            r.dec\n     \
    \   return r + 1 - self.size\n      sm = ST.calc_op(self.d[r], sm)\n      if not\
    \ ((r and -r) != r): break\n    return 0\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: atcoder/extra/structure/universal_segtree.nim
  requiredBy:
  - tests/test_extra_universal_segtree_stress.nim
  - tests/test_extra_universal_segtree_stress.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/extra_segtree_test.nim
  - verify/extra/structure/extra_segtree_test.nim
  - verify/extra/structure/extra_lazy_segtree_test.nim
  - verify/extra/structure/extra_lazy_segtree_test.nim
documentation_of: atcoder/extra/structure/universal_segtree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/universal_segtree.nim
- /library/atcoder/extra/structure/universal_segtree.nim.html
title: atcoder/extra/structure/universal_segtree.nim
---
