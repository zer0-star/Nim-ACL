when not declared ATCODER_PARTICULAR_MOD_CONVOLUTION:
  const ATCODER_PARTICULAR_MOD_CONVOLUTION* = 1
  import atcoder/element_concepts
  when not declared ATCODER_CONVOLUTION_HPP:
    import atcoder/convolution
    discard
  import std/sequtils
  type ParticularModConvolution* = object
    discard
  type ParticularModFFTType[T:FiniteFieldElem] = seq[T]
  proc fft*[T:FiniteFieldElem](t:typedesc[ParticularModConvolution], a:seq[T]):ParticularModFFTType[T] {.inline.} =
    result = a
    butterfly(result)
  proc inplace_partial_dot*[T](t:typedesc[ParticularModConvolution], a:var ParticularModFFTType[T], b:ParticularModFFTType[T], p:Slice[int]) =
    for i in p:
      a[i] *= b[i]
  proc dot*[T](t:typedesc[ParticularModConvolution], a, b:ParticularModFFTType[T]):ParticularModFFTType[T] =
    result = a
    inplace_partial_dot(t, result, b, 0..<a.len)

  proc ifft*[T](t:typedesc[ParticularModConvolution], a:ParticularModFFTType[T]):seq[T] {.inline.} =
    mixin init, inv
    result = a
    result.butterfly_inv
    let iz = T.init(a.len).inv()
    result.applyIt(it * iz)
  proc convolution*[T:FiniteFieldElem](t:typedesc[ParticularModConvolution], a, b:seq[T]):auto {.inline.} = convolution(a, b)
