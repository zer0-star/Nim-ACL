when not declared ATCODER_MODINT_HPP:
  const ATCODER_MODINT_HPP* = 1
  import std/macros
  import atcoder/generate_definitions

  type
    StaticModInt*[M: static[int]] = object
      a:uint32
    DynamicModInt*[T: static[int]] = object
      a:uint32

  type ModInt* = StaticModInt or DynamicModInt
#  type ModInt* = concept x, type T
#    T is StaticModInt or T is DynamicModInt

  proc isStaticModInt*(T:typedesc[ModInt]):bool = T is StaticModInt
  proc isDynamicModInt*(T:typedesc[ModInt]):bool = T is DynamicModInt
  #proc isModInt*(T:typedesc):bool = T.isStaticModInt or T.isDynamicModInt
  proc isStatic*(T:typedesc[ModInt]):bool = T is StaticModInt
  proc getMod*[M:static[int]](t:typedesc[StaticModInt[M]]):int {.inline.} = M


  import atcoder/internal_math

  proc getBarrett*[T:static[int]](t:typedesc[DynamicModInt[T]]):ptr Barrett =
    {.cast(noSideEffect).}:
      var Barrett_of_DynamicModInt {.global.}: Barrett
      once:
        Barrett_of_DynamicModInt = initBarrett(998244353.uint)
      return Barrett_of_DynamicModInt.addr
  
  proc getMod*[T:static[int]](t:typedesc[DynamicModInt[T]]):uint32 {.inline.} =
    (t.getBarrett)[].m.uint32
  proc setMod*[T:static[int]](t:typedesc[DynamicModInt[T]], M:SomeInteger){.inline.} =
    (t.getBarrett)[] = initBarrett(M.uint)

  proc val*(m: ModInt): int {.inline.} = int(m.a)

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


  proc `-`*[T:ModInt](m: T): T {.inline.} =
    if int(m.a) == 0: return m
    else: return T(a:m.umod() - m.a)

  proc `+=`*[T:ModInt](m: var T; n: SomeInteger | T):T {.inline discardable.} =
    m.a += T.init(n).a
    if m.a >= T.umod: m.a -= T.umod
    return m

  proc `-=`*[T:ModInt](m: var T; n: SomeInteger | T):T {.inline discardable.} =
    m.a -= T.init(n).a
    if m.a >= T.umod: m.a += T.umod
    return m

  proc `*=`*[T:ModInt](m: var T; n: SomeInteger | T):T {.inline discardable.} =
    when T is StaticModInt:
      m.a = (m.a.uint * T.init(n).a.uint mod T.umod).uint32
    elif T is DynamicModInt:
      m.a = T.getBarrett[].mul(m.a.uint, T.init(n).a.uint).uint32
    else:
      static: assert false
    return m

  proc `/=`*[T:ModInt](m: var T; n: SomeInteger | T):T {.inline discardable.} =
    m.a = (m.a.uint * T.init(n).inv().a.uint mod T.umod).uint32
    return m

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

  proc inc*(m: var ModInt):ModInt {.inline discardable.} =
    m.a.inc
    if m.a == m.umod.uint32:
      m.a = 0
    return m
  proc `++`*(m: var ModInt):ModInt {.inline discardable.} = m.inc

  proc dec*(m: var ModInt):ModInt {.inline discardable.} =
    if m.a == 0.uint32:
      m.a = m.umod - 1
    else:
      m.a.dec
    return m
  proc `--`*(m: var ModInt):ModInt {.inline discardable.} = m.dec

  generatePow(ModInt)
  
  # TODO: intのところはSomeIntegerに拡張したいがそうするとSystem.nimのuintのconverterとバッティングする。。。
  template useStaticModint*(name, M) =
    generateConverter(name, int, StaticModInt[M])
  template useDynamicModInt*(name, M) =
    generateConverter(name, int, DynamicModInt[M])

  # TODO: Nimのstatic[int]を使うconverterがバグっていて個々に宣言しないとconverterが使えない
  # したがって、下記以外のmodintを使う場合はuseStaticModIntあるいはuseDynamicModIntで宣言が必要
  useStaticModInt(modint998244353, 998244353)
  useStaticModInt(modint1000000007, 1000000007)
  useDynamicModInt(modint, -1)

  import std/math as math_lib_modint
  proc estimateRational*(a:ModInt, ub:int = int(sqrt(float(ModInt.mod))), output_stderr:static[bool] = false):string =
    var v:seq[tuple[s, n, d: int]]
    for d in 1 .. ub:
      var n = (a * d).val
      # n or mod - n
      if n * 2 > a.mod:
        n = - (a.mod - n)
      if gcd(n, d) > 1: continue
      v.add((n.abs + d, n, d))
    v.sort
    when output_stderr:
      stderr.write "estimation result: ", v
    return $v[0].n & "/" & $v[0].d

  # TODO:
  # Modint -> intのconverterあるとmint(2) * 3みたいなのがintになっちゃう
  # converter toInt*(m: ModInt):int {.inline.} = m.val


