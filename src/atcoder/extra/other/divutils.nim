when not declared ATCODER_DIVUTILS_HPP:
  const ATCODER_DIVUTILS_HPP* = 1
  proc ceilDiv*[T:SomeInteger](a, b:T):T =
    assert b != 0
    if b < 0: return ceilDiv(-a, -b)
    result = a.floorDiv(b)
    if a mod b != 0: result.inc

  template `/^`*[T:SomeInteger](a, b:T):T = ceilDiv(a, b)
  template `/_`*[T:SomeInteger](a, b:T):T = floorDiv(a, b)
