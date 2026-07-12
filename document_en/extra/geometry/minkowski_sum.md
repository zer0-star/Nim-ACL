# Minkowski Sum

Computes the Minkowski sum of the convex hulls of two point sets.

## General form

~~~nim
let result =
  minkowskiSum(
    left,
    right,
  )
~~~

## Parameters and types

- `left`, `right`: sequences of `Point2[T]`
- `T`: coordinate type
- Return type: `seq[Point2[T]]`

Input points may be in any order and may contain duplicates, interior points,
or redundant points on hull edges. The implementation normalizes both inputs
to convex hulls before computing their Minkowski sum.

The input sequences are not modified.

## Preconditions

`T` must be an exact ordered-ring-like type supporting:

- comparison
- addition and subtraction
- multiplication
- zero

`int64` is the typical choice. Coordinate operations and cross products must
fit in `T`.

## Return value

If either input is empty, the result is empty.

Otherwise, the result is:

- a strict counterclockwise convex polygon
- free of redundant collinear intermediate vertices
- rotated so the first vertex has the smallest `y`, then the smallest `x`
- not closed by repeating the first vertex at the end

Degenerate point and segment results are supported.

## Example

~~~nim
import atcoder/extra/geometry/geometry
import atcoder/extra/geometry/minkowski_sum

let left =
  @[
    initPoint(0'i64, 0'i64),
    initPoint(1'i64, 0'i64),
    initPoint(1'i64, 1'i64),
    initPoint(0'i64, 1'i64),
  ]

let right =
  @[
    initPoint(-1'i64, -2'i64),
    initPoint(2'i64, -2'i64),
    initPoint(2'i64, 3'i64),
    initPoint(-1'i64, 3'i64),
  ]

doAssert minkowskiSum(
  left,
  right,
) == @[
  initPoint(-1'i64, -2'i64),
  initPoint(3'i64, -2'i64),
  initPoint(3'i64, 4'i64),
  initPoint(-1'i64, 4'i64),
]
~~~

## Related APIs

- `Point2[T]`: two-dimensional point type
- `convexHull`: convex hull of a point set
- `cross`: two-dimensional cross product

The implementation normalizes arbitrary point sets and merges the two convex
hulls' edge vectors by polar angle.

## Complexity and implementation

Let the input sizes be `n` and `m`.

- Convex-hull normalization: `O(n log n + m log m)`
- Hull-edge merge: `O(n + m)`
- Overall: `O(n log n + m log m)`
- Memory: `O(n + m)`

Even when inputs are already convex polygons, the public API normalizes them
to guarantee a consistent canonical result.
