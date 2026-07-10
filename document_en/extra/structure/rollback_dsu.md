# RollbackDSU

`RollbackDSU` is a Union-Find data structure that can roll back merge operations.

A normal DSU cannot return to a previous state after `merge(a, b)`.  
`RollbackDSU` stores the previous root information on a stack, so it can restore older states with `undo()` or `rollback(snapshot)`.

## Use cases

Typical use cases include:

- offline graph problems with edge insertions and deletions
- segment tree over time + DSU rollback
- divide-and-conquer with DSU
- offline MST or edge-set queries
- dynamic connectivity when all queries are known in advance

## Idea

A normal DSU often uses path compression for speed.  
However, path compression changes many parent pointers, so it is difficult to roll back.

Rollback DSU does not use path compression.  
It only uses union by size.

For each `merge(a, b)`, it stores the old root information on a stack:

- `parentOrSize[x]` before the merge
- `parentOrSize[y]` before the merge
- whether the merge actually connected two components

Then `undo()` pops the last record and restores the saved values.  
This makes merge operations logarithmic and undo operations constant-time.

## Import

~~~nim
import atcoder/extra/structure/rollback_dsu
~~~

## Types

~~~nim
type RollbackDSU
type RollbackDSUHistory
~~~

## Constructor

~~~nim
proc initRollbackDSU(n: int): RollbackDSU
~~~

Creates a rollback-capable DSU with `n` vertices.

## Operations

~~~nim
proc len(uf: RollbackDSU): int
proc componentCount(uf: RollbackDSU): int

proc leader(uf: RollbackDSU, a: int): int
proc size(uf: RollbackDSU, a: int): int
proc same(uf: RollbackDSU, a, b: int): bool
proc merge(uf: var RollbackDSU, a, b: int): bool

proc snapshot(uf: RollbackDSU): int
proc time(uf: RollbackDSU): int

proc undo(uf: var RollbackDSU): bool
proc rollback(uf: var RollbackDSU): bool
proc rollback(uf: var RollbackDSU, snap: int)

proc groups(uf: RollbackDSU): seq[seq[int]]
~~~

- `merge(a, b)` merges the components of `a` and `b`.
- `same(a, b)` checks if `a` and `b` are in the same component.
- `size(a)` returns the component size of `a`.
- `snapshot()` returns the current rollback point.
- `undo()` undoes one previous `merge`.
- `rollback(snap)` restores a previous snapshot.
- `componentCount()` returns the current number of connected components.

## Example

~~~nim
var uf = initRollbackDSU(5)

discard uf.merge(0, 1)
discard uf.merge(2, 3)

let s = uf.snapshot

discard uf.merge(1, 2)

doAssert uf.same(0, 3)
doAssert uf.size(0) == 4

uf.rollback(s)

doAssert uf.same(0, 1)
doAssert uf.same(2, 3)
doAssert not uf.same(0, 2)
~~~

## undo

`undo()` restores one previous `merge`.

~~~nim
var uf = initRollbackDSU(3)

discard uf.merge(0, 1)

doAssert uf.same(0, 1)

discard uf.undo()

doAssert not uf.same(0, 1)
~~~

Even a `merge` between already connected vertices is pushed to the history.  
This makes it easy to match the number of merge calls and undo calls.

## Nim-friendly usage

`componentCount`, `snapshot`, and `time` read naturally with UFCS.

~~~nim
let s = uf.snapshot

discard uf.merge(0, 1)

echo uf.componentCount

uf.rollback(s)
~~~

## Complexity

For `n` vertices:

- `leader`: `O(log n)`
- `same`: `O(log n)`
- `size`: `O(log n)`
- `merge`: `O(log n)`
- `undo`: `O(1)`
- `rollback(snap)`: proportional to the number of undone merge calls
- `groups`: `O(n log n)`

It is slightly slower than a normal DSU because it does not use path compression, but it supports rollback.

## Notes

- Path compression is intentionally not used.
- A `snapshot` is the current length of the merge history.
- Pass a previously saved snapshot to `rollback(snap)`.
- This is not a fully online edge-deletion structure by itself. It is typically combined with offline processing.

## Related resources and libraries

- [cp-algorithms: Deleting from a data structure in O(T(n) log n)](https://cp-algorithms.com/data_structures/deleting_in_log_n.html)
- [Library Checker: Dynamic Graph Vertex Add Component Sum](https://judge.yosupo.jp/problem/dynamic_graph_vertex_add_component_sum)
- Nyaan Library: Offline Dynamic Connectivity
- ei1333 Library: Union-Find rollback / offline dynamic connectivity
