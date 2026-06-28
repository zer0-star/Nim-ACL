when not declared ATCODER_EXTRA_COMPOSITION_FPS:
  const ATCODER_EXTRA_COMPOSITION_FPS* = 1
  import std/sequtils
  import atcoder/extra/math/formal_power_series
  import atcoder/extra/other/algorithmutils
  # f(g(x)) を計算
  proc composition*[mint](g, f: FormalPowerSeries[mint], deg = -1):FormalPowerSeries[mint] =
    proc dfs(Q:FormalPowerSeries[mint], n, h, k:int):FormalPowerSeries[mint] =
      var Q = Q
      if n == 0:
        var T = Q[0 ..< k]
        T.add 1
        var
          u = g * T.rev().inv().rev()
          P = initFormalPowerSeries[mint](h * k)
        #debug k, h, u.len, P.len, g.len
        for i in 0 ..< min(g.len, k):
          P[k - 1 - i] = u[i + k]
        return P
      var
        nQ = initFormalPowerSeries[mint](4 * h * k)
        nR = initFormalPowerSeries[mint](2 * h * k)
      for i in 0 ..< k:
        copy(Q, i * h .. i * h + n, nQ, i * 2 * h)
      nQ[k * 2 * h] += 1
      nQ = nQ.fft()
      # nQ.ntt()
      block:
        var i = 0
        while i < 4 * h * k:
          swap(nQ[i], nQ[i + 1])
          i += 2
      for i in 0 ..< 2 * h * k: nR[i] = nQ[i * 2] * nQ[i * 2 + 1]
      nR = nR.ifft(mint)
      #nR.intt()
      nR[0] -= 1
      Q = newSeqWith(h * k, mint(0))
      #Q.assign(h * k, 0);
      for i in 0 ..< 2 * k:
        for j in 0 .. n div 2:
          Q[i * h div 2 + j] = nR[i * h + j]
      var
        P = dfs(Q, n div 2, h div 2, k * 2)
        nP = initFormalPowerSeries[mint](4 * h * k)
      for i in 0 ..< 2 * k:
        for j in 0 .. n div 2:
          nP[i * 2 * h + j * 2 + n mod 2] = P[i * h div 2 + j]
      nP = nP.fft()
      #nP.ntt()
      block:
        var i = 2
        while i < 4 * h * k:
          nQ.reverse(i ..< i * 2)
          i *= 2
      for i in 0 ..< 4 * h * k: nP[i] *= nQ[i]
      nP = nP.ifft(mint)
      #nP.intt()
      P = newSeqWith(h * k, mint(0))
      #P.assign(h * k, 0)
      for i in 0 ..< k:
        copy(nP, i * 2 * h .. i * 2 * h + n, P, i * h)
      return P
    var
      f = f
      g = g
      deg = deg
    #if deg == -1: deg = max(f.len, g.len)
    if deg == -1: deg = (f.len - 1) * (g.len - 1) + 1
    f.setLen(deg)
    g.setLen(deg)
    let
      n = f.len - 1
      k = 1
    var
      h = 1
    while h < n + 1: h *= 2
    var Q = initFormalPowerSeries[mint](h * k)
    for i in 0 .. n: Q[i] = -f[i]
    var P = dfs(Q, n, h, k)
    return P.pre(n + 1).rev()
