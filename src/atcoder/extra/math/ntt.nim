when not declared ATCODER_NTT_HPP:
  const ATCODER_NTT_HPP* = 1
  import atcoder/element_concepts
  include atcoder/extra/math/particular_mod_convolution
  include atcoder/extra/math/arbitrary_mod_convolution
  import std/bitops

  template get_fft_type*[T:FiniteFieldElem](self: typedesc[T]):typedesc =
    when T.isStatic and countTrailingZeroBits(T.mod - 1) >= 20: ParticularModConvolution
    else: ArbitraryModConvolution
  proc fft*[T:FiniteFieldElem](a:seq[T]):auto =
    fft(get_fft_type(T), a)
  proc ifft*(a:auto, T:typedesc[FiniteFieldElem]):auto =
    ifft[T](get_fft_type(T), a)
  proc dot*(a, b:auto, T:typedesc[FiniteFieldElem]):auto =
    dot(get_fft_type(T), a, b)
  proc inplace_partial_dot*(a:var auto, b:auto, p:Slice[int], T:typedesc[FiniteFieldElem]) =
    inplace_partial_dot(get_fft_type(T), a, b, p)
  proc multiply*[T:FiniteFieldElem](a, b:seq[T]):seq[T] =
    convolution(get_fft_type(T), a, b)
