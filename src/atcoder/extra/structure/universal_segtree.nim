when not declared ATCODER_LAZYSEGTREE_HPP:
  const ATCODER_LAZYSEGTREE_HPP* = 1
  
  import std/sugar, std/sequtils, std/bitops
  import atcoder/internal_bit, atcoder/rangeutils
  type segtree[S,F;useP:static[bool];p:static[tuple]] = object
    len, size, log:int
    when S isnot void:
      d:seq[S]
    when F isnot void:
      lz:seq[F]
      when useP:
        p:(F,Slice[int])->F
  proc hasData(ST:typedesc[segtree]):bool {.compileTime.} = ST.S isnot void
  proc hasLazy(ST:typedesc[segtree]):bool {.compileTime.} = ST.F isnot void
#  proc hasP(ST:typedesc[segtree]):bool {.compileTime.} = ST.useP

  template calc_op[ST:segtree](self:typedesc[ST], a, b:ST.S):auto =
    block:
      let op = ST.p.op
      op(a, b)
  template calc_e[ST:segtree](self:typedesc[ST]):auto =
    block:
      let e = ST.p.e
      e()
  template calc_mapping[ST:segtree](self:typedesc[ST], a:ST.F, b:ST.S):auto =
    block:
      let mapping = ST.p.mapping
      mapping(a, b)
  template calc_composition[ST:segtree](self:typedesc[ST], a, b:ST.F):auto =
    block:
      let composition = ST.p.composition
      composition(a, b)
  template calc_id[ST:segtree](self:typedesc[ST]):auto =
    block:
      let id = ST.p.id
      id()
  template calc_p[ST:segtree](self:typedesc[ST], a:ST.F, s:Slice[int]):auto =
    block:
      let p = ST.p.p
      p(a, s)

  proc update*[ST:segtree](self:var ST, k:int) =
    self.d[k] = ST.calc_op(self.d[2 * k], self.d[2 * k + 1])
  proc all_apply*[ST:segtree](self:var ST, k:int, f:ST.F) =
    static: assert ST.hasLazy
    when ST.hasData:
      self.d[k] = ST.calc_mapping(f, self.d[k])
      if k < self.size: self.lz[k] = ST.calc_composition(f, self.lz[k])
    else:
      self.lz[k] = ST.calc_composition(f, self.lz[k])

  proc push*[ST:segtree](self: var ST, k:int) =
    static: assert ST.hasLazy
    when ST.useP:
      let m = self.size shr (k.fastLog2 + 1)
    self.all_apply(2 * k    , when ST.useP: ST.calc_p(self.lz[k], 0..<m    ) else: self.lz[k])
    self.all_apply(2 * k + 1, when ST.useP: ST.calc_p(self.lz[k], m..<m + m) else: self.lz[k])
    self.lz[k] = ST.calc_id()

#  segtree(int n) : segtree(std::vector<S>(n, e())) {}
  proc init*[ST:segtree](self: var ST, v:int or seq[ST.S] or seq[ST.F]) =
    when v is int:
      when ST.hasData:
        self.init(newSeqWith(v, ST.calc_e()))
      else:
        self.init(newSeqWith(v, ST.calc_id()))
    else:
      let
        n = v.len
        log = ceil_pow2(n)
        size = 1 shl log
      self.len = n;self.log = log;self.size = size
      when ST.hasLazy:
        when ST.hasData:
          self.lz = newSeqWith(size, ST.calc_id())
        else:
          self.lz = newSeqWith(size * 2, ST.calc_id())
      when ST.hasData:
        self.d = newSeqWith(2 * size, ST.calc_e())
        for i in 0..<n: self.d[size + i] = v[i]
        for i in countdown(size - 1, 1): self.update(i)
      else:
        for i in 0..<n: self.lz[size + i] = v[i]

  proc init_segtree*[S](v:seq[S], op:static[(S,S)->S], e:static[()->S]):auto =
    result = segtree[S,void,false, (op:op,e:e)]()
    result.init(v)
  proc init_segtree*[S](n:int, op:static[(S,S)->S], e:static[()->S]):auto =
    let e0 = e
    var v = newSeqWith(n, e0())
    return init_segtree(v, op, e)
  proc init_dual_segtree*[F](v:seq[F], composition:static[(F,F)->F], id:static[()->F]):auto =
    result = segtree[void,F,false, (composition:composition,id:id)]()
    result.init(v)
  proc init_dual_segtree*[F](n:int, composition:static[(F,F)->F], id:static[()->F]):auto =
    let id0 = id
    init_dual_segtree[F](newSeqWith(n, id0()), composition, id)
  proc init_lazy_segtree*[S,F](v:seq[S], op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F]):auto =
    result = segtree[S,F,false,(op:op,e:e,mapping:mapping,composition:composition,id:id)]()
    result.init(v)
  proc init_lazy_segtree*[S,F](n:int, op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F]):auto =
    let e0 = e
    init_lazy_segtree[S,F](newSeqWith(n, e0()), op,e,mapping,composition,id)
  proc init_lazy_segtree*[S,F](v:seq[S], op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F], p:static[(F,Slice[int])->F]):auto =
    result = segtree[S,F,true,(op:op,e:e,mapping:mapping,composition:composition,id:id, p:p)]()
    result.init(v)
  proc init_lazy_segtree*[S,F](n:int, op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F], p:static[(F,Slice[int])->F]):auto =
    let e0 = e
    init_lazy_segtree[S,F](newSeqWith(n, e0()), op,e,mapping,composition,id,p)

#  proc set*[ST:segtree](self: var ST, p:int, x:ST.S or ST.F) =
  proc set*[ST:segtree](self: var ST, p:IndexType, x:auto) =
    var p = self^^p
    assert p in 0..<self.len
    p += self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(p shr i)
    when ST.hasData:
      self.d[p] = x
      for i in 1..self.log: self.update(p shr i)
    else:
      self.lz[p] = x
  proc `[]=`*[ST:segtree](self: var ST, p:int, x:auto) = self.set(p, x)

  proc get*[ST:segtree](self: var ST, p:IndexType):auto =
    var p = self^^p
    assert p in 0..<self.len
    p += self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(p shr i)
    when ST.hasData:
      return self.d[p]
    else:
      return self.lz[p]
  proc `[]`*[ST:segtree](self: var ST, p:IndexType):auto = self.get(p)

  proc prod*[ST:segtree](self:var ST, p:RangeType):ST.S =
    static: assert ST.hasData
    var (l, r) = self.halfOpenEndpoints(p)
    assert 0 <= l and l <= r and r <= self.len
    if l == r: return ST.calc_e()
    l += self.size;r += self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1):
        if ((l shr i) shl i) != l: self.push(l shr i)
        if ((r shr i) shl i) != r: self.push(r shr i)
    var sml, smr = ST.calc_e()
    while l < r:
      if (l and 1) != 0: sml = ST.calc_op(sml, self.d[l]);l.inc
      if (r and 1) != 0: r.dec;smr = ST.calc_op(self.d[r], smr)
      l = l shr 1;r = r shr 1
    return ST.calc_op(sml, smr)
  proc `[]`*[ST:segtree](self:var ST, p:RangeType):ST.S = self.prod(p)

  proc all_prod*[ST:segtree](self:ST):auto = self.d[1]

  proc getPos[ST:segtree](self: ST, k:int, base:int):Slice[int] =
    static: assert ST.useP
    let
      h = fastLog2(k)
      l = self.size shr h
      base_n = (k - (1 shl h)) * l - base
    return base_n..<base_n + l

  proc apply*[ST:segtree](self: var ST, p:IndexType, f:ST.F) =
    var p = self^^p
    assert p in 0..<self.len
    p += self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(p shr i)
    when ST.hasData:
      self.d[p] = ST.calc_mapping(when ST.useP: ST.calc_p(f, self.getPos(p, p - self.size)) else: f, self.d[p])
      for i in 1..self.log: self.update(p shr i)
    else:
      self.lz[p] = when ST.useP: ST.calc_p(f, self.getPos(p, p - self.size)) else: f
  proc apply*[ST:segtree](self: var ST, p:RangeType, f:ST.F) =
    var (l, r) = self.halfOpenEndpoints(p)
    assert 0 <= l and l <= r and r <= self.len
    if l == r: return

    l += self.size
    r += self.size

    when ST.hasLazy:
      for i in countdown(self.log, 1):
        if ((l shr i) shl i) != l: self.push(l shr i)
        if ((r shr i) shl i) != r: self.push((r - 1) shr i)
      block:
        var (l, r) = (l, r)
        while l < r:
          if (l and 1) != 0: self.all_apply(l, when ST.useP: ST.calc_p(f, self.getPos(l, p.a)) else: f);l.inc
          if (r and 1) != 0: r.dec;self.all_apply(r, when ST.useP: ST.calc_p(f, self.getPos(r, p.a)) else: f)
          l = l shr 1; r = r shr 1

    when ST.hasData:
      for i in 1..self.log:
        if ((l shr i) shl i) != l: self.update(l shr i)
        if ((r shr i) shl i) != r: self.update((r - 1) shr i)

#  template <bool (*g)(S)> int max_right(int l) {
#    return max_right(l, [](S x) { return g(x); });
#  }
  proc max_right*[ST:segtree](self:var ST, l:IndexType, g:(ST.S)->bool):int =
    static: assert ST.hasData
    var l = self^^l
    assert l in 0..self.len
    assert g(ST.calc_e())
    if l == self.len: return self.len
    l += self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(l shr i)
    var sm = ST.calc_e()
    while true:
      while l mod 2 == 0: l = l shr 1
      if not g(ST.calc_op(sm, self.d[l])):
        while l < self.size:
          when ST.hasLazy:
            self.push(l)
          l = (2 * l)
          if g(ST.calc_op(sm, self.d[l])):
            sm = ST.calc_op(sm, self.d[l])
            l.inc
        return l - self.size
      sm = ST.calc_op(sm, self.d[l])
      l.inc
      if not((l and -l) != l): break
    return self.len

#  template <bool (*g)(S)> int min_left(int r) {
#    return min_left(r, [](S x) { return g(x); });
#  }
  proc min_left*[ST:segtree](self: var ST, r:IndexType, g:(ST.S)->bool):int =
    var r = self^^r
    static: assert ST.hasData
    assert r in 0..self.len
    assert g(ST.calc_e())
    if r == 0: return 0
    r += self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push((r - 1) shr i)
    var sm = ST.calc_e()
    while true:
      r.dec
      while r > 1 and r mod 2 == 1: r = r shr 1
      if not g(ST.calc_op(self.d[r], sm)):
        while r < self.size:
          when ST.hasLazy:
            self.push(r)
          r = (2 * r + 1)
          if g(ST.calc_op(self.d[r], sm)):
            sm = ST.calc_op(self.d[r], sm)
            r.dec
        return r + 1 - self.size
      sm = ST.calc_op(self.d[r], sm)
      if not ((r and -r) != r): break
    return 0
