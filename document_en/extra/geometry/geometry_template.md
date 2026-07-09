# Geometry Template

For new code, you can also use the readable facade [`atcoder/extra/geometry/geometry`](./geometry.html).

`geometry_template` provides basic types and operations for two-dimensional computational geometry.

It includes points, lines, segments, circles, cross products, dot products, ccw classification, intersections, distances, and cross points.

## Import

~~~nim
import atcoder/extra/geometry/geometry_template
~~~

## Point

A point is represented as `Point[Real]`. Use `initPoint[Real](x, y)` to create one.

~~~nim
import atcoder/extra/geometry/geometry_template

let
  a = initPoint[float](0.0, 0.0)
  b = initPoint[float](3.0, 4.0)

doAssert distance(a, b) == 5.0
doAssert dot(b, b) == 25.0
~~~

Main operations:

~~~nim
cross(a, b)      # cross product
dot(a, b)        # dot product
norm(a)          # dot(a, a)
distance(a, b)   # distance between two points
rotate(theta, p) # rotate p counterclockwise by theta radians
~~~

## Line / Segment

A line is `Line[Real]`, and a segment is `Segment[Real]`.

~~~nim
let
  a = initPoint[float](0.0, 0.0)
  b = initPoint[float](2.0, 2.0)
  c = initPoint[float](0.0, 2.0)
  d = initPoint[float](2.0, 0.0)

let
  l1 = initLine(a, b)
  l2 = initLine(c, d)
  s1 = initSegment(a, b)
  s2 = initSegment(c, d)

doAssert intersect(l1, l2)
doAssert intersect(s1, s2)

let p = crosspoint(l1, l2)

doAssert p.re == 1.0
doAssert p.im == 1.0
~~~

## ccw

`ccw(a, b, c)` classifies the relation of the three points `a -> b -> c`.

~~~nim
let
  a = initPoint[float](0.0, 0.0)
  b = initPoint[float](2.0, 0.0)
  c = initPoint[float](1.0, 1.0)

doAssert ccw(a, b, c) == CCWState.COUNTER_CLOCKWISE
~~~

The result is one of:

- `COUNTER_CLOCKWISE`
- `CLOCKWISE`
- `ON_SEGMENT`
- `ONLINE_FRONT`
- `ONLINE_BACK`

## Parallel, orthogonal, and distance

~~~nim
parallel(l1, l2)
orthogonal(l1, l2)
distance(line, point)
distance(segment, point)
distance(segment1, segment2)
~~~

## Circle

A circle is represented as `Circle[Real]`.

~~~nim
let
  p = initPoint[float](0.0, 0.0)
  c = initCircle(p, 2.0)
~~~

## Notes

- Floating-point comparisons use tolerant comparisons from `floatutils`.
- This is a competitive-programming geometry template, not an exact arithmetic geometry package.
- `Point[Real]` is internally a complex-like type. In user code, prefer creating points with `initPoint` and using geometry APIs.
