when not declared ATCODER_EXTRA_MATH_LOG_OF_SET_POWER_SERIES_HPP:
  const
    ATCODER_EXTRA_MATH_LOG_OF_SET_POWER_SERIES_HPP* = 1

  import atcoder/extra/math/subset_convolution


  proc isPositivePowerOfTwo(
      value: int,
  ): bool {.inline.} =
    value > 0 and
      (value and (value - 1)) == 0


  proc copySetPowerSeries[T](
      values: openArray[T],
  ): seq[T] =
    result =
      newSeq[T](values.len)

    for index in 0 ..< values.len:
      result[index] =
        values[index]


  proc inverseUnitSetPowerSeriesSolve[T](
      values: seq[T],
  ): seq[T] =
    if values.len == 1:
      return @[T(1)]

    let half =
      values.len div 2

    var
      low =
        newSeq[T](half)

      high =
        newSeq[T](half)

    for index in 0 ..< half:
      low[index] =
        values[index]

      high[index] =
        values[half + index]

    let lowInverse =
      inverseUnitSetPowerSeriesSolve(
        low
      )

    let firstProduct =
      subsetConvolution(
        lowInverse,
        high,
      )

    let secondProduct =
      subsetConvolution(
        firstProduct,
        lowInverse,
      )

    result =
      newSeq[T](values.len)

    for index in 0 ..< half:
      result[index] =
        lowInverse[index]

      result[half + index] =
        -secondProduct[index]


  proc logOfSetPowerSeriesSolve[T](
      values: seq[T],
  ): seq[T] =
    if values.len == 1:
      return @[default(T)]

    let half =
      values.len div 2

    var
      low =
        newSeq[T](half)

      high =
        newSeq[T](half)

    for index in 0 ..< half:
      low[index] =
        values[index]

      high[index] =
        values[half + index]

    let lowLog =
      logOfSetPowerSeriesSolve(
        low
      )

    let lowInverse =
      inverseUnitSetPowerSeriesSolve(
        low
      )

    let highLog =
      subsetConvolution(
        lowInverse,
        high,
      )

    result =
      newSeq[T](values.len)

    for index in 0 ..< half:
      result[index] =
        lowLog[index]

      result[half + index] =
        highLog[index]


  proc logOfSetPowerSeries*[T](
      values: openArray[T],
  ): seq[T] =
    ## Returns the logarithm of a unit set power series.
    ##
    ## The input length must be a positive power of two, and
    ## the empty-set coefficient must be one.

    if not isPositivePowerOfTwo(
        values.len
    ):
      raise newException(
        ValueError,
        "length must be a positive power of two",
      )

    if values[0] != T(1):
      raise newException(
        ValueError,
        "the empty-set coefficient must be one",
      )

    logOfSetPowerSeriesSolve(
      copySetPowerSeries(values)
    )
