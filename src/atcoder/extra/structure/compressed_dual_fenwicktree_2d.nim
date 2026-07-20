when not declared ATCODER_EXTRA_STRUCTURE_COMPRESSED_DUAL_FENWICKTREE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_COMPRESSED_DUAL_FENWICKTREE_2D_HPP* = 1

  import atcoder/extra/monoid/monoid
  import atcoder/extra/structure/compressed_fenwicktree_2d

  type
    CompressedDualFenwickTree2D*[
        CG: CommutativeGroup
    ] = object
      tree:
        CompressedFenwickTree2D[CG]

    CompressedDualFenwickTree2DBuilder* =
      object
        builder:
          CompressedFenwickTree2DBuilder

  proc initCompressedDualFenwickTree2DBuilder*():
      CompressedDualFenwickTree2DBuilder =
    discard

  proc registerRectangle*(
      builder:
        var CompressedDualFenwickTree2DBuilder,
      xLeft,
      xRight,
      yLower,
      yUpper: int
  ) =
    doAssert xLeft <= xRight
    doAssert yLower <= yUpper

    if xLeft == xRight or
       yLower == yUpper:
      return

    builder.builder.registerPoint(
      xLeft,
      yLower,
    )

    builder.builder.registerPoint(
      xLeft,
      yUpper,
    )

    builder.builder.registerPoint(
      xRight,
      yLower,
    )

    builder.builder.registerPoint(
      xRight,
      yUpper,
    )

  proc build*[
      CG: CommutativeGroup
  ](
      builder:
        CompressedDualFenwickTree2DBuilder,
      _: typedesc[CG]
  ): CompressedDualFenwickTree2D[CG] =
    result.tree =
      builder.builder.build(
        CG
      )

  proc add*[
      CG: CommutativeGroup
  ](
      tree:
        var CompressedDualFenwickTree2D[CG],
      xLeft,
      xRight,
      yLower,
      yUpper: int,
      delta:
        CG.value_type
  ) =
    doAssert xLeft <= xRight
    doAssert yLower <= yUpper

    if xLeft == xRight or
       yLower == yUpper:
      return

    let inverseDelta =
      CG.inv(
        delta
      )

    tree.tree.add(
      xLeft,
      yLower,
      delta,
    )

    tree.tree.add(
      xLeft,
      yUpper,
      inverseDelta,
    )

    tree.tree.add(
      xRight,
      yLower,
      inverseDelta,
    )

    tree.tree.add(
      xRight,
      yUpper,
      delta,
    )

  proc get*[
      CG: CommutativeGroup
  ](
      tree:
        CompressedDualFenwickTree2D[CG],
      x,
      y: int
  ): CG.value_type =
    tree.tree.prefixSumInclusive(
      x,
      y,
    )
