import atcoder/extra/dp/dual_cumulative_sum_2d

block rectangleAdd:
  var cumulative =
    initDualCumulativeSum2D[int](
      height = 3,
      width = 4,
    )

  cumulative.add(
    rowBegin = 1,
    rowEnd = 3,
    colBegin = 0,
    colEnd = 2,
    value = 2,
  )

  cumulative.add(
    row = 2,
    col = 3,
    value = 5,
  )

  cumulative.add(
    0,
    0,
    0,
    4,
    100,
  )

  cumulative.build()

  doAssert cumulative.get(
    row = 0,
    col = 0,
  ) == 0

  doAssert cumulative.get(1, 0) == 2
  doAssert cumulative.get(2, 1) == 2
  doAssert cumulative.get(2, 3) == 5
  doAssert cumulative[1, 1] == 2

  echo "DUAL_CUMULATIVE_SUM_2D_HALF_OPEN_OK"

block inclusiveSlice:
  var cumulative =
    initDualCumulativeSum2D[int](
      3,
      4,
    )

  cumulative.add(
    0 .. 1,
    1 .. 3,
    4,
  )

  cumulative.build()

  doAssert cumulative[0, 1] == 4
  doAssert cumulative[1, 3] == 4
  doAssert cumulative[2, 3] == 0
  doAssert cumulative[-1, 0] == 0
  doAssert cumulative[3, 0] == 0
  doAssert cumulative[0, 4] == 0

  echo "DUAL_CUMULATIVE_SUM_2D_INCLUSIVE_OK"
