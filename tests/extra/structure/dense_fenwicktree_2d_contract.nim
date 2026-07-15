import atcoder/extra/structure/dense_fenwicktree_2d

type
  Box = object
    value: int

proc `+`(
    a,
    b: Box
): Box =
  Box(
    value:
      a.value + b.value
  )

proc `-`(
    a,
    b: Box
): Box =
  Box(
    value:
      a.value - b.value
  )

block dimensions:
  let tree =
    initDenseFenwickTree2D[int](
      4,
      3,
    )

  doAssert tree.width == 4
  doAssert tree.height == 3
  doAssert tree.allSum == 0

  echo "DENSE_FENWICKTREE_2D_DIMENSIONS_OK"

block pointAddAndRectangleSum:
  var tree =
    initDenseFenwickTree2D[int](
      4,
      3,
    )

  tree.add(0, 0, 1)
  tree.add(1, 1, 5)
  tree.add(3, 2, 7)
  tree.add(1, 1, 4)

  doAssert tree.prefixSum(
    2,
    2,
  ) == 10

  doAssert tree.sum(
    0,
    4,
    0,
    3,
  ) == 17

  doAssert tree.sum(
    1,
    4,
    1,
    3,
  ) == 16

  doAssert tree.sum(
    2,
    2,
    0,
    3,
  ) == 0

  doAssert tree.get(1, 1) == 9
  doAssert tree[3, 2] == 7
  doAssert tree.allSum == 17

  echo "DENSE_FENWICKTREE_2D_RECTANGLE_OK"

block zeroDimension:
  var tree =
    initDenseFenwickTree2D[int](
      0,
      0,
    )

  doAssert tree.prefixSum(
    0,
    0,
  ) == 0

  doAssert tree.sum(
    0,
    0,
    0,
    0,
  ) == 0

  echo "DENSE_FENWICKTREE_2D_EMPTY_OK"

block genericAdditiveType:
  var tree =
    initDenseFenwickTree2D[Box](
      2,
      2,
    )

  tree.add(
    0,
    0,
    Box(value: 3),
  )

  tree.add(
    1,
    1,
    Box(value: 8),
  )

  doAssert tree.allSum.value == 11

  doAssert tree.sum(
    1,
    2,
    1,
    2,
  ).value == 8

  echo "DENSE_FENWICKTREE_2D_GENERIC_OK"
