# ConvexHullTrickAddMonotone

`ConvexHullTrickAddMonotone` maintains a set of linear functions whose slopes are added monotonically and answers minimum or maximum value queries at a given `x`.

Each line has the form `f(x) = ax + b`.

## Import

~~~nim
import atcoder/extra/structure/convex_hull_trick_add_monotone
~~~

## Type

~~~nim
type ConvexHullTrickAddMonotone[T]
~~~

`T` is the coefficient and value type, usually `int` or `int64`.

## Constructor

~~~nim
proc initConvexHullTrickAddMonotone[T](isMin: bool): ConvexHullTrickAddMonotone[T]
~~~

- `isMin = true`: minimum queries
- `isMin = false`: maximum queries

## Operations

~~~nim
proc add[T](cht: var ConvexHullTrickAddMonotone[T], a, b: T)
proc query[T](cht: ConvexHullTrickAddMonotone[T], x: T): T
proc query_monotone_inc[T](cht: var ConvexHullTrickAddMonotone[T], x: T): T
proc query_monotone_dec[T](cht: var ConvexHullTrickAddMonotone[T], x: T): T
~~~

- `add(a, b)` inserts `f(x) = ax + b`.
- `query(x)` returns the current minimum or maximum value.
- `query_monotone_inc(x)` is for monotonically increasing query `x`.
- `query_monotone_dec(x)` is for monotonically decreasing query `x`.

## Example

~~~nim
var cht = initConvexHullTrickAddMonotone[int](true)

cht.add(0, 5)
cht.add(1, 1)
cht.add(2, 0)

doAssert cht.query(0) == 0
doAssert cht.query(2) == 4
~~~

## Constraints

The slopes `a` of added lines must be monotonic.  
If slopes are not monotonic, consider using Li Chao Tree.

## Complexity

- `add`: amortized `O(1)`
- `query`: `O(log n)`
- `query_monotone_inc`, `query_monotone_dec`: amortized `O(1)`
