import atcoder/extra/dp/cumulative_sum_2d

block emptyConstruction:
  var cumulative =
    initCumulativeSum2D[int](
      height = 0,
      width = 3,
    )

  cumulative.build()

  doAssert cumulative.height == 0
  doAssert cumulative.width == 3

  doAssert cumulative.sum(
    rowBegin = 0,
    rowEnd = 0,
    colBegin = 0,
    colEnd = 3,
  ) == 0

  doAssert cumulative.allSum == 0

  echo "CUMULATIVE_SUM_2D_EMPTY_OK"

block incrementalConstruction:
  var cumulative =
    initCumulativeSum2D[int](
      height = 3,
      width = 4,
    )

  cumulative.add(
    row = 0,
    col = 0,
    value = 1,
  )

  cumulative.add(1, 1, 5)
  cumulative.add(2, 3, 7)
  cumulative.build()

  doAssert cumulative.height == 3
  doAssert cumulative.width == 4

  doAssert cumulative[
    0 .. 0,
    0 .. 0,
  ] == 1

  doAssert cumulative[
    0 .. 2,
    0 .. 3,
  ] == 13

  doAssert cumulative.sum(
    rowBegin = 0,
    rowEnd = 3,
    colBegin = 0,
    colEnd = 4,
  ) == 13

  doAssert cumulative.sum(
    1,
    3,
    1,
    4,
  ) == 12

  doAssert cumulative.sum(
    2,
    2,
    0,
    4,
  ) == 0

  doAssert cumulative.allSum == 13

  echo "CUMULATIVE_SUM_2D_HALF_OPEN_OK"

block matrixConstruction:
  let data = @[
    @[1, 2, 3, 4],
    @[5, 6, 7, 8],
    @[9, 10, 11, 12],
  ]

  let cumulative =
    initCumulativeSum2D(data)

  doAssert cumulative.height == 3
  doAssert cumulative.width == 4

  doAssert cumulative[
    1 .. 2,
    2 .. 3,
  ] == 38

  doAssert cumulative.sum(
    1,
    3,
    2,
    4,
  ) == 38

  doAssert cumulative.sum(
    0,
    3,
    1,
    3,
  ) == 39

  doAssert cumulative.allSum == 78

  echo "CUMULATIVE_SUM_2D_MATRIX_OK"
