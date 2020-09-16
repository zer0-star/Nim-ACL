when not defined ATCODER_MODINT_HPP:
  const ATCODER_MODINT_HPP* = 1

  type
    ModInt*[M: static[int]] = distinct uint32

  proc `$`*[M: static[int]](m: ModInt[M]): string {.inline.} =
    $m.int

  #proc modulo*(x, y: int): int {.inline.} =
  #  ## requires: y > 0
  #  assert y > 0
  #  if x < 0:
  #    let tmp = (-x) mod y
  #    if tmp == 0:
  #      0
  #    else:
  #      y - tmp
  #  else:
  #    x mod y

  #proc extgcd*(x, y: int): (int, int) {.inline.} =
  #  var
  #    a = x
  #    p = y
  #    b, r = 1
  #    c, q = 0
  #  while a mod p != 0:
# #   while a.modulo(p) != 0:
  #    let t = a div p
  #    a -= p * t
  #    b -= q * t
  #    c -= r * t
  #    swap(a, p)
  #    swap(b, q)
  #    swap(c, r)
  #  (q, r)

  proc initModInt*(v: SomeInteger or ModInt; M: static[int] = 1_000_000_007): ModInt[M] {.inline.} =
    when v is ModInt: return v
    else:
      if 0 <= v:
        if v < M: return ModInt[M](v.uint32)
        else: return ModInt[M]((v mod M).uint32)
      else:
        var v = v mod M
        if v < 0: v += M
        return ModInt[M](v.uint32)
#  converter toModInt[M:static[int]](n:SomeInteger):ModInt[M] {.inline.}= initModInt(n, M)

  proc initModIntRaw*(v: SomeInteger; M: static[int] = 1_000_000_007): ModInt[M] {.inline.} =
    ModInt[M](v.uint32)

  proc inv[M:static[int]](v:ModInt[M]):ModInt[M] {.inline.} =
    var
      a = initModInt(v, M).int
      b = M
      u = 1
      v = 0
    while b > 0:
      let t = a div b
      a -= t * b;swap(a, b)
      u -= t * v;swap(u, v)
    return initModInt(u, M)

#  proc retake*[M: static[int]](m: var ModInt[M]) {.inline.} =
#    int(m) = int(m).modulo(M)

  proc val*[M: static[int]](m: ModInt[M]): int {.inline.} =
    int(m)

  proc modulo*[M: static[int]](m: ModInt[M]): int {.inline.} =
    M

  proc `-`*[M: static[int]](m: ModInt[M]): ModInt[M] {.inline.} =
    if int(m) == 0: return m
    else: return ModInt[M](M - int(m))

  template generateDefinitions(name, l, r, retType, body: untyped): untyped {.dirty.} =
    proc name*[M: static[int]](l: ModInt[M]; r: ModInt[M]): retType {.inline.} =
      body
    proc name*[M: static[int]](l: SomeInteger; r: ModInt[M]): retType {.inline.} =
      body
    proc name*[M: static[int]](l: ModInt[M]; r: SomeInteger): retType {.inline.} =
      body

#  proc inv*[M: static[int]](m: ModInt[M]): ModInt[M] {.inline.} =
#    result = initModInt(extgcd(M, int(m))[1], M)

  proc `+=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.} =
    uint32(m) += initModInt(n, M).uint32
    if uint32(m) >= M.uint32: uint32(m) -= M.uint32

  proc `-=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.} =
    uint32(m) += M.uint32 - initModInt(n, M).uint32
    if uint32(m) >= M.uint32: uint32(m) -= M.uint32

  proc `*=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.} =
    uint32(m) = (int(m) * initModInt(n, M).int mod M).uint32
#    m.retake()

  proc `/=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.} =
    uint32(m) = (int(m) * initModInt(n, M).inv().int mod M).uint32
#    m.retake()

  generateDefinitions(`+`, m, n, ModInt[M]):
    result = initModInt(m, M)
    result += n

  generateDefinitions(`-`, m, n, ModInt[M]):
    result = initModInt(m, M)
    result -= n

  generateDefinitions(`*`, m, n, ModInt[M]):
    result = initModInt(m, M)
    result *= n

  generateDefinitions(`/`, m, n, ModInt[M]):
    result = initModInt(m, M)
    result /= n

  proc `==`*[M: static[int]](m: ModInt[M]; n: SomeInteger | ModInt[M]): bool {.inline.} =
    int(m) == initModInt(n, M).int

  proc inc*[M: static[int]](m: var ModInt[M]) {.inline.} =
    uint32(m).inc
    if m == M:
      uint32(m) = 0

  proc dec*[M: static[int]](m: var ModInt[M]) {.inline.} =
    if m == 0:
      uint32(m) = M - 1
    else:
      uint32(m).dec

  proc pow*[M: static[int]](m: ModInt[M]; p: SomeInteger): ModInt[M] {.inline.} =
    var
      p = p.int
      m = m
    uint32(result) = 1
    while p > 0:
      if (p and 1) == 1:
        result *= m
      m *= m
      p = p shr 1
