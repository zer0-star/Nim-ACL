#{.hints:off checks:off assertions:on checks:off}
## header {{{
#import algorithm, sequtils, tables, macros, math, sets, strutils, streams, strformat, sugar
#when defined(MYDEBUG):
#  import header
#
#proc scanf(formatstr: cstring){.header: "<stdio.h>", varargs.}
#proc getchar(): char {.header: "<stdio.h>", varargs.}
#proc nextInt(base:int = 0): int =
#  scanf("%lld",addr result)
#  result -= base
#proc nextFloat(): float = scanf("%lf",addr result)
#proc nextString(): string =
#  var get = false;result = ""
#  while true:
#    var c = getchar()
#    if int(c) > int(' '): get = true;result.add(c)
#    elif get: break
#template `max=`*(x,y:typed):void = x = max(x,y)
#template `min=`*(x,y:typed):void = x = min(x,y)
#template inf(T): untyped = 
#  when T is SomeFloat: T(Inf)
#  elif T is SomeInteger: ((T(1) shl T(sizeof(T)*8-2)) - (T(1) shl T(sizeof(T)*4-1)))
#  else: assert(false)
#
## }}}
#
when not defined ATCODER_SEGTREE_HPP:
  const ATCODER_SEGTREE_HPP = 1
  import internal_bit
  import sugar, sequtils

  type segtree[S] = object
    n, size, log:int
    d:seq[int]
    op:(S, S)->S
    e:()->S

  proc update[ST:segtree](self: var ST, k:int) =
    self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])

  proc initSegTree*[S](v:seq[S], op:(S,S)->S, e:()->S):auto =
    let
      n = v.len
      log = ceil_pow2(n)
      size = 1 shl log
    result = segtree[S](n:n, size:size, log:log, d:newSeqWith(2 * size, e()), op:op, e:e)
    for i in 0..<n: result.d[size + i] = v[i]
    for i in countdown(size - 1, 1): result.update(i)

  proc initSegTree*[S](n:int, op:(S,S)->S, e:()->S):auto =
    initSegTree(newSeqWith(n, e()), op, e)

  proc set*[ST:segtree](self:var ST, p:int, x:ST.S) =
    assert p in 0..<self.n
    var p = p + self.size
    self.d[p] = x
    for i in 1..self.log: self.update(p shr i)

  proc get*[ST:segtree](self:ST, p:int):ST.S =
    assert p in 0..<self.n
    return self.d[p + self.size]

  proc prod*[ST:segtree](self:ST, p:Slice[int]):ST.S =
    var (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    var sml, smr = self.e()
    l += self.size; r += self.size
    while l < r:
      if (l and 1) != 0: sml = self.op(sml, self.d[l]);l.inc
      if (r and 1) != 0: r.dec;smr = self.op(self.d[r], smr)
      l = l shr 1
      r = r shr 1
    return self.op(sml, smr)

  proc all_prod*[ST:segtree](self:ST):auto = self.d[1]

#  proc max_right*[ST:segtree, f:static[proc(s:ST.S):bool]](self:ST, l:int):auto = self.max_right(l, f)
  proc max_right*[ST:segtree](self:ST, l:int, f:proc(s:ST.S):bool):int =
    assert l in 0..self.n
    assert f(self.e())
    if l == self.n: return self.n
    var
      l = l + self.size
      sm = self.e()
    while true:
      while l mod 2 == 0: l = l shr 1
      if not f(self.op(sm, self.d[l])):
        while l < self.size:
          l = (2 * l)
          if f(self.op(sm, self.d[l])):
            sm = self.op(sm, self.d[l])
            l.inc
        return l - self.size
      sm = self.op(sm, self.d[l])
      l.inc
      if not ((l and -l) != l): break
    return self.n

#  proc min_left*[ST:segtree, f:static[proc(s:ST.S):bool]](self:ST, r:int):auto = self.min_left(r, f)
  proc min_left*[ST:segtree](self:ST, r:int, f:proc(s:ST.S):bool):int =
    assert r in 0..self.n
    assert f(self.e())
    if r == 0: return 0
    var
      r = r + self.size
      sm = self.e()
    while true:
      r.dec
      while r > 1 and (r mod 2 != 0): r = r shr 1
      if not f(self.op(self.d[r], sm)):
        while r < self.size:
          r = (2 * r + 1)
          if f(self.op(self.d[r], sm)):
            sm = self.op(self.d[r], sm)
            r.dec
        return r + 1 - self.size
      sm = self.op(self.d[r], sm)
      if not ((r and -r) != r): break
    return 0

#endif  // ATCODER_SEGTREE_HPP

#import strutils
#
#let n, q = nextInt()
#let a = newSeqWith(n, nextInt())
#var target:int
#proc f(v:int):bool = v < target
#var seg = initSegTree[int](a, (a:int,b:int)=>max(a, b), () => -1)
#
#for i in 0..<q:
#  let t = nextInt()
#  if t == 1:
#    var x, v = nextInt()
#    x.dec
#    seg.set(x, v);
#  elif t == 2:
#    var l, r = nextInt()
#    l.dec
#    echo seg.prod(l..<r)
#  elif t == 3:
#    let p = nextInt() - 1
#    target = nextInt()
#    echo seg.max_right(p, f) + 1
