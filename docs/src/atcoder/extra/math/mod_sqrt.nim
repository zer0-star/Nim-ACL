# modSqrt {{{
when not declared ATCODER_MODSQRT_HPP:
  const ATCODER_MODSQRT_HPP* = 1
  import atcoder/modint
  import std/options
  
  proc modSqrt*[T:ModInt](a:T):Option[T] =
    let p = a.umod.int
    if a == 0: return T(0).some
    if p == 2: return T(a).some
    if a.pow((p - 1) shr 1) != 1: return none(T)
    var b = T(1)
    while b.pow((p - 1) shr 1) == 1: b += 1
    var
      e = 0
      m = p - 1
    while m mod 2 == 0: m = m shr 1; e.inc
    var
      x = a.pow((m - 1) shr 1)
      y = a * x * x
    x *= a
    var z = b.pow(m)
    while y != 1:
      var
        j = 0
        t = y
      while t != 1:
        j.inc
        t *= t
      z = z.pow(1 shl (e - j - 1))
      x *= z
      z *= z
      y *= z
      e = j
    return T(x).some
#}}}
