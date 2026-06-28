when not declared ATCODER_ZETA_TRANSFORM_HPP:
  const ATCODER_ZETA_TRANSFORM_HPP* = 1
  import std/bitops, std/math

  proc zeta_transform*[T](f:openArray[T], subset:static[bool] = false,
    add:proc(a:var T, b:T):void =
      proc(a:var T, b:T):void =
        a += b):seq[T] = 
    let n = fastLog2(f.len)
    let N = 2^n
    doAssert f.len == N
    result = f.toSeq

    for k in 0..<n:
      for s in 0..<N:
        when not subset:
          if ((s shr k) and 1) == 0:
            add(result[s], result[s xor (1 shl k)])
        else:
          if ((s shr k) and 1) != 0:
            add(result[s], result[s xor (1 shl k)])

  proc movius_transform*[T](f:openArray[T], subset:static[bool] = false,
    subt:proc(a:var T, b:T):void =
      proc(a:var T, b:T):void =
        a -= b):seq[T] = 
    let n = fastLog2(f.len)
    let N = 2^n
    doAssert f.len == N
    result = f.toSeq

    for k in 0..<n:
      for s in 0..<N:
        when not subset:
          if ((s shr k) and 1) == 0:
            subt(result[s], result[s xor (1 shl k)])
        else:
          if ((s shr k) and 1) != 0:
            subt(result[s], result[s xor (1 shl k)])
  proc zeta_superset*[T](f:openArray[T],
    add:proc(a:var T, b:T):void =
      proc(a:var T, b:T):void =
        a += b):seq[T] =
    zeta_transform[T](f, false, add)
  proc movius_superset*[T](f:openArray[T],
    subt:proc(a:var T, b:T):void =
      proc(a:var T, b:T):void =
        a -= b):seq[T] =
    movius_transform[T](f, false, subt)
  proc zeta_subset*[T](f:openArray[T],
    add:proc(a:var T, b:T):void =
      proc(a:var T, b:T):void =
        a += b):seq[T] =
    zeta_transform[T](f, true, add)
  proc movius_subset*[T](f:openArray[T],
    subt:proc(a:var T, b:T):void =
      proc(a:var T, b:T):void =
        a -= b):seq[T] =
    movius_transform[T](f, true)

