---
layout: default
---

<!-- mathjax config similar to math.stackexchange -->
<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    TeX: { equationNumbers: { autoNumber: "AMS" }},
    tex2jax: {
      inlineMath: [ ['$','$'] ],
      processEscapes: true
    },
    "HTML-CSS": { matchFontHeight: false },
    displayAlign: "left",
    displayIndent: "2em"
  });
</script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-balloon-js@1.1.2/jquery.balloon.min.js" integrity="sha256-ZEYs9VrgAeNuPvs15E39OsyOJaIkXEEt10fzxJ20+2I=" crossorigin="anonymous"></script>
<script type="text/javascript" src="../../../assets/js/copy-button.js"></script>
<link rel="stylesheet" href="../../../assets/css/copy-button.css" />


# :warning: src/nim_acl/lazysegtree.nim

<a href="../../../index.html">Back to top page</a>

* category: <a href="../../../index.html#9445bba494c2e7790206eaaedbe1a4db">src/nim_acl</a>
* <a href="{{ site.github.repository_url }}/blob/master/src/nim_acl/lazysegtree.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-09 20:06:33+09:00




## Code

<a id="unbundled"></a>
{% raw %}
```cpp
{.hints:off checks:off assertions:on checks:off}
# header {{{
import algorithm, sequtils, tables, macros, math, sets, strutils, streams, strformat, sugar
when defined(MYDEBUG):
  import header

proc scanf(formatstr: cstring){.header: "<stdio.h>", varargs.}
proc getchar(): char {.header: "<stdio.h>", varargs.}
proc nextInt(base:int = 0): int =
  scanf("%lld",addr result)
  result -= base
proc nextFloat(): float = scanf("%lf",addr result)
proc nextString(): string =
  var get = false;result = ""
  while true:
    var c = getchar()
    if int(c) > int(' '): get = true;result.add(c)
    elif get: break
template `max=`*(x,y:typed):void = x = max(x,y)
template `min=`*(x,y:typed):void = x = min(x,y)
template inf(T): untyped = 
  when T is SomeFloat: T(Inf)
  elif T is SomeInteger: ((T(1) shl T(sizeof(T)*8-2)) - (T(1) shl T(sizeof(T)*4-1)))
  else: assert(false)

# }}}

const Mod = 998244353

# ModInt {{{
# ModInt[Mod] {{{
type ModInt[Mod: static[int]] = object
  v:int32
 
proc initModInt(a:SomeInteger, Mod:static[int]):ModInt[Mod] =
  var a = a.int
  a = a mod Mod
  if a < 0: a += Mod
  result.v = a.int32
 
proc getMod[Mod:static[int]](self: ModInt[Mod]):static int32 = self.Mod
proc getMod[Mod:static[int]](self: typedesc[ModInt[Mod]]):static int32 = self.Mod
 
macro declareModInt(Mod:static[int], t: untyped):untyped =
  var strBody = ""
  strBody &= fmt"""
type {t.repr} = ModInt[{Mod.repr}]
proc init{t.repr}(a:SomeInteger):{t.repr} = initModInt(a, {Mod.repr})
proc `$`(a:{t.repr}):string = $(a.v)
converter to{t.repr}(a:SomeInteger):{t.repr} = initModInt(a, {Mod.repr})
"""
  parseStmt(strBody)
 
when declared(Mod): declareModInt(Mod, Mint)
##}}}
 
# DynamicModInt {{{
type DMint = object
  v:int32
 
proc setModSub(self:typedesc[not ModInt], m:int = -1, update = false):int32 =
  {.noSideEffect.}:
    var DMOD {.global.}:int32
    if update: DMOD = m.int32
    return DMOD
 
proc fastMod(a:int,m:uint32):uint32{.inline.} =
  var
    minus = false
    a = a
  if a < 0:
    minus = true
    a = -a
  elif a < m.int:
    return a.uint32
  var
    xh = (a shr 32).uint32
    xl = a.uint32
    d:uint32
  asm """
    "divl %4; \n\t"
    : "=a" (`d`), "=d" (`result`)
    : "d" (`xh`), "a" (`xl`), "r" (`m`)
  """
  if minus and result > 0'u32: result = m - result
proc initDMint(a:SomeInteger, Mod:int):DMint = result.v = fastMod(a.int, Mod.uint32).int32
 
proc getMod[T:not ModInt](self: T):int32 = T.type.setModSub()
proc getMod(self: typedesc[not ModInt]):int32 = self.setModSub()
proc setMod(self: typedesc[not ModInt], m:int) = discard self.setModSub(m, update = true)
#}}}
 
# Operations {{{
type ModIntC = concept x, type T
  x.v
#  x.v is int32
#  x.getMod() is int32
#  when T isnot ModInt: setMod(T, int)
type SomeIntC = concept x
  x is SomeInteger or x is ModIntC
 
proc Identity(self:ModIntC):auto = result = self;result.v = 1
proc init[Mod:static[int]](self:ModInt[Mod], a:SomeIntC):ModInt[Mod] =
  when a is SomeInteger: initModInt(a, Mod)
  else: a
proc init(self:ModIntC and not ModInt, a:SomeIntC):auto =
  when a is SomeInteger:
    var r = self.type.default
    r.v = fastMod(a.int, self.getMod().uint32).int32
    r
  else: a
 
macro declareDMintConverter(t:untyped) =
  parseStmt(fmt"""
converter to{t.repr}(a:SomeInteger):{t.repr} =
  let Mod = {t.repr}.getMod()
  if Mod > 0:
    result.v = fastMod(a.int, Mod.uint32).int32
  else:
    result.v = a.int32
  return result
""")
 
declareDMintConverter(DMint)
 
macro declareDMint(t:untyped) =
  parseStmt(fmt"""
type {t.repr} {{.borrow: `.`.}} = distinct DMint
declareDMintConverter({t.repr})
""")
 
proc `*=`(self:var ModIntC, a:SomeIntC) =
  when self is ModInt:
    self.v = (self.v.int * self.init(a).v.int mod self.getMod().int).int32
  else:
    self.v = fastMod(self.v.int * self.init(a).v.int, self.getMod().uint32).int32
proc `==`(a:ModIntC, b:SomeIntC):bool = a.v == a.init(b).v
proc `!=`(a:ModIntC, b:SomeIntC):bool = a.v != a.init(b).v
proc `-`(self:ModIntC):auto =
  if self.v == 0: return self
  else: return self.init(self.getMod() - self.v)
proc `$`(a:ModIntC):string = return $(a.v)
 
proc `+=`(self:var ModIntC; a:SomeIntC) =
  self.v += self.init(a).v
  if self.v >= self.getMod(): self.v -= self.getMod()
proc `-=`(self:var ModIntC, a:SomeIntC) =
  self.v -= self.init(a).v
  if self.v < 0: self.v += self.getMod()
proc `^=`(self:var ModIntC, n:SomeInteger) =
  var (x,n,a) = (self,n,self.Identity)
  while n > 0:
    if (n and 1) > 0: a *= x
    x *= x
    n = (n shr 1)
  swap(self, a)
proc inv(self: ModIntC):auto =
  var
    a = self.v.int
    b = self.getMod().int
    u = 1
    v = 0
  while b > 0:
    let t = a div b
    a -= t * b;swap(a, b)
    u -= t * v;swap(u, v)
  return self.init(u)
proc `/=`(a:var ModIntC,b:SomeIntC) = a *= a.init(b).inv()
proc `+`(a:ModIntC,b:SomeIntC):auto = result = a;result += b
proc `-`(a:ModIntC,b:SomeIntC):auto = result = a;result -= b
proc `*`(a:ModIntC,b:SomeIntC):auto = result = a;result *= b
proc `/`(a:ModIntC,b:SomeIntC):auto = result = a;result /= b
proc `^`(a:ModIntC,b:SomeInteger):auto = result = a;result ^= b
# }}}
# }}}

when not defined ATCODER_LAZYSEGTREE_HPP:
  const ATCODER_LAZYSEGTREE_HPP = 1
  
  #include <algorithm>
  #include <atcoder/internal_bit>
  #include <cassert>
  #include <iostream>
  #include <vector>
  import sugar, internal_bit, sequtils
  type lazy_segtree[S,F] = object
    n, size, log:int
    d:seq[S]
    lz:seq[F]
    op:(S, S)->S
    e:()->S
    mapping:(F,S)->S
    composition:(F,F)->F
    id:()->F
  
  proc update[ST:lazy_segtree](self:var ST, k:int) = self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])
  proc all_apply[ST:lazy_segtree](self:var ST, k:int, f:ST.F) =
    self.d[k] = self.mapping(f, self.d[k])
    if k < self.size: self.lz[k] = self.composition(f, self.lz[k])
  proc push[ST:lazy_segtree](self: var ST, k:int) =
    self.all_apply(2 * k, self.lz[k])
    self.all_apply(2 * k + 1, self.lz[k])
    self.lz[k] = self.id()

#  lazy_segtree(int n) : lazy_segtree(std::vector<S>(n, e())) {}
  proc init_lazy_segtree[S,F](v:int or seq[S], op:(S,S)->S,e:()->S,mapping:(F,S)->S,composition:(F,F)->F,id:()->F):auto =
    when v is int:
      return init_lazy_segtree[S,F](newSeqWith(v, e()),op,e,mapping,composition,id)
    let
      n = v.len
      log = ceil_pow2(n)
      size = 1 shl log
    var d = newSeqWith(2 * size, e())
    for i in 0..<n:
      d[size + i] = v[i]
    result = lazy_segtree[S,F](n:n,log:log,size:size,d:d,lz:newSeqWith(size, id()),op:op,e:e,mapping:mapping,composition:composition,id:id)
    for i in countdown(size - 1, 1):
      result.update(i)

  proc set[ST:lazy_segtree](self: var ST, p:int, x:ST.S) =
    assert p in 0..<self.n
    let p = p + self.size
    for i in countdown(self.log, 1): self.push(p shr i)
    self.d[p] = x
    for i in 1..self.log: self.update(p shr i)

  proc get[ST:lazy_segtree](self: ST, p:int):ST.S =
    assert p in 0..<self.n
    let p = p + self.size
    for i in countdown(self.log, 1): self.push(p shr i)
    return self.d[p]

  proc prod[ST:lazy_segtree](self:var ST, p:Slice[int]):ST.S =
    var (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    if l == r: return self.e()

    l += self.size
    r += self.size

    for i in countdown(self.log, 1):
      if ((l shr i) shl i) != l: self.push(l shr i)
      if ((r shr i) shl i) != r: self.push(r shr i)

    var sml, smr = self.e()
    while l < r:
      if (l and 1) != 0: sml = self.op(sml, self.d[l]);l.inc
      if (r and 1) != 0: r.dec;smr = self.op(self.d[r], smr)
      l = l shr 1
      r = r shr 1
    return self.op(sml, smr)

  proc all_prod[ST:lazy_segtree](self:ST):auto = self.d[1]

  proc apply[ST:lazy_segtree](self: var ST, p:int, f:ST.F) =
    assert p in 0..<self.n
    let p = p + self.size
    for i in countdown(self.log, 1): self.push(p shr i)
    self.d[p] = self.mapping(f, self.d[p])
    for i in 1..self.log: self.update(p shr i)
  proc apply[ST:lazy_segtree](self: var ST, p:Slice[int], f:ST.F) =
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
  proc max_right[ST:lazysegtree](self:var ST, l:int, g:(ST.S)->bool):int =
    assert l in 0..self.n
    assert g(e())
    if l == self.n: return self.n
    var l = l + self.size
    for i in countdown(self.log, 1): self.push(l shr i)
    var sm = self.e()
    while true:
      while l mod 2 == 0: l = l shr 1
      if not g(self.op(sm, self.d[l])):
        while l < self.size:
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
  proc min_left[ST:lazy_segtree](self: var ST, r:int, g:(ST.S)->bool):int =
    assert r in 0..self.n
    assert(g(self.e()))
    if r == 0: return 0
    var r = r + self.size
    for i in countdown(self.log, 1): self.push((r - 1) shr i)
    var sm = self.e()
    while true:
      r.dec
      while r > 1 and r mod 2 == 1: r = r shr 1
      if not g(self.op(self.d[r], sm)):
        while r < self.size:
          self.push(r)
          r = (2 * r + 1)
          if g(self.op(self.d[r], sm)):
            sm = self.op(self.d[r], sm)
            r.dec
        return r + 1 - self.size
      sm = self.op(self.d[r], sm)
      if not ((r & -r) != r): break
    return 0

#endif  // ATCODER_LAZYSEGTREE_HPP

block:
  type mint = Mint
  
  type S = tuple[a:mint, size:int]
  type F = tuple[a:mint, b:mint]
  
  proc op(l, r:S):S = (l.a + r.a, l.size + r.size)
  proc e():S = (mint(0), 0)
  proc mapping(l:F, r:S):S = (r.a * l.a + r.size * l.b, r.size)
  proc composition(l, r:F):F = (r.a * l.a, r.b * l.a + l.b)
  proc id():F = (mint(1), mint(0))
  
  let n, q = nextInt()
  let a = newSeqWith(n, (mint(nextInt()), 1))

  var seg = init_lazy_segtree(a, op, e, mapping, composition, id)

  for i in 0..<q:
    let t = nextInt()
    if t == 0:
      let l, r, c, d = nextInt()
      seg.apply(l..<r, (mint(c), mint(d)))
    else:
      let l, r = nextInt()
      echo seg.prod(l..<r)[0]

```
{% endraw %}

<a id="bundled"></a>
{% raw %}
```cpp
Traceback (most recent call last):
  File "/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/docs.py", line 349, in write_contents
    bundled_code = language.bundle(self.file_class.file_path, basedir=pathlib.Path.cwd())
  File "/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py", line 86, in bundle
    raise NotImplementedError
NotImplementedError

```
{% endraw %}

<a href="../../../index.html">Back to top page</a>

