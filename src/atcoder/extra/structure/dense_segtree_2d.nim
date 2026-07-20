when not declared ATCODER_EXTRA_STRUCTURE_DENSE_SEGTREE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_DENSE_SEGTREE_2D_HPP* = 1

  import std/sequtils
  import atcoder/extra/monoid/monoid

  type
    DenseSegTree2D*[
        CM: CommutativeMonoid
    ] = object
      heightValue:
        int
      widthValue:
        int
      rowSize:
        int
      colSize:
        int
      data:
        seq[
          seq[
            CM.value_type
          ]
        ]

  proc nextPowerOfTwo(
      length: int
  ): int =
    doAssert length >= 0

    result =
      1

    while result < length:
      result =
        result shl 1

  proc initDenseSegTree2D*[
      CM: CommutativeMonoid
  ](
      height,
      width: int,
      _: typedesc[CM]
  ): DenseSegTree2D[CM] =
    ## Constructs an identity-filled dense H x W segment tree.
    ##
    ## The public array convention is:
    ##
    ## dimensions: (height, width)
    ## indices:    (row, col)

    doAssert height >= 0
    doAssert width >= 0

    result.heightValue =
      height

    result.widthValue =
      width

    result.rowSize =
      nextPowerOfTwo(
        height
      )

    result.colSize =
      nextPowerOfTwo(
        width
      )

    result.data =
      newSeqWith(
        2 * result.rowSize,
        newSeqWith(
          2 * result.colSize,
          CM.e(),
        ),
      )

  proc initDenseSegTree2D*[
      CM: CommutativeMonoid
  ](
      values:
        seq[
          seq[
            CM.value_type
          ]
        ],
      _: typedesc[CM]
  ): DenseSegTree2D[CM] =
    ## Builds a dense segment tree from values[row][col].

    let height =
      values.len

    let width =
      if height == 0:
        0
      else:
        values[0].len

    result =
      initDenseSegTree2D(
        height,
        width,
        CM,
      )

    for row in 0 ..< height:
      doAssert values[row].len == width

      for col in 0 ..< width:
        result.data[
          result.rowSize + row
        ][
          result.colSize + col
        ] =
          values[row][col]

    if result.colSize > 1:
      for rowNode in result.rowSize ..< 2 * result.rowSize:
        for colNode in countdown(
            result.colSize - 1,
            1
        ):
          result.data[rowNode][colNode] =
            CM.op(
              result.data[rowNode][2 * colNode],
              result.data[rowNode][2 * colNode + 1],
            )

    if result.rowSize > 1:
      for rowNode in countdown(
          result.rowSize - 1,
          1
      ):
        for colNode in 1 ..< 2 * result.colSize:
          result.data[rowNode][colNode] =
            CM.op(
              result.data[2 * rowNode][colNode],
              result.data[2 * rowNode + 1][colNode],
            )

  proc height*[
      CM: CommutativeMonoid
  ](
      tree:
        DenseSegTree2D[CM]
  ): int {.inline.} =
    tree.heightValue

  proc width*[
      CM: CommutativeMonoid
  ](
      tree:
        DenseSegTree2D[CM]
  ): int {.inline.} =
    tree.widthValue

  proc set*[
      CM: CommutativeMonoid
  ](
      tree:
        var DenseSegTree2D[CM],
      row,
      col: int,
      value:
        CM.value_type
  ) =
    ## Assigns value to data[row][col].

    doAssert 0 <= row
    doAssert row < tree.heightValue
    doAssert 0 <= col
    doAssert col < tree.widthValue

    let rowLeaf =
      tree.rowSize + row

    let colLeaf =
      tree.colSize + col

    tree.data[rowLeaf][colLeaf] =
      value

    var colNode =
      colLeaf shr 1

    while colNode > 0:
      tree.data[rowLeaf][colNode] =
        CM.op(
          tree.data[rowLeaf][2 * colNode],
          tree.data[rowLeaf][2 * colNode + 1],
        )

      colNode =
        colNode shr 1

    var rowNode =
      rowLeaf shr 1

    while rowNode > 0:
      colNode =
        colLeaf

      while colNode > 0:
        tree.data[rowNode][colNode] =
          CM.op(
            tree.data[2 * rowNode][colNode],
            tree.data[2 * rowNode + 1][colNode],
          )

        colNode =
          colNode shr 1

      rowNode =
        rowNode shr 1

  proc get*[
      CM: CommutativeMonoid
  ](
      tree:
        DenseSegTree2D[CM],
      row,
      col: int
  ): CM.value_type {.inline.} =
    ## Returns data[row][col].

    doAssert 0 <= row
    doAssert row < tree.heightValue
    doAssert 0 <= col
    doAssert col < tree.widthValue

    tree.data[
      tree.rowSize + row
    ][
      tree.colSize + col
    ]

  proc columnProd[
      CM: CommutativeMonoid
  ](
      tree:
        DenseSegTree2D[CM],
      rowNode,
      colBegin,
      colEnd: int
  ): CM.value_type =
    result =
      CM.e()

    var left =
      colBegin + tree.colSize

    var right =
      colEnd + tree.colSize

    while left < right:
      if (left and 1) != 0:
        result =
          CM.op(
            result,
            tree.data[rowNode][left],
          )

        left.inc

      if (right and 1) != 0:
        right.dec

        result =
          CM.op(
            result,
            tree.data[rowNode][right],
          )

      left =
        left shr 1

      right =
        right shr 1

  proc prod*[
      CM: CommutativeMonoid
  ](
      tree:
        DenseSegTree2D[CM],
      rowBegin,
      rowEnd,
      colBegin,
      colEnd: int
  ): CM.value_type =
    ## Returns the commutative monoid product over:
    ##
    ## [rowBegin, rowEnd) x [colBegin, colEnd).

    doAssert 0 <= rowBegin
    doAssert rowBegin <= rowEnd
    doAssert rowEnd <= tree.heightValue
    doAssert 0 <= colBegin
    doAssert colBegin <= colEnd
    doAssert colEnd <= tree.widthValue

    result =
      CM.e()

    var top =
      rowBegin + tree.rowSize

    var bottom =
      rowEnd + tree.rowSize

    while top < bottom:
      if (top and 1) != 0:
        result =
          CM.op(
            result,
            tree.columnProd(
              top,
              colBegin,
              colEnd,
            ),
          )

        top.inc

      if (bottom and 1) != 0:
        bottom.dec

        result =
          CM.op(
            result,
            tree.columnProd(
              bottom,
              colBegin,
              colEnd,
            ),
          )

      top =
        top shr 1

      bottom =
        bottom shr 1

  proc allProd*[
      CM: CommutativeMonoid
  ](
      tree:
        DenseSegTree2D[CM]
  ): CM.value_type {.inline.} =
    tree.data[1][1]

  proc `[]`*[
      CM: CommutativeMonoid
  ](
      tree:
        DenseSegTree2D[CM],
      row,
      col: int
  ): CM.value_type {.inline.} =
    tree.get(
      row,
      col,
    )
