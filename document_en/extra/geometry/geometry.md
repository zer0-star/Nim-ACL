# Geometry

See also [Geometry Guide](./geometry_guide.html) for a guided overview.

`atcoder/extra/geometry/geometry` is a friendly facade module for two-dimensional geometry utilities.

It re-exports `geometry_template`, `polygon`, `closest_pair`, `triangle`, and `tangent`, and adds readable constructors and aliases.

## Import

~~~nim
import atcoder/extra/geometry/geometry
~~~

## Basic example

~~~nim
import atcoder/extra/geometry/geometry

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

doAssert p.re == 1.0
doAssert p.im == 1.0
~~~

## Friendly constructors

In addition to the existing `initPoint`, `initLine`, `initSegment`, and `initCircle`, this facade provides shorter readable names.

~~~nim
let p = point(1.0, 2.0)
let l = line(point(0.0, 0.0), point(1.0, 1.0))
let s = segment(point(0.0, 0.0), point(1.0, 1.0))
let c = circle(point(0.0, 0.0), 2.0)
~~~

## Friendly aliases

The following type aliases are provided:

~~~nim
Point2[float]
Line2[float]
Segment2[float]
Circle2[float]
Polygon2[float]
~~~

They are aliases of the existing geometry types.

## Friendly operations

~~~nim
dist(a, b)
intersects(a, b)
intersection(a, b)
~~~

- `dist`: distance
- `intersects`: intersection predicate
- `intersection`: intersection point

The original names `distance`, `intersect`, and `crosspoint` are still available.

## Re-export

This module re-exports:

~~~nim
atcoder/extra/geometry/geometry_template
atcoder/extra/geometry/closest_pair
atcoder/extra/geometry/polygon
atcoder/extra/geometry/triangle
atcoder/extra/geometry/tangent
~~~

Therefore, the following functions can be used with this single import:

~~~nim
closest_pair(points)
convexHull(points)
area(poly)
contains(poly, p)
centroid(a, b, c)
incenter(a, b, c)
tangent(circle, point)
~~~

## Policy

This facade does not break existing APIs. It only adds readable aliases.  
Existing competitive-programming shorthand such as `a -- b` and `a !! b` remains available.
