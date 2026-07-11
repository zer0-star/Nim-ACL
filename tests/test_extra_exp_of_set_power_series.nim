import std/unittest

import atcoder/modint
import atcoder/extra/math/exp_of_set_power_series


type
  mint = modint998244353


proc m(
    value: int,
): mint {.inline.} =
  mint.init(value)


proc naiveExpOfSetPowerSeries[T](
    f: openArray[T],
): seq[T] =
  let size = f.len

  result =
    newSeq[T](size)

  result[0] =
    T(1)

  for mask in 1 ..< size:
    let distinguishedBit =
      mask and -mask

    var subset = mask

    while subset > 0:
      if (
        subset and distinguishedBit
      ) != 0:
        result[mask] +=
          f[subset] *
          result[mask xor subset]

      subset =
        (subset - 1) and mask


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state = state xor (state shl 7)
  state = state xor (state shr 9)
  state = state xor (state shl 8)
  state


suite "expOfSetPowerSeries":
  test "one-element input":
    check expOfSetPowerSeries(
      @[m(0)]
    ) == @[m(1)]

  test "known example":
    check expOfSetPowerSeries(
      @[
        m(0),
        m(2),
        m(3),
        m(5),
      ]
    ) == @[
      m(1),
      m(2),
      m(3),
      m(11),
    ]

  test "integer coefficients":
    check expOfSetPowerSeries(
      @[
        0,
        2,
        3,
        5,
      ]
    ) == @[
      1,
      2,
      3,
      11,
    ]

  test "input is preserved":
    let
      f = @[
        m(0),
        m(2),
        m(3),
        m(5),
      ]

      original = f

    discard expOfSetPowerSeries(f)

    check f == original

  test "empty input is rejected":
    expect ValueError:
      discard expOfSetPowerSeries(
        newSeq[mint]()
      )

  test "non-power-of-two length is rejected":
    expect ValueError:
      discard expOfSetPowerSeries(
        @[
          m(0),
          m(1),
          m(2),
        ]
      )

  test "nonzero empty-set coefficient is rejected":
    expect ValueError:
      discard expOfSetPowerSeries(
        @[
          m(1),
          m(2),
        ]
      )

  test "randomized independent recurrence differential":
    var state =
      0xb531_97ca_4d20_e86f'u64

    for bitCount in 0 .. 8:
      let size =
        1 shl bitCount

      for _ in 0 ..< 16:
        var f =
          newSeq[mint](size)

        for mask in 1 ..< size:
          f[mask] =
            mint.init(
              int(nextRandom(state) mod 1000'u64)
            )

        check expOfSetPowerSeries(f) ==
          naiveExpOfSetPowerSeries(f)
