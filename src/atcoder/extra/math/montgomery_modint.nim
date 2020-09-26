when not declared ATCODER_MONTGOMERY_MODINT_HPP:
  const ATCODER_MONTGOMERY_MODINT_HPP* = 1

  import macros, strformat

  type LazyMontgomeryModInt*[M, r, n2:static[uint32]] = object
    a:uint32

  proc get_r*(M:uint32):auto =
    result = M
    for i in 0..<4: result *= 2.uint32 - M * result
  
  #static constexpr u32 r = get_r();
  #static constexpr u32 n2 = -u64(mod) % mod;
  
  proc reduce(b:uint, M, r:static[uint32]):uint32 =
    return ((b + (b.uint32 * ((not r) + 1.uint32)).uint * M.uint) shr 32).uint32
  
  template reduce(T:typedesc[LazyMontgomeryModInt], b:uint):auto =
    reduce(b, T.M, T.r)

  proc initLazyMontgomeryModInt*(b:SomeInteger = 0, M:static[SomeInteger]):auto {.inline.} =
    const M = M.uint32
    const r = get_r(M)
    const n2 = (((not M.uint) + 1.uint) mod M.uint).uint32
    static:
      assert r * M == 1, "invalid, r * mod != 1"
      assert M < (1 shl 30), "invalid, mod >= 2 ^ 30"
      assert (M and 1) == 1, "invalid, mod % 2 == 0"
    type T = LazyMontgomeryModInt[M, r, n2]
    return T(a:reduce((b.int mod M.int + M.int).uint * T.n2, M, T.r))

  proc init*(T:typedesc[LazyMontgomeryModInt], b:T or SomeInteger):auto =
    when b is T: b
    else: T(a:reduce((b.int mod T.M.int + T.M.int).uint * T.n2, T.M, T.r))

  macro declareMontgomery*(name, M) =
    var strBody = ""
    strBody &= fmt"""
type {name.repr}* = LazyMontgomeryModInt[{M.repr}.uint32, get_r({M.repr}), (((not {M.repr}.uint) + 1.uint) mod {M.repr}.uint).uint32]
proc `$`*(m: {name.repr}): string = $(m.val())
converter to{name.repr}OfMontgomery(n:SomeInteger):{name.repr} = {name.repr}.init(n)
"""
    parseStmt(strBody)

  #constexpr LazyMontgomeryModInt() : a(0) {}
  #constexpr LazyMontgomeryModInt(const int64_t &b)
  #    : a(reduce(u64(b % mod + mod) * n2)){};
  
  proc val*[T:LazyMontgomeryModInt](self: T):int =
    var a = T.reduce(self.a)
    if a >= T.M: a -= T.M
    a.int
  
  proc get_mod*[T:LazyMontgomeryModInt](self:T):auto = T.M
  
  proc `+=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self.a += b.a - 2.uint32 * T.M
    if int32(self.a) < 0.int32: self.a += 2.uint32 * T.M
    return self
  
  proc `-=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self.a -= b.a
    if int32(self.a) < 0.int32: self.a += 2.uint32 * T.M
    return self
  
  proc `*=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self.a = T.reduce(self.a.uint * b.a.uint)
    return self
  
  proc pow*[T:LazyMontgomeryModInt](self: T, n:SomeInteger):T {.inline.} =
    result = T.init(1)
    var mul = self
    var n = n.uint
    while n > 0'u:
      if (n and 1'u) != 0'u: result *= mul
      mul *= mul
      n = n shr 1
  
  proc inv*[T:LazyMontgomeryModInt](self: T):T = self.pow(T.M - 2)
  
  proc `/=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self *= b.inv()
    return self
  proc `==`*[T:LazyMontgomeryModInt](a, b:T):bool {.inline.} =
    return (if a.a >= T.M: a.a - T.M else: a.a) == (if b.a >= T.M: b.a - T.M else: b.a)
  proc `!=`*[T:LazyMontgomeryModInt](a, b:T):bool {.inline.} =
    return (if a.a >= T.M: a.a - T.M else: a.a) != (if b.a >= T.M: b.a - T.M else: b.a)

  template generateLazyMontgomeryModIntDefinitions(name, l, r, body: untyped): untyped {.dirty.} =
    proc name*[T:LazyMontgomeryModInt](l: T; r: T): auto {.inline.} =
      body
    proc name*[T:LazyMontgomeryModInt](l: SomeInteger; r: T): auto {.inline.} =
      body
    proc name*[T:LazyMontgomeryModInt](l: T; r: SomeInteger): auto {.inline.} =
      body

  generateLazyMontgomeryModIntDefinitions(`+`, m, n):
    result = T.init(m)
    result += T.init(n)

  generateLazyMontgomeryModIntDefinitions(`-`, m, n):
    result = T.init(m)
    result -= T.init(n)

  generateLazyMontgomeryModIntDefinitions(`*`, m, n):
    result = T.init(m)
    result *= T.init(n)

  generateLazyMontgomeryModIntDefinitions(`/`, m, n):
    result = T.init(m)
    result /= T.init(n)

  generateLazyMontgomeryModIntDefinitions(`==`, m, n):
    result = (T.init(m).int == T.init(n).int)

  proc `$`*[T:LazyMontgomeryModInt](m: T): string = (m.val()).toStr

  proc `-`*[T:LazyMontgomeryModInt](self:T):T = T.init() - self

#
#friend istream &operator>>(istream &is, mint &b) {
#  int64_t t;
#  is >> t;
#  b = LazyMontgomeryModInt<mod>(t);
#  return (is);
#}



#const MOD = 998244353
#var a = initLazyMontgomeryModInt(100000000, MOD)
#var b = initLazyMontgomeryModInt(123456789, MOD)
#
#for i in 0..<MOD-1:
#  a *= b
#
#echo a.val
#echo a.val == 100000000
#

#import atcoder/modint
#type mint = modint998244353
#
#var a = mint.init(100000000)
#var b = mint.init(123456789)
#
#for i in 0..<998244352:
#  a *= b
#
#echo a


