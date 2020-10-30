when not declared ATCODER_LAZYSEGTREE_HPP:
  const ATCODER_LAZYSEGTREE_HPP* = 1
  
  import std/sugar, std/sequtils, atcoder/internal_bit
  type LazySegtree*[S,F;p:static[tuple]] = object
    n*, size*, log*:int
    d:seq[S]
    lz:seq[F]
#    op:(S, S)->S
#    e:()->S
#    mapping:(F,S)->S
#    composition:(F,F)->F
#    id:()->F
  
  proc update[ST:LazySegtree](self:var ST, k:int) =
    let op = ST.p.op
    self.d[k] = op(self.d[2 * k], self.d[2 * k + 1])
  proc all_apply*[ST:LazySegtree](self:var ST, k:int, f:ST.F) =
    let mapping = ST.p.mapping
    self.d[k] = mapping(f, self.d[k])
    let composition = ST.p.composition
    if k < self.size: self.lz[k] = composition(f, self.lz[k])
  proc push*[ST:LazySegtree](self: var ST, k:int) =
    self.all_apply(2 * k, self.lz[k])
    self.all_apply(2 * k + 1, self.lz[k])
    let id = ST.p.id
    self.lz[k] = id()

  proc init[ST:LazySegtree](self:var ST, v:seq[ST.S]) =
    let
      n = v.len
      log = ceil_pow2(n)
      size = 1 shl log
    let e = ST.p.e
    var d = newSeqWith(2 * size, e())
    for i in 0..<n:
      d[size + i] = v[i]
    let id = ST.p.id
    self = ST(n:n,log:log,size:size,d:d,lz:newSeqWith(size, id()))
    for i in countdown(size - 1, 1):
      self.update(i)
  proc init[ST:LazySegtree](self: var ST, n:int) =
    let e = ST.p.e
    self.init(newSeqWith(n, e()))
  proc init[ST:LazySegtree](self: typedesc[ST], v:seq[ST.S]):auto =
    result = ST()
    result.init(v)
  proc init[ST:LazySegtree](self: typedesc[ST], n:int):auto =
    result = ST()
    result.init(n)

#  LazySegtree(int n) : LazySegtree(std::vector<S>(n, e())) {}
  proc init_LazySegtree*[S, F](v:seq[S], op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F]):auto =
    type ST = LazySegtree[S,F,(op:op,e:e,mapping:mapping, composition:composition, id:id)]
    return ST.init(v)
  proc init_LazySegtree*[S, F](n:int, op:static[(S,S)->S],e:static[()->S],mapping:static[(F,S)->S],composition:static[(F,F)->F],id:static[()->F]):auto =
    type ST = LazySegtree[S,F,(op:op,e:e,mapping:mapping, composition:composition, id:id)]
    let e = e
    return ST.init(newSeqWith(n, e()))


  proc set*[ST:LazySegtree](self: var ST, p:int, x:ST.S) =
    assert p in 0..<self.n
    let p = p + self.size
    for i in countdown(self.log, 1): self.push(p shr i)
    self.d[p] = x
    for i in 1..self.log: self.update(p shr i)

  proc get*[ST:LazySegtree](self: var ST, p:int):ST.S =
    assert p in 0..<self.n
    let p = p + self.size
    for i in countdown(self.log, 1): self.push(p shr i)
    return self.d[p]

  proc prod*[ST:LazySegtree](self:var ST, p:Slice[int]):ST.S =
    var (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    let e = ST.p.e
    if l == r: return e()

    l += self.size
    r += self.size

    for i in countdown(self.log, 1):
      if ((l shr i) shl i) != l: self.push(l shr i)
      if ((r shr i) shl i) != r: self.push(r shr i)

    var sml, smr = e()
    while l < r:
      let op = ST.p.op
      if (l and 1) != 0: sml = op(sml, self.d[l]);l.inc
      if (r and 1) != 0: r.dec;smr = op(self.d[r], smr)
      l = l shr 1
      r = r shr 1
    let op = ST.p.op
    return op(sml, smr)

  proc all_prod*[ST:LazySegtree](self:ST):auto = self.d[1]

  proc apply*[ST:LazySegtree](self: var ST, p:int, f:ST.F) =
    assert p in 0..<self.n
    let p = p + self.size
    for i in countdown(self.log, 1): self.push(p shr i)
    let mapping = ST.p.mapping
    self.d[p] = mapping(f, self.d[p])
    for i in 1..self.log: self.update(p shr i)
  proc apply*[ST:LazySegtree](self: var ST, p:Slice[int], f:ST.F) =
    var (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    if l == r: return

    l += self.size
    r += self.size

    for i in countdown(self.log, 1):
      if ((l shr i) shl i) != l: self.push(l shr i)
      if ((r shr i) shl i) != r: self.push((r - 1) shr i)

    block:
      var (l, r) = (l, r)
      while l < r:
        if (l and 1) != 0: self.all_apply(l, f);l.inc
        if (r and 1) != 0: r.dec;self.all_apply(r, f)
        l = l shr 1
        r = r shr 1

    for i in 1..self.log:
      if ((l shr i) shl i) != l: self.update(l shr i)
      if ((r shr i) shl i) != r: self.update((r - 1) shr i)

#  template <bool (*g)(S)> int max_right(int l) {
#    return max_right(l, [](S x) { return g(x); });
#  }
  proc max_right*[ST:LazySegtree](self:var ST, l:int, g:(ST.S)->bool):int =
    assert l in 0..self.n
    let e = ST.p.e
    assert g(e())
    if l == self.n: return self.n
    var l = l + self.size
    for i in countdown(self.log, 1): self.push(l shr i)
    var sm = e()
    while true:
      while l mod 2 == 0: l = l shr 1
      let op = ST.p.op
      if not g(op(sm, self.d[l])):
        while l < self.size:
          self.push(l)
          l = (2 * l)
          let op = ST.p.op
          if g(op(sm, self.d[l])):
            let op = ST.p.op
            sm = op(sm, self.d[l])
            l.inc
        return l - self.size
      sm = op(sm, self.d[l])
      l.inc
      if not((l and -l) != l): break
    return self.n

#  template <bool (*g)(S)> int min_left(int r) {
#    return min_left(r, [](S x) { return g(x); });
#  }
  proc min_left*[ST:LazySegtree](self: var ST, r:int, g:(ST.S)->bool):int =
    assert r in 0..self.n
    let e = ST.p.e
    assert(g(e()))
    if r == 0: return 0
    var r = r + self.size
    for i in countdown(self.log, 1): self.push((r - 1) shr i)
    var sm = e()
    while true:
      r.dec
      while r > 1 and r mod 2 == 1: r = r shr 1
      let op = ST.p.op
      if not g(op(self.d[r], sm)):
        while r < self.size:
          self.push(r)
          r = (2 * r + 1)
          let op = ST.p.op
          if g(op(self.d[r], sm)):
            let op = ST.p.op
            sm = op(self.d[r], sm)
            r.dec
        return r + 1 - self.size
      sm = op(self.d[r], sm)
      if not ((r and -r) != r): break
    return 0
