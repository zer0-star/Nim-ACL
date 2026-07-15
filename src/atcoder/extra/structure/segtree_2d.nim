when not declared ATCODER_EXTRA_STRUCTURE_SEGTREE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_SEGTREE_2D_HPP* = 1

  import std/algorithm

  import atcoder/segtree

  import atcoder/extra/structure/compressed_segtree_2d

  export compressed_segtree_2d

  type
    SegTree2D*[S; SegTree] =
      CompressedSegTree2D[S, SegTree]

  proc initSegTree2D*[S](
      points: seq[tuple[x, y: int]],
      op: static[proc(a, b: S): S],
      e: static[proc(): S]
  ): auto =
    type
      LegacyCommutativeMonoid =
        CommutativeMonoidOf(
          S,
          op,
          e,
        )

    initCompressedSegTree2D(
      points,
      LegacyCommutativeMonoid,
    )

  proc add*[
      ST: SegTree2D
  ](
      tree: var ST,
      x,
      y: int,
      value: ST.S
  ) {.inline.} =
    tree.combineAt(
      x,
      y,
      value,
    )

  proc prod*[
      ST: SegTree2D;
      XRange: Slice[int] or int;
      YRange: Slice[int] or int
  ](
      tree: ST,
      xRange: XRange,
      yRange: YRange
  ): ST.S =
    ## Historical inclusive-Slice rectangle interface.
    var
      xBegin: int
      xEnd: int
      yBegin: int
      yEnd: int

    when XRange is int:
      xBegin =
        tree.xs.lowerBound(xRange)

      xEnd =
        tree.xs.upperBound(xRange)
    else:
      if xRange.a > xRange.b:
        return tree.SegTree.calc_e()

      xBegin =
        tree.xs.lowerBound(xRange.a)

      xEnd =
        tree.xs.upperBound(xRange.b)

    var left =
      xBegin + tree.N2

    var right =
      xEnd + tree.N2

    var productLeft =
      tree.SegTree.calc_e()

    var productRight =
      tree.SegTree.calc_e()

    while left < right:
      if (left and 1) != 0:
        when YRange is int:
          yBegin =
            tree.ys[left].lowerBound(yRange)

          yEnd =
            tree.ys[left].upperBound(yRange)
        else:
          if yRange.a > yRange.b:
            return tree.SegTree.calc_e()

          yBegin =
            tree.ys[left].lowerBound(yRange.a)

          yEnd =
            tree.ys[left].upperBound(yRange.b)

        productLeft =
          tree.SegTree.calc_op(
            productLeft,
            tree.segt[left].prod(
              yBegin..<yEnd
            ),
          )

        left.inc()

      if (right and 1) != 0:
        right.dec()

        when YRange is int:
          yBegin =
            tree.ys[right].lowerBound(yRange)

          yEnd =
            tree.ys[right].upperBound(yRange)
        else:
          if yRange.a > yRange.b:
            return tree.SegTree.calc_e()

          yBegin =
            tree.ys[right].lowerBound(yRange.a)

          yEnd =
            tree.ys[right].upperBound(yRange.b)

        productRight =
          tree.SegTree.calc_op(
            tree.segt[right].prod(
              yBegin..<yEnd
            ),
            productRight,
          )

      left = left shr 1
      right = right shr 1

    tree.SegTree.calc_op(
      productLeft,
      productRight,
    )

  proc `[]`*[
      ST: SegTree2D
  ](
      tree: ST,
      xRange: Slice[int],
      yRange: Slice[int]
  ): ST.S {.inline.} =
    tree.prod(
      xRange,
      yRange,
    )

  proc `[]`*[
      ST: SegTree2D
  ](
      tree: ST,
      xRange: Slice[int],
      y: int
  ): ST.S {.inline.} =
    tree.prod(
      xRange,
      y,
    )

  proc `[]`*[
      ST: SegTree2D
  ](
      tree: ST,
      x: int,
      yRange: Slice[int]
  ): ST.S {.inline.} =
    tree.prod(
      x,
      yRange,
    )
