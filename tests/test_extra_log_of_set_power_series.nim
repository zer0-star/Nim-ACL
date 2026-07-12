import std/unittest

import atcoder/extra/math/exp_of_set_power_series
import atcoder/extra/math/log_of_set_power_series
import atcoder/extra/math/subset_convolution


proc copySequence[T](
    values: openArray[T],
): seq[T] =
  result =
    newSeq[T](values.len)

  for index in 0 ..< values.len:
    result[index] =
      values[index]


proc naiveSubsetConvolution(
    left,
    right: openArray[int64],
): seq[int64] =
  if left.len != right.len:
    raise newException(
      ValueError,
      "lengths must match",
    )

  result =
    newSeq[int64](left.len)

  for mask in 0 ..< left.len:
    var subset =
      mask

    while true:
      result[mask] +=
        left[subset] *
        right[mask xor subset]

      if subset == 0:
        break

      subset =
        (subset - 1) and mask


proc naiveUnitInverse(
    values: openArray[int64],
): seq[int64] =
  result =
    newSeq[int64](values.len)

  result[0] =
    1

  for mask in 1 ..< values.len:
    var
      sum =
        0'i64

      subset =
        mask

    while subset > 0:
      sum +=
        values[subset] *
        result[mask xor subset]

      subset =
        (subset - 1) and mask

    result[mask] =
      -sum


proc naiveUnitLog(
    values: openArray[int64],
): seq[int64] =
  let size =
    values.len

  var bitCount =
    0

  var remaining =
    size

  while remaining > 1:
    inc bitCount

    remaining =
      remaining shr 1

  var shifted =
    copySequence(values)

  shifted[0] -=
    1

  var power =
    newSeq[int64](size)

  power[0] =
    1

  result =
    newSeq[int64](size)

  for exponent in 1 .. bitCount:
    power =
      naiveSubsetConvolution(
        power,
        shifted,
      )

    let divisor =
      int64(exponent)

    let sign =
      if exponent mod 2 == 1:
        1'i64
      else:
        -1'i64

    for mask in 1 ..< size:
      doAssert power[mask] mod divisor == 0

      result[mask] +=
        sign *
        (power[mask] div divisor)


proc identitySeries(
    size: int,
): seq[int64] =
  result =
    newSeq[int64](size)

  result[0] =
    1


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state =
    state xor (state shl 7)

  state =
    state xor (state shr 9)

  state =
    state xor (state shl 8)

  state


suite "log of set power series":
  test "scalar unit series":
    check logOfSetPowerSeries(
      @[1'i64]
    ) == @[0'i64]

  test "known exponential and logarithm pair":
    let logarithm =
      @[
        0'i64,
        2,
        3,
        5,
      ]

    let exponential =
      expOfSetPowerSeries(
        logarithm
      )

    check exponential ==
      @[
        1'i64,
        2,
        3,
        11,
      ]

    check logOfSetPowerSeries(
      exponential
    ) == logarithm

  test "unit inverse recurrence used by logarithm":
    let value =
      @[
        1'i64,
        2,
        -1,
        4,
        3,
        -2,
        1,
        5,
      ]

    let inverse =
      naiveUnitInverse(
        value
      )

    check subsetConvolution(
      value,
      inverse,
    ) == identitySeries(
      value.len
    )

  test "randomized exp-log and log-exp roundtrips":
    var state =
      0x6a09_e667_f3bc_c909'u64

    for bitCount in 0 .. 6:
      let size =
        1 shl bitCount

      for _ in 0 ..< 24:
        var logarithm =
          newSeq[int64](size)

        for mask in 1 ..< size:
          logarithm[mask] =
            int64(
              nextRandom(state) mod 7'u64
            ) - 3

        let logarithmBefore =
          logarithm

        let exponential =
          expOfSetPowerSeries(
            logarithm
          )

        let exponentialBefore =
          exponential

        let recovered =
          logOfSetPowerSeries(
            exponential
          )

        check recovered ==
          logarithm

        check recovered ==
          naiveUnitLog(
            exponential
          )

        check logarithm ==
          logarithmBefore

        check exponential ==
          exponentialBefore

        var arbitraryUnit =
          newSeq[int64](size)

        arbitraryUnit[0] =
          1

        for mask in 1 ..< size:
          arbitraryUnit[mask] =
            int64(
              nextRandom(state) mod 7'u64
            ) - 3

        let arbitraryBefore =
          arbitraryUnit

        let unitLog =
          logOfSetPowerSeries(
            arbitraryUnit
          )

        check unitLog ==
          naiveUnitLog(
            arbitraryUnit
          )

        check expOfSetPowerSeries(
          unitLog
        ) == arbitraryUnit

        check arbitraryUnit ==
          arbitraryBefore

  test "invalid length and empty-set coefficient":
    expect ValueError:
      discard logOfSetPowerSeries(
        newSeq[int64]()
      )

    expect ValueError:
      discard logOfSetPowerSeries(
        @[
          1'i64,
          2,
          3,
        ]
      )

    expect ValueError:
      discard logOfSetPowerSeries(
        @[
          0'i64,
          2,
        ]
      )
