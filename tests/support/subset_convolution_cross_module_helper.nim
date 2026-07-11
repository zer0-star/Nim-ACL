import atcoder/modint
import atcoder/extra/math/subset_convolution

export modint
export subset_convolution


type
  CrossSubsetMint* =
    modint998244353


proc buildCrossSubsetConvolution*():
    seq[CrossSubsetMint] =
  proc m(
      value: int,
  ): CrossSubsetMint {.inline.} =
    CrossSubsetMint.init(value)

  subsetConvolution(
    @[m(1), m(2), m(3), m(4)],
    @[m(5), m(6), m(7), m(8)],
  )
