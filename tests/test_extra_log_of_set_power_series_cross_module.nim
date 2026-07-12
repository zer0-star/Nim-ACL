import std/unittest

import support/log_of_set_power_series_cross_module_helper


suite "log of set power series cross-module":
  test "public API remains usable across modules":
    let result =
      buildCrossModuleSetPowerSeriesResult()

    check result.logarithm ==
      @[
        0'i64,
        2,
        3,
        5,
      ]

    check result.exponential ==
      @[
        1'i64,
        2,
        3,
        11,
      ]
