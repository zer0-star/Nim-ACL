when not declared ATCODER_INTERNAL_FFT_HPP:
  const ATCODER_INTERNAL_FFT_HPP* = 1
  import atcoder/modint
  import atcoder/extra/math/particular_mod_convolution
  import atcoder/extra/math/arbitrary_mod_convolution

  template get_fft_type*[T:ModInt](self: typedesc[T]):typedesc =
    when T is StaticModInt and (T.umod - 1) mod (1 shl 20) == 0: ParticularModConvolution
    else: ArbitraryModConvolution

