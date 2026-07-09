# Dual Cumulative Sum

`DualCumulativeSum` is a one-dimensional imos helper supporting range additions and point queries.

## Import

~~~nim
import atcoder/extra/dp/dual_cumulative_sum
~~~

## Example

~~~nim
import atcoder/extra/dp/dual_cumulative_sum

var ds = initDualCumulativeSum[int](5)

ds.add(1 .. 3, 10)
ds.add(2, -3)

doAssert ds[0] == 0
doAssert ds[1] == 10
doAssert ds[2] == 7
doAssert ds[3] == 10
doAssert ds[4] == 0
~~~

## API

### initDualCumulativeSum

~~~nim
var ds = initDualCumulativeSum[int](n)
~~~

### add

~~~nim
ds.add(l .. r, x)
ds.add(i, x)
~~~

Adds `x` to the closed interval `[l, r]`. `ds.add(i, x)` is a point addition.

### []

~~~nim
ds[i]
~~~

Returns the value at position `i`.

## Complexity

- `add`: `O(1)`
- `ds[i]`: propagated lazily; total amortized `O(n)`
