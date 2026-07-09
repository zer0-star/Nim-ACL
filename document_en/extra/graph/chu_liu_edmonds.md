# Chu-Liu/Edmonds

`minimumSpanningTreeArborescence(es, V, start)` computes a minimum spanning arborescence of a directed graph.

The root is `start`. The algorithm selects exactly one incoming edge for each vertex `v != start` so that all vertices are reachable from the root and the total edge weight is minimized.

## Import

~~~nim
import std/options
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/chu_liu_edmonds
~~~

## Example

~~~nim
import std/options
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/chu_liu_edmonds

let es: Edges[int, int] = @[
  initEdge[int, int](0, 1, 1),
  initEdge[int, int](0, 2, 5),
  initEdge[int, int](1, 2, 1),
  initEdge[int, int](2, 3, 1),
]

let ans = minimumSpanningTreeArborescence(es, 4, 0)

doAssert ans.isSome

let (cost, parent) = ans.get

doAssert cost == 3
doAssert parent == @[0, 0, 1, 2]
~~~

## Return value

~~~nim
Option[(T, seq[int])]
~~~

If a spanning arborescence exists, the result is `some((cost, parent))`.

- `cost`: total weight of selected edges
- `parent[v]`: parent of vertex `v` in the arborescence
- `parent[start] == start`

If not all vertices can be reached from the root, the result is `none`.

## Notes

- The input is an edge list `Edges[T, int]`.
- Edges are directed.
- Vertices are assumed to be numbered `0 ..< V`.
- Use `std/options` helpers such as `isSome`, `isNone`, and `get`.

## Complexity

Let `n` be the number of vertices and `m` the number of edges. The running time is roughly:

- `O(m log n)`
