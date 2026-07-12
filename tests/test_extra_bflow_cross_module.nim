import std/unittest

import support/bflow_cross_module_helper


suite "minimum-cost B-flow cross-module":
  test "public type and operations remain usable":
    let result =
      buildCrossModuleBFlowResult()

    check result.feasible
    check result.cost == 10

    check result.edgeFlows ==
      @[2, 2, 0]

    check result.potentialCount ==
      3
