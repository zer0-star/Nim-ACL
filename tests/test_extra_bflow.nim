import std/unittest

import atcoder/extra/graph/bflow


suite "minimum-cost B-flow":
  test "lower bound, cost, flow order, and potentials":
    var flow =
      initBFlow[int, int](2)

    flow.add_supply(
      0,
      2,
    )

    flow.add_demand(
      1,
      2,
    )

    flow.add_edge(
      0,
      1,
      2,
      5,
      3,
    )

    let answer =
      flow.solve()

    check answer ==
      (true, 6)

    check flow.f ==
      @[2]

    check flow.potential.len ==
      2

    check not flow.infeasible

  test "parallel edges use input-edge order":
    var flow =
      initBFlow[int, int](2)

    flow.add_supply(
      0,
      3,
    )

    flow.add_demand(
      1,
      3,
    )

    flow.add_edge(
      0,
      1,
      0,
      3,
      1,
    )

    flow.add_edge(
      0,
      1,
      0,
      3,
      5,
    )

    let answer =
      flow.solve()

    check answer ==
      (true, 3)

    check flow.f ==
      @[3, 0]

  test "negative edge costs":
    var flow =
      initBFlow[int, int](2)

    flow.add_supply(
      0,
      2,
    )

    flow.add_demand(
      1,
      2,
    )

    flow.add_edge(
      0,
      1,
      0,
      2,
      -1,
    )

    flow.add_edge(
      0,
      1,
      0,
      2,
      4,
    )

    let answer =
      flow.solve()

    check answer ==
      (true, -2)

    check flow.f ==
      @[2, 0]

  test "capacity shortage is reported by solve":
    var flow =
      initBFlow[int, int](2)

    flow.add_supply(
      0,
      2,
    )

    flow.add_demand(
      1,
      2,
    )

    flow.add_edge(
      0,
      1,
      0,
      1,
      7,
    )

    let answer =
      flow.solve()

    check not answer[0]

    # This public field only records an immediately invalid
    # lower/upper-bound pair.
    check not flow.infeasible

  test "unbalanced total supply and demand":
    var flow =
      initBFlow[int, int](2)

    flow.add_supply(
      0,
      2,
    )

    flow.add_demand(
      1,
      1,
    )

    flow.add_edge(
      0,
      1,
      0,
      5,
      1,
    )

    let answer =
      flow.solve()

    check not answer[0]
    check not flow.infeasible

  test "invalid lower and upper bounds":
    var flow =
      initBFlow[int, int](2)

    flow.add_edge(
      0,
      1,
      3,
      2,
      5,
    )

    check flow.infeasible

    let answer =
      flow.solve()

    check not answer[0]
