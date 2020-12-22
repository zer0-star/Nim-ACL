when not declared ATCODER_SEGTREE_HPP:
  const ATCODER_SEGTREE_HPP* = 1
  import atcoder/internal_bit
  import std/sugar, std/sequtils, std/algorithm

  type SegTree*[S; p:static[tuple]] = object
    n, size, log:int
    d: seq[S]

  template calc_op[ST:SegTree](self:typedesc[ST], a, b:ST.S):auto =
    block:
      let op = ST.p.op
      op(a, b)
  template calc_e[ST:SegTree](self:typedesc[ST]):auto =
    block:
      let e = ST.p.e
      e()
  proc update[ST:SegTree](self: var ST, k:int) {.inline.} =
    self.d[k] = ST.calc_op(self.d[2 * k], self.d[2 * k + 1])

  proc init*[ST:SegTree](self: var ST, v:seq[ST.S]) =
    let
      n = v.len
      log = ceil_pow2(n)
      size = 1 shl log
    (self.n, self.size, self.log) = (n, size, log)
    if self.d.len < 2 * size:
      self.d = newSeqWith(2 * size, ST.calc_e())
    else:
      self.d.fill(0, 2 * size - 1, ST.calc_e())
    for i in 0..<n: self.d[size + i] = v[i]
    for i in countdown(size - 1, 1): self.update(i)
  proc init*[ST:SegTree](self: var ST, n:int) =
    self.init(newSeqWith(n, ST.calc_e()))
  proc init*[ST:SegTree](self: typedesc[ST], v:seq[ST.S]):auto =
    result = ST()
    result.init(v)
  proc init*[ST:SegTree](self: typedesc[ST], n:int):auto =
    self.init(newSeqWith(n, ST.calc_e()))
  template getType*(ST:typedesc[SegTree], S:typedesc, op0:static[(S,S)->S], e0:static[()->S]):typedesc[SegTree] =
    SegTree[S, (op:op0, e:e0)]
  template SegTreeType*(S:typedesc, op0:static[(S,S)->S], e0:static[()->S]):typedesc[SegTree] =
    SegTree[S, (op:op0, e:e0)]
  proc initSegTree*[S](v:seq[S], op:static[(S,S)->S], e:static[()->S]):auto =
    SegTreeType(S, op, e).init(v)
  proc initSegTree*[S](n:int, op:static[(S,S)->S], e:static[()->S]):auto =
    result = SegTreeType(S, op, e)()
    result.init(newSeqWith(n, result.type.calc_e()))

  proc set*[ST:SegTree](self:var ST, p:int, x:ST.S) {.inline.} =
    assert p in 0..<self.n
    var p = p + self.size
    self.d[p] = x
    for i in 1..self.log: self.update(p shr i)

  proc get*[ST:SegTree](self:ST, p:int):ST.S {.inline.} =
    assert p in 0..<self.n
    return self.d[p + self.size]

  proc prod*[ST:SegTree](self:ST, p:Slice[int]):ST.S {.inline.} =
    var (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    var
      sml, smr = ST.calc_e()
    l += self.size; r += self.size
    while l < r:
      if (l and 1) != 0: sml = ST.calc_op(sml, self.d[l]);l.inc
      if (r and 1) != 0: r.dec;smr = ST.calc_op(self.d[r], smr)
      l = l shr 1
      r = r shr 1
    return ST.calc_op(sml, smr)
  proc `[]`*[ST:SegTree](self:ST, p:int):auto {.inline.} = self.get(p)
  proc `[]`*[ST:SegTree](self:ST, p:Slice[int]):auto {.inline.} = self.prod(p)
  proc `[]=`*[ST:SegTree](self:var ST, p:int, x:ST.S) {.inline.} = self.set(p, x)

  proc all_prod*[ST:SegTree](self:ST):ST.S = self.d[1]

#  proc max_right*[ST:SegTree, f:static[proc(s:ST.S):bool]](self:ST, l:int):auto = self.max_right(l, f)
  proc max_right*[ST:SegTree](self:ST, l:int, f:proc(s:ST.S):bool):int =
    assert l in 0..self.n
    assert f(ST.calc_e())
    if l == self.n: return self.n
    var
      l = l + self.size
      sm = ST.calc_e()
    while true:
      while l mod 2 == 0: l = l shr 1
      if not f(ST.calc_op(sm, self.d[l])):
        while l < self.size:
          l = (2 * l)
          if f(ST.calc_op(sm, self.d[l])):
            sm = ST.calc_op(sm, self.d[l])
            l.inc
        return l - self.size
      sm = ST.calc_op(sm, self.d[l])
      l.inc
      if not ((l and -l) != l): break
    return self.n

#  proc min_left*[ST:SegTree, f:static[proc(s:ST.S):bool]](self:ST, r:int):auto = self.min_left(r, f)
  proc min_left*[ST:SegTree](self:ST, r:int, f:proc(s:ST.S):bool):int =
    assert r in 0..self.n
    assert f(ST.calc_e())
    if r == 0: return 0
    var
      r = r + self.size
      sm = ST.calc_e()
    while true:
      r.dec
      while r > 1 and (r mod 2 != 0): r = r shr 1
      if not f(ST.calc_op(self.d[r], sm)):
        while r < self.size:
          r = (2 * r + 1)
          if f(ST.calc_op(self.d[r], sm)):
            sm = ST.calc_op(self.d[r], sm)
            r.dec
        return r + 1 - self.size
      sm = ST.calc_op(self.d[r], sm)
      if not ((r and -r) != r): break
    return 0
