# WeightedUnionFind

`WeightedUnionFind` is a Union-Find data structure with potentials.

For two vertices `x` and `y` in the same connected component, it can compute `weight(y) - weight(x)`.

## Import

~~~nim
import atcoder/extra/structure/weighted_union_find
~~~

## Type

~~~nim
type WeightedUnionFind[T]
~~~

`T` is the type of potential differences, usually `int`.

## Constructor

~~~nim
proc initWeightedUnionFind[T](n: int): WeightedUnionFind[T]
~~~

Creates a Weighted Union-Find with `n` vertices. Initially, every vertex is isolated and has potential `0`.

## Operations

~~~nim
proc root[T](uf: var WeightedUnionFind[T], x: int): int
proc weight[T](uf: var WeightedUnionFind[T], x: int): T

proc unionSet[T](uf: var WeightedUnionFind[T], x, y: int, w: T): bool

proc same[T](uf: var WeightedUnionFind[T], x, y: int): bool
proc size[T](uf: var WeightedUnionFind[T], x: int): int
proc diff[T](uf: var WeightedUnionFind[T], x, y: int): T
proc groups[T](uf: var WeightedUnionFind[T]): seq[seq[int]]
~~~

`unionSet(uf, x, y, w)` merges components while adding the following constraint:

~~~text
weight(y) - weight(x) = w
~~~

`diff(uf, x, y)` returns `weight(y) - weight(x)`.

## Example

~~~nim
var uf = initWeightedUnionFind[int](4)

discard uf.unionSet(0, 1, 2)  # weight(1) - weight(0) = 2
discard uf.unionSet(1, 2, 3)  # weight(2) - weight(1) = 3

doAssert uf.same(0, 2)
doAssert uf.diff(0, 2) == 5
doAssert uf.diff(2, 0) == -5
doAssert uf.size(0) == 3
~~~

## Complexity

The amortized time complexity is `O(α(n))`, like ordinary Union-Find.
