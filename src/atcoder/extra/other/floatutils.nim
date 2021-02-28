when not declared ATCODER_FLOAT_UTILS_HPP:
  const ATCODER_FLOAT_UTILS_HPP* = 1
  import std/math as math_lib_floatutils
  proc getParameters*(Real:typedesc):ptr[tuple[n:int, pi, eps, inf:Real]] =
    var p {.global.}:tuple[n:int, pi, eps, inf:Real]
    return p.addr

  converter floatConverter*(a:SomeInteger):float = a.float

  proc getPi*(Real:typedesc):Real = Real.getParameters()[].pi
  proc getEPS*(Real:typedesc):Real = Real.getParameters()[].eps
  proc getINF*(Real:typedesc):Real = Real.getParameters()[].inf
  proc setEPS*(Real:typedesc, x:Real) = Real.getParameters()[].eps = x

  proc valid_range*[Real](l, r:Real):bool =
    # assert(l <= r)
    var (l, r) = (l, r)
    if l > r: swap(l, r)
    let d = r - l
    let eps = Real.getEPS
    if d < eps: return true
    if l <= Real(0) and Real(0) <= r: return false
    return d < eps * min(abs(l), abs(r))

  # float comp
  # TODO: relative error
  proc `=~`*[Real](a,b:Real):bool = abs(a - b) < Real.getEPS
  proc `!=~`*[Real](a,b:Real):bool = abs(a - b) > Real.getEPS
  proc `<~`*[Real](a,b:Real):bool = a + Real.getEPS < b
  proc `>~`*[Real](a,b:Real):bool = a > b + Real.getEPS
  proc `<=~`*[Real](a,b:Real):bool = a < b + Real.getEPS
  proc `>=~`*[Real](a,b:Real):bool = a + Real.getEPS > b

  proc initPrec*(Real:typedesc[SomeFloat], n = 0) =
    when Real is float or Real is float64:
      Real.getParameters()[] = (n, PI.Real, 1e-9.Real, Inf.Real)
    elif Real is float32:
      Real.getParameters()[] = (n, PI.Real, 1e-6.Real, Inf.Real)

  proc estimateRational*[Real](x:Real, n:int) =
    var m = Real.getInf
    var q = 1
    while q <= n:
      let p = round(x * q.Real)
      let d = abs(p / q.Real - x)
      if d < m:
        m = d
        echo "found: ", p, "/", q, "   ", "error: ", d
      q.inc
    return

  float.initPrec()
  float32.initPrec()
  float64.initPrec()
