# Dual Cumulative Sum 2D

`DualCumulativeSum2D` is a two-dimensional imos helper supporting rectangle additions and point queries.

## Import

~~~nim
import atcoder/extra/dp/dual_cumulative_sum_2d
~~~

## Example

~~~nim
import atcoder/extra/dp/dual_cumulative_sum_2d

var ds = initDualCumulativeSum2D[int](4, 4)

ds.add(1 .. 2, 0 .. 1, 10)
ds.add(0 .. 3, 3 .. 3, 5)
ds.add(2, 2, -4)

ds.build()

doAssert ds[1, 0] == 10
doAssert ds[2, 1] == 10
doAssert ds[2, 2] == -4
doAssert ds[3, 3] == 5
~~~

## API

### initDualCumulativeSum2D

~~~nim
var ds = initDualCumulativeSum2D[int](W, H)
~~~

### add

~~~nim
ds.add(x1 .. x2, y1 .. y2, z)
ds.add(x, y, z)
~~~

Adds `z` to the closed rectangle `[x1, x2] × [y1, y2]`.  
`ds.add(x, y, z)` is a point addition.

### build

~~~nim
ds.build()
~~~

Applies the imos prefix sums.

### []

~~~nim
ds[x, y]
~~~

Returns the value at cell `(x, y)`.

## Complexity

- `add`: `O(1)`
- `build`: `O(W H)`
- point query: `O(1)`
