when not declared ATCODER_NTT_HPP:
  const ATCODER_NTT_HPP* = 1
  import atcoder/element_concepts
  import atcoder/extra/math/particular_mod_convolution
  import atcoder/extra/math/arbitrary_mod_convolution
  import std/bitops

  template get_fft_type*[T:FiniteFieldElem](self: typedesc[T]):typedesc =
    when countTrailingZeroBits(T.mod - 1) >= 20: ParticularModConvolution
    else: ArbitraryModConvolution
  proc fft*[T:FiniteFieldElem](a:seq[T]):auto =
    fft(get_fft_type(T), a)
  proc ifft*(a:auto, T:typedesc[FiniteFieldElem]):seq[T] =
    ifft[T](get_fft_type(T), a)
  proc dot*(a, b:auto, T:typedesc[FiniteFieldElem]):auto =
    dot(get_fft_type(T), a, b)
  proc multiply*[T:FiniteFieldElem](a, b:seq[T]):seq[T] =
    convolution(get_fft_type(T), a, b)
