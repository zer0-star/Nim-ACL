when not declared ATCODER_NTT_HPP:
  const ATCODER_NTT_HPP* = 1
  import atcoder/element_concepts
  include atcoder/extra/math/particular_mod_convolution
  include atcoder/extra/math/arbitrary_mod_convolution
  import std/bitops

  template get_fft_type*[T:FiniteFieldElem](self: typedesc[T]):typedesc =
    when T.isStatic and countTrailingZeroBits(T.mod - 1) >= 20:
      ParticularModConvolution
    else:
      ArbitraryModConvolution
  proc fft*[T:FiniteFieldElem](a:seq[T]):auto =
    type fft_type = get_fft_type(T)
    fft(fft_type, a)
  proc ifft*(a:auto, T:typedesc[FiniteFieldElem]):auto =
    type fft_type = get_fft_type(T)
    ifft[T](fft_type, a)
  proc dot*(a, b:auto, T:typedesc[FiniteFieldElem]):auto = # TODO: このdotがorcでばぐる特にaを変数ではなくfft(f)みたいに関数で読んだ場合
    dot(get_fft_type(T), a, b)
  proc inplace_partial_dot*(a:var auto, b:auto, p:Slice[int], T:typedesc[FiniteFieldElem]) =
    inplace_partial_dot(get_fft_type(T), a, b, p)
  proc multiply*[T:FiniteFieldElem](a, b:seq[T]):seq[T] =
    convolution(get_fft_type(T), a, b)
  proc fft_doubling*[T: FiniteFieldElem](a: seq[T]):seq[T] =
    type F = get_fft_type(T)
    var a = a
    F.ntt_doubling(a)
    return a
