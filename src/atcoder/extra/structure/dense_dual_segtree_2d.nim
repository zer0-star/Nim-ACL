when not declared ATCODER_EXTRA_STRUCTURE_DENSE_DUAL_SEGTREE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_DENSE_DUAL_SEGTREE_2D_HPP* = 1

  import std/sequtils
  import atcoder/extra/monoid/monoid

  type
    DenseDualSegTree2D*[S; FM: CommutativeMonoid; Mapper] = object
      heightValue: int
      widthValue: int
      rowSize: int
      colSize: int
      values: seq[seq[S]]
      tags: seq[seq[FM.value_type]]

  proc initializeStorage[S; FM: CommutativeMonoid; Mapper](
      tree: var DenseDualSegTree2D[S, FM, Mapper]
  ) =
    tree.rowSize = 1
    while tree.rowSize < tree.heightValue:
      tree.rowSize = tree.rowSize shl 1

    tree.colSize = 1
    while tree.colSize < tree.widthValue:
      tree.colSize = tree.colSize shl 1

    tree.tags = newSeq[seq[FM.value_type]](2 * tree.rowSize)
    for rowNode in 0 ..< 2 * tree.rowSize:
      tree.tags[rowNode] =
        newSeqWith(2 * tree.colSize, FM.e())

  proc initDenseDualSegTree2D*[
      S;
      FM: CommutativeMonoid;
      Mapper
  ](
      height,
      width: int,
      initialValue: S,
      _: typedesc[FM],
      _: typedesc[Mapper]
  ): DenseDualSegTree2D[S, FM, Mapper] =
    doAssert height >= 0
    doAssert width >= 0

    result.heightValue = height
    result.widthValue = width
    result.values = newSeq[seq[S]](height)

    for row in 0 ..< height:
      result.values[row] = newSeqWith(width, initialValue)

    result.initializeStorage()

  proc initDenseDualSegTree2D*[
      S;
      FM: CommutativeMonoid;
      Mapper
  ](
      values: seq[seq[S]],
      _: typedesc[FM],
      _: typedesc[Mapper]
  ): DenseDualSegTree2D[S, FM, Mapper] =
    let height = values.len
    let width =
      if height == 0:
        0
      else:
        values[0].len

    for row in 0 ..< height:
      doAssert values[row].len == width

    result.heightValue = height
    result.widthValue = width
    result.values = newSeq[seq[S]](height)

    for row in 0 ..< height:
      result.values[row] = newSeq[S](width)

      for col in 0 ..< width:
        result.values[row][col] = values[row][col]

    result.initializeStorage()

  proc height*[S; FM: CommutativeMonoid; Mapper](
      tree: DenseDualSegTree2D[S, FM, Mapper]
  ): int {.inline.} =
    tree.heightValue

  proc width*[S; FM: CommutativeMonoid; Mapper](
      tree: DenseDualSegTree2D[S, FM, Mapper]
  ): int {.inline.} =
    tree.widthValue

  proc applyColumns[S; FM: CommutativeMonoid; Mapper](
      tree: var DenseDualSegTree2D[S, FM, Mapper],
      rowNode,
      colBegin,
      colEnd: int,
      action: FM.value_type
  ) =
    var left = colBegin + tree.colSize
    var right = colEnd + tree.colSize

    while left < right:
      if (left and 1) == 1:
        tree.tags[rowNode][left] =
          FM.op(tree.tags[rowNode][left], action)
        left.inc

      if (right and 1) == 1:
        right.dec
        tree.tags[rowNode][right] =
          FM.op(tree.tags[rowNode][right], action)

      left = left shr 1
      right = right shr 1

  proc apply*[S; FM: CommutativeMonoid; Mapper](
      tree: var DenseDualSegTree2D[S, FM, Mapper],
      rowBegin,
      rowEnd,
      colBegin,
      colEnd: int,
      action: FM.value_type
  ) =
    doAssert 0 <= rowBegin
    doAssert rowBegin <= rowEnd
    doAssert rowEnd <= tree.heightValue
    doAssert 0 <= colBegin
    doAssert colBegin <= colEnd
    doAssert colEnd <= tree.widthValue

    if rowBegin == rowEnd or colBegin == colEnd:
      return

    var top = rowBegin + tree.rowSize
    var bottom = rowEnd + tree.rowSize

    while top < bottom:
      if (top and 1) == 1:
        tree.applyColumns(
          top,
          colBegin,
          colEnd,
          action,
        )
        top.inc

      if (bottom and 1) == 1:
        bottom.dec
        tree.applyColumns(
          bottom,
          colBegin,
          colEnd,
          action,
        )

      top = top shr 1
      bottom = bottom shr 1

  proc get*[S; FM: CommutativeMonoid; Mapper](
      tree: DenseDualSegTree2D[S, FM, Mapper],
      row,
      col: int
  ): S =
    mixin mapping

    doAssert 0 <= row
    doAssert row < tree.heightValue
    doAssert 0 <= col
    doAssert col < tree.widthValue

    var accumulatedAction = FM.e()
    var rowNode = row + tree.rowSize

    while rowNode > 0:
      var colNode = col + tree.colSize

      while colNode > 0:
        accumulatedAction =
          FM.op(
            accumulatedAction,
            tree.tags[rowNode][colNode],
          )

        colNode = colNode shr 1

      rowNode = rowNode shr 1

    mapping(
      Mapper,
      accumulatedAction,
      tree.values[row][col],
    )

  proc `[]`*[S; FM: CommutativeMonoid; Mapper](
      tree: DenseDualSegTree2D[S, FM, Mapper],
      row,
      col: int
  ): S {.inline.} =
    tree.get(row, col)
