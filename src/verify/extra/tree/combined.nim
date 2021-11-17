# verify-helper: PROBLEM https://yukicoder.me/problems/no/1333

#[ import atcoder/header ]#
when not declared ATCODER_HEADER_HPP:
  const ATCODER_HEADER_HPP* = 1
  {.hints:off checks:off assertions:on optimization:speed.}
  {. warning[UnusedImport]:off .}
  import std/algorithm as algorithm_lib
  import std/sequtils as sequils_lib
  import std/tables as tables_lib
  import std/macros as macros_lib
  import std/math as math_lib
  import std/sets as sets_lib
  import std/strutils as strutils_lib
  import std/streams as streams_lib
  import std/strformat as strformat_lib

  proc scanf*(formatstr: cstring){.header: "<stdio.h>", varargs.}
  proc getchar*(): char {.header: "<stdio.h>", varargs.}
  proc nextInt*(base:int = 0): int =
    scanf("%lld",addr result)
    result -= base
  proc nextFloat*(): float = scanf("%lf",addr result)
  proc nextString*(): string =
    var get = false;result = ""
    while true:
      var c = getchar()
      if int(c) > int(' '): get = true;result.add(c)
      elif get: break
  template `max=`*(x,y:typed):void = x = max(x,y)
  template `min=`*(x,y:typed):void = x = min(x,y)
  template inf*(T): untyped = 
    when T is SomeFloat: T(Inf)
    elif T is SomeInteger: T.high div 2
    else: assert(false)
  discard
#[ import atcoder/modint ]#
when not declared ATCODER_MODINT_HPP:
  const ATCODER_MODINT_HPP* = 1
  import std/macros
  import std/strformat
  #[ import atcoder/generate_definitions ]#
  when not declared ATCODER_GENERATE_DEFINITIONS_NIM:
    const ATCODER_GENERATE_DEFINITIONS_NIM* = 1
    import std/strformat
    import std/macros
  
    type hasInv* = concept x
      var t: x
      t.inv()
  
    template generateDefinitions*(name, l, r, typeObj, typeBase, body: untyped): untyped {.dirty.} =
      proc name*(l, r: typeObj): auto {.inline.} =
        type T = l.type
        body
      proc name*(l: typeBase; r: typeObj): auto {.inline.} =
        type T = r.type
        body
      proc name*(l: typeObj; r: typeBase): auto {.inline.} =
        type T = l.type
        body
  
    template generatePow*(name) {.dirty.} =
      proc pow*(m: name; p: SomeInteger): name {.inline.} =
        when name is hasInv:
          if p < 0: return pow(m.inv(), -p)
        else:
          assert p >= 0
        if (p.type)(0) <= p:
          var
            p = p.uint
            m = m
          result = m.unit()
          while p > 0'u:
            if (p and 1'u) != 0'u: result *= m
            m *= m
            p = p shr 1'u
      proc `^`*[T:name](m: T; p: SomeInteger): T {.inline.} = m.pow(p)
  
    macro generateConverter*(name, from_type, to_type) =
      parseStmt(fmt"""type {name.repr}* = {to_type.repr}{'\n'}converter to{name.repr}OfGenerateConverter*(a:{from_type}):{name.repr} {{.used.}} = {name.repr}.init(a){'\n'}""")
    discard

  type
    StaticModInt*[M: static[int]] = object
      a:uint32
    DynamicModInt*[T: static[int]] = object
      a:uint32

  type ModInt* = StaticModInt or DynamicModInt
#  type ModInt* = concept x, type T
#    T is StaticModInt or T is DynamicModInt

  proc isStaticModInt*(T:typedesc):bool = T is StaticModInt
  proc isDynamicModInt*(T:typedesc):bool = T is DynamicModInt
  proc isModInt*(T:typedesc):bool = T.isStaticModInt or T.isDynamicModInt
  proc isStatic*(T:typedesc[ModInt]):bool = T is StaticModInt

  #[ import atcoder/internal_math ]#
  when not declared ATCODER_INTERNAL_MATH_HPP:
    const ATCODER_INTERNAL_MATH_HPP* = 1
    import std/math
  
    # Fast moduler by barrett reduction
    # Reference: https:#en.wikipedia.org/wiki/Barrett_reduction
    # NOTE: reconsider after Ice Lake
    type Barrett* = object
      m*, im:uint
  
    # @param m `1 <= m`
    proc initBarrett*(m:uint):auto = Barrett(m:m, im:(0'u - 1'u) div m + 1)
  
    # @return m
    proc umod*(self: Barrett):uint =
      self.m
  
    {.emit: """
  inline unsigned long long calc_mul(const unsigned long long &a, const unsigned long long &b){
    return (unsigned long long)(((unsigned __int128)(a)*b) >> 64);
  }
  """.}
    proc calc_mul*(a,b:culonglong):culonglong {.importcpp: "calc_mul(#,#)", nodecl.}
    # @param a `0 <= a < m`
    # @param b `0 <= b < m`
    # @return `a * b % m`
    proc mul*(self: Barrett, a:uint, b:uint):uint =
      # [1] m = 1
      # a = b = im = 0, so okay
  
      # [2] m >= 2
      # im = ceil(2^64 / m)
      # -> im * m = 2^64 + r (0 <= r < m)
      # let z = a*b = c*m + d (0 <= c, d < m)
      # a*b * im = (c*m + d) * im = c*(im*m) + d*im = c*2^64 + c*r + d*im
      # c*r + d*im < m * m + m * im < m * m + 2^64 + m <= 2^64 + m * (m + 1) < 2^64 * 2
      # ((ab * im) >> 64) == c or c + 1
      let z = a * b
      #  #ifdef _MSC_VER
      #      unsigned long long x;
      #      _umul128(z, im, &x);
      #  #else
      ##TODO
      #      unsigned long long x =
      #        (unsigned long long)(((unsigned __int128)(z)*im) >> 64);
      #  #endif
      let x = calc_mul(z.culonglong, self.im.culonglong).uint
      var v = z - x * self.m
      if self.m <= v: v += self.m
      return v
  
    # @param n `0 <= n`
    # @param m `1 <= m`
    # @return `(x ** n) % m`
    proc pow_mod_constexpr*(x,n,m:int):int =
      if m == 1: return 0
      var
        r = 1
        y = floorMod(x, m)
        n = n
      while n != 0:
        if (n and 1) != 0: r = (r * y) mod m
        y = (y * y) mod m
        n = n shr 1
      return r.int
    
    # Reference:
    # M. Forisek and J. Jancina,
    # Fast Primality Testing for Integers That Fit into a Machine Word
    # @param n `0 <= n`
    proc is_prime_constexpr*(n:int):bool =
      if n <= 1: return false
      if n == 2 or n == 7 or n == 61: return true
      if n mod 2 == 0: return false
      var d = n - 1
      while d mod 2 == 0: d = d div 2
      for a in [2, 7, 61]:
        var
          t = d
          y = pow_mod_constexpr(a, t, n)
        while t != n - 1 and y != 1 and y != n - 1:
          y = y * y mod n
          t =  t shl 1
        if y != n - 1 and t mod 2 == 0:
          return false
      return true
    proc is_prime*[n:static[int]]():bool = is_prime_constexpr(n)
  #  
  #  # @param b `1 <= b`
  #  # @return pair(g, x) s.t. g = gcd(a, b), xa = g (mod b), 0 <= x < b/g
    proc inv_gcd*(a, b:int):(int,int) =
      var a = floorMod(a, b)
      if a == 0: return (b, 0)
    
      # Contracts:
      # [1] s - m0 * a = 0 (mod b)
      # [2] t - m1 * a = 0 (mod b)
      # [3] s * |m1| + t * |m0| <= b
      var
        s = b
        t = a
        m0 = 0
        m1 = 1
    
      while t != 0:
        var u = s div t
        s -= t * u;
        m0 -= m1 * u;  # |m1 * u| <= |m1| * s <= b
    
        # [3]:
        # (s - t * u) * |m1| + t * |m0 - m1 * u|
        # <= s * |m1| - t * u * |m1| + t * (|m0| + |m1| * u)
        # = s * |m1| + t * |m0| <= b
    
        var tmp = s
        s = t;t = tmp;
        tmp = m0;m0 = m1;m1 = tmp;
      # by [3]: |m0| <= b/g
      # by g != b: |m0| < b/g
      if m0 < 0: m0 += b div s
      return (s, m0)
  
    # Compile time primitive root
    # @param m must be prime
    # @return primitive root (and minimum in now)
    proc primitive_root_constexpr*(m:int):int =
      if m == 2: return 1
      if m == 167772161: return 3
      if m == 469762049: return 3
      if m == 754974721: return 11
      if m == 998244353: return 3
      var divs:array[20, int]
      divs[0] = 2
      var cnt = 1
      var x = (m - 1) div 2
      while x mod 2 == 0: x = x div 2
      var i = 3
      while i * i <= x:
        if x mod i == 0:
          divs[cnt] = i
          cnt.inc
          while x mod i == 0:
            x = x div i
        i += 2
      if x > 1:
        divs[cnt] = x
        cnt.inc
      var g = 2
      while true:
        var ok = true
        for i in 0..<cnt:
          if pow_mod_constexpr(g, (m - 1) div divs[i], m) == 1:
            ok = false
            break
        if ok: return g
        g.inc
    proc primitive_root*[m:static[int]]():auto =
      primitive_root_constexpr(m)
  
    # @param n `n < 2^32`
    # @param m `1 <= m < 2^32`
    # @return sum_{i=0}^{n-1} floor((ai + b) / m) (mod 2^64)
    proc floor_sum_unsigned*(n, m, a, b:uint):uint =
      result = 0
      var (n, m, a, b) = (n, m, a, b)
      while true:
        if a >= m:
          result += n * (n - 1) div 2 * (a div m)
          a = a mod m
        if b >= m:
          result += n * (b div m)
          b = b mod m
  
        let y_max = a * n + b
        if y_max < m: break
        # y_max < m * (n + 1)
        # floor(y_max / m) <= n
        n = y_max div m
        b = y_max mod m
        swap(m, a)
    discard

  proc getBarrett*[T:static[int]](t:typedesc[DynamicModInt[T]]):ptr Barrett =
    var Barrett_of_DynamicModInt {.global.} = initBarrett(998244353.uint)
    return Barrett_of_DynamicModInt.addr
  proc getMod*[T:static[int]](t:typedesc[DynamicModInt[T]]):uint32 {.inline.} =
    (t.getBarrett)[].m.uint32
  proc setMod*[T:static[int]](t:typedesc[DynamicModInt[T]], M:SomeInteger){.inline.} =
    (t.getBarrett)[] = initBarrett(M.uint)

  proc `$`*(m: StaticModInt or DynamicModInt): string {.inline.} = $(m.val())

  template umod*[T:ModInt](self: typedesc[T] or T):uint32 =
    when T is typedesc:
      when T is StaticModInt:
        T.M.uint32
      elif T is DynamicModInt:
        T.getMod()
      else:
        static: assert false
    else: T.umod

  template `mod`*[T:ModInt](self:typedesc[T] or T):int = T.umod.int

  proc init*[T:ModInt](t:typedesc[T], v: SomeInteger or T): auto {.inline.} =
    when v is T: return v
    else:
      when v is SomeUnsignedInt:
        if v.uint < T.umod:
          return T(a:v.uint32)
        else:
          return T(a:(v.uint mod T.umod.uint).uint32)
      else:
        var v = v.int
        if 0 <= v:
          if v < T.mod: return T(a:v.uint32)
          else: return T(a:(v mod T.mod).uint32)
        else:
          v = v mod T.mod
          if v < 0: v += T.mod
          return T(a:v.uint32)
  proc unit*[T:ModInt](t:typedesc[T] or T):T = T.init(1)

  template initModInt*(v: SomeInteger or ModInt; M: static[int] = 1_000_000_007): auto =
    StaticModInt[M].init(v)

# TODO
#  converter toModInt[M:static[int]](n:SomeInteger):StaticModInt[M] {.inline.} = initModInt(n, M)

#  proc initModIntRaw*(v: SomeInteger; M: static[int] = 1_000_000_007): auto {.inline.} =
#    ModInt[M](v.uint32)
  proc raw*[T:ModInt](t:typedesc[T], v:SomeInteger):auto = T(a:v)

  proc inv*[T:ModInt](v:T):T {.inline.} =
    var
      a = v.a.int
      b = T.mod
      u = 1
      v = 0
    while b > 0:
      let t = a div b
      a -= t * b;swap(a, b)
      u -= t * v;swap(u, v)
    return T.init(u)

  proc val*(m: ModInt): int {.inline.} = int(m.a)

  proc `-`*[T:ModInt](m: T): T {.inline.} =
    if int(m.a) == 0: return m
    else: return T(a:m.umod() - m.a)

  proc `+=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =
    m.a += T.init(n).a
    if m.a >= T.umod: m.a -= T.umod

  proc `-=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =
    m.a -= T.init(n).a
    if m.a >= T.umod: m.a += T.umod

  proc `*=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =
    when T is StaticModInt:
      m.a = (m.a.uint * T.init(n).a.uint mod T.umod).uint32
    elif T is DynamicModInt:
      m.a = T.getBarrett[].mul(m.a.uint, T.init(n).a.uint).uint32
    else:
      static: assert false

  proc `/=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =
    m.a = (m.a.uint * T.init(n).inv().a.uint mod T.umod).uint32

  generateDefinitions(`+`, m, n, ModInt, SomeInteger):
    result = T.init(m)
    result += n

  generateDefinitions(`-`, m, n, ModInt, SomeInteger):
    result = T.init(m)
    result -= n

  generateDefinitions(`*`, m, n, ModInt, SomeInteger):
    result = T.init(m)
    result *= n

  generateDefinitions(`/`, m, n, ModInt, SomeInteger):
    result = T.init(m)
    result /= n

  generateDefinitions(`==`, m, n, ModInt, SomeInteger):
    result = (T.init(m).val() == T.init(n).val())

  proc inc*(m: var ModInt) {.inline.} =
    m.a.inc
    if m.a == m.umod.uint32:
      m.a = 0

  proc dec*(m: var ModInt) {.inline.} =
    if m.a == 0.uint32:
      m.a = m.umod - 1
    else:
      m.a.dec

  generatePow(ModInt)

  template useStaticModint*(name, M) =
    generateConverter(name, int, StaticModInt[M])
  template useDynamicModInt*(name, M) =
    generateConverter(name, int, DynamicModInt[M])

  useStaticModInt(modint998244353, 998244353)
  useStaticModInt(modint1000000007, 1000000007)
  useDynamicModInt(modint, -1)
  discard
#[ import atcoder/extra/tree/rerooting ]#
when not declared ATCODER_REROOTING_HPP:
  const ATCODER_REROOTING_HPP* = 1
  import sequtils
  type
    Edge*[Weight, Data] = object
      to: int
      weight: Weight
      dp, ndp: Data
    ReRooting*[Weight, Data] = object
      g:seq[seq[Edge[Weight, Data]]]
      subdp*, dp*: seq[Data]
      ident: Data
      f_up: proc(d:Data,w:Weight):Data
      f_merge: proc(d0, d1: Data):Data
  
  proc initEdge*[Weight, Data](to:int, d: Weight, dp, ndp: Data):Edge[Weight, Data] = Edge[Weight, Data](to: to, weight: d, dp: dp, ndp: ndp)
  proc initReRooting*[Weight, Data](n:int, f_up:proc(d:Data,w:Weight):Data, f_merge:proc(d0, d1:Data):Data, ident:Data):ReRooting[Weight,Data] =
    return ReRooting[Weight,Data](
      g:newSeqWith(n, newSeq[Edge[Weight, Data]]()),
      subdp: newSeqWith(n, ident),
      dp: newSeqWith(n, ident),
      f_up:f_up, f_merge:f_merge, ident:ident)
  
  proc addEdge*[Weight, Data](self: var ReRooting[Weight, Data]; u,v:int, d:Weight) =
    self.g[u].add(initEdge[Weight, Data](v, d, self.ident, self.ident))
    self.g[v].add(initEdge[Weight, Data](u, d, self.ident, self.ident))
  proc addBiEdge*[Weight, Data](self: var ReRooting[Weight, Data]; u,v:int, d,e:Weight) =
    self.g[u].add(initEdge[Weight, Data](v, d, self.ident, self.ident))
    self.g[v].add(initEdge[Weight, Data](u, e, self.ident, self.ident))
  proc addBiEdge*[Weight, Data](self: var ReRooting[Weight, Data]; u,v:int, d:Weight) =
    self.g[u].add(initEdge[Weight, Data](v, d, self.ident, self.ident))
    self.g[v].add(initEdge[Weight, Data](u, d, self.ident, self.ident))

  proc dfs_sub*[Weight, Data](self: var ReRooting[Weight, Data]; idx, par:int) =
    for e in self.g[idx]:
      if e.to == par: continue
      self.dfs_sub(e.to, idx)
      self.subdp[idx] = self.f_merge(self.subdp[idx], self.f_up(self.subdp[e.to], e.weight))
  
  proc dfs_all*[Weight, Data](self: var ReRooting[Weight, Data]; idx, par:int, top:Data) =
    var buff = self.ident
    for i in 0..<self.g[idx].len:
      var e = self.g[idx][i].addr
      e[].ndp = buff
      e[].dp = self.f_up(if par == e.to: top else: self.subdp[e.to], e[].weight)
      buff = self.f_merge(buff, e[].dp)
    self.dp[idx] = buff
    buff = self.ident
    for i in countdown(self.g[idx].len - 1, 0):
      var e = self.g[idx][i].addr
      if e[].to != par:
        var tmp = self.f_merge(e[].ndp, buff)
        self.dfs_all(e[].to, idx, tmp)
      e[].ndp = self.f_merge(e[].ndp, buff)
      buff = self.f_merge(buff, e[].dp)
  
  proc solve*[Weight, Data](self: var ReRooting[Weight, Data]):seq[Data] =
    self.dfs_sub(0, -1)
    self.dfs_all(0, -1, self.ident)
    return self.dp
  
  discard

let N = nextInt()

type mint = modint1000000007
type Data = tuple[n, s, t:mint]
type Weight = mint

proc f_up(d:Data, w:Weight):Data =
  var (n, s, t) = d
  return (n + 1, s + w * n + w, t + 2 * s * w + w * w * n + w * w)
proc f_merge(d0, d1:Data):Data = (d0.n + d1.n, d0.s + d1.s, d0.t + d1.t)

var g = initRerooting[Weight, Data](N, f_up, f_merge, (mint(0), mint(0), mint(0)))

for _ in 0 ..< N - 1:
  var u, v, w = nextInt()
  u.dec;v.dec
  g.addBiEdge(u, v, w)

var d = g.solve()
var ans = mint(0)
for i, (n, s, t) in d:
  ans += t

echo ans / 2
