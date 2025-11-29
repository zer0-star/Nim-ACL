when not declared ATCODER_LAZYSEGTREE_HPP:
  const ATCODER_LAZYSEGTREE_HPP* = 1
  
  import std/sugar, std/sequtils, std/bitops, std/options
  import atcoder/internal_bit, atcoder/rangeutils
  type
    USEP_TRUE* = object
    USEP_FALSE* = object
    IS_BEATS_TRUE* = object
    IS_BEATS_FALSE* = object

  type UniversalSegTree[S,F,useP, isBeats;p:static[tuple]] = object
    len, size, log:int
    when S isnot void:
      d:seq[S]
    when F isnot void:
      lz:seq[F]
      when useP is USEP_TRUE:
        p:(F,Slice[int])->F
  proc hasData(ST:typedesc[UniversalSegTree]):bool {.compileTime.} = ST.S isnot void
  proc hasLazy(ST:typedesc[UniversalSegTree]):bool {.compileTime.} = ST.F isnot void
#  proc hasP(ST:typedesc[UniversalSegTree]):bool {.compileTime.} = ST.useP

  template calc_op*[ST:UniversalSegTree](self:ST or typedesc[ST], a, b:ST.S):auto =
    ST.p.op(a, b)
  template calc_e*[ST:UniversalSegTree](self:ST or typedesc[ST]):auto =
    ST.p.e()
  template calc_mapping*[ST:UniversalSegTree](self:ST or typedesc[ST], a:ST.F, b:ST.S):auto =
    ST.p.mapping(a, b)
  template calc_composition*[ST:UniversalSegTree](self:ST or typedesc[ST], a, b:ST.F):auto =
    ST.p.composition(a, b)
  template calc_id*[ST:UniversalSegTree](self:ST or typedesc[ST]):auto =
    ST.p.id()
  template calc_p*[ST:UniversalSegTree](self:ST or typedesc[ST], a:ST.F, s:Slice[int]):auto =
    ST.p.p(a, s)

  proc update*[ST:UniversalSegTree](self:var ST, k:int) =
    self.d[k] = ST.calc_op(self.d[2 * k], self.d[2 * k + 1])

  proc push*[ST:UniversalSegTree](self: var ST, k:int)
  proc all_apply*[ST:UniversalSegTree](self:var ST, k:int, f:ST.F) =
    static: assert ST.hasLazy
    when ST.hasData:
      when ST.isBeats is IS_BEATS_TRUE:
        if k < self.size:
          self.lz[k] = ST.calc_composition(f, self.lz[k])
        let c = ST.calc_mapping(f, self.d[k])
        if c.isNone:
          assert k < self.size
          self.push(k); self.update(k)
        else:
          self.d[k] = c.get
      else:
        if k < self.size:
          self.lz[k] = ST.calc_composition(f, self.lz[k])
        self.d[k] = ST.calc_mapping(f, self.d[k])
    else:
      self.lz[k] = ST.calc_composition(f, self.lz[k])

  proc push*[ST:UniversalSegTree](self: var ST, k:int) =
    static: assert ST.hasLazy
    when ST.useP is USEP_TRUE:
      let m = self.size shr (k.fastLog2 + 1)
    self.all_apply(2 * k    , when ST.useP is USEP_TRUE: ST.calc_p(self.lz[k], 0 ..< m    ) else: self.lz[k])
    self.all_apply(2 * k + 1, when ST.useP is USEP_TRUE: ST.calc_p(self.lz[k], m ..< m + m) else: self.lz[k])
    self.lz[k] = ST.calc_id()

  proc init*[ST:UniversalSegTree](self: var ST, v:int or seq[ST.S] or seq[ST.F]) =
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
  template universalSegTreeType[S, F, useP, isBeats](op0, e0, mapping0, composition0, id0, p0:untyped):typedesc[UniversalSegTree] =
    UniversalSegTree[S, F, useP, isBeats, 
      (op:op0, e:e0, mapping:mapping0,composition:composition0,id:id0,p:p0)]

  template initSegtree*[S](v:int or seq[S], op, e:untyped):auto =
    when v is int:
      let e0 = e
      initSegtree(newSeqWith(v, e0()), op, e)
    else:
      proc op0(a, b:S):S {.gensym inline.} = op(a, b)
      proc e0():S {.gensym inline.} = e()
      var a: universalSegTreeType[S, void, USEP_FALSE, IS_BEATS_FALSE](op0, e0, nil, nil, nil, nil)
      a.init(v)
      a
  template initDualSegtree*[F](v:int or seq[F], composition, id:untyped):auto =
    when v is int:
      let id0 = id
      initDualSegtree[F](newSeqWith(v, id0()), composition, id)
    else:
      proc composition0(f1, f2: F):F {.gensym inline.} = composition(f1, f2)
      proc id0():F {.gensym inline.} = id()
      var a: universalSegTreeType[void,F,USEP_FALSE, IS_BEATS_FALSE](nil, nil, nil, composition0, id0, nil)
      a.init(v)
      a
  template initLazySegtree*[S,F](v:int or seq[S], op,e,mapping,composition,id:untyped):auto =
    when v is int:
      let e0 = e
      initLazySegtree[S,F](newSeqWith(v, e0()), op,e,mapping,composition,id)
    else:
      proc op0(a, b:S):S {.gensym inline.} = op(a, b)
      proc e0():S {.gensym inline.} = e()
      proc mapping0(f:F, s:S):S {.gensym inline.} = mapping(f, s)
      proc composition0(f1, f2:F):F {.gensym inline.} = composition(f1, f2)
      proc id0():F {.gensym inline.} = id()
      var a: universalSegTreeType[S, F, USEP_FALSE, IS_BEATS_FALSE](op0, e0, mapping0, composition0, id0, nil)
      a.init(v)
      a
  template initLazySegtree_with_p*[S,F](v:int or seq[S], op,e,mapping,composition,id,p:untyped):auto =
    when v is int:
      let e0 = e
      initLazySegtree[S,F](newSeqWith(n, e0()), op,e,mapping,composition,id,p)
    else:
      var a:universalSegTreeType[S, F, USEP_TRUE, IS_BEATS_FALSE](op, e, mapping, composition, id, p)
      a.init(v)
      a
  template initSegTreeBeats*[S,F](v:int or seq[S], op,e,mapping,composition,id:untyped):auto =
    when v is int:
      let e0 = e
      initSegtreeBeats[S,F](newSeqWith(v, e0()), op,e,mapping,composition,id)
    else:
      proc op0(a, b:S):S {.gensym inline.} = op(a, b)
      proc e0():S {.gensym inline.} = e()
      proc mapping0(f:F, s:S):Option[S] {.gensym inline.} = mapping(f, s)
      proc composition0(f1, f2:F):F {.gensym inline.} = composition(f1, f2)
      proc id0():F {.gensym inline.} = id()
      var a: universalSegTreeType[S, F, USEP_FALSE, IS_BEATS_TRUE](op0, e0, mapping0, composition0, id0, nil)
      a.init(v)
      a



  proc set*[ST:UniversalSegTree](self: var ST, p:IndexType, x:auto) =
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
  proc `[]=`*[ST:UniversalSegTree](self: var ST, p:int, x:auto) = self.set(p, x)

  proc get*[ST:UniversalSegTree](self: var ST, p:IndexType):auto =
    var p = self^^p
    assert p in 0..<self.len
    p += self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(p shr i)
    when ST.hasData:
      return self.d[p]
    else:
      return self.lz[p]
  proc `[]`*[ST:UniversalSegTree](self: var ST, p:IndexType):auto = self.get(p)

  proc prod*[ST:UniversalSegTree](self:var ST, p:RangeType):ST.S =
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
  proc `[]`*[ST:UniversalSegTree](self:var ST, p:RangeType):ST.S = self.prod(p)

  proc all_prod*[ST:UniversalSegTree](self:ST):auto = self.d[1]

  proc getPos[ST:UniversalSegTree](self: ST, k:int, base:int):Slice[int] =
    static: assert ST.useP is USEP_TRUE
    let
      h = fastLog2(k)
      l = self.size shr h
      base_n = (k - (1 shl h)) * l - base
    return base_n..<base_n + l

  proc apply*[ST:UniversalSegTree](self: var ST, p:IndexType, f:ST.F) =
    var p = self^^p
    assert p in 0..<self.len
    p += self.size
    when ST.hasLazy:
      for i in countdown(self.log, 1): self.push(p shr i)
    when ST.hasData:
      self.d[p] = ST.calc_mapping(when ST.useP is USEP_TRUE: ST.calc_p(f, self.getPos(p, p - self.size)) else: f, self.d[p])
      for i in 1..self.log: self.update(p shr i)
    else:
      self.lz[p] = when ST.useP is USEP_TRUE: ST.calc_p(f, self.getPos(p, p - self.size)) else: f
  proc apply*[ST:UniversalSegTree](self: var ST, p:RangeType, f:ST.F) =
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
          if (l and 1) != 0: self.all_apply(l, when ST.useP is USEP_TRUE: ST.calc_p(f, self.getPos(l, p.a)) else: f);l.inc
          if (r and 1) != 0: r.dec;self.all_apply(r, when ST.useP is USEP_TRUE: ST.calc_p(f, self.getPos(r, p.a)) else: f)
          l = l shr 1; r = r shr 1

    when ST.hasData:
      for i in 1..self.log:
        if ((l shr i) shl i) != l: self.update(l shr i)
        if ((r shr i) shl i) != r: self.update((r - 1) shr i)

  proc max_right*[ST:UniversalSegTree](self:var ST, l:IndexType, g:(ST.S)->bool):int =
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

  proc min_left*[ST:UniversalSegTree](self: var ST, r:IndexType, g:(ST.S)->bool):int =
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
