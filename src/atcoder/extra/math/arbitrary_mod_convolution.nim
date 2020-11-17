when not declared ATCODER_ARBITRARY_MOD_CONVOLUTION:
  const ATCODER_ARBITRARY_MOD_CONVOLUTION* = 1
  import atcoder/convolution
  import atcoder/modint
  import atcoder/extra/math/particular_mod_convolution
  import std/sequtils

  type ArbitraryModConvolution* = object
    discard

  const
    m0 = 167772161.uint
    m1 = 469762049.uint
    m2 = 754974721.uint
  type
    mint0 = StaticModInt[m0.int]
    mint1 = StaticModInt[m1.int]
    mint2 = StaticModint[m2.int]
  type ArbitraryModFFTElem* = (mint0, mint1, mint2)
  proc setLen*(v:var (seq[mint0], seq[mint1], seq[mint2]), n:int) =
    v[0].setLen(n)
    v[1].setLen(n)
    v[2].setLen(n)
  
  proc `*=`(a:var ArbitraryModFFTElem, b:ArbitraryModFFTElem) =
    a[0] *= b[0];a[1] *= b[1];a[2] *= b[2]
  proc `-`(a:ArbitraryModFFTElem):auto = (-a[0], -a[1], -a[2])

  const
    r01 = mint1.init(m0).inv().val().uint
    r02 = mint2.init(m0).inv().val().uint
    r12 = mint2.init(m1).inv().val().uint
    r02r12 = r02 * r12 mod m2

  proc fft*[T:ModInt](t:typedesc[ArbitraryModConvolution], a:seq[T]):auto {.inline.} =
    type F = ParticularModConvolution
    var
      v0 = newSeq[mint0](a.len)
      v1 = newSeq[mint1](a.len)
      v2 = newSeq[mint2](a.len)
    for i in 0..<a.len:
      v0[i] = mint0.init(a[i].val())
      v1[i] = mint1.init(a[i].val())
      v2[i] = mint2.init(a[i].val())
    v0 = F.fft(v0)
    v1 = F.fft(v1)
    v2 = F.fft(v2)
    return (v0,v1,v2)
  proc inplace_partial_dot*(t:typedesc[ArbitraryModConvolution], a:var (seq[mint0], seq[mint1], seq[mint2]), b:(seq[mint0], seq[mint1], seq[mint2]), p:Slice[int]):auto =
    for i in p:
      a[0][i] *= b[0][i]
      a[1][i] *= b[1][i]
      a[2][i] *= b[2][i]
  proc dot*(t:typedesc[ArbitraryModConvolution], a, b:(seq[mint0], seq[mint1], seq[mint2])):auto =
    result = a
    t.inplace_partial_dot(result, b, 0..<a[0].len)

  proc calc_garner[T:ModInt](a0:seq[mint0], a1:seq[mint1], a2:seq[mint2], deg:int):seq[T] =
    let
      w1 = m0 mod T.umod
      w2 = w1 * m1 mod T.umod
    result = newSeq[T](deg)
    for i in 0..<deg:
      let
        (n0, n1, n2) = (a0[i].val().uint, a1[i].val().uint, a2[i].val().uint)
        b = (n1 + m1 - n0) * r01 mod m1
        c = ((n2 + m2 - n0) * r02r12 + (m2 - b) * r12) mod m2
      result[i] = T.init(n0 + b * w1 + c * w2)

  proc ifft*[T:ModInt](t:typedesc[ArbitraryModConvolution], a:(seq[mint0], seq[mint1], seq[mint2]), deg = -1):auto {.inline.} =
    type F = ParticularModConvolution
    let
      deg = if deg == -1: a[0].len else: deg
      a0 = F.ifft(a[0])
      a1 = F.ifft(a[1])
      a2 = F.ifft(a[2])
    return calc_garner[T](a0, a1, a2, deg)
  proc convolution*[T:ModInt](t:typedesc[ArbitraryModConvolution], a, b:seq[T]):seq[T] {.inline.} =
    proc f0(x:T):mint0 = mint0.init(x.val())
    proc f1(x:T):mint1 = mint1.init(x.val())
    proc f2(x:T):mint2 = mint2.init(x.val())
    let
      c0 = convolution(a.map(f0), b.map(f0))
      c1 = convolution(a.map(f1), b.map(f1))
      c2 = convolution(a.map(f2), b.map(f2))
    return calc_garner[T](c0, c1, c2, a.len + b.len - 1)
