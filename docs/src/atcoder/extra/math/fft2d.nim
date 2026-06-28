when not declared ATCODER_FFT2d_HPP:
  const ATCODER_FFT2d_HPP* = 1
  import atcoder/extra/math/ntt, atcoder/extra/math/formal_power_series
  import std/sequtils

  proc fft2d*[mint](a: var seq[FormalPowerSeries[mint]]) =
    let
      H = a.len
      W = a[0].len
    assert (H and (H - 1)) == 0
    assert (W and (W - 1)) == 0
    type FT = getFFTType(mint)
    for i in 0 ..< H:
      var ok = false
      for x in a[i]:
        if x != mint(0):
          ok = true;
          break
      if ok: FT.inplace_fft(a[i])
    var buf = initFormalPowerSeries[mint](H)
    for i in 0 ..< W:
      for j in 0 ..< H:
        buf[j] = a[j][i]
      FT.inplace_fft(buf)
      for j in 0 ..< H: a[j][i] = buf[j]
  
  proc ifft2d*[mint](a: var seq[FormalPowerSeries[mint]]) =
    let
      H = a.len
      W = a[0].len
    assert (H and (H - 1)) == 0
    assert (W and (W - 1)) == 0

    type FT = getFFTType(mint)

    var buf = initFormalPowerSeries[mint](H)
    for i in 0 ..< W:
      for j in 0 ..< H:
        buf[j] = a[j][i]
      FT.inplace_ifft(buf)
      for j in 0 ..< H: a[j][i] = buf[j]

    for i in 0 ..< H:
      var ok = false
      for x in a[i]:
        if x != mint(0):
          ok = true
          break
      if ok: FT.inplace_ifft(a[i])
  
  proc transpose[mint](f: seq[FormalPowerSeries[mint]]): seq[FormalPowerSeries[mint]] =
    let
      H = f.len
      W = f[0].len
    for v in f: assert v.len == W
    var g = newSeqWith(W, initFormalPowerSeries[mint](H))
    for i in 0 ..< H:
      for j in 0 ..< W:
        g[j][i] = f[i][j];
    return g

  type fps2d[mint] = seq[FormalPowerSeries[mint]]
  proc multiply2d_naive*[mint](a, b: fps2d[mint]): fps2d[mint] =
    if a.len == 0 or b.len == 0: return
    if a[0].len == 0 or b[0].len == 0: return
    let
      (Ha, Wa) = (a.len, a[0].len)
      (Hb, Wb) = (b.len, b[0].len)
    for v in a: assert v.len == Wa
    for v in b: assert v.len == Wb
    var c = newSeqWith(Ha + Hb - 1, initFormalPowerSeries[mint](Wa + Wb - 1))
    for ia in 0 ..< Ha:
      for ja in 0 ..< Wa:
        for ib in 0 ..< Hb:
          for jb in 0 ..< Wb:
            c[ia + ib][ja + jb] += a[ia][ja] * b[ib][jb]
    return c
  
  proc multiply2d_partially_naive*[mint](a, b: fps2d[mint]):fps2d[mint] =
    if a.len == 0 or b.len == 0: return
    if a[0].len == 0 or b[0].len == 0: return
    var
      (Ha, Wa) = (a.len, a[0].len)
      (Hb, Wb) = (b.len, b[0].len)
    for v in a: assert v.len == Wa
    for v in b: assert v.len == Wb
  
    if min(Ha, Hb) * min(Wa, Wb) <= 40:
      return multiply2d_naive(a, b)
  
    var W = 1
    while W < Wa + Wb - 1: W *= 2
    var (a, b) = (a, b)
  
    if W >= 64 and Wa + Wb - 1 <= W div 2 + 20:
      if Wa <= 20: swap(a, b); swap(Ha, Hb); swap(Wa, Wb)
      let d = Wa + Wb - 1 - W div 2
      var
        a1 = newSeq[FormalPowerSeries[mint]](Ha)
        a2 = newSeq[FormalPowerSeries[mint]](Ha)
      for i in 0 ..< Ha:
        a1[i] = a[i][0 ..< a[i].len - d]
        a2[i] = a[i][a[i].len - d ..< a[i].len]
      var
        c1 = multiply2d_partially_naive(a1, b)
        c2 = multiply2d_partially_naive(a2, b)
      for i in 0 ..< Ha + Hb - 1:
        c1[i] += c2[i] shl (Wa - d)
        c1[i].resize(Wa + Wb - 1)
      return c1
    type FT = getFFTType(mint)
  
    for v in a.mitems: v.resize(W); FT.inplace_fft(v)
    for v in b.mitems: v.resize(W); FT.inplace_fft(v)
    var cT: fps2d[mint]
    for j in 0 ..< W:
      var
        bufa = initFormalPowerSeries[mint](Ha)
        bufb = initFormalPowerSeries[mint](Hb)
      for i in 0 ..< Ha: bufa[i] = a[i][j]
      for i in 0 ..< Hb: bufb[i] = b[i][j]
      cT.add(bufa * bufb)
    var c = transpose(cT)
    for v in c.mitems: FT.inplace_ifft(v); v.resize(Wa + Wb - 1)
    return c
  
  proc multiply2d*[mint](a, b: fps2d[mint]):fps2d[mint] =
    if a.len == 0 or b.len == 0: return
    if a[0].len == 0 or b[0].len == 0: return
    var
      (Ha, Wa) = (a.len, a[0].len)
      (Hb, Wb) = (b.len, b[0].len)
    for v in a: assert v.len == Wa
    for v in b: assert v.len == Wb

    if min(Ha, Hb) * min(Wa, Wb) <= 40: return multiply2d_naive(a, b)
    if min(Ha, Hb) <= 40: return multiply2d_partially_naive(a, b)
    if min(Wa, Wb) <= 40:
      let
        aT = transpose(a)
        bT = transpose(b)
        cT = multiply2d_partially_naive(aT, bT)
      return transpose(cT)
  
    var (H, W) = (1, 1)
    while H < Ha + Hb - 1: H *= 2
    while W < Wa + Wb - 1: W *= 2
  
    if Wa + Wb - 1 < W div 2 + 20:
      let d = Wa + Wb - 1 - W div 2
      var
        a1 = newSeq[FormalPowerSeries[mint]](Ha)
        a2 = newSeq[FormalPowerSeries[mint]](Ha)
      for i in 0 ..< Ha:
        a1[i] = a[i][0 ..< a[i].len - d]
        a2[i] = a[i][a[i].len - d ..< a[i].len]
      var
        c1 = multiply2d(a1, b)
        c2 = multiply2d(a2, b)
      for i in 0 ..< Ha + Hb - 1:
        c1[i] += c2[i] shl (Wa - d)
        c1[i].resize(Wa + Wb - 1)
      return c1
    if Ha + Hb - 1 < H div 2 + 20:
      let
        aT = transpose(a)
        bT = transpose(b)
        cT = multiply2d(aT, bT)
      return transpose(cT)
    var (a, b) = (a, b)
    a.setLen(H); b.setLen(H)
    for v in a.mitems: v.resize(W)
    for v in b.mitems: v.resize(W)
    fft2d(a); fft2d(b)
    for i in 0 ..< H:
      for j in 0 ..< W:
        a[i][j] *= b[i][j];
    ifft2d(a)
    a.setLen(Ha + Hb - 1)
    for v in a.mitems: v.resize(Wa + Wb - 1)
    return a
