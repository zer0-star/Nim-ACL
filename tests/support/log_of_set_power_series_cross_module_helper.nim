import atcoder/extra/math/exp_of_set_power_series
import atcoder/extra/math/log_of_set_power_series


proc buildCrossModuleSetPowerSeriesResult*():
    tuple[
      logarithm: seq[int64],
      exponential: seq[int64],
    ] =
  result.exponential =
    @[
      1'i64,
      2,
      3,
      11,
    ]

  result.logarithm =
    logOfSetPowerSeries(
      result.exponential
    )

  result.exponential =
    expOfSetPowerSeries(
      result.logarithm
    )
