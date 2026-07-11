when not declared ATCODER_EXTRA_MATH_POLYNOMIAL_INTERPOLATION_HPP:
  const
    ATCODER_EXTRA_MATH_POLYNOMIAL_INTERPOLATION_HPP* = 1

  import atcoder/element_concepts
  import atcoder/extra/math/ntt
  import atcoder/extra/math/formal_power_series
  import atcoder/extra/math/subproduct_tree
  import atcoder/extra/math/multipoint_evaluation

  export ntt
  export formal_power_series

  proc polynomialInterpolation*[
      T: FiniteFieldElem
  ](
      xs,
      ys: openArray[T],
  ): FormalPowerSeries[T] =
    ## Returns the unique polynomial of degree less than `xs.len`
    ## whose value at `xs[i]` is `ys[i]`.
    ##
    ## Coefficients are stored in ascending degree order.
    if xs.len != ys.len:
      raise newException(
        ValueError,
        "xs and ys must have the same length",
      )

    let n = xs.len

    if n == 0:
      return @[]

    let
      xValues = @xs
      yValues = @ys

      productTree =
        subproduct_tree(
          FormalPowerSeries[T](
            xValues
          )
        )

      leafCount =
        productTree.len div 2

      derivativeValues =
        multipointEvaluation(
          productTree[1].diff(),
          xValues,
        )

    var partial =
      newSeq[
        FormalPowerSeries[T]
      ](
        productTree.len
      )

    for i in 0 ..< n:
      if derivativeValues[i] == default(T):
        raise newException(
          ValueError,
          "xs must be pairwise distinct",
        )

      partial[
        leafCount + i
      ] =
        @[
          yValues[i] / derivativeValues[i]
        ]

    if leafCount > 1:
      for node in countdown(
          leafCount - 1,
          1,
      ):
        partial[node] =
          partial[
            node shl 1
          ] * productTree[
            node shl 1 or 1
          ] +
          partial[
            node shl 1 or 1
          ] * productTree[
            node shl 1
          ]

    result = partial[1]
    result.setLen(n)
