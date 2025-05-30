when not declared ATCODER_NTT_QUADRATIC_FIELD_HPP:
  const ATCODER_NTT_QUADRATIC_FIELD_HPP* = 1
  import atcoder/element_concepts
  import atcoder/convolution
  import atcoder/extra/math/quadratic_field
  import atcoder/internal_bit

  proc inplace_fft*[T: QF](a: var seq[T]) =
    type mint = T.T
    var a0, b0 = newSeqOfCap[mint](a.len)
    for i in 0 ..< a.len:
      a0.add a[i].a
      b0.add a[i].b
    a0.butterfly()
    b0.butterfly()
    a = newSeqOfCap[T](a0.len)
    for i in 0 ..< a0.len:
      a.add T.init(a0[i], b0[i])
  proc fft*[T:QF](a:seq[T]):seq[T] =
    result = a
    result.inplace_fft()
  proc inplace_ifft*[T: QF](a: var seq[T]) =
    type mint = T.T
    var a0, b0 = newSeqOfCap[mint](a.len)
    for i in 0 ..< a.len:
      a0.add a[i].a
      b0.add a[i].b
    a0.butterflyInv()
    b0.butterflyInv()
    a = newSeqOfCap[T](a0.len)
    for i in 0 ..< a0.len:
      a.add T.init(a0[i], b0[i])
  proc ifft*[T: QF](a:seq[T], td:typedesc[T]):auto =
    result = a
    result.inplace_ifft(T)
  proc dot*(a, b:auto, T:typedesc[FiniteFieldElem]):auto = # TODO: このdotがorcでばぐる特にaを変数ではなくfft(f)みたいに関数で読んだ場合
    result = newSeqOfCap[T](a.len)
    for i in 0 ..< a.len:
      result.add a[i] * b[i]
  proc inplace_partial_dot*(a:var auto, b:auto, p:Slice[int], T:typedesc[FiniteFieldElem]) =
    for i in p:
      a[i] *= b[i]
  proc multiply_fft*[T:QF](a, b:seq[T]):seq[T] =
    if a.len == 0 or b.len == 0: return
    var (a, b) = (a, b)
    let
      (n, m) = (a.len, b.len)
      z = 1 shl ceil_pow2(n + m - 1)
    a.setLen(z)
    b.setLen(z)
    var
      a0 = fft(a)
      b0 = fft(b)
    for i in 0 ..< a0.len:
      a0[i] *= b0[i]
    result = a0.ifft(T)
    result.setLen(n + m - 1)
    let iz = T.init(z).inv()
    for i in 0 ..< result.len: result[i] *= iz
  proc multiply_naive*[T:QF](a, b:seq[T]):seq[T] =
    result = newSeq[T](a.len + b.len - 1)
    for i in 0 ..< a.len:
      for j in 0 ..< b.len:
        result[i + j] += a[i] * b[j]
  proc multiply*[T:QF](a, b:seq[T]):seq[T] =
    if min(a.len, b.len) <= 60: return multiply_naive(a, b)
    else: multiply_fft(a, b)

  proc inplace_fft_doubling*[T:QF](a:var seq[T]) =
    let M = a.len
    var b = a
    const fftInfo = initFFTInfo[T.T]()
    inplace_ifft(b)
    var
      r:T = 1
      zeta:T = T(fftInfo.g).pow((T.getMod() - 1) div (M shl 1))
    for i in 0 ..< M:
      b[i] *= r
      r *= zeta
    inplace_fft(b)
    a &= b
  proc fft_doubling*[T:QF](a:seq[T]):seq[T] =
    result = a
    result.fft_doubling()

