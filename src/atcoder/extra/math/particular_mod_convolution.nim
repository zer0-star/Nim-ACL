when not declared ATCODER_PARTICULAR_MOD_CONVOLUTION:
  const ATCODER_PARTICULAR_MOD_CONVOLUTION* = 1
  import atcoder/modint
  import atcoder/convolution
  import std/sequtils
  type ParticularModConvolution* = object
    discard
  proc fft*[T:StaticModInt](t:typedesc[ParticularModConvolution], a:seq[T]):seq[T] {.inline.} =
    result = a
    butterfly(result)
  proc dot*[T:StaticModInt](a, b:seq[T]):seq[T] =
    result = newSeq[T](a.len)
    for i in 0..<a.len:
      result[i] = a[i] * b[i]
  proc ifft*[T:StaticModInt](t:typedesc[ParticularModConvolution], a:seq[T]):seq[T] {.inline.} =
    result = a
    result.butterfly_inv
    let iz = T(a.len).inv()
    result.applyIt(it * iz)
  proc convolution*[T:StaticModInt](t:typedesc[ParticularModConvolution], a, b:seq[T]):auto {.inline.} = convolution(a, b)
