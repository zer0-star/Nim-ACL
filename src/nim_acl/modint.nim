when not declared ATCODER_MODINT_HPP:
  const ATCODER_MODINT_HPP* = 1

  type
    ModInt*[M: static[int]] = distinct int

  proc `$`*[M: static[int]](m: ModInt[M]): string {.inline.} =
    $m.int

  proc `mod`*(x, y: int): int {.inline.} =
    ## requires: y > 0
    assert y > 0
    if x < 0:
      y - system.`mod`(-x, y)
    else:
      system.`mod`(x, y)

  proc extgcd*(x, y: int): (int, int) {.inline.} =
    var
      a = x
      p = y
      b, r = 1
      c, q = 0
    while a mod p != 0:
      let t = a div p
      a -= p * t
      b -= q * t
      c -= r * t
      swap(a, p)
      swap(b, q)
      swap(c, r)
    (q, r)

  proc initModInt*(v: int = 0; M: static[int] = 1_000_000_007): ModInt[M] {.inline.} =
    ModInt[M](v mod M)

  proc initModIntRaw*(v: int = 0; M: static[int] = 1_000_000_007): ModInt[M] {.inline.} =
    ModInt[M](v)

  proc retake*[M: static[int]](m: var ModInt[M]) {.inline.} =
    int(m) = int(m) mod M

  proc val*[M: static[int]](m: ModInt[M]): int {.inline.} =
    int(m)

  proc modulo*[M: static[int]](m: ModInt[M]): int {.inline.} =
    M

  proc `-`*[M: static[int]](m: ModInt[M]): ModInt[M] {.inline.} =
    ModInt[M](M - int(m))

  template generateDefinitions(name, l, r, retType, body: untyped): untyped =
    proc name*[M: static[int]](l: ModInt[M]; r: ModInt[M]): retType {.inline.} =
      body
    proc name*[M: static[int]](l: int; r: ModInt[M]): retType {.inline.} =
      body
    proc name*[M: static[int]](l: ModInt[M]; r: int): retType {.inline.} =
      body

  proc inv*[M: static[int]](m: ModInt[M]): ModInt[M] {.inline.} =
    result = initModInt(extgcd(M, int(m))[1], M)

  proc `+=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.} =
    int(m) += int(n)
    m.retake()

  proc `-=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.} =
    int(m) -= int(n)
    m.retake()

  proc `*=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.} =
    int(m) *= int(n)
    m.retake()

  proc `/=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.} =
    int(m) *= extgcd(M, n mod M)[1] mod M
    m.retake()

  generateDefinitions(`+`, m, n, ModInt[M]):
    result += m
    result += n

  generateDefinitions(`-`, m, n, ModInt[M]):
    result += m
    result -= n

  generateDefinitions(`*`, m, n, ModInt[M]):
    result += m
    result *= n

  generateDefinitions(`/`, m, n, ModInt[M]):
    result += m
    result /= n

  proc `==`*[M: static[int]](m: ModInt[M]; n: int | ModInt[M]): bool {.inline.} =
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

  proc pow*[M: static[int]](m: ModInt[M]; p: int): ModInt[M] {.inline.} =
    var
      p = p
      m = m
    int(result) = 1
    while p > 0:
      if (p and 1) == 1:
        result *= m
      m *= m
      p = p shr 1
