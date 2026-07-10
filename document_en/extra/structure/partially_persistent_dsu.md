# PartiallyPersistentDSU

`PartiallyPersistentDSU` is a Union-Find data structure that can answer connectivity and component-size queries for past times.

You merge vertices with a timestamp `t`, and query the state at any timestamp.

## Import

~~~nim
import atcoder/extra/structure/partially_persistent_dsu
~~~

## Type

~~~nim
type PartiallyPersistentDSU
~~~

## Constructor

~~~nim
proc initPartiallyPersistentDSU(n: int): PartiallyPersistentDSU
~~~

Creates a partially persistent DSU with `n` vertices.

## Operations

~~~nim
proc merge(uf: var PartiallyPersistentDSU, t, x, y: int): bool

proc leader(uf: var PartiallyPersistentDSU, t, x: int): int
proc same(uf: var PartiallyPersistentDSU, t, x, y: int): bool
proc size(uf: var PartiallyPersistentDSU, t, x: int): int
~~~

- `merge(t, x, y)` merges `x` and `y` at time `t`.
- `leader(t, x)` returns the leader of `x` at time `t`.
- `same(t, x, y)` checks if `x` and `y` are in the same component at time `t`.
- `size(t, x)` returns the component size of `x` at time `t`.

## Example

<!-- nim-line-numbers -->
~~~nim
var uf = initPartiallyPersistentDSU(4)

discard uf.merge(1, 0, 1)
discard uf.merge(3, 1, 2)

doAssert uf.same(0, 0, 1) == false
doAssert uf.same(1, 0, 1) == true
doAssert uf.same(2, 0, 2) == false
doAssert uf.same(3, 0, 2) == true

doAssert uf.size(0, 0) == 1
doAssert uf.size(1, 0) == 2
doAssert uf.size(3, 0) == 3
~~~

## Constraints

Timestamps passed to `merge` are normally expected to be monotonically increasing.

## Complexity

- `merge`: almost `O(α(n))`
- `leader`, `same`: almost `O(α(n))`
- `size`: `O(log n)`
