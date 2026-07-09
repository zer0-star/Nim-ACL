# Geometry

`atcoder/extra/geometry/geometry` is a friendly facade module for two-dimensional geometry utilities.

See also [Geometry Guide](./geometry_guide.html) for a guided overview.

It re-exports `geometry_template`, `polygon`, `closest_pair`, `triangle`, and `tangent`, and adds readable constructors and aliases.

## Import

~~~nim
import atcoder/extra/geometry/geometry
~~~

## Re-export

This module re-exports:

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/closest_pair
import atcoder/extra/geometry/polygon
import atcoder/extra/geometry/triangle
import atcoder/extra/geometry/tangent
~~~

## Type aliases

### Definition

~~~nim
type Point2[Real] = Point[Real]
type Line2[Real] = Line[Real]
type Segment2[Real] = Segment[Real]
type Circle2[Real] = Circle[Real]
type Polygon2[Real] = Polygon[Real]
~~~

## Friendly constructors

### Definition

~~~nim
proc point[Real](x, y: Real): Point[Real]

proc line[Real](a, b: Point[Real]): Line[Real]
proc line[Real](A, B, C: Real): Line[Real]

proc segment[Real](a, b: Point[Real]): Segment[Real]

proc circle[Real](center: Point[Real], radius: Real): Circle[Real]
proc circle[Real](a, b, c: Point[Real]): Circle[Real]
~~~

## Friendly operations

### Definition

~~~nim
proc dist[Real](a, b: Point[Real]): Real
proc dist[Real](l: Line[Real], p: Point[Real]): Real
proc dist[Real](s: Segment[Real], p: Point[Real]): Real
proc dist[Real](a, b: Segment[Real]): Real

proc intersects[Real](a, b: Line[Real]): bool
proc intersects[Real](a, b: Segment[Real]): bool

proc intersection[Real](a, b: Line[Real]): Point[Real]
proc intersection[Real](a, b: Segment[Real]): Point[Real]
~~~

## Example

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

doAssert p.re == 1.0
doAssert p.im == 1.0
~~~
