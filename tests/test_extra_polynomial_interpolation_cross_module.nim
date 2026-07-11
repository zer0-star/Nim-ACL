import std/unittest

import support/polynomial_interpolation_cross_module_helper


suite "polynomialInterpolation cross-module":
  test "return type and coefficients remain visible":
    let result =
      buildCrossInterpolation()

    check result.len == 3
    check result[0] ==
      CrossInterpolationMint.init(3)
    check result[1] ==
      CrossInterpolationMint.init(2)
    check result[2] ==
      CrossInterpolationMint.init(5)
