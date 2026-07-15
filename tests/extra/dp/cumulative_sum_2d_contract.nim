import atcoder/extra/dp/cumulative_sum_2d

block emptyConstruction:
  var cumulative =
    initCumulativeSum2D[int](
      0,
      0,
    )

  cumulative.build()

  doAssert cumulative.width == 0
  doAssert cumulative.height == 0

  doAssert cumulative.sum(
    0,
    0,
    0,
    0,
  ) == 0

  doAssert cumulative.allSum == 0

  echo "CUMULATIVE_SUM_2D_EMPTY_OK"

block incrementalConstruction:
  var cumulative =
    initCumulativeSum2D[int](
      4,
      3,
    )

  cumulative.add(0, 0, 1)
  cumulative.add(1, 1, 5)
  cumulative.add(3, 2, 7)
  cumulative.build()

  doAssert cumulative.width == 4
  doAssert cumulative.height == 3

  doAssert cumulative[
    0..0,
    0..0,
  ] == 1

  doAssert cumulative[
    0..3,
    0..2,
  ] == 13

  doAssert cumulative.sum(
    0,
    4,
    0,
    3,
  ) == 13

  doAssert cumulative.sum(
    1,
    4,
    1,
    3,
  ) == 12

  doAssert cumulative.sum(
    2,
    2,
    0,
    3,
  ) == 0

  doAssert cumulative.allSum == 13

  echo "CUMULATIVE_SUM_2D_HALF_OPEN_OK"

block matrixConstruction:
  let data = @[
    @[1, 2],
    @[3, 4],
    @[5, 6],
  ]

  let cumulative =
    initCumulativeSum2D(
      data
    )

  doAssert cumulative.width == 3
  doAssert cumulative.height == 2

  doAssert cumulative[
    1..2,
    0..0,
  ] == 8

  doAssert cumulative.sum(
    1,
    3,
    0,
    1,
  ) == 8

  doAssert cumulative.allSum == 21

  echo "CUMULATIVE_SUM_2D_MATRIX_OK"
