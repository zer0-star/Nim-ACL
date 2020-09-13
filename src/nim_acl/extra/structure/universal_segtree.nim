when not declared ATCODER_LAZYSEGTREE_HPP:
  const ATCODER_LAZYSEGTREE_HPP* = 1
  
  import sugar, sequtils, bitops
  import src/nim_acl/internal_bit
  type segtree[S,F,useP] = object
    n, size, log:int
    when S isnot void:
      d:seq[S]
      op:(S, S)->S
      e:()->S
    when F isnot void:
      lz:seq[F]
      composition:(F,F)->F
      id:()->F
      when S isnot void:
        mapping:(F,S)->S
      when useP isnot void:
        p:(F,Slice[int])->F
  proc hasData(ST:typedesc[segtree]):bool {.compileTime.} = ST.S isnot void
  proc hasLazy(ST:typedesc[segtree]):bool {.compileTime.} = ST.F isnot void
  proc hasP(ST:typedesc[segtree]):bool {.compileTime.} = ST.useP isnot void
  
  proc update*[ST:segtree](self:var ST, k:int) =
    self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])
  proc all_apply*[ST:segtree](self:var ST, k:int, f:ST.F) =
    static: assert ST.hasLazy
    when ST.hasData:
      self.d[k] = self.mapping(f, self.d[k])
    if k < self.size: self.lz[k] = self.composition(f, self.lz[k])

  proc push*[ST:segtree](self: var ST, k:int) =
    static: assert ST.hasLazy
    when ST.hasP:
      let m = self.size shr (k.fastLog2 + 1)
    self.all_apply(2 * k    , when ST.hasP: self.p(self.lz[k], 0..<m    ) else: self.lz[k])
    self.all_apply(2 * k + 1, when ST.hasP: self.p(self.lz[k], m..<m + m) else: self.lz[k])
    self.lz[k] = self.id()

#  segtree(int n) : segtree(std::vector<S>(n, e())) {}
  proc init*[ST:segtree](self: var ST, v:int or seq[ST.S] or seq[ST.F]) =
    when v is int:
      when ST.hasData:
        self.init(newSeqWith(v, self.e()))
      else:
        self.init(newSeqWith(v, self.id()))
    else:
      let
        n = v.len
        log = ceil_pow2(n)
        size = 1 shl log
      self.n = n;self.log = log;self.size = size
      when ST.hasLazy:
        self.lz = newSeqWith(size, self.id())
      when ST.hasData:
        self.d = newSeqWith(2 * size, self.e())
        for i in 0..<n: self.d[size + i] = v[i]
        for i in countdown(size - 1, 1): self.update(i)
      else:
        for i in 0..<n: self.lz[size + i] = v[i]
        
  proc init_segtree*[S](v:int or seq[S], op:(S,S)->S, e:()->S):auto =
    result = segtree[S,void,void](op:op,e:e)
    result.init(v)
  proc init_dual_segtree*[F](v:int or seq[F], composition:(F,F)->F, id:()->F):auto =
    result = segtree[void,F,void](composition:composition,id:id)
    result.init(v)
  proc init_lazy_segtree*[S,F](v:int or seq[S], op:(S,S)->S,e:()->S,mapping:(F,S)->S,composition:(F,F)->F,id:()->F):auto =
    result = segtree[S,F,void](op:op,e:e,mapping:mapping,composition:composition,id:id)
    result.init(v)
  proc init_lazy_segtree*[S,F](v:int or seq[S], op:(S,S)->S,e:()->S,mapping:(F,S)->S,composition:(F,F)->F,id:()->F, p:(F,Slice[int])->F):auto =
    result = segtree[S,F,int](op:op,e:e,mapping:mapping,composition:composition,id:id, p:p)
    result.init(v)

  proc set*[ST:segtree](self: var ST, p:int, x:ST.S or ST.F) =
    assert p in 0..<self.n
    let p = p + self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(p shr i)
    when ST.hasData:
      self.d[p] = x
      for i in 1..self.log: self.update(p shr i)
    else:
      self.lz[p] = x

  proc get*[ST:segtree](self: var ST, p:int):auto =
    assert p in 0..<self.n
    let p = p + self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(p shr i)
    when ST.hasData:
      return self.d[p]
    else:
      return self.lz[p]

  proc prod*[ST:segtree](self:var ST, p:Slice[int]):ST.S =
    static: assert ST.hasData
    var (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    if l == r: return self.e()
    l += self.size;r += self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1):
        if ((l shr i) shl i) != l: self.push(l shr i)
        if ((r shr i) shl i) != r: self.push(r shr i)
    var sml, smr = self.e()
    while l < r:
      if (l and 1) != 0: sml = self.op(sml, self.d[l]);l.inc
      if (r and 1) != 0: r.dec;smr = self.op(self.d[r], smr)
      l = l shr 1;r = r shr 1
    return self.op(sml, smr)

  proc all_prod*[ST:segtree](self:ST):auto = self.d[1]

  proc getPos[ST:segtree](self: ST, k:int, base:int):Slice[int] =
    static: assert ST.hasP
    let
      h = fastLog2(k)
      l = self.size shr h
      base_n = (k - (1 shl h)) * l - base
    return base_n..<base_n + l

  proc apply*[ST:segtree](self: var ST, p:int, f:ST.F) =
    assert p in 0..<self.n
    let p = p + self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(p shr i)
    self.d[p] = self.mapping(when ST.hasP: self.p(f, self.getPos(p, p - self.size)) else: f, self.d[p])
    when ST.hasData:
      for i in 1..self.log: self.update(p shr i)
  proc apply*[ST:segtree](self: var ST, p:Slice[int], f:ST.F) =
    var (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
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
          if (l and 1) != 0: self.all_apply(l, when ST.hasP: self.p(f, self.getPos(l, p.a)) else: f);l.inc
          if (r and 1) != 0: r.dec;self.all_apply(r, when ST.hasP: self.p(f, self.getPos(r, p.a)) else: f)
          l = l shr 1; r = r shr 1

    when ST.hasData:
      for i in 1..self.log:
        if ((l shr i) shl i) != l: self.update(l shr i)
        if ((r shr i) shl i) != r: self.update((r - 1) shr i)

#  template <bool (*g)(S)> int max_right(int l) {
#    return max_right(l, [](S x) { return g(x); });
#  }
  proc max_right*[ST:segtree](self:var ST, l:int, g:(ST.S)->bool):int =
    static: assert ST.hasData
    assert l in 0..self.n
    assert g(e())
    if l == self.n: return self.n
    var l = l + self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(l shr i)
    var sm = self.e()
    while true:
      while l mod 2 == 0: l = l shr 1
      if not g(self.op(sm, self.d[l])):
        while l < self.size:
          when ST.hasLazy:
            self.push(l)
          l = (2 * l)
          if g(self.op(sm, self.d[l])):
            sm = self.op(sm, self.d[l])
            l.inc
        return l - self.size
      sm = self.op(sm, self.d[l])
      l.inc
      if not((l & -l) != l): break
    return self.n

#  template <bool (*g)(S)> int min_left(int r) {
#    return min_left(r, [](S x) { return g(x); });
#  }
  proc min_left*[ST:segtree](self: var ST, r:int, g:(ST.S)->bool):int =
    static: assert ST.hasData
    assert r in 0..self.n
    assert g(self.e())
    if r == 0: return 0
    var r = r + self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push((r - 1) shr i)
    var sm = self.e()
    while true:
      r.dec
      while r > 1 and r mod 2 == 1: r = r shr 1
      if not g(self.op(self.d[r], sm)):
        while r < self.size:
          when ST.hasLazy:
            self.push(r)
          r = (2 * r + 1)
          if g(self.op(self.d[r], sm)):
            sm = self.op(self.d[r], sm)
            r.dec
        return r + 1 - self.size
      sm = self.op(self.d[r], sm)
      if not ((r & -r) != r): break
    return 0
