when not declared ATCODER_ARBITRARY_MOD_CONVOLUTION:
  const ATCODER_ARBITRARY_MOD_CONVOLUTION* = 1
  import atcoder/convolution
  import atcoder/modint
  import atcoder/extra/math/internal_fft
  const
    m0 = 167772161.uint
    m1 = 469762049.uint
    m2 = 754974721.uint
  type
    mint0 = StaticModInt[m0.int]
    mint1 = StaticModInt[m1.int]
    mint2 = StaticModint[m2.int]

  const
    r01 = mint1.init(m0).inv().uint
    r02 = mint2.init(m0).inv().uint
    r12 = mint2.init(m1).inv().uint
    r02r12 = r02.int * r12.int mod m2

  proc fft*[T:ModInt](a:seq[T]):auto =
    var
      v0 = newSeq[mint0](a.len)
      v1 = newSeq[mint1](a.len)
      v2 = newSeq[mint2](a.len)
    for i in 0..<a.len:
      v0[i] = mint0.init(a[i].int)
      v1[i] = mint1.init(a[i].int)
      v2[i] = mint2.init(a[i].int)
    v0 = internal_fft.fft(v0)
    v1 = internal_fft.fft(v1)
    v2 = internal_fft.fft(v2)
    return (v0,v1,v2)
  proc dot*(a, b:(seq[mint0], seq[mint1], seq[mint2])):auto =
    let N = a[0].len
    result = (newSeq[mint0](N), newSeq[mint1](N), newSeq[mint2](N))
    for i in 0..<N:
      result[0][i] = a[0][i] * b[0][i]
      result[1][i] = a[1][i] * b[1][i]
      result[2][i] = a[2][i] * b[2][i]
  
  proc calc_garner*[T:ModInt](a0:seq[mint0], a1:seq[mint1], a2:seq[mint2], deg:int):seq[T] =
    let
      w1 = m0 mod T.umod
      w2 = w1 * m1 mod T.umod
    result = newSeq[T](deg)
    for i in 0..<deg:
      let
        (n0, n1, n2) = (a0[i].uint, a1[i].uint, a2[i].uint)
        b = (n1 + m1 - n0) * r01 mod m1
        c = ((n2 + m2 - n0) * r02r12 + (m2 - b) * r12) mod m2
      result[i] = T.init(n0 + b * w1 + c * w2)

  proc ifft*[T:ModInt](a:(seq[mint0], seq[mint1], seq[mint2]), deg = -1):auto =
    let
      deg = if deg == -1: a[0].len else: deg
      a0 = internal_fft.ifft(a[0])
      a1 = internal_fft.ifft(a[1])
      a2 = internal_fft.ifft(a[2])
    return calc_garner[T](a0, a1, a2, deg)
  proc convolution*[T:ModInt](a, b:seq[T]):seq[T] =
    var
      a0 = newSeq[mint0](a.len)
      a1 = newSeq[mint1](a.len)
      a2 = newSeq[mint2](a.len)
    for i in 0..<a.len:
      a0[i] = mint0.init(a[i].int)
      a1[i] = mint1.init(a[i].int)
      a2[i] = mint2.init(a[i].int)
    var
      b0 = newSeq[mint0](b.len)
      b1 = newSeq[mint1](b.len)
      b2 = newSeq[mint2](b.len)
    for i in 0..<b.len:
      b0[i] = mint0.init(b[i].int)
      b1[i] = mint1.init(b[i].int)
      b2[i] = mint2.init(b[i].int)
    let
      c0 = convolution.convolution(a0, b0)
      c1 = convolution.convolution(a1, b1)
      c2 = convolution.convolution(a2, b2)
    return calc_garner[T](c0, c1, c2, a.len + b.len - 1)
