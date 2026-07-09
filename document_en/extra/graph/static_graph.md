# Static Graph

`StaticGraph` is a graph representation that collects edges first and builds adjacency lists with `build()`.

It is useful when all edges are known before graph traversal or graph algorithms.

## Import

~~~nim
import atcoder/extra/graph/static_graph
~~~

## Example

~~~nim
import atcoder/extra/graph/static_graph

var g = initStaticGraph[int](4)

discard g.addBiEdge(0, 1, 5)
discard g.addBiEdge(1, 2, 7)
discard g.addBiEdge(1, 3, 11)

g.build()

doAssert g.len == 4
doAssert g.degree(1) == 3

var to: seq[int] = @[]
for e in g[1]:
  to.add(e.dst)

doAssert 0 in to
doAssert 2 in to
doAssert 3 in to
~~~

## Edge

Each adjacency edge `e` mainly has the following fields:

- `e.src`: source vertex
- `e.dst`: destination vertex
- `e.weight`: edge weight
- `e.rev`: position of the reverse edge

## addBiEdge

~~~nim
discard g.addBiEdge(u, v, w)
~~~

This adds both `u -> v` and `v -> u`.

## build

~~~nim
g.build()
~~~

After adding edges, call `build()` to make adjacency lists available through `g[v]`.

## Complexity

Let `n` be the number of vertices and `m` the number of directed edges.

- `build()`: `O(n + m)`
- `degree(v)`: `O(1)`
- iterating over `g[v]`: `O(degree(v))`
