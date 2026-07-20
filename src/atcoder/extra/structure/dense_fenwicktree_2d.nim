when not declared ATCODER_EXTRA_STRUCTURE_DENSE_FENWICKTREE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_DENSE_FENWICKTREE_2D_HPP* = 1

  type
    DenseFenwickTree2D*[T] = object
      heightValue: int
      widthValue: int
      data: seq[seq[T]]

  proc initDenseFenwickTree2D*[T](
      height,
      width: int,
  ): DenseFenwickTree2D[T] =
    ## Constructs a dense two-dimensional Fenwick tree.
    ##
    ## Valid array indices satisfy:
    ##
    ## 0 <= row < height
    ## 0 <= col < width

    assert height >= 0
    assert width >= 0

    result.heightValue = height
    result.widthValue = width

    result.data = newSeq[seq[T]](
      height + 1,
    )

    for row in 0 .. height:
      result.data[row] = newSeq[T](
        width + 1,
      )

  proc height*[T](
      tree: DenseFenwickTree2D[T],
  ): int {.inline.} =
    tree.heightValue

  proc width*[T](
      tree: DenseFenwickTree2D[T],
  ): int {.inline.} =
    tree.widthValue

  proc add*[T](
      tree: var DenseFenwickTree2D[T],
      row,
      col: int,
      delta: T,
  ) =
    ## Adds delta to array element (row, col).

    mixin `+`

    assert 0 <= row
    assert row < tree.heightValue
    assert 0 <= col
    assert col < tree.widthValue

    var rowIndex = row + 1

    while rowIndex <= tree.heightValue:
      var colIndex = col + 1

      while colIndex <= tree.widthValue:
        tree.data[rowIndex][colIndex] =
          tree.data[rowIndex][colIndex] +
          delta

        colIndex += colIndex and -colIndex

      rowIndex += rowIndex and -rowIndex

  proc prefixSum*[T](
      tree: DenseFenwickTree2D[T],
      rowEnd,
      colEnd: int,
  ): T =
    ## Returns the sum over
    ## [0, rowEnd) x [0, colEnd).

    mixin `+`

    assert 0 <= rowEnd
    assert rowEnd <= tree.heightValue
    assert 0 <= colEnd
    assert colEnd <= tree.widthValue

    var rowIndex = rowEnd

    while rowIndex > 0:
      var colIndex = colEnd

      while colIndex > 0:
        result =
          result +
          tree.data[rowIndex][colIndex]

        colIndex -= colIndex and -colIndex

      rowIndex -= rowIndex and -rowIndex

  proc sum*[T](
      tree: DenseFenwickTree2D[T],
      rowBegin,
      rowEnd,
      colBegin,
      colEnd: int,
  ): T =
    ## Returns the sum over
    ## [rowBegin, rowEnd) x [colBegin, colEnd).

    mixin `+`, `-`

    assert 0 <= rowBegin
    assert rowBegin <= rowEnd
    assert rowEnd <= tree.heightValue
    assert 0 <= colBegin
    assert colBegin <= colEnd
    assert colEnd <= tree.widthValue

    tree.prefixSum(
      rowEnd,
      colEnd,
    ) -
    tree.prefixSum(
      rowBegin,
      colEnd,
    ) -
    tree.prefixSum(
      rowEnd,
      colBegin,
    ) +
    tree.prefixSum(
      rowBegin,
      colBegin,
    )

  proc get*[T](
      tree: DenseFenwickTree2D[T],
      row,
      col: int,
  ): T {.inline.} =
    tree.sum(
      row,
      row + 1,
      col,
      col + 1,
    )

  proc allSum*[T](
      tree: DenseFenwickTree2D[T],
  ): T {.inline.} =
    tree.prefixSum(
      tree.heightValue,
      tree.widthValue,
    )

  proc `[]`*[T](
      tree: DenseFenwickTree2D[T],
      row,
      col: int,
  ): T {.inline.} =
    tree.get(
      row,
      col,
    )
