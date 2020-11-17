when not declared ATCODER_MONTGOMERY_MODINT_HPP:
  const ATCODER_MONTGOMERY_MODINT_HPP* = 1

  import std/macros, std/strformat

  type LazyMontgomeryModInt*[M:static[uint32]] = object
    a:uint32

  proc get_r*(M:uint32):auto =
    result = M
    for i in 0..<4: result *= 2.uint32 - M * result
  proc get_n2*(M:uint32):auto = (((not M.uint) + 1.uint) mod M.uint).uint32

  proc reduce(b:uint, M: static[uint32]):uint32 =
    const r = get_r(M)
    return ((b + (cast[uint32](b) * ((not r) + 1.uint32)).uint * M.uint) shr 32).uint32
#    return ((b + (((b and MASK) * ((not r) + 1.uint32).uint) and MASK) * M.uint) shr 32).uint32
  proc `mod`*[T:LazyMontgomeryModInt](self:typedesc[T]):int = T.M.int
  proc `mod`*[T:LazyMontgomeryModInt](self:T):int = T.M.int

  template reduce(T:typedesc[LazyMontgomeryModInt], b:uint):auto =
    reduce(b, T.M)

  proc initLazyMontgomeryModInt*(b:SomeInteger = 0, M:static[SomeInteger]):auto {.inline.} =
    const M = M.uint32
    const r = get_r(M)
    const n2 = get_n2(M)
    static:
      assert r * M == 1, "invalid, r * mod != 1"
      assert M < (1 shl 30), "invalid, mod >= 2 ^ 30"
      assert (M and 1) == 1, "invalid, mod % 2 == 0"
    type T = LazyMontgomeryModInt[M]
    return T(a:reduce((b.int mod M.int + M.int).uint * n2, M, r))

  proc init*(T:typedesc[LazyMontgomeryModInt], b:T or SomeInteger):auto =
    const r = get_r(T.M)
    const n2 = get_n2(T.M)
    when b is uint:
      let b = (b mod T.M.uint).int
    when b is LazyMontgomeryModInt: b
    else:
      T(a:reduce((b.int mod T.M.int + T.M.int).uint * n2, T.M))

  macro useMontgomery*(name, M) =
    var strBody = ""
    strBody &= fmt"""type {name.repr}* = LazyMontgomeryModInt[{M.repr}.uint32]{'\n'}converter to{name.repr}OfMontgomery*(n:int):{name.repr} {{.used.}} = {name.repr}.init(n){'\n'}"""
    parseStmt(strBody)

  proc val*[T:LazyMontgomeryModInt](self: T):int =
    var a = T.reduce(self.a)
    if a >= T.M: a -= T.M
    a.int

  proc get_mod*[T:LazyMontgomeryModInt](self:T):auto = T.M

  proc `+=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self.a += b.a - 2.uint32 * T.M
    if cast[int32](self.a) < 0.int32: self.a += 2.uint32 * T.M
    return self

  proc `-=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self.a -= b.a
    if cast[int32](self.a) < 0.int32: self.a += 2.uint32 * T.M
    return self

  proc `*=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self.a = T.reduce(self.a.uint * b.a.uint)
    return self

  proc pow*[T:LazyMontgomeryModInt, N:SomeInteger](self: T, n:N):T {.inline.} =
    assert n >= N(0)
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

  template generateLazyMontgomeryModIntDefinitions(name, l, r, body: untyped): untyped {.dirty.} =
    proc name*(l, r: LazyMontgomeryModInt): auto {.inline.} =
      type T = l.type
      body
    proc name*(l: SomeInteger; r: LazyMontgomeryModInt): auto {.inline.} =
      type T = r.type
      body
    proc name*(l: LazyMontgomeryModInt; r: SomeInteger): auto {.inline.} =
      type T = l.type
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
    result = (T.init(m).val() == T.init(n).val())

  proc `$`*(m: LazyMontgomeryModInt): string {.inline.} = $(m.val())

  proc `-`*[T:LazyMontgomeryModInt](self:T):T = T.init(0) - self

  useMontgomery modint998244353, 998244353
  useMontgomery modint1000000007, 1000000007
