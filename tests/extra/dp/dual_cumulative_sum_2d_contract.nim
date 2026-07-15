import atcoder/extra/dp/dual_cumulative_sum_2d

block rectangleAdd:
  var cumulative =
    initDualCumulativeSum2D[int](
      4,
      3,
    )

  cumulative.add(
    1,
    4,
    0,
    2,
    2,
  )

  cumulative.add(
    2,
    2,
    5,
  )

  cumulative.add(
    0,
    0,
    0,
    3,
    100,
  )

  cumulative.build()

  doAssert cumulative.get(0, 0) == 0
  doAssert cumulative.get(1, 0) == 2
  doAssert cumulative.get(3, 1) == 2
  doAssert cumulative.get(2, 2) == 5

  doAssert cumulative[1, 1] == 2

  echo "DUAL_CUMULATIVE_SUM_2D_HALF_OPEN_OK"

block legacyInclusiveSlice:
  var cumulative =
    initDualCumulativeSum2D[int](
      3,
      3,
    )

  cumulative.add(
    0..1,
    1..2,
    4,
  )

  cumulative.build()

  doAssert cumulative[0, 1] == 4
  doAssert cumulative[1, 2] == 4
  doAssert cumulative[2, 2] == 0

  echo "DUAL_CUMULATIVE_SUM_2D_LEGACY_OK"
