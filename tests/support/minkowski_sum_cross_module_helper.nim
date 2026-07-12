import atcoder/extra/geometry/geometry
import atcoder/extra/geometry/minkowski_sum


proc buildMinkowskiCrossModuleResult*():
    seq[
      Point2[int64]
    ] =
  let
    left =
      @[
        initPoint(0'i64, 0'i64),
        initPoint(2'i64, 0'i64),
        initPoint(2'i64, 1'i64),
        initPoint(0'i64, 1'i64),
      ]

    right =
      @[
        initPoint(-1'i64, -1'i64),
        initPoint(1'i64, -1'i64),
        initPoint(1'i64, 2'i64),
        initPoint(-1'i64, 2'i64),
      ]

  minkowskiSum(
    left,
    right,
  )
