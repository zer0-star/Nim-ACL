# Cumulative Sum

`CumulativeSum` is a one-dimensional cumulative-sum helper supporting point additions and range-sum queries.

It can be initialized either from an existing sequence or from a length.

## Import

~~~nim
import atcoder/extra/dp/cumulative_sum
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/dp/cumulative_sum

var cs = initCumulativeSum(@[1, 2, 3, 4, 5])

doAssert cs.sum(3) == 6      # a[0] + a[1] + a[2]
doAssert cs[1 .. 3] == 9     # a[1] + a[2] + a[3]
doAssert cs[0 .. 4] == 15
~~~

## Starting from an empty array

~~~nim
var cs = initCumulativeSum[int](5)

cs.add(0, 3)
cs.add(2, 7)
cs.add(4, 11)

doAssert cs[0 .. 4] == 21
doAssert cs[1 .. 3] == 7
~~~

## API

### initCumulativeSum

~~~nim
var cs = initCumulativeSum(@[1, 2, 3])
var cs2 = initCumulativeSum[int](n)
~~~

### add

~~~nim
cs.add(i, x)
~~~

Adds `x` to position `i`.

### sum

~~~nim
cs.sum(k)
~~~

Returns the sum of the first `k` elements.

### []

~~~nim
cs[l .. r]
~~~

Returns the sum over the closed interval `[l, r]`.

## Complexity

The cumulative values are propagated lazily.

- `add`: `O(1)`
- `sum(k)`: amortized over propagated positions
- `cs[l .. r]`: two prefix-sum queries
