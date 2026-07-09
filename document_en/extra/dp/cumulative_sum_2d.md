# Cumulative Sum 2D

`CumulativeSum2D` is a two-dimensional cumulative-sum helper for rectangle-sum queries.

## Import

~~~nim
import atcoder/extra/dp/cumulative_sum_2d
~~~

## Example

~~~nim
import atcoder/extra/dp/cumulative_sum_2d

let a = @[
  @[1, 2, 3],
  @[4, 5, 6],
  @[7, 8, 9],
]

var cs = initCumulativeSum2D(a)

doAssert cs[0 .. 1, 0 .. 1] == 12
doAssert cs[1 .. 2, 1 .. 2] == 28
doAssert cs[0 .. 2, 0 .. 2] == 45
~~~

## Starting from an empty grid

~~~nim
var cs = initCumulativeSum2D[int](3, 3)

cs.add(0, 0, 5)
cs.add(2, 1, 7)
cs.build()

doAssert cs[0 .. 2, 0 .. 2] == 12
doAssert cs[2 .. 2, 1 .. 1] == 7
~~~

## API

### initCumulativeSum2D

~~~nim
var cs = initCumulativeSum2D(a)
var cs2 = initCumulativeSum2D[int](W, H)
~~~

### add

~~~nim
cs.add(x, y, z)
~~~

Adds `z` to cell `(x, y)`. Call it before `build()`.

### build

~~~nim
cs.build()
~~~

Builds the cumulative sum table.

### []

~~~nim
cs[x1 .. x2, y1 .. y2]
~~~

Returns the sum of the closed rectangle `[x1, x2] × [y1, y2]`.

## Complexity

- `add`: `O(1)`
- `build`: `O(W H)`
- rectangle query: `O(1)`
