# Tangent

`tangent` provides helpers for tangents related to circles.

It can compute tangent points from an external point to a circle and common tangent lines of two circles.

## Import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/tangent
~~~

## Tangents from a point to a circle

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/tangent

let
  c = initCircle(initPoint[float](0.0, 0.0), 1.0)
  p = initPoint[float](2.0, 0.0)

let (u, v) = tangent(c, p)

doAssert distance(c.p, u) == c.r
doAssert distance(c.p, v) == c.r
~~~

`tangent(c, p)` returns the two tangent points from point `p` to circle `c`.

## Common tangents of two circles

~~~nim
let
  c1 = initCircle(initPoint[float](0.0, 0.0), 1.0)
  c2 = initCircle(initPoint[float](4.0, 0.0), 1.0)

let lines = tangent(c1, c2)

doAssert lines.len == 4
~~~

`tangent(c1, c2)` returns common tangent lines as `seq[Line[Real]]`.

## Notes

- If fewer tangents exist, fewer lines are returned.
- For overlapping circles or concentric circles, the result may be empty.
- Floating-point errors may occur.
