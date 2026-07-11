import std/unittest

import support/bipartite_edge_coloring_cross_module_helper


suite "bipartite edge coloring cross-module":
  test "public free-function API remains visible":
    let colors =
      buildCrossModuleEdgeColors()

    check colors.len == 4

    if colors.len == 4:
      var used:
        array[3, bool]

      for color in colors:
        check color >= 0
        check color < 3

        if color >= 0 and color < 3:
          used[color] =
            true

      check used ==
        [true, true, true]

      # Input edges:
      # 0: (0, 0)
      # 1: (0, 0)
      # 2: (0, 1)
      # 3: (1, 0)
      #
      # Check every pair sharing an endpoint.
      check colors[0] != colors[1]
      check colors[0] != colors[2]
      check colors[0] != colors[3]
      check colors[1] != colors[2]
      check colors[1] != colors[3]
