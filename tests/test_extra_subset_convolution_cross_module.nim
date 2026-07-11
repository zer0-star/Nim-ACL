import std/unittest

import support/subset_convolution_cross_module_helper


suite "subsetConvolution cross-module":
  test "public API and element type remain visible":
    let result =
      buildCrossSubsetConvolution()

    check result.len == 4
    check result[0] ==
      CrossSubsetMint.init(5)
    check result[1] ==
      CrossSubsetMint.init(16)
    check result[2] ==
      CrossSubsetMint.init(22)
    check result[3] ==
      CrossSubsetMint.init(60)
