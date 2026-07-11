import atcoder/modint
export modint

import atcoder/extra/math/berlekamp_massey


type
  BerlekampCrossMint* = modint998244353


proc recoverCrossModuleFibonacci*():
    seq[BerlekampCrossMint] =
  let sequence =
    @[
      BerlekampCrossMint.init(0),
      BerlekampCrossMint.init(1),
      BerlekampCrossMint.init(1),
      BerlekampCrossMint.init(2),
      BerlekampCrossMint.init(3),
      BerlekampCrossMint.init(5),
      BerlekampCrossMint.init(8),
      BerlekampCrossMint.init(13),
    ]

  berlekampMassey(sequence)
