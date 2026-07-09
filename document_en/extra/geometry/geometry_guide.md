# Geometry Guide

Nim-ACL's geometry library keeps existing competitive-programming shorthand APIs while also providing a readable facade module.

For new code, start with:

~~~nim
import atcoder/extra/geometry/geometry
~~~

This module re-exports basic geometry, polygon, triangle, tangent, and closest-pair utilities, and adds readable constructors and aliases.

## Recommended style

### Points

~~~nim
let
  a = point(0.0, 0.0)
  b = point(3.0, 4.0)

doAssert dist(a, b) == 5.0
~~~

The traditional style is still available:

~~~nim
let a = initPoint[float](0.0, 0.0)
~~~

### Lines and segments

~~~nim
let
  a = point(0.0, 0.0)
  b = point(2.0, 2.0)
  c = point(0.0, 2.0)
  d = point(2.0, 0.0)

let
  l1 = line(a, b)
  l2 = line(c, d)
  s1 = segment(a, b)
  s2 = segment(c, d)

doAssert intersects(l1, l2)
doAssert intersects(s1, s2)

let p = intersection(l1, l2)
~~~

The older shorthand remains available:

~~~nim
let l = a -- b
let s = a !! b
~~~

### Circles

~~~nim
let c = circle(point(0.0, 0.0), 2.0)
~~~

You can also construct the circle through three points:

~~~nim
let c = circle(a, b, c)
~~~

## Name mapping

| facade | original name | meaning |
|---|---|---|
| `point(x, y)` | `initPoint[Real](x, y)` | point |
| `line(a, b)` | `initLine(a, b)` | line |
| `segment(a, b)` | `initSegment(a, b)` | segment |
| `circle(p, r)` | `initCircle(p, r)` | circle |
| `dist(a, b)` | `distance(a, b)` | distance |
| `intersects(a, b)` | `intersect(a, b)` | intersection predicate |
| `intersection(a, b)` | `crosspoint(a, b)` | intersection point |

## Common operations

### Cross product and dot product

~~~nim
cross(a, b)
dot(a, b)
norm(a)
~~~

### ccw

~~~nim
ccw(a, b, c)
~~~

The result is one of:

- `COUNTER_CLOCKWISE`
- `CLOCKWISE`
- `ON_SEGMENT`
- `ONLINE_FRONT`
- `ONLINE_BACK`

### polygon

~~~nim
let h = convexHull(points)
let s = area(poly)
let state = contains(poly, p)
let ok = isConvex(poly)
~~~

### triangle

~~~nim
let g = centroid(a, b, c)
let ic = incenter(a, b, c)
let cc = circumcenter(a, b, c)
let oc = orthocenter(a, b, c)
~~~

### tangent

~~~nim
let (u, v) = tangent(circle, point)
let lines = tangent(circle1, circle2)
~~~

## Choosing imports

Usually this is enough:

~~~nim
import atcoder/extra/geometry/geometry
~~~

If you want to import only a specific module, the traditional imports are still available:

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon
import atcoder/extra/geometry/triangle
import atcoder/extra/geometry/tangent
import atcoder/extra/geometry/closest_pair
~~~

## Notes

- Geometry code is affected by floating-point error.
- This is a practical competitive-programming geometry library, not an exact geometry package.
- Existing shorthand APIs remain for compatibility; the facade adds readability.
