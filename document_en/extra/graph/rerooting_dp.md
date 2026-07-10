# Rerooting DP

`Rerooting DP` is a technique for computing tree DP answers for every possible root.

A normal tree DP fixes one root and computes values from child subtrees to the parent.  
However, many problems ask for the answer when each vertex is considered as the root.

Running DFS from every vertex would be `O(n^2)`, but rerooting computes all answers in about `O(n)` or `O(n log n)`.

## Use cases

Typical use cases include:

- sum of distances from each vertex to all vertices
- farthest distance from each vertex
- subtree DP answers for every root
- tree DP where parent-side contributions are needed
- AtCoder ABC/ARC tree DP problems

## Idea

Think of DP values as contributions coming from adjacent directions.

The answer for vertex `v` is obtained by merging contributions from all neighbors and then applying `addRoot`.

Child-side contributions are computed by an ordinary bottom-up pass.  
Parent-side contributions are computed using prefix/suffix products of neighbor contributions, excluding one child at a time.

This module asks you to provide three functions:

- `merge(a, b)`: combine contributions
- `addRoot(x, v)`: include vertex `v` itself
- `addEdge(x, edgeId, fromVertex, toVertex)`: transform a value across one edge

## Import

~~~nim
import atcoder/extra/graph/rerooting_dp
~~~

## Types

~~~nim
type RerootingEdge
type RerootingGraph
~~~

## Constructor

~~~nim
proc initRerootingGraph(n: int): RerootingGraph
proc addEdge(g: var RerootingGraph, u, v: int): int
~~~

- `initRerootingGraph(n)` creates a tree container with `n` vertices.
- `addEdge(u, v)` adds an undirected edge and returns its edge id.

## Run

~~~nim
proc rerooting[T](
  g: RerootingGraph,
  identity: T,
  merge: proc(a, b: T): T,
  addRoot: proc(x: T, v: int): T,
  addEdge: proc(x: T, edgeId: int, fromVertex: int, toVertex: int): T
): seq[T]

proc rerooting[T](
  g: RerootingGraph,
  identity: T,
  merge: proc(a, b: T): T,
  addRoot: proc(x: T, v: int): T
): seq[T]
~~~

If `addEdge` is omitted, values are unchanged across edges.

`rerootingDP` is also available as an alias.

## Example: sum of distances from each vertex

~~~nim
import std/sequtils
import atcoder/extra/graph/rerooting_dp

type DP = tuple[size, dist: int]

var g = initRerootingGraph(4)

discard g.addEdge(0, 1)
discard g.addEdge(1, 2)
discard g.addEdge(2, 3)

proc merge(a, b: DP): DP =
  (size: a.size + b.size, dist: a.dist + b.dist)

proc addRoot(x: DP, v: int): DP =
  (size: x.size + 1, dist: x.dist)

proc addEdge(x: DP, edgeId: int, fromVertex: int, toVertex: int): DP =
  (size: x.size, dist: x.dist + x.size)

let ans = g.rerooting((size: 0, dist: 0), merge, addRoot, addEdge)

doAssert ans.mapIt(it.dist) == @[6, 4, 4, 6]
~~~

Here, `size` is the number of vertices in the component, and `dist` is the sum of distances from the current root.  
When crossing one edge, all distances in that component increase by one, so `dist` becomes `dist + size`.

## Example: farthest distance from each vertex

~~~nim
var g = initRerootingGraph(6)

discard g.addEdge(0, 1)
discard g.addEdge(0, 2)
discard g.addEdge(1, 3)
discard g.addEdge(1, 4)
discard g.addEdge(4, 5)

proc merge(a, b: int): int = max(a, b)
proc addRoot(x: int, v: int): int = x
proc addEdge(x: int, edgeId: int, fromVertex: int, toVertex: int): int = x + 1

let ans = g.rerootingDP(0, merge, addRoot, addEdge)

doAssert ans == @[3, 2, 4, 3, 3, 4]
~~~

## Nim-friendly usage

Write `merge`, `addRoot`, and `addEdge` as ordinary procs and call with UFCS.

~~~nim
let ans = g.rerooting(identity, merge, addRoot, addEdge)
~~~

If edge weights are needed, use `edgeId` inside `addEdge` to refer to an external array.

~~~nim
proc addEdge(x: DP, edgeId: int, fromVertex: int, toVertex: int): DP =
  let w = weight[edgeId]
  ...
~~~

## Complexity

For `n` vertices:

- build: `O(n)`
- rerooting: `O(n * merge/addRoot/addEdge cost)`
- memory: `O(n)`

## Notes

- `graph` must be a tree.
- `merge` must be associative.
- `identity` must be the identity element of `merge`.
- This implementation internally roots the tree at vertex `0`, but the result contains answers for all roots.
- Use the overload without `addEdge` only when values do not change across edges.

## Related resources and libraries

- AtCoder / ABC / ARC: rerooting tree DP problems
- ei1333 Library: ReRooting
- Nyaan Library: Rerooting
- AtCoder Library Practice related tree DP explanations
