import std/unittest

import atcoder/modint
import atcoder/extra/math/multipoint_evaluation
import atcoder/extra/math/polynomial_interpolation


type
  mint = modint998244353


proc m(
    value: int,
): mint =
  mint.init(value)


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state = state xor (state shl 7)
  state = state xor (state shr 9)
  state = state xor (state shl 8)
  state


suite "polynomialInterpolation":
  test "empty input":
    let result =
      polynomialInterpolation(
        newSeq[mint](),
        newSeq[mint](),
      )

    check result.len == 0

  test "singleton":
    check polynomialInterpolation(
      @[m(7)],
      @[m(11)],
    ) == @[m(11)]

  test "known non-power-of-two example":
    let result =
      polynomialInterpolation(
        @[m(0), m(1), m(2)],
        @[m(3), m(10), m(27)],
      )

    check result ==
      @[m(3), m(2), m(5)]

  test "length mismatch is rejected":
    expect ValueError:
      discard polynomialInterpolation(
        @[m(1), m(2)],
        @[m(3)],
      )

  test "duplicate x coordinates are rejected":
    expect ValueError:
      discard polynomialInterpolation(
        @[m(4), m(4)],
        @[m(1), m(2)],
      )

  test "randomized multipoint roundtrip":
    var state =
      0x8d31_4a72_c905_e6bf'u64

    for n in 1 .. 24:
      var
        xs =
          newSeq[mint](n)

        coefficients =
          newSeq[mint](n)

      for i in 0 ..< n:
        xs[i] =
          m(i + 1)

        coefficients[i] =
          mint.init(
            int(
              nextRandom(state) mod 998244353'u64
            )
          )

      let
        values =
          multipointEvaluation(
            FormalPowerSeries[mint](
              coefficients
            ),
            xs,
          )

        restored =
          polynomialInterpolation(
            xs,
            values,
          )

      check restored == coefficients

      check multipointEvaluation(
        restored,
        xs,
      ) == values
