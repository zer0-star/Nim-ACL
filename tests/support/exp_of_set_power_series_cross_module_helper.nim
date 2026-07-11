import atcoder/modint
import atcoder/extra/math/exp_of_set_power_series

export modint
export exp_of_set_power_series


type
  CrossSetPowerSeriesMint* =
    modint998244353


proc buildCrossSetPowerSeriesExp*():
    seq[CrossSetPowerSeriesMint] =
  proc m(
      value: int,
  ): CrossSetPowerSeriesMint {.inline.} =
    CrossSetPowerSeriesMint.init(value)

  expOfSetPowerSeries(
    @[
      m(0),
      m(2),
      m(3),
      m(5),
    ]
  )
