when not declared ATCODER_INTERNAL_FFT_HPP:
  const ATCODER_INTERNAL_FFT_HPP* = 1
  import atcoder/modint
  import atcoder/convolution
  import std/sequtils

  proc isGoodMod*[T:ModInt](self: typedesc[T]):bool {.compileTime.} = (T.umod - 1) mod (1 shl 20) == 0
  proc fft*[T:StaticModInt](a:seq[T]):seq[T] =
    when T.isGoodMod:
      result = a
      butterfly(result)
    else:
      static: assert false
  proc dot*[T:StaticModInt](a, b:seq[T]):seq[T] =
    when T.isGoodMod:
      result = newSeq[T](a.len)
      for i in 0..<a.len:
        result[i] = a[i] * b[i]
  proc ifft*[T:StaticModInt](a:seq[T]):seq[T] =
    when T.isGoodMod:
      result = a
      result.butterfly_inv
      let iz = T(a.len).inv()
      result.applyIt(it * iz)
    else:
      static: assert false

