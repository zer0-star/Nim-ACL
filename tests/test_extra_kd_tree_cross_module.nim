import std/unittest

import support/kd_tree_cross_module_helper


suite "KD-tree cross-module":
  test "generic dimensions and public operations":
    let result =
      buildKDTreeCrossModuleResult()

    check result.nearestIndex == 2
    check result.squaredDistance == 1
    check result.rangeIndices == @[0, 1, 2]
    check result.pointCount == 4
