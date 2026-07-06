when not declared ATCODER_FACTORIAL_HPP:
  const ATCODER_FACTORIAL_HPP* = 1
  import atcoder/extra/math/combination
  import atcoder/extra/math/formal_power_series
  import math
  proc factorial*[ModInt](n:int):ModInt =
    if n >= ModInt.mod(): return 0
    if n == 0: return 1
  
    let
      sn = sqrt(n.float).int
      sn_inv = ModInt(1) / sn
  
    proc shift(f:FormalPowerSeries[ModInt], dx:ModInt):auto = 
      let
        n = f.len
        a = dx * sn_inv
      var p1 = f
      for i in 0..<n:
        var d = ModInt.rfact(i) * ModInt.rfact((n - 1) - i)
        if ((n - 1 - i) and 1) != 0: d = -d
        p1[i] *= d
      var p2 = initFormalPowerSeries[ModInt](2 * n)
      for i in 0..<p2.len:
        p2[i] = if ((a.val) + i - n) <= 0: 1 else: (a + i - n).val
      for i in 1..<p2.len:
        p2[i] *= p2[i - 1]
      var
        prod = p2[2 * n - 1]
        prod_inv = ModInt(1) / prod
      for i in countdown(2 * n - 1, 1):
        p2[i] = prod_inv * p2[i - 1]
        prod_inv *= a + i - n
      p2[0] = prod_inv
#      var fft = p2.getFFT()
#      var p3 = fft[].multiply(p1, p2, (int) p2.len)

#      p1 = p3[p1.len..<p2.len]

      p1 = (p1 * p2)[p1.len..<p2.len]
      prod = 1
      for i in 0..<n:
        prod *= a + n - 1 - i
      for i in countdown(n - 1, 0):
        p1[i] *= prod
        prod *= p2[n + i] * (a + i - n)
      return p1
    proc rec(n:int):seq[ModInt] =
      if n == 1: return initFormalPowerSeries[ModInt](@[1, 1 + sn])
      let nh = n shr 1
      var
        a1 = rec(nh)
        a2 = shift(a1, nh)
        b1 = shift(a1, sn * nh)
        b2 = shift(a1, sn * nh + nh)
      for i in 0..nh: a1[i] *= a2[i]
      for i in 1..nh: a1.add(b1[i] * b2[i])
      if (n and 1) != 0:
        for i in 0..<n:
          a1[i] *= n + sn * i
        var prod = ModInt(1)
        for i in n * sn..<n * sn + n:
          prod *= (i + 1)
        a1.add(prod.val)
      return a1;
    let vs = rec(sn)
    result = ModInt(1)
    for i in 0..<sn: result *= vs[i]
    for i in sn * sn + 1..n: result *= i
