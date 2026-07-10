# DSUOnTree

`DSUOnTree` is a technique for efficiently computing information over every subtree of a tree.

It is also known as `Sack` or `small-to-large on tree`.

## Use cases

Typical use cases include:

- number of distinct colors in each subtree
- maximum color frequency in each subtree
- subtree queries using a frequency table
- tree DP with a multiset or counter for each subtree
- problems where running DFS for every vertex would be `O(n^2)`

Codeforces 600E “Lomsat gelral” is a representative subtree color-frequency problem.

## Idea

If we build subtree information from scratch at every vertex, the same vertices may be added and removed many times, leading to `O(n^2)`.

DSU on Tree keeps the largest child subtree, called the heavy child, and only rebuilds the smaller light child subtrees.

The usual flow is:

1. Process light children first and clear their data.
2. Process the heavy child and keep its data.
3. Add all vertices in light child subtrees again.
4. Add the current vertex.
5. Call `answer(v)` with the current subtree data.
6. Clear the whole subtree if needed.

Each vertex is re-added through light edges only `O(log n)` times, so the whole process is efficient.

## Import

~~~nim
import atcoder/extra/graph/dsu_on_tree
~~~

## Type

~~~nim
type DSUOnTree
~~~

## Constructor

~~~nim
proc initDSUOnTree(graph: seq[seq[int]], root: int = 0): DSUOnTree
~~~

`graph` is the adjacency list of an undirected tree.

## Metadata

~~~nim
proc len(dt: DSUOnTree): int
proc subtreeVertices(dt: DSUOnTree, v: int): seq[int]
~~~

`DSUOnTree` also exposes these fields:

~~~nim
n: int
root: int
graph: seq[seq[int]]
parent: seq[int]
depth: seq[int]
subtreeSize: seq[int]
heavy: seq[int]
tin: seq[int]
tout: seq[int]
order: seq[int]
~~~

- `parent[v]`: parent vertex
- `depth[v]`: depth from the root
- `subtreeSize[v]`: subtree size
- `heavy[v]`: child with the largest subtree, or `-1`
- `tin`, `tout`, `order`: Euler order for subtree intervals

## Run

~~~nim
proc run(
  dt: DSUOnTree,
  add: proc(v: int),
  remove: proc(v: int),
  answer: proc(v: int)
)

proc runDSUOnTree(
  dt: DSUOnTree,
  add: proc(v: int),
  remove: proc(v: int),
  answer: proc(v: int)
)
~~~

When `answer(v)` is called, the current data structure contains **exactly the vertices in the subtree of `v`**.

- `add(v)`: add vertex `v` to the current state
- `remove(v)`: remove vertex `v` from the current state
- `answer(v)`: record the answer for vertex `v`

## Example: distinct colors in each subtree

~~~nim
import std/tables
import atcoder/extra/graph/dsu_on_tree

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

let
  dt = initDSUOnTree(g)
  color = @[1, 2, 1, 2, 3, 1, 3]

var
  freq = initTable[int, int]()
  distinctCount = 0
  ans = newSeq[int](7)

proc addVertex(v: int) =
  let c = color[v]
  let old = freq.getOrDefault(c, 0)

  if old == 0:
    distinctCount.inc

  freq[c] = old + 1

proc removeVertex(v: int) =
  let c = color[v]
  let old = freq.getOrDefault(c, 0)

  if old == 1:
    freq.del(c)
    distinctCount.dec
  else:
    freq[c] = old - 1

proc answerVertex(v: int) =
  ans[v] = distinctCount

dt.run(addVertex, removeVertex, answerVertex)

doAssert ans == @[3, 2, 2, 1, 1, 1, 1]
~~~

## Nim-friendly usage

Write callbacks as ordinary procs and call `dt.run(...)` with UFCS.

~~~nim
dt.run(addVertex, removeVertex, answerVertex)
~~~

`subtreeVertices(v)` is also available as a helper.

~~~nim
for u in dt.subtreeVertices(v):
  echo u
~~~

## Complexity

For `n` vertices:

- preprocessing: `O(n)`
- `run`: about `O(n log n * add/remove cost)`
- memory: `O(n)`

For typical color-frequency queries, it is fast in practice.

## Notes

- `graph` must be a tree.
- At `answer(v)`, the current state contains only the subtree of `v`.
- `add` and `remove` must be implemented consistently.
- This implementation uses an explicit stack, so it is less likely to overflow the call stack on deep trees.

## Related resources and libraries

- Codeforces 600E: Lomsat gelral
- cp-algorithms: tree queries / small-to-large merging concepts
- Nyaan Library: DSU on Tree
- ei1333 Library: DSU on Tree / Sack
