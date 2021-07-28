when not declared ATCODER_INF_HPP:
  const ATCODER_INF_HPP* = 1
  template inf*(T:typedesc): untyped = 
    when T is SomeFloat: T(Inf)
    elif T is SomeInteger: T.high div 2
    else:
      static: assert(false)
  proc `∞`*(T:typedesc):T = T.inf
  proc `*!`*[T:SomeInteger](a, b:T):T =
    if a == T(0) or b == T(0): return T(0)
    var sgn = T(1)
    if a < T(0): sgn = -sgn
    if b < T(0): sgn = -sgn
    let a = abs(a)
    let b = abs(b)
    if b > T.inf div a: result = T.inf
    else: result = min(T.inf, a * b)
    result *= sgn
  proc `+!`*[T:SomeInteger](a, b:T):T =
    result = a + b
    result = min(T.inf, result)
    result = max(-T.inf, result)
  proc `-!`*[T:SomeInteger](a, b:T):T =
    result = a - b
    result = min(T.inf, result)
    result = max(-T.inf, result)
