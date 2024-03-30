when not declared ATCODER_PARTICULAR_MOD_CONVOLUTION:
  const ATCODER_PARTICULAR_MOD_CONVOLUTION* = 1
  import atcoder/element_concepts
  import atcoder/convolution
  import std/sequtils
  type ParticularModConvolution* = object
    discard
  #type ParticularModFFTType*[T:FiniteFieldElem] = seq[T]
  proc fft*[T:FiniteFieldElem](t:typedesc[ParticularModConvolution], a:seq[T]):seq[T] {.inline.} =
    result = a
    butterfly(result)
  proc inplace_fft*[T:FiniteFieldElem](t:typedesc[ParticularModConvolution], a:var seq[T]) {.inline.} =
    butterfly(a)
  proc inplace_partial_dot*[T](t:typedesc[ParticularModConvolution], a:var seq[T], b:seq[T], p:Slice[int]) =
    for i in p:
      a[i] *= b[i]
  proc dot*[T](t:typedesc[ParticularModConvolution], a, b:seq[T]):seq[T] =
    result = a
    inplace_partial_dot(t, result, b, 0..<a.len)

  proc ifft*[T](t:typedesc[ParticularModConvolution], a:seq[T]):seq[T] {.inline.} =
    mixin init, inv
    result = a
    result.butterfly_inv
    let iz = T.init(a.len).inv()
    result.applyIt(it * iz)
  proc inplace_ifft*[T](t:typedesc[ParticularModConvolution], a:var seq[T]) {.inline.} =
    mixin init, inv
    a.butterfly_inv
    let iz = T.init(a.len).inv()
    a.applyIt(it * iz)

  proc convolution*[T:FiniteFieldElem](t:typedesc[ParticularModConvolution], a, b:seq[T]):auto {.inline.} =
    convolution(a, b)
  proc ntt_doubling*[T](t:typedesc[ParticularModConvolution], a:var seq[T]) =
    let M = a.len
    var b = a
    const fftInfo = initFFTInfo[T]()
    t.inplace_ifft(b)
    var
      r:T = 1
      zeta:T = T(fftInfo.g).pow((T.getMod() - 1) div (M shl 1))
    for i in 0 ..< M:
      b[i] *= r
      r *= zeta
    t.inplace_fft(b)
    a = a & b
