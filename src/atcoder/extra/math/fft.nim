when not declared ATCODER_FFT_HPP:
  const ATCODER_FFT_HPP* = 1

  import std/sequtils, std/bitops, std/math
#  import atcoder/extra/math/longdouble
  import atcoder/internal_bit
  
#  type Real = LongDouble
  type Real = float
#  type Real = clongdouble
  
  type Complex = tuple[x, y:Real]

  proc initComplex*[S,T](x:S, y:T):Complex =
    (Real(x), Real(y))
  
  proc `+`*(a,b:Complex):Complex = initComplex(a.x + b.x, a.y + b.y)
  proc `-`*(a,b:Complex):Complex = initComplex(a.x - b.x, a.y - b.y)
  proc `*`*(a,b:Complex):Complex = initComplex(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x)
  proc conj*(a:Complex):Complex = initComplex(a.x, -a.y)
  
  type SeqComplex = object
    real, imag: seq[Real]
  
  proc initSeqComplex*(n:int):SeqComplex = SeqComplex(real: newSeqWith(n, Real(0)), imag: newSeqWith(n, Real(0)))
  
  proc setLen*(self: var SeqComplex, n:int) =
    self.real.setLen(n)
    self.imag.setLen(n)
  proc swap*(self: var SeqComplex, i, j:int) =
    swap(self.real[i], self.real[j])
    swap(self.imag[i], self.imag[j])
  
  type FastFourierTransform* = object of RootObj
    base:int
    rts: SeqComplex
    rev:seq[int]
  
  proc getC*(self: SeqComplex, i:int):Complex = (self.real[i], self.imag[i])
  proc `[]`*(self: SeqComplex, i:int):Complex = self.getC(i)
  proc `[]=`*(self: var SeqComplex, i:int, x:Complex) =
    self.real[i] = x.x
    self.imag[i] = x.y
  
  proc initFastFourierTransform*():FastFourierTransform = 
    return FastFourierTransform(base:1, rts: SeqComplex(real: @[Real(0), Real(1)], imag: @[Real(0), Real(0)]), rev: @[0, 1])
  #proc init(self:typedesc[FastFourierTransform]):auto = initFastFourierTransform()

  proc ensureBase*(self:var FastFourierTransform; nbase:int) =
    if nbase <= self.base: return
    self.rev.setlen(1 shl nbase)
    self.rts.setlen(1 shl nbase)
    for i in 0..<(1 shl nbase): self.rev[i] = (self.rev[i shr 1] shr 1) + ((i and 1) shl (nbase - 1))
    while self.base < nbase:
      let angle = arccos(Real(-1)) * Real(2) / Real(1 shl (self.base + 1))
      for i in (1 shl (self.base - 1))..<(1 shl self.base):
        self.rts[i shl 1] = self.rts[i]
        let angle_i = angle * Real(2 * i + 1 - (1 shl self.base))
        self.rts[(i shl 1) + 1] = initComplex(cos(angle_i), sin(angle_i))
      self.base.inc
  
  proc fft(self:var FastFourierTransform; a:var SeqComplex, n:int) =
    assert((n and (n - 1)) == 0)
    let zeros = countTrailingZeroBits(n)
    self.ensureBase(zeros)
    let shift = self.base - zeros
    for i in 0..<n:
      if i < (self.rev[i] shr shift):
        a.swap(i, self.rev[i] shr shift)
    var k = 1
    while k < n:
      var i = 0
      while i < n:
        for j in 0..<k:
          let z = a[i + j + k] * self.rts[j + k]
          a[i + j + k] = a[i + j] - z
          a[i + j] = a[i + j] + z
        i += 2 * k
      k = k shl 1
  
  proc ifft(self: var FastFourierTransform; a: var SeqComplex, n:int) =
    for i in 0..<n: a[i] = a[i].conj()
    let rN = Real(1) / Real(n)
    self.fft(a, n)
    for i in 0..<n:
      let t = a[i]
      a[i] = (t.x * rN, t.y * rN)
  
  var fft_t* = initFastFourierTransform()
  
  proc fft*[T:SomeFloat or Real](a:seq[T]):SeqComplex =
    result = initSeqComplex(a.len)
    for i in 0..<a.len:
      result[i] = initComplex(a[i], T(0))
    fft_t.fft(result, a.len)
  proc ifft*(a:SeqComplex, T:typedesc[SomeFloat or Real]):auto =
    var a = a
    let n = a.real.len
    fft_t.ifft(a, n)
    var r  = newSeq[T](n)
    for i in 0..<n:
      r[i] = T(a.real[i])
    return r
  proc inplace_partial_dot*(a:var SeqComplex, b:SeqComplex, p:Slice[int], T:typedesc[SomeFloat or Real]):auto =
    for i in p:
      a[i] = a[i] * b[i]

  proc dot*(a, b:SeqComplex, T:typedesc[SomeFloat or Real]):auto =
    let n = a.real.len
    result = a
    result.inplace_partial_dot(b, 0..<n, T)
  proc multiply*[T:SomeFloat or Real](a, b:seq[T]):seq[T] =
    let
      (n, m) = (a.len, b.len)
      z = 1 shl ceil_pow2(n + m - 1)
    var (a, b) = (a, b)
    a.setLen(z)
    b.setLen(z)
    var r = newSeq[T]()
    r = ifft(dot(a.fft(), b.fft(), T), T)
    r.setLen(n + m - 1)
    return r.mapIt(it.T)
