when not defined ATCODER_MODINT_HPP:
  const ATCODER_MODINT_HPP* = 1

  type
    StaticModInt*[M: static[int]] = distinct uint32
  type
    DynamicModInt* = distinct uint32
  
  type ModInt = StaticModInt or DynamicModInt

  var ModVal_of_DynamicModInt = 1000000007.uint32
  import internal_math
  var Barrett_of_DynamicModInt:Barrett

  proc getMod*(t:typedesc[DynamicModInt], set = false, M:SomeInteger = 0.uint32):uint32 =
    if set:
      ModVal_of_DynamicModInt = M.uint32
    return ModVal_of_DynamicModInt
  proc setMod*(t:typedesc[DynamicModInt], M:SomeInteger){.used.} =
    discard t.getMod(true, M)
    Barrett_of_DynamicModInt = initBarrett(M.uint)

  proc `$`*(m: ModInt): string {.inline.} =
    $m.int

  template umod*[T:ModInt](self: typedesc[T]):uint32 =
    when T is StaticModInt:
      T.M
    elif T is DynamicModInt:
      T.getMod()
    else:
      static: assert false
  template umod*[T:ModInt](self: T):uint32 = self.type.umod

#  proc initModInt*(v: SomeInteger or ModInt; M: static[int] = 1_000_000_007): auto {.inline.} =
#    when v is ModInt: return v
#    else:
#      if 0 <= v:
#        if v < M: return ModInt[M](v.uint32)
#        else: return ModInt[M]((v mod M).uint32)
#      else:
#        var v = v mod M
#        if v < 0: v += M
#        return ModInt[M](v.uint32)
  proc init*[T:ModInt](t:typedesc[T], v: SomeInteger or T): auto {.inline.} =
    when v is T: return v
    else:
      var v = v.int
      if 0 <= v:
        if v < T.umod.int: return T(v.uint32)
        else: return T((v mod T.umod.int).uint32)
      else:
        v = v mod T.umod.int
        if v < 0: v += T.umod.int
        return T(v.uint32)

#  converter toModInt[M:static[int]](n:SomeInteger):ModInt[M] {.inline.}= initModInt(n, M)

  proc initModIntRaw*(v: SomeInteger; M: static[int] = 1_000_000_007): auto {.inline.} =
    ModInt[M](v.uint32)

  proc inv*[T](v:T):T {.inline.} =
    var
      a = T.init(v).int
      b = T.umod.int
      u = 1
      v = 0
    while b > 0:
      let t = a div b
      a -= t * b;swap(a, b)
      u -= t * v;swap(u, v)
    return T.init(u)

#  proc retake*[M: static[int]](m: var ModInt[M]) {.inline.} =
#    int(m) = int(m).modulo(M)

  proc val*(m: ModInt): int {.inline.} =
    int(m)

#  proc modulo*[M: static](m: ModInt): int {.inline.} =
#    M

  proc `-`*(m: ModInt): ModInt {.inline.} =
    if int(m) == 0: return m
    else: return m.type(m.umod() - int(m))

  template generateDefinitions(name, l, r, body: untyped): untyped {.dirty.} =
    proc name*[T:ModInt](l: T; r: T): auto {.inline.} =
      body
    proc name*[T:ModInt](l: SomeInteger; r: T): auto {.inline.} =
      body
    proc name*[T:ModInt](l: T; r: SomeInteger): auto {.inline.} =
      body

#  proc inv*[M: static[int]](m: ModInt[M]): ModInt[M] {.inline.} =
#    result = initModInt(extgcd(M, int(m))[1], M)

  proc `+=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =
    uint32(m) += T.init(n).uint32
    if uint32(m) >= T.umod: uint32(m) -= T.umod

  proc `-=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =
    uint32(m) += T.umod - T.init(n).uint32
    if uint32(m) >= T.umod: uint32(m) -= T.umod

  proc `*=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =
    when T is StaticModInt:
      uint32(m) = (uint(m) * T.init(n).uint mod T.umod()).uint32
    elif T is DynamicModInt:
      uint32(m) = Barrett_of_DynamicModInt.mul(uint(m), T.init(n).uint).uint32
    else:
      static: assert false
#    m.retake()

  proc `/=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =
    uint32(m) = (uint(m) * T.init(n).inv().uint mod T.umod).uint32
#    m.retake()

  generateDefinitions(`+`, m, n):
    result = T.init(m)
    result += n

  generateDefinitions(`-`, m, n):
    result = T.init(m)
    result -= n

  generateDefinitions(`*`, m, n):
    result = T.init(m)
    result *= n

  generateDefinitions(`/`, m, n):
    result = T.init(m)
    result /= n

  proc `==`*[T:ModInt](m: T; n: SomeInteger | T): bool {.inline.} =
    int(m) == T.init(n).int

  proc inc*[T:ModInt](m: var T) {.inline.} =
    uint32(m).inc
    if m == T.umod:
      uint32(m) = 0

  proc dec*[T:ModInt](m: var T) {.inline.} =
    if m == 0:
      uint32(m) = T.umod - 1
    else:
      uint32(m).dec

  proc pow*[T:ModInt](m: T; p: SomeInteger): T {.inline.} =
    var
      p = p.int
      m = m
    uint32(result) = 1
    while p > 0:
      if (p and 1) == 1:
        result *= m
      m *= m
      p = p shr 1
