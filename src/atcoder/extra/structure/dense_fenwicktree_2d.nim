when not declared ATCODER_EXTRA_STRUCTURE_DENSE_FENWICKTREE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_DENSE_FENWICKTREE_2D_HPP* = 1

  type
    DenseFenwickTree2D*[T] = object
      widthValue: int
      heightValue: int
      data: seq[seq[T]]

  proc initDenseFenwickTree2D*[T](
      width,
      height: int
  ): DenseFenwickTree2D[T] =
    ## Constructs a dense two-dimensional Fenwick tree.
    ##
    ## Valid coordinates satisfy:
    ##
    ##   0 <= x < width
    ##   0 <= y < height
    assert width >= 0
    assert height >= 0

    result.widthValue = width
    result.heightValue = height

    result.data =
      newSeq[seq[T]](
        width + 1
      )

    for x in 0..width:
      result.data[x] =
        newSeq[T](
          height + 1
        )

  proc width*[T](
      tree: DenseFenwickTree2D[T]
  ): int {.inline.} =
    tree.widthValue

  proc height*[T](
      tree: DenseFenwickTree2D[T]
  ): int {.inline.} =
    tree.heightValue

  proc add*[T](
      tree: var DenseFenwickTree2D[T],
      x,
      y: int,
      delta: T
  ) =
    ## Adds delta to point (x, y).
    mixin `+`
    assert 0 <= x
    assert x < tree.widthValue
    assert 0 <= y
    assert y < tree.heightValue

    var xi =
      x + 1

    while xi <= tree.widthValue:
      var yi =
        y + 1

      while yi <= tree.heightValue:
        tree.data[xi][yi] =
          tree.data[xi][yi] + delta

        yi +=
          yi and -yi

      xi +=
        xi and -xi

  proc prefixSum*[T](
      tree: DenseFenwickTree2D[T],
      xRight,
      yRight: int
  ): T =
    ## Returns the sum over [0, xRight) x [0, yRight).
    mixin `+`
    assert 0 <= xRight
    assert xRight <= tree.widthValue
    assert 0 <= yRight
    assert yRight <= tree.heightValue

    var xi =
      xRight

    while xi > 0:
      var yi =
        yRight

      while yi > 0:
        result =
          result + tree.data[xi][yi]

        yi -=
          yi and -yi

      xi -=
        xi and -xi

  proc sum*[T](
      tree: DenseFenwickTree2D[T],
      xLeft,
      xRight,
      yLeft,
      yRight: int
  ): T =
    ## Returns the sum over
    ## [xLeft, xRight) x [yLeft, yRight).
    mixin `+`, `-`
    assert 0 <= xLeft
    assert xLeft <= xRight
    assert xRight <= tree.widthValue
    assert 0 <= yLeft
    assert yLeft <= yRight
    assert yRight <= tree.heightValue

    tree.prefixSum(
      xRight,
      yRight,
    ) -
    tree.prefixSum(
      xLeft,
      yRight,
    ) -
    tree.prefixSum(
      xRight,
      yLeft,
    ) +
    tree.prefixSum(
      xLeft,
      yLeft,
    )

  proc get*[T](
      tree: DenseFenwickTree2D[T],
      x,
      y: int
  ): T {.inline.} =
    tree.sum(
      x,
      x + 1,
      y,
      y + 1,
    )

  proc allSum*[T](
      tree: DenseFenwickTree2D[T]
  ): T {.inline.} =
    tree.prefixSum(
      tree.widthValue,
      tree.heightValue,
    )

  proc `[]`*[T](
      tree: DenseFenwickTree2D[T],
      x,
      y: int
  ): T {.inline.} =
    tree.get(
      x,
      y,
    )
