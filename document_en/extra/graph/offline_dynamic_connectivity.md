# OfflineDynamicConnectivity

`OfflineDynamicConnectivity` is a helper for processing graphs with edge insertions and deletions offline.

You register the active time interval `[l, r)` of each edge.  
Then each time point is visited with a `RollbackDSU` representing the graph state at that time.

## Use cases

Typical use cases include:

- undirected graph with edge insertions and deletions
- connectivity queries at each time
- number of connected components at each time
- all queries are known in advance
- offline processing is allowed
- segment tree over time + Rollback DSU

## Idea

Suppose an edge `(u, v)` is active during the time interval `[l, r)`.

Build a segment tree over time `[0, q)`, and decompose `[l, r)` into segment tree nodes.  
Store the edge on those nodes.

Then DFS over the segment tree:

- When entering a node, merge all edges stored at the node into `RollbackDSU`.
- At a leaf, answer queries for that time.
- When leaving the node, roll back to the snapshot before entering.

Each edge is stored in only `O(log q)` nodes, and each time state is restored efficiently.

## Import

~~~nim
import atcoder/extra/graph/offline_dynamic_connectivity
~~~

This module also re-exports `rollback_dsu`.  
Inside callbacks, you can use `RollbackDSU` methods such as `same`, `size`, and `componentCount`.

## Types

~~~nim
type OfflineDCEdge = tuple[u, v: int]
type OfflineDynamicConnectivity
~~~

## Constructor

~~~nim
proc initOfflineDynamicConnectivity(n, q: int): OfflineDynamicConnectivity
~~~

- `n`: number of vertices
- `q`: number of time points. Times are `0 ..< q`.

## Adding active edge intervals

~~~nim
proc addEdgeInterval(dc: var OfflineDynamicConnectivity, l, r, u, v: int)
~~~

Registers an undirected edge `(u, v)` active during the half-open interval `[l, r)`.

## Run

~~~nim
proc run(dc: OfflineDynamicConnectivity, f: proc(t: int, uf: RollbackDSU))
proc componentCounts(dc: OfflineDynamicConnectivity): seq[int]
~~~

- `run(f)` calls `f(t, uf)` for every time `t`.
- Inside the callback, `uf` represents the graph state at time `t`.
- `componentCounts()` is a helper returning the number of connected components at each time.

## Example

~~~nim
var dc = initOfflineDynamicConnectivity(n = 4, q = 5)

# t = 0: 0-1
# t = 1: 0-1, 1-2
# t = 2: 0-1, 1-2, 2-3
# t = 3: 1-2, 2-3
# t = 4: 1-2
dc.addEdgeInterval(0, 3, 0, 1)
dc.addEdgeInterval(1, 5, 1, 2)
dc.addEdgeInterval(2, 4, 2, 3)

var ans = newSeq[bool](5)

dc.run(proc(t: int, uf: RollbackDSU) =
  ans[t] = uf.same(0, 3)
)

doAssert ans == @[false, false, true, false, false]
~~~

For component counts, use the helper.

~~~nim
doAssert dc.componentCounts == @[3, 2, 1, 2, 3]
~~~

## Nim-friendly usage

Callbacks and UFCS make per-time queries concise.

~~~nim
dc.run(proc(t: int, uf: RollbackDSU) =
  echo t, ": ", uf.componentCount
)
~~~

## Complexity

Let `q` be the number of time points and `m` be the number of active edge intervals.

- registering an edge interval: `O(log q)`
- whole DFS: `O(m log q * log n + q * callback)`
- memory: `O(m log q)`

`RollbackDSU` does not use path compression, so `merge`, `same`, and `size` are about `O(log n)`.

## Notes

- You must build active intervals `[l, r)` yourself.
- If the input is given as `add edge` / `delete edge`, keep the add time for each edge in a table and register `[addTime, deleteTime)` when it is deleted.
- This module restores graph states. What to answer at each time is up to the callback.
- This is not a fully online edge-deletion data structure.

## Related resources and libraries

- [cp-algorithms: Deleting from a data structure in O(T(n) log n)](https://cp-algorithms.com/data_structures/deleting_in_log_n.html)
- [Library Checker: Dynamic Graph Vertex Add Component Sum](https://judge.yosupo.jp/problem/dynamic_graph_vertex_add_component_sum)
- Nyaan Library: Offline Dynamic Connectivity
- ei1333 Library: Offline Dynamic Connectivity
