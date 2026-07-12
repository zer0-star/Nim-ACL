# KD-tree

Supports nearest-neighbor and orthogonal-range queries on a fixed
multidimensional point set.

## General form

~~~nim
let tree =
  initKDTree(points)

let nearestPoint =
  tree.nearest(query)

let indices =
  tree.rangeSearch(
    lower,
    upper,
  )
~~~

## Parameters and types

- `D`: positive compile-time dimension
- `T`: coordinate and squared-distance type
- `KDPoint[D, T]`: an alias for `array[D, T]`
- `KDTree[D, T]`: the constructed static KD-tree
- `KDNearestResult[T]`: original input index and squared distance

`initKDTree` copies the input point sequence. It does not modify the input.

## Preconditions

- `D > 0`
- `T` supports comparison, addition, subtraction, multiplication, and zero
- squared coordinate differences and their sum fit in `T`
- points are not inserted or removed after construction

## Return values and side effects

`nearest(query)` returns:

~~~nim
Option[
  tuple[
    index: int,
    squaredDistance: T,
  ]
]
~~~

It returns `none` for an empty tree. Distance ties are resolved by the smallest
original input index.

`rangeSearch(lower, upper)` returns sorted original input indices satisfying:

~~~text
lower[d] <= point[d] < upper[d]
~~~

in every dimension. The query box is half-open.

`tree.len` returns the number of points.

## Example

~~~nim
import std/options
import atcoder/extra/structure/kd_tree

let points:
  seq[KDPoint[2, int64]] =
    @[
      [0'i64, 0],
      [5'i64, 1],
      [2'i64, 2],
    ]

let tree =
  initKDTree(points)

let nearestPoint =
  tree.nearest(
    [3'i64, 2]
  ).get

doAssert nearestPoint.index == 2
doAssert nearestPoint.squaredDistance == 1

doAssert tree.rangeSearch(
  [0'i64, 0],
  [6'i64, 2],
) == @[0, 1]
~~~

## Related APIs

- `closestPair`: finds the closest pair among all points
- `segtree_2d`: a two-dimensional structure with updates and aggregation
- `rangeSearch`: half-open orthogonal-range reporting on a static point set

A KD-tree is useful for nearest-neighbor search and coordinate-range reporting.

## Complexity and implementation

Let `n` be the number of points, `D` the dimension, and `k` the output size.

- Construction: `O(D n log^2 n)`
- Nearest neighbor: average `O(log n)`, worst case `O(n)`
- Orthogonal range: average `O(log n + k)`, worst case `O(n + k)`
- Memory: `O(D n)`

Each node stores its subtree bounding box. Queries prune subtrees whose boxes
cannot improve or intersect the answer.
