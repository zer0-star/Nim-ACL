# Euler Tour

`EulerTour` maps every subtree of a tree to a contiguous preorder interval `[tin[v], tout[v])`.

## Supported graph forms

The primary interface accepts a sequence-backed Nim-ACL `Graph`.

A lightweight `seq[seq[int]]` adjacency list is accepted by the same constructor. Both forms share one traversal implementation, and the source graph is not retained.

## Import

~~~nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/euler_tour
~~~

## API

~~~nim
proc initEulerTour*[G](
  graph: G,
  root: int = 0
): EulerTour

proc subtreeRange(
  tour: EulerTour,
  vertex: int
): tuple[l, r: int]

proc subtreeSize(
  tour: EulerTour,
  vertex: int
): int
~~~

## Example: Nim-ACL Graph

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/euler_tour

var graph = initGraph(5)

graph.addBiEdge(0, 1)
graph.addBiEdge(0, 2)
graph.addBiEdge(1, 3)
graph.addBiEdge(1, 4)

let tour = initEulerTour(graph)

doAssert tour.subtreeSize(1) == 3
~~~

## Example: adjacency list

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/graph/euler_tour

var graph = newSeq[seq[int]](5)

proc addEdge(u, v: int) =
  graph[u].add v
  graph[v].add u

addEdge(0, 1)
addEdge(0, 2)
addEdge(1, 3)
addEdge(1, 4)

let tour = initEulerTour(graph)

doAssert tour.subtreeSize(1) == 3
~~~

## Complexity

- build: `O(n)`
- subtree interval: `O(1)`
- memory: `O(n)`

## Related resources

- [AtCoder Algorithm Lectures: オイラーツアーテクニック](https://info.atcoder.jp/entry/algorithm_lectures/euler_tour_technique)
- [Heavy-Light Decomposition](../tree/heavy_light_decomposition.html)
- [AC Library: Fenwick Tree](https://atcoder.github.io/ac-library/production/document_en/fenwicktree.html)
- [AC Library: Segment Tree](https://atcoder.github.io/ac-library/production/document_en/segtree.html)
