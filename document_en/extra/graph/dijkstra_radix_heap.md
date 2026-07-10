# Radix Heap Dijkstra

`dijkstra_radix_heap(g, s)` computes single-source shortest paths on a graph with non-negative integer edge weights using a radix heap.

The return value is a `DijkstraResult`, like the ordinary `dijkstra(g, s)`. Use `d[v]` to get the distance and `d.path(v)` to restore one shortest path.

## Import

~~~nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra_radix_heap
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra_radix_heap

var g = initGraph(5)
g.addEdge(0, 1, 2)
g.addEdge(0, 2, 9)
g.addEdge(1, 2, 1)
g.addEdge(2, 3, 1)
g.addEdge(3, 4, 3)

var d = dijkstra_radix_heap(g, 0)

doAssert d[4] == 7
doAssert d.path(4) == @[0, 1, 2, 3, 4]
~~~

## Multiple sources

The source can be either a single vertex or a sequence of vertices. When a sequence is passed, all given sources start with distance `0`.

~~~nim
var d = dijkstra_radix_heap(g, @[0, 3])
~~~

## Constraints

- The edge weight type `G.T` must be an integer type.
- Edge weights must be non-negative.
- Use `bellman_ford` if the graph may contain negative edges.

## Complexity

Let `n` be the number of vertices, `m` the number of edges, and `B` the bit width used by the radix heap. The running time is roughly:

- `O((n + m) B)`

The result uses the same `DijkstraResult` interface as the ordinary binary-heap `dijkstra`.
