import std/unittest

import support/smawk_cross_module_helper


suite "smawk cross-module":
  test "public callback API remains visible":
    check buildCrossSmawkResult() ==
      @[0, 0, 1, 3]
