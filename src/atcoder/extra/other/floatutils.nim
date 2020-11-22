when not declared ATCODER_FLOAT_UTILS_HPP:
  const ATCODER_FLOAT_UTILS_HPP* = 1
  import std/math
  proc getParameters*(Real:typedesc):ptr[tuple[n:int, pi, eps:Real]] =
    var p {.global.}:tuple[n:int, pi, eps:Real]
    return p.addr

  proc getPi*(Real:typedesc):Real = Real.getParameters()[].pi
  proc getEPS*(Real:typedesc):Real = Real.getParameters()[].eps
  proc setEPS*(Real:typedesc, x:Real) = Real.getParameters()[].eps = x

  # float comp
  proc `=~`*[Real](a,b:Real):bool = abs(a - b) < Real.getEPS
  proc `!=~`*[Real](a,b:Real):bool = abs(a - b) > Real.getEPS
  proc `<~`*[Real](a,b:Real):bool = a + Real.getEPS < b
  proc `>~`*[Real](a,b:Real):bool = a > b + Real.getEPS
  proc `<=~`*[Real](a,b:Real):bool = a < b + Real.getEPS
  proc `>=~`*[Real](a,b:Real):bool = a + Real.getEPS > b

  proc initPrec*(Real:typedesc[SomeFloat], n = 0) =
    when Real is float or Real is float64:
      Real.getParameters()[] = (n, PI.Real, 0.0000000001.Real)
    elif Real is float32:
      Real.getParameters()[] = (n, PI.Real, 0.0000001.Real)

  float.initPrec()
  float32.initPrec()
  float64.initPrec()
