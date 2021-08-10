when not declared ATCODER_MONTGOMERY_MODINT_HPP:
  const ATCODER_MONTGOMERY_MODINT_HPP* = 1

  import std/macros
  import atcoder/generate_definitions

  type StaticLazyMontgomeryModInt*[M:static[uint32]] = object
    a:uint32
  type DynamicLazyMontgomeryModInt*[T:static[int]] = object
    a:uint32
  type LazyMontgomeryModInt = StaticLazyMontgomeryModInt or DynamicLazyMontgomeryModInt

  proc get_r*(M:uint32):auto =
    result = M
    for i in 0..<4: result *= 2.uint32 - M * result
  proc get_n2*(M:uint32):auto = (((not M.uint) + 1.uint) mod M.uint).uint32

  proc getMontgomeryParameters(M:uint32):tuple[M, r, n2:uint32] =
    (M, get_r(M), get_n2(M))

  proc getParameters*[T:static[int]](t:typedesc[DynamicLazyMontgomeryModInt[T]]):ptr[tuple[M, r, n2:uint32]] =
    var p {.global.} : tuple[M, r, n2:uint32] = getMontgomeryParameters(998244353.uint32)
    return p.addr

  proc checkParameters(M, r:uint32) =
    assert r * M == 1, "invalid, r * mod != 1"
    assert M < (1 shl 30), "invalid, mod >= 2 ^ 30"
    assert (M and 1) == 1, "invalid, mod % 2 == 0"

  proc setMod*[T:static[int]](self:typedesc[DynamicLazyMontgomeryModInt[T]], M:SomeInteger) =
    let p = getMontgomeryParameters(M.uint32)
    checkParameters(p.M, p.r)
    (self.getParameters)[] = p

  template getMod*[T:StaticLazyMontgomeryModInt](self:T or typedesc[T]):uint32 = T.M.uint32
  template getMod*[T:static[int]](self:typedesc[DynamicLazyMontgomeryModInt[T]] or DynamicLazyMontgomeryModInt[T]):uint32 =
    (DynamicLazyMontgomeryModInt[T].getParameters)[].M.uint32
  template `mod`*[T:LazyMontgomeryModInt](self:T or typedesc[T]):int = T.get_mod.int

  template reduce(T:typedesc[LazyMontgomeryModInt], b:uint):uint32 =
    when T is StaticLazyMontgomeryModInt:
      const M = T.get_mod
      const r = get_r(M)
      static:
        checkParameters(M, r)
      ((b + (cast[uint32](b) * ((not r) + 1.uint32)).uint * M.uint) shr 32).uint32
    elif T is DynamicLazyMontgomeryModInt:
      let p = (T.getParameters)[]
      ((b + (cast[uint32](b) * ((not p.r) + 1.uint32)).uint * p.M.uint) shr 32).uint32
    else:
      assert false, "no such lazy montgomerymodint"

  proc init*[T:LazyMontgomeryModInt](t:typedesc[T], b:T or SomeInteger):auto {.inline.} =
    when b is LazyMontgomeryModInt: return b
    else:
      when b is SomeUnsignedInt:
        let b = (b.uint mod T.get_mod.uint).int
      when T is StaticLazyMontgomeryModInt:
        const n2 = get_n2(T.get_mod)
        return T(a:T.reduce((b.int mod T.get_mod.int + T.get_mod.int).uint * n2))
      elif T is DynamicLazyMontgomeryModInt:
        let p = (T.getParameters)[]
        return T(a:T.reduce((b.int mod p.M.int + p.M.int).uint * p.n2))
  proc unit*[T:LazyMontgomeryModInt](t:typedesc[T] or T):T = T.init(1)

  proc val*[T:LazyMontgomeryModInt](self: T):int =
    var a = T.reduce(self.a.uint)
    if a >= T.get_mod: a -= T.get_mod
    return a.int

  proc `+=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self.a += b.a - 2.uint32 * T.get_mod
    if cast[int32](self.a) < 0.int32: self.a += 2.uint32 * T.get_mod
    return self

  proc `-=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self.a -= b.a
    if cast[int32](self.a) < 0.int32: self.a += 2.uint32 * T.get_mod
    return self

  proc inc*[T:LazyMontgomeryModInt](self: var T):T {.discardable, inline.} =
    return self += 1
  proc dec*[T:LazyMontgomeryModInt](self: var T):T {.discardable, inline.} =
    return self -= 1

  proc `*=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self.a = T.reduce(self.a.uint * b.a.uint)
    return self

  generatePow(LazyMontgomeryModInt)

  proc inv*[T:LazyMontgomeryModInt](self: T):T = self.pow(T.mod - 2)

  proc `/=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    self *= b.inv()
    return self

  generateDefinitions(`+`, m, n, LazyMontgomeryModInt, SomeInteger):
    result = T.init(m)
    result += T.init(n)

  generateDefinitions(`-`, m, n, LazyMontgomeryModInt, SomeInteger):
    result = T.init(m)
    result -= T.init(n)

  generateDefinitions(`*`, m, n, LazyMontgomeryModInt, SomeInteger):
    result = T.init(m)
    result *= T.init(n)

  generateDefinitions(`/`, m, n, LazyMontgomeryModInt, SomeInteger):
    result = T.init(m)
    result /= T.init(n)

  generateDefinitions(`==`, m, n, LazyMontgomeryModInt, SomeInteger):
    result = (T.init(m).val() == T.init(n).val())

  proc `$`*(m: LazyMontgomeryModInt): string {.inline.} = $(m.val())
  proc `-`*[T:LazyMontgomeryModInt](self:T):T = T.init(0) - self

  template useStaticMontgomery*(name, M) =
    generateConverter(name, int, StaticLazyMontgomeryModInt[M])
  template useDynamicMontgomery*(name, M) =
    generateConverter(name, int, DynamicLazyMontgomeryModInt[M])

  useStaticMontgomery(modint_montgomery_998244353, 998244353)
  useStaticMontgomery(modint_montgomery_1000000007, 1000000007)
  useDynamicMontgomery(modint_montgomery, -1)
