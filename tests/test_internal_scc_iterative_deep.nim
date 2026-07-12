import std/unittest

import atcoder/scc
import atcoder/twosat


suite "iterative internal SCC":
  test "deep directed chain":
    const vertexCount =
      300_000

    var graph =
      initSccGraph(vertexCount)

    for vertex in 0 ..< vertexCount - 1:
      graph.add_edge(
        vertex,
        vertex + 1,
      )

    let components =
      graph.scc()

    check components.len ==
      vertexCount

    check components[0] ==
      @[0]

    check components[^1] ==
      @[vertexCount - 1]

  test "deep TwoSAT implication chain":
    const variableCount =
      200_000

    var solver =
      init_TwoSAT(variableCount)

    for variable in 0 ..< variableCount - 1:
      solver.add_clause(
        variable,
        false,
        variable + 1,
        true,
      )

    check solver.satisfiable()
