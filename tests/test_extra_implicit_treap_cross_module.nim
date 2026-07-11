import std/unittest

import support/implicit_treap_cross_module_helper


suite "implicit treap cross-module":
  test "factory types and public operations remain usable":
    let result =
      buildCrossModuleTreapResult()

    check result.removed == 1

    check result.values ==
      @[4, 10, 3, 2]

    check result.total == 19

    check result.text ==
      "dbca"
