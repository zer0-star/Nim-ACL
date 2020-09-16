when not defined ATCODER_MODINT_HPP:
  const ATCODER_MODINT_HPP* = 1

  type
    ModInt*[M: static[int]] = distinct int

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

  proc initModInt*(v: int or ModInt; M: static[int] = 1_000_000_007): ModInt[M] {.inline.} =
    when v is ModInt: return v
    else:
      if 0 <= v:
        if v < M: return ModInt[M](v)
        else: return ModInt[M](v mod M)
      else:
        var vm = v mod M
        if vm < 0: vm += M
        return ModInt[M](vm)

  proc initModIntRaw*(v: int = 0; M: static[int] = 1_000_000_007): ModInt[M] {.inline.} =
    ModInt[M](v)

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
    ModInt[M](M - int(m))

  template generateDefinitions(name, l, r, retType, body: untyped): untyped =
    proc name*[M: static[int]](l: ModInt[M]; r: ModInt[M]): retType {.inline.} =
      body
    proc name*[M: static[int]](l: SomeInteger; r: ModInt[M]): retType {.inline.} =
      body
    proc name*[M: static[int]](l: ModInt[M]; r: SomeInteger): retType {.inline.} =
      body

#  proc inv*[M: static[int]](m: ModInt[M]): ModInt[M] {.inline.} =
#    result = initModInt(extgcd(M, int(m))[1], M)

  proc `+=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.} =
    int(m) += initModInt(n, M).int
    if int(m) >= M: int(m) -= M

  proc `-=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.} =
    int(m) -= initModInt(n, M).int
    if int(m) < 0: int(m) += M

  proc `*=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.} =
    int(m) *= initModInt(n, M).int
    int(m) = int(m) mod M
#    m.retake()

  proc `/=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.} =
    int(m) *= initModInt(n, M).inv().int
    int(m) = int(m) mod M
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
    int(m) == int(n)

  proc inc*[M: static[int]](m: var ModInt[M]) {.inline.} =
    int(m).inc
    if m == M:
      int(m) = 0

  proc dec*[M: static[int]](m: var ModInt[M]) {.inline.} =
    if m == 0:
      int(m) = M - 1
    else:
      int(m).dec

  proc pow*[M: static[int]](m: ModInt[M]; p: SomeInteger): ModInt[M] {.inline.} =
    var
      p = p.int
      m = m
    int(result) = 1
    while p > 0:
      if (p and 1) == 1:
        result *= m
      m *= m
      p = p shr 1
