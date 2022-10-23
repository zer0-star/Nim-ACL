when not declared ATCODER_CHARACTERISTIC_POLYNOMIAL_HPP:
  const ATCODER_CHARACTERISTIC_POLYNOMIAL_HPP* = 1
  import atcoder/extra/math/matrix
  import std/random

  # 特性多項式を計算する
  proc characteristicPolynomial*[M:SomeMatrix](A:M):seq[M.T] =
    let n = A.height
    doAssert A.width == n
    var b = M.initVector(n)
    for i in 0 ..< n:
      b[i] = random.rand(0 ..< A.T.mod)
    var P = M.init(n, n + 1)
    for i in 0 .. n:
      for j in 0 ..< n:
        P[j, i] = b[j]
      b = A * b
    var
      z = M.initVector(n + 1)
      o = P.linearEquations(z)
      v = o.get()[1]
    #doAssert v.len == 1
    for j in v.len:
      if v[j][^1] != 0:
        result = v[j]
        break
    block:
      let p = 1 / result[^1]
      for t in result.mitems: t *= p


