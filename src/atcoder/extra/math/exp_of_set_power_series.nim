when not declared ATCODER_EXTRA_MATH_EXP_OF_SET_POWER_SERIES_HPP:
  const
    ATCODER_EXTRA_MATH_EXP_OF_SET_POWER_SERIES_HPP* = 1

  import atcoder/extra/math/subset_convolution

  proc isPositivePowerOfTwo(
      value: int,
  ): bool {.inline.} =
    value > 0 and
      (value and (value - 1)) == 0

  proc expOfSetPowerSeries*[T](
      f: openArray[T],
  ): seq[T] =
    ## Computes the exponential of a set power series.
    ##
    ## The empty-set coefficient of `f` must be zero.
    ## The result has empty-set coefficient one.
    let size = f.len

    if not isPositivePowerOfTwo(size):
      raise newException(
        ValueError,
        "the input length must be a positive power of two",
      )

    if f[0] != default(T):
      raise newException(
        ValueError,
        "the empty-set coefficient must be zero",
      )

    result =
      newSeqOfCap[T](size)

    result.add(
      T(1)
    )

    var layerSize = 1

    while layerSize < size:
      var nextInput =
        newSeq[T](layerSize)

      for index in 0 ..< layerSize:
        nextInput[index] =
          f[layerSize + index]

      let nextLayer =
        subsetConvolution(
          result,
          nextInput,
        )

      for value in nextLayer:
        result.add(value)

      layerSize =
        layerSize shl 1
