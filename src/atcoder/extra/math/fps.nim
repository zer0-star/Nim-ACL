when not declared ATCODER_EXTRA_MATH_FPS:
  const ATCODER_EXTRA_MATH_FPS* = 1

  import std/macros
  import std/strutils
  import atcoder/modint
  import atcoder/extra/math/ntt
  import atcoder/extra/math/formal_power_series
  import atcoder/extra/math/formal_power_series_sqrt

  export modint
  export ntt
  export formal_power_series
  export formal_power_series_sqrt

  template useFPSPrecTemplate*(T: typedesc, F, x: untyped, p: static[int]) =
    static:
      doAssert p >= 0, "useFPS(..., prec = N) requires N >= 0"

    proc `F`*(a: int, n = p): FormalPowerSeries[T] =
      result = initFormalPowerSeries[T](@[a])
      if n >= 0:
        result.resize(n)

    proc `F`*(a: T, n = p): FormalPowerSeries[T] =
      result = initFormalPowerSeries[T](@[a])
      if n >= 0:
        result.resize(n)

    proc `F`*(a: seq, n = p): FormalPowerSeries[T] =
      result = initFormalPowerSeries[T](a)
      if n >= 0:
        result.resize(n)

    proc `F`*[N: static[int], U](a: array[N, U], n: int = p): FormalPowerSeries[T] =
      var v = newSeq[U](N)
      for i in 0 ..< N:
        v[i] = a[i]
      result = initFormalPowerSeries[T](v)
      if n >= 0:
        result.resize(n)
    proc `F`*(f: SparseFormalPowerSeries[T], n = p): FormalPowerSeries[T] =
      result = f
      if n >= 0:
        result.resize(n)

    proc `F`*(f: FormalPowerSeries[T], n = p): FormalPowerSeries[T] =
      result = f
      if n >= 0:
        result.resize(n)

    proc `F`*(f: static[string], n = p): FormalPowerSeries[T] =
      result = initFPS[T](f)
      if n >= 0:
        result.resize(n)

    var `x` {.inject, used.} = initVar[T]()

  macro useFPS*(a, F, prec: untyped): untyped =
    if a.len != 2:
      error("useFPS expects the first argument like mint{x}; example: useFPS(mint{x}, F, prec = 100)", a)

    let T = a[0]
    let x = a[1]

    result = quote do:
      useFPSPrecTemplate(`T`, `F`, `x`, `prec`)


  proc parseFPSDeclString(decl: string, origin: NimNode): tuple[F, T, x: NimNode] =
    let eq = decl.find('=')
    if eq <= 0 or eq >= decl.high:
      error("useFPSDecl string declaration expects F = mint{x} or F = mint<x>", origin)

    let lhs = decl[0 ..< eq].strip()
    let rhs = decl[eq + 1 .. ^1].strip()

    if lhs.len == 0 or rhs.len == 0:
      error("useFPSDecl string declaration expects F = mint{x} or F = mint<x>", origin)

    var l, r: int

    if rhs.endsWith("}"):
      l = rhs.find('{')
      r = rhs.rfind('}')
    elif rhs.endsWith(">"):
      l = rhs.find('<')
      r = rhs.rfind('>')
    else:
      error("useFPSDecl string declaration expects the right hand side like mint{x} or mint<x>", origin)

    if l <= 0 or r != rhs.high or l + 1 >= r:
      error("useFPSDecl string declaration expects the right hand side like mint{x} or mint<x>", origin)

    let typeName = rhs[0 ..< l].strip()
    let varName = rhs[l + 1 ..< r].strip()

    if typeName.len == 0 or varName.len == 0:
      error("useFPSDecl string declaration expects the right hand side like mint{x} or mint<x>", origin)

    result = (parseExpr(lhs), parseExpr(typeName), parseExpr(varName))

  macro useFPSDecl*(args: varargs[untyped]): untyped =
    var decl: NimNode = nil
    var prec: NimNode = nil

    for arg in args:
      if arg.kind == nnkExprEqExpr and arg[0].eqIdent("prec"):
        if not prec.isNil:
          error("useFPSDecl got duplicate prec argument", arg)
        prec = arg[1]
      else:
        if not decl.isNil:
          error("useFPSDecl expects exactly one declaration and one prec argument", arg)
        decl = arg

    if decl.isNil:
      error("useFPSDecl expects a declaration, e.g. useFPSDecl(H = mint{z}, prec = 100)")
    if prec.isNil:
      error("useFPSDecl expects prec = N, e.g. useFPSDecl(H = mint{z}, prec = 100)")

    var F, T, x: NimNode

    if decl.kind in {nnkStrLit, nnkRStrLit, nnkTripleStrLit}:
      let parsed = parseFPSDeclString(decl.strVal, decl)
      F = parsed.F
      T = parsed.T
      x = parsed.x
    else:
      let e = decl

      if e.kind notin {nnkAsgn, nnkExprEqExpr}:
        error("useFPSDecl expects F = mint{x}", e)

      F = e[0]
      let rhs = e[1]

      if rhs.len != 2:
        error("useFPSDecl expects the right hand side like mint{x}", rhs)

      T = rhs[0]
      x = rhs[1]

    result = quote do:
      useFPSPrecTemplate(`T`, `F`, `x`, `prec`)

