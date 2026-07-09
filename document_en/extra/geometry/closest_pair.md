# Closest Pair

`closest_pair(ps)` computes the minimum distance between two points in a two-dimensional point set.

## Import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/closest_pair
~~~

## Example

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/closest_pair

let ps = @[
  initPoint[float](0.0, 0.0),
  initPoint[float](3.0, 4.0),
  initPoint[float](2.0, 0.0),
  initPoint[float](2.0, 1.0),
]

doAssert closest_pair(ps) == 1.0
~~~

## API

~~~nim
closest_pair(ps)
~~~

Returns the minimum distance between two distinct points in `ps`.

## Notes

- Assumes `ps.len >= 2`.
- If duplicate points exist, the minimum distance is `0`.
- Floating-point comparisons use tolerant comparisons from `geometry_template` / `floatutils`.

## Complexity

For `n` points:

- `O(n log n)`
