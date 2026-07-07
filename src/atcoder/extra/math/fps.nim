when not declared ATCODER_EXTRA_MATH_FPS:
  const ATCODER_EXTRA_MATH_FPS* = 1

  import std/macros
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

    proc `F`*[N: static[int], U](a: array[N, U], n = p): FormalPowerSeries[T] =
      result = initFormalPowerSeries[T](a)
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

    var e: NimNode

    if decl.kind in {nnkStrLit, nnkRStrLit, nnkTripleStrLit}:
      let st = parseStmt(decl.strVal)
      if st.len != 1:
        error("useFPSDecl string declaration expects one assignment, e.g. useFPSDecl(\"H = mint{z}\", prec = 100)", decl)
      e = st[0]
    else:
      e = decl

    if e.kind notin {nnkAsgn, nnkExprEqExpr}:
      error("useFPSDecl expects F = mint{x}", e)

    let F = e[0]
    let rhs = e[1]

    if rhs.len != 2:
      error("useFPSDecl expects the right hand side like mint{x}", rhs)

    let T = rhs[0]
    let x = rhs[1]

    result = quote do:
      useFPSPrecTemplate(`T`, `F`, `x`, `prec`)

