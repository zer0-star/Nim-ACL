when not declared ATCODER_KITAMASA_HPP:
  const ATCODER_KITAMASA_HPP* = 1

  import atcoder/extra/math/ntt
  import atcoder/extra/math/formal_power_series
  import atcoder/extra/math/matrix
  import atcoder/extra/math/characteristic_polynomial

  proc kitamasa*[M:SomeMatrix](A:M, b:M.Vector, k:int):M.Vector =
    # A^n * bを高速に計算する
    var c = initFormalPowerSeries[M.T](A.characteristicPolynomial())
    let n = A.height
    var
      k = k
      a, p = initFormalPowerSeries[M.T](n)
    p[0] = 1
    a[1] = 1
    while k > 0:
      if k mod 2 == 1:
        p = p * a mod c
      k = k div 2
      a = a * a mod c
    result = M.initVector(n)
    block:
      var b = b
      for t in p:
        for i in 0 ..< n:
          result[i] += b[i] * t
        b = A * b
