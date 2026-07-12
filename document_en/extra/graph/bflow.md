# Minimum-Cost B-Flow

Solves a minimum-cost B-flow problem with lower and upper edge bounds,
per-vertex supplies and demands, and edge costs.

## General form

~~~nim
var flow =
  initBFlow[Capacity, Cost](
    vertexCount,
  )

flow.add_supply(
  vertex,
  supply,
)

flow.add_demand(
  vertex,
  demand,
)

flow.add_edge(
  source,
  target,
  lowerCapacity,
  upperCapacity,
  cost,
)

let (feasible, minimumCost) =
  flow.solve()
~~~

## Parameters and types

- `CAP`: capacity, supply, demand, and flow type
- `COST`: edge-cost, minimum-cost, and potential type
- `vertexCount`: number of vertices
- `add_supply(v, amount)`: adds supply at vertex `v`
- `add_demand(v, amount)`: adds demand at vertex `v`
- `add_edge(s, t, lower, upper, cost)`: adds a directed edge with lower and
  upper capacity bounds and a unit cost

Edges are numbered in insertion order. Parallel edges and negative edge costs
are supported.

## Preconditions

- vertex indices are in `0 ..< vertexCount`
- `CAP` and `COST` support the arithmetic and comparisons required by the
  internal maximum-flow and cost-scaling implementations
- normally, every edge satisfies `lower <= upper`

Adding an edge with `lower > upper` sets `flow.infeasible` to `true`.

For general feasibility, always use the first component returned by `solve()`,
not `flow.infeasible`. Capacity shortage or unequal total supply and demand can
make `solve()[0]` false while `flow.infeasible` remains false.

## Return values and side effects

~~~nim
let (feasible, minimumCost) =
  flow.solve()
~~~

- `feasible`: whether a feasible B-flow exists
- `minimumCost`: minimum cost when the problem is feasible
- `flow.f[edgeId]`: flow on edge `edgeId`, in insertion order
- `flow.potential[v]`: potential of vertex `v` after solving
- `flow.infeasible`: pre-solve flag recording an edge with `lower > upper`

The authoritative general feasibility result is `solve()[0]`.

## Example

~~~nim
import atcoder/extra/graph/bflow

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

doAssert answer ==
  (true, 6)

doAssert flow.f ==
  @[2]
~~~

## Related APIs

- `MinCostFlow`: source/sink/flow-oriented minimum-cost flow
- `MinCostFlowLowerBound`: minimum-cost flow with lower bounds
- `MFGraph`: maximum flow

This module combines lower and upper bounds, vertex balances, and costs in one
B-flow formulation. Internally, it uses maximum flow and a cost-scaling
minimum-cost-flow solver.

## Complexity and implementation

- `initBFlow`: `O(vertexCount)`
- `add_supply`, `add_demand`, `add_edge`: amortized `O(1)`
- `solve`: follows the complexity of the internal maximum-flow and
  cost-scaling minimum-cost-flow implementations
- Memory: `O(vertexCount + edgeCount)` plus the workspaces of the internal
  solvers

The detailed bound for `solve` depends on the internal `MFGraph` and
`MCFCostScaling` implementations.
