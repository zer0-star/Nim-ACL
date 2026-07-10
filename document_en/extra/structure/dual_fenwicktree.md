# DualFenwickTree

`DualFenwickTree` is a Fenwick-tree variant supporting range additions and point queries.

A normal Fenwick Tree supports point additions and range-sum queries; a dual Fenwick Tree supports the opposite direction.

## Import

~~~nim
import atcoder/extra/structure/dual_fenwicktree
~~~

## Type

~~~nim
type DualFenwickTree[T, U]
~~~

Usually, construct it with `initDualFenwickTree[T](n)`.

## Constructor

~~~nim
proc initDualFenwickTree[T](n: int): auto
~~~

Creates a length-`n` array initialized with zeros.

## Operations

~~~nim
proc add[FT: DualFenwickTree](fw: var FT, r: RangeType, x: FT.T)
proc `[]`[FT: DualFenwickTree](fw: FT, p: IndexType): FT.T
~~~

- `add(fw, r, x)` adds `x` to range `r`.
- `fw[p]` returns the value at position `p`.

## Example

<!-- nim-line-numbers -->
~~~nim
var fw = initDualFenwickTree[int](5)

fw.add(1 .. 3, 10)
fw.add(2 .. 4, -3)

doAssert fw[0] == 0
doAssert fw[1] == 10
doAssert fw[2] == 7
doAssert fw[3] == 7
doAssert fw[4] == -3
~~~

## Complexity

- range add: `O(log n)`
- point query: `O(log n)`
