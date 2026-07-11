import atcoder/modint
import atcoder/extra/math/polynomial_interpolation

export modint
export polynomial_interpolation


type
  CrossInterpolationMint* =
    modint998244353


proc buildCrossInterpolation*():
    FormalPowerSeries[CrossInterpolationMint] =
  proc m(
      value: int,
  ): CrossInterpolationMint =
    CrossInterpolationMint.init(value)

  polynomialInterpolation(
    @[m(0), m(1), m(2)],
    @[m(3), m(10), m(27)],
  )
