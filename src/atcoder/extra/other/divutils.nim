when not declared ATCODER_DIVUTILS_HPP:
  const ATCODER_DIVUTILS_HPP* = 1
  import std/math
  proc ceilDiv*[T:SomeInteger](a, b:T):T =
    assert b != 0
    if b < 0: return ceilDiv(-a, -b)
    return (a + b - 1).floorDiv(b)
  proc ceilMod*[T:SomeInteger](a, b:T):T =
    let z = ceilDiv(a, b)
    return a - z * b
  template `/.`*[T:SomeInteger](a, b:T):T = floorDiv(a, b)
  template `/^`*[T:SomeInteger](a, b:T):T = ceilDiv(a, b)
  template `%.`*[T:SomeInteger](a, b:T):T = floorMod(a, b)
  template `%^`*[T:SomeInteger](a, b:T):T = ceilMod(a, b)
