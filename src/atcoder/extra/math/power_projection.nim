when not declared ATCODER_POWER_PROJECTION_HPP:
  const ATCODER_POWER_PROJECTION_HPP* = 1
  # [x^n] f(x)^i g(x) を i=0,1,...,n で列挙
  # 簡単のため [x^0] f = 0 を仮定
  import atcoder/extra/math/ntt
  import atcoder/extra/math/formal_power_series
  import atcoder/extra/math/fft2d
  import std/sequtils
  proc power_projection*[mint](f, g: FormalPowerSeries[mint]):FormalPowerSeries[mint] =
    type fps = FormalPowerSeries[mint]
    assert f.len == g.len
    var
      n = f.len - 1
      k = 1
    var
      P = newSeqWith(n + 1, initFormalPowerSeries[mint](k + 1))
      Q = newSeqWith(n + 1, initFormalPowerSeries[mint](k + 1))
    Q[0][0] = 1
    for i in 0 .. n: P[i][0] = g[i]
    for i in 0 .. n: Q[i][1] = -f[i]
    while n > 0:
      var R = Q
      for i in countup(1, n, 2): R[i] = -R[i]
      let
        S = multiply2d(P, R)
        T = multiply2d(Q, R);
      var
        U = newSeqWith(n div 2 + 1, initFormalPowerSeries[mint](k * 2 + 1))
        V = newSeqWith(n div 2 + 1, initFormalPowerSeries[mint](k * 2 + 1))
      for i in 0 .. n div 2: U[i] = S[i * 2 + n mod 2]; V[i] = T[i * 2]
      P = U; Q = V
      n = n div 2
      k *= 2
    return (P[0] * Q[0].inv()).pre(f.len)
