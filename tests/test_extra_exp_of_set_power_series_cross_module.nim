import std/unittest

import support/exp_of_set_power_series_cross_module_helper


suite "expOfSetPowerSeries cross-module":
  test "public API and coefficient type remain visible":
    let result =
      buildCrossSetPowerSeriesExp()

    check result.len == 4
    check result[0] ==
      CrossSetPowerSeriesMint.init(1)
    check result[1] ==
      CrossSetPowerSeriesMint.init(2)
    check result[2] ==
      CrossSetPowerSeriesMint.init(3)
    check result[3] ==
      CrossSetPowerSeriesMint.init(11)
