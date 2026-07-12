import std/unittest

import atcoder/extra/geometry/geometry
import support/minkowski_sum_cross_module_helper


suite "Minkowski sum cross-module":
  test "geometry point type and public API":
    let result =
      buildMinkowskiCrossModuleResult()

    check result == @[
      initPoint(-1'i64, -1'i64),
      initPoint(3'i64, -1'i64),
      initPoint(3'i64, 3'i64),
      initPoint(-1'i64, 3'i64),
    ]
