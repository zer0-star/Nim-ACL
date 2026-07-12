import atcoder/extra/graph/bflow


proc buildCrossModuleBFlowResult*():
    tuple[
      feasible: bool,
      cost: int,
      edgeFlows: seq[int],
      potentialCount: int,
    ] =
  var flow =
    initBFlow[int, int](3)

  flow.add_supply(
    0,
    2,
  )

  flow.add_demand(
    2,
    2,
  )

  flow.add_edge(
    0,
    1,
    0,
    2,
    2,
  )

  flow.add_edge(
    1,
    2,
    0,
    2,
    3,
  )

  flow.add_edge(
    0,
    2,
    0,
    2,
    10,
  )

  let answer =
    flow.solve()

  result.feasible =
    answer[0]

  result.cost =
    answer[1]

  result.edgeFlows =
    flow.f

  result.potentialCount =
    flow.potential.len
