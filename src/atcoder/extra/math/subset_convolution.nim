when not declared ATCODER_EXTRA_MATH_SUBSET_CONVOLUTION_HPP:
  const
    ATCODER_EXTRA_MATH_SUBSET_CONVOLUTION_HPP* = 1

  import std/bitops

  proc isPositivePowerOfTwo(
      value: int,
  ): bool {.inline.} =
    value > 0 and
      (value and (value - 1)) == 0

  proc subsetConvolution*[T](
      f,
      g: openArray[T],
  ): seq[T] =
    ## Computes the subset convolution of `f` and `g`.
    ##
    ## For every mask S:
    ##
    ##   result[S] = sum f[T] * g[S xor T]
    ##
    ## where T ranges over all subsets of S.
    if f.len != g.len:
      raise newException(
        ValueError,
        "f and g must have the same length",
      )

    let size = f.len

    if not isPositivePowerOfTwo(size):
      raise newException(
        ValueError,
        "the input length must be a positive power of two",
      )

    var
      bitCount = 0
      currentSize = size

    while currentSize > 1:
      currentSize = currentSize shr 1
      inc bitCount

    let
      degreeCount = bitCount + 1
      tableSize = size * degreeCount

    var
      rankedF = newSeq[T](tableSize)
      rankedG = newSeq[T](tableSize)
      rankedH = newSeq[T](tableSize)

    for mask in 0 ..< size:
      let
        degree = countSetBits(mask)
        offset = mask * degreeCount + degree

      rankedF[offset] = f[mask]
      rankedG[offset] = g[mask]

    for bit in 0 ..< bitCount:
      let bitMask = 1 shl bit

      for mask in 0 ..< size:
        if (mask and bitMask) == 0:
          continue

        let
          destination = mask * degreeCount
          source = (mask xor bitMask) * degreeCount

        for degree in 0 .. bitCount:
          rankedF[destination + degree] +=
            rankedF[source + degree]

          rankedG[destination + degree] +=
            rankedG[source + degree]

    for mask in 0 ..< size:
      let offset = mask * degreeCount

      for leftDegree in 0 .. bitCount:
        for rightDegree in 0 .. bitCount - leftDegree:
          rankedH[offset + leftDegree + rightDegree] +=
            rankedF[offset + leftDegree] *
            rankedG[offset + rightDegree]

    for bit in 0 ..< bitCount:
      let bitMask = 1 shl bit

      for mask in 0 ..< size:
        if (mask and bitMask) == 0:
          continue

        let
          destination = mask * degreeCount
          source = (mask xor bitMask) * degreeCount

        for degree in 0 .. bitCount:
          rankedH[destination + degree] -=
            rankedH[source + degree]

    result = newSeq[T](size)

    for mask in 0 ..< size:
      result[mask] =
        rankedH[
          mask * degreeCount + countSetBits(mask)
        ]
