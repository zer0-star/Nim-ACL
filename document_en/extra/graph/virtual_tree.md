# VirtualTree

`VirtualTree` builds a small auxiliary tree from a subset of important vertices and their necessary LCAs.

If running DP on the whole tree for every query is too expensive, a virtual tree lets you process only `O(k)` relevant vertices for a query with `k` important vertices.

## Use cases

Typical use cases include:

- queries where only a given subset of vertices is important
- building the minimum subtree connecting important vertices
- tree DP over a compressed set of vertices
- handling distances and ancestor relations using LCA
- large original tree with many small per-query vertex sets

## Idea

Paths between important vertices may meet at LCA vertices.  
Those LCA vertices are necessary to preserve the tree structure.

Sort important vertices by DFS order and add LCAs of adjacent vertices.  
After sorting this expanded set again, use a stack to restore parent-child relations.  
The result is a small tree consisting only of important vertices and necessary LCAs.

Each virtual tree edge stores the distance in the original tree.

## Import

~~~nim
import atcoder/extra/graph/virtual_tree
~~~

## Types

~~~nim
type VirtualTree
type BuiltVirtualTree

type VirtualTreeEdge = tuple[parent, child, dist: int]
type VirtualTreeAdjEdge = tuple[to, dist: int]
~~~

`VirtualTree` is the builder with LCA preprocessing for the original tree.  
`BuiltVirtualTree` is the compressed tree built for a query.

## Constructor

~~~nim
proc initVirtualTree(graph: seq[seq[int]], root: int = 0): VirtualTree
~~~

`graph` is the adjacency list of an undirected tree.

## LCA / distance

~~~nim
proc isAncestor(vt: VirtualTree, a, b: int): bool
proc lca(vt: VirtualTree, a, b: int): int
proc dist(vt: VirtualTree, a, b: int): int
~~~

- `isAncestor(a, b)` checks whether `a` is an ancestor of `b`.
- `lca(a, b)` returns the lowest common ancestor.
- `dist(a, b)` returns the distance in the original tree.

## Building a virtual tree

~~~nim
proc buildVirtualTree(vt: VirtualTree, keys: openArray[int]): BuiltVirtualTree
~~~

Builds a virtual tree containing the important vertices in `keys` and necessary LCAs.

Main fields of `BuiltVirtualTree`:

~~~nim
root: int
vertices: seq[int]
edges: seq[VirtualTreeEdge]
adj: seq[seq[VirtualTreeAdjEdge]]
~~~

- `root` is the original vertex id of the virtual tree root.
- `vertices[i]` is the original vertex id of compressed node `i`.
- `edges` is an edge list using original vertex ids.
- `adj[i]` stores children of compressed node `i`. `to` is a compressed index.

## Example

~~~nim
var g = newSeq[seq[int]](7)

proc addEdge(u, v: int) =
  g[u].add v
  g[v].add u

addEdge(0, 1)
addEdge(0, 2)
addEdge(1, 3)
addEdge(1, 4)
addEdge(2, 5)
addEdge(2, 6)

let vt = initVirtualTree(g)
let built = vt.buildVirtualTree(@[3, 4, 5])

doAssert built.root == 0
doAssert built.vertices == @[0, 1, 3, 4, 5]

doAssert built.edges == @[
  (parent: 0, child: 1, dist: 1),
  (parent: 1, child: 3, dist: 1),
  (parent: 1, child: 4, dist: 1),
  (parent: 0, child: 5, dist: 2),
]
~~~

## Compressed adjacency

`adj` is indexed by compressed node id. To get the original vertex id, use `vertices[to]`.

~~~nim
for e in built.adj[0]:
  let childOriginalVertex = built.vertices[e.to]
  echo childOriginalVertex, " dist = ", e.dist
~~~

## Nim-friendly usage

`lca`, `dist`, and `buildVirtualTree` read naturally with UFCS.

~~~nim
let c = vt.lca(u, v)
let d = vt.dist(u, v)
let tree = vt.buildVirtualTree(keys)
~~~

## Complexity

Let `n` be the number of original tree vertices, `k` be the number of important vertices, and `K` be the number of virtual tree vertices.

- preprocessing: `O(n log n)`
- `lca`: `O(log n)`
- `dist`: `O(log n)`
- `buildVirtualTree`: `O(k log k + k log n)`
- memory: preprocessing `O(n log n)`, built tree `O(K)`

## Notes

- `graph` must be a tree.
- `keys` must not be empty.
- Duplicate keys are removed.
- In `adj`, `to` is a compressed index, not an original vertex id.
- Edge `dist` is the distance in the original tree.

## Related resources and libraries

- cp-algorithms: Lowest Common Ancestor / auxiliary tree concepts
- Nyaan Library: Virtual Tree
- ei1333 Library: Auxiliary Tree
- Codeforces: important vertices on tree / auxiliary tree style problems
