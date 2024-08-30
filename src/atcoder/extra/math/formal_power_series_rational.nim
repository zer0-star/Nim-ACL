when not declared ATCODER_FORMAL_POWER_SERIES_RATIONAL:
  const ATCODER_FORMAL_POWER_SERIES_RATIONAL* = 1
  import atcoder/convolution
  import atcoder/extra/math/formal_power_series
  import std/bitops

  type RationalFormalPowerSeries*[T] = object
    num*, den*: FormalPowerSeries[T]
  type RFPS*[T] = RationalFormalPowerSeries[T]
  #converter toRationalFormalPowerSeries*[T](a:FormalPowerSeries[T]):RationalFormalPowerSeries[T] = RationalFormalPowerSeries[T](num:a, den: @[T(1)])
  proc `//`*[T](P, Q:FormalPowerSeries[T]):RationalFormalPowerSeries[T] =
    RationalFormalPowerSeries[T](num:P, den:Q)
  #converter toRationalFormalPowerSeries*[T](a:int):RationalFormalPowerSeries[T] =
  #  @[T(a)] // @[T(1)]

  proc berlekampMassey*[mint](s:seq[mint]):FormalPowerSeries[mint] =
    let N = s.len
    var b, c = newSeqOfCap[mint](N + 1)
    b.add(mint(1))
    c.add(mint(1))
    var y = mint(1)
    for ed in 1 .. N:
      var
        l = c.len
        m = b.len
        x = mint(0)
      for i in 0 ..< l:
        x += c[i] * s[ed - l + i]
      b.add(mint(0))
      m.inc
      if x == mint(0): continue
      var freq = x / y
      if l < m:
        let tmp = c
        c = mint(0).repeat(m - l) & c
        for i in 0 ..< m:
          c[m - 1 - i] -= freq * b[m - 1 - i]
        b = tmp
        y = x
      else:
        for i in 0 ..< m:
          c[l - 1 - i] -= freq * b[m - 1 - i]
    c.reverse
    return c
  proc getGeneratingFunction*[mint](s:seq[mint]):RationalFormalPowerSeries[mint] =
    let Q = berlekampMassey(s)
    var P = s[0 ..< Q.len - 1].convolution(Q)
    P.setLen(Q.len - 1)
    return P // Q

  proc linearRecurrence*[mint](P, Q: FormalPowerSeries[mint], k:int):mint =
    var (P, Q) = (P, Q)
    Q.shrink()
    result = 0
    if P.len >= Q.len:
      let R = P / Q
      P -= R * Q
      P.shrink()
      if k < R.len: result += R[k]
    if P.len == 0: return

    when not mint.hasFFT:
      P.resize(Q.len - 1)
      while k > 0:
        var Q2 = Q
        for i in countup(1, Q.len - 1, 2):
          Q2[i] = -Q2[i]
        let
          S = P * Q2
          T = Q * Q2
        if (k and 1) != 0:
          for i in countup(1, S.len - 1, 2): P[i shr 1] = S[i]
          for i in countup(0, T.len - 1, 2): Q[i shr 1] = T[i]
        else:
          for i in countup(0, S.len - 1, 2): P[i shr 1] = S[i]
          for i in countup(0, T.len - 1, 2): Q[i shr 1] = T[i]
        k = k shr 1
      return result + P[0]
    else:
      mixin pow, inv
      var N = 1
      while N < Q.len:
        N = N shl 1
      P.resize(2 * N)
      Q.resize(2 * N)
      type f = getFFTType(mint)
      P = f.fft(P)
      Q = f.fft(Q)
      doAssert P.len == N * 2 and Q.len == N * 2
      var
        S, T = newSeq[mint](2 * N)
        btr = newSeq[int](N)
      let logn = countTrailingZeroBits(N)
      for i in 0 ..< (1 shl logn):
        btr[i] = (btr[i shr 1] shr 1) + ((i and 1) shl (logn - 1))
      const fftinfo = initFFTInfo[mint]()
      let dw = mint(fftinfo.g)
                    .inv()
                    .pow((mint.getMod() - 1) div (2 * N))
      var k = k
      while k > 0:
        var inv2 = mint(2).inv()
  
        # even degree of Q(x)Q(-x)
        T.resize(N)
        for i in 0 ..< N:
          T[i] = Q[(i shl 1) or 0] * Q[(i shl 1) or 1]
  
        S.resize(N)
        if (k and 1) != 0:
          # odd degree of P(x)Q(-x)
          for i in btr:
            S[i] = (P[(i shl 1) or 0] * Q[(i shl 1) or 1] -
                    P[(i shl 1) or 1] * Q[(i shl 1) or 0]) *
                   inv2
            inv2 *= dw
        else:
          # even degree of P(x)Q(-x)
          for i in 0 ..< N:
            S[i] = (P[(i shl 1) or 0] * Q[(i shl 1) or 1] +
                    P[(i shl 1) or 1] * Q[(i shl 1) or 0]) *
                   inv2
        swap(P, S)
        swap(Q, T)
        k = k shr 1
        if k < N: break
        f.ntt_doubling(P)
        f.ntt_doubling(Q)
      P = f.ifft(P)
      Q = f.ifft(Q)
      return result + (P * (Q.inv()))[k]

  proc kitamasa*[mint](a, Q:FormalPowerSeries[mint], N:int):mint =
    assert Q.len > 0 and Q[0] != 0
    if N < a.len: return a[N]
    assert a.len >= Q.len - 1
    var P = a.pre(Q.len - 1) * Q
    P.resize(Q.len - 1)
    return linearRecurrence[mint](P, Q, N)

  proc `[]`*[T](r:RationalFormalPowerSeries[T], N:int):T =
    linearRecurrence(r.num, r.den, N)
  #proc normalize*[T](a:var RFPS[T]) =
  #  let g = gcd(a.num, a.den)
  #  a.num = a.num div g
  #  a.den = a.den div g
  proc `+`*[T](a:RFPS[T], b: RFPS[T] or FPS[T] or T):RFPS[T] =
    when b is FPS[T]:
      var b = b // @[T(1)]
    elif b is T:
      var b = @[b] // @[T(1)]
    result = (a.num * b.den + b.num * a.den) // (a.den * b.den)
    #result.normalize
  proc `+=`*[T](a:var RFPS[T], b: RFPS[T] or FPS[T] or T) =
    a = a + b
  proc `-`*[T](a:RFPS[T], b: RFPS[T] or FPS[T] or T):RFPS[T] =
    when b is FPS[T]:
      var b = b // @[T(1)]
    elif b is T:
      var b = @[b] // @[T(1)]
    result = (a.num * b.den - b.num * a.den) // (a.den * b.den)
    #result.normalize
  proc `-=`*[T](a:var RFPS[T], b: RFPS[T] or FPS[T] or T) =
    a = a - b
  proc `*`*[T](a:RFPS[T], b: RFPS[T] or FPS[T] or T):RFPS[T] =
    when b is FPS[T]:
      var b = b // @[T(1)]
    elif b is T:
      var b = @[b] // @[T(1)]
    result = (a.num * b.num) // (a.den * b.den)
    #result.normalize
  proc `*=`*[T](a:var RFPS[T], b: RFPS[T] or FPS[T] or T) =
    a = a * b
  proc `/`*[T](a:RFPS[T], b: RFPS[T] or FPS[T] or T):RFPS[T] =
    when b is FPS[T]:
      var b = b // @[T(1)]
    elif b is T:
      var b = @[b] // @[T(1)]
    result = (a.num * b.den) // (a.den * b.num)
    #result.normalize
  proc `/=`*[T](a:var RFPS[T], b: RFPS[T] or FPS[T] or T) =
    a = a / b

  template eval*[T](self: RFPS[T], x:T):T = self.num.eval(x) / self.den.eval(x)
  {.push experimental: "callOperator".}
  template `()`*[T](self: RFPS[T], x:T):T = self.eval(x)
  {.pop.}

  proc kitamasa*[mint](a, Q:FPS[mint]):RFPS[mint] =
    assert Q.len > 0 and Q[0] != 0
    assert a.len >= Q.len - 1
    var P = a.pre(Q.len - 1) * Q
    P.resize(Q.len - 1)
    return P // Q
