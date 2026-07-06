when not declared ATCODER_POLYNOMIAL_HPP:
  const ATCODER_POLYNOMIAL_HPP* = 1

  #import atcoder/extra/math/combination
  import std/sequtils
  
  type poly*[T] = seq[T]
  
  proc `+=`*[T](a:var poly[T], b:poly[T]) =
    while a.len < b.len: a.add T(0)
    for i in 0..<b.len:a[i] += b[i]

  proc `+`*[T](a, b:poly[T]):poly[T] =
    result = a
    result += b

  proc `-=`*[T](a:var poly[T], b:poly[T]) =
    while a.len < b.len: a.add T(0)
    for i in 0..<b.len:a[i] -= b[i]

  proc `-`*[T](a, b:poly[T]):poly[T] =
    result = a
    result -= b

  proc `*`*[T](a, b:poly[T]):poly[T] =
    result = newSeqWith(a.len + b.len - 1, T(0))
    for i in 0..<a.len:
      for j in 0..<b.len:
        result[i + j] += a[i] * b[j]
  
  proc `*`*[T](a:poly[T], d:T):poly[T] =
    result = a
    for a in result.mitems: a *= d
  
  proc eval*[T](p:poly[T], x:T):T =
    result = T(0)
    for i in countdown(p.len - 1, 0):
      result *= x
      result += p[i]
  
  proc integral*[T](p:poly[T]):poly[T] =
    result = newSeq[T](p.len + 1)
    for i in 0..<p.len:
      result[i + 1] = p[i] / (i + 1)
