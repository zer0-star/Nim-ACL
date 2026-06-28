when not declared ATCODER_CHIRPZ_HPP:
  const ATCODER_CHIRPZ_HPP* = 1
  import atcoder/extra/math/formal_power_series
  import std/sequtils
  # f(A W^0), f(A W^1), ..., f(A W^{N-1}) を返す
  proc ChirpZ*[mint](f:FormalPowerSeries[mint], W: mint, N: int, A: mint): FormalPowerSeries[mint] =
    mixin init, inv
    const
      ０ = mint.init(0)
      １ = mint.init(1)
    var
      f = f
      N = N
    if N == -1: N = f.len
    if f.len == 0 or N == 0:
      return initFormalPowerSeries[mint](N)
    var M = f.len
    if A != mint.init(1):
      var x = mint.init(1)
      for i in 0 ..< M:  f[i] *= x; x *= A
    if W == ０:
      var F = newSeqWith(N, f[0])
      for i in 1 ..< M: F[0] += f[i]
      return F
    var
      wc = initFormalPowerSeries[mint](N + M)
      iwc = initFormalPowerSeries[mint](max(N, M))
      ws = １
      iW = W.inv()
      iws = １
    wc[0] = １; iwc[0] = １
    for i in 1 ..< N + M: wc[i] = ws * wc[i - 1]; ws *= W
    for i in 1 ..< max(N, M): iwc[i] = iws * iwc[i - 1]; iws *= iW
    for i in 0 ..< M: f[i] *= iwc[i]
    f.reverse
    var
      g = f * wc
      F = g[M - 1 ..< M + N - 1]
    for i in 0 ..< N: F[i] *= iwc[i]
    return F
  proc ChirpZ*[mint](f:FormalPowerSeries[mint], W: mint, N = -1): FormalPowerSeries[mint] =
    mixin init
    ChirpZ(f, W, N, mint.init(1))
