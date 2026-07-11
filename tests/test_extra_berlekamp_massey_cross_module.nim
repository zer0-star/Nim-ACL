import std/unittest

import support/berlekamp_massey_cross_module_helper


suite "Berlekamp-Massey cross-module use":
  test "exported generic procedure works across modules":
    check recoverCrossModuleFibonacci() == @[
      BerlekampCrossMint.init(1),
      BerlekampCrossMint.init(1),
    ]
