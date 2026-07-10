# Geometry Template

`geometry_template` provides basic types and functions for two-dimensional geometry.

It supports points, lines, segments, circles, cross products, dot products, ccw classification, intersection tests, distances, and intersection points.

For new code, you can also use the readable facade [`atcoder/extra/geometry/geometry`](./geometry.html).

## Import

~~~nim
import atcoder/extra/geometry/geometry_template
~~~

## Types

~~~nim
type Point[Real]
type Line[Real]
type Segment[Real]
type Circle[Real]
~~~

`Real` is usually a floating-point type such as `float`.

## Point

### Definition

~~~nim
proc initPoint[Real](x, y: Real): Point[Real]
~~~

Returns the point `(x, y)`.

## Line / Segment

### Definition

~~~nim
proc initLine[Real](a, b: Point[Real]): Line[Real]
proc initLine[Real](A, B, C: Real): Line[Real]
proc initSegment[Real](a, b: Point[Real]): Segment[Real]
~~~

The shorthand operators are also available:

~~~nim
proc `--`[Real](a, b: Point[Real]): Line[Real]
proc `!!`[Real](a, b: Point[Real]): Segment[Real]
~~~

## Circle

### Definition

~~~nim
proc initCircle[Real](p: Point[Real], r: Real): Circle[Real]
proc initCircle[Real](a, b, c: Point[Real]): Circle[Real]
~~~

## Basic operations

### Definition

~~~nim
proc cross[Real](a, b: Point[Real]): Real
proc dot[Real](a, b: Point[Real]): Real
proc norm[Real](a: Point[Real]): Real
proc distance[Real](a, b: Point[Real]): Real
proc rotate[Real](theta: Real, p: Point[Real]): Point[Real]
proc radianToDegree[Real](r: Real): Real
proc degreeToRadian[Real](d: Real): Real
~~~

## ccw

### Definition

~~~nim
type CCWState = enum
  ONLINE_FRONT
  CLOCKWISE
  ON_SEGMENT
  COUNTER_CLOCKWISE
  ONLINE_BACK

proc ccw[Real](a, b, c: Point[Real]): CCWState
~~~

## Intersections, distances, and cross points

### Definition

~~~nim
proc parallel[Real](a, b: Line[Real]): bool
proc orthogonal[Real](a, b: Line[Real]): bool

proc intersect[Real](a, b: Line[Real]): bool
proc intersect[Real](a, b: Segment[Real]): bool
proc intersect[Real](a, b: Circle[Real]): int

proc distance[Real](l: Line[Real], p: Point[Real]): Real
proc distance[Real](s: Segment[Real], p: Point[Real]): Real
proc distance[Real](a, b: Segment[Real]): Real

proc crosspoint[Real](a, b: Line[Real]): Point[Real]
proc crosspoint[Real](a, b: Segment[Real]): Point[Real]
proc crosspoint[Real](c: Circle[Real], l: Line[Real]): tuple
proc crosspoint[Real](c1, c2: Circle[Real]): (Point[Real], Point[Real])
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
let
  a = initPoint[float](0.0, 0.0)
  b = initPoint[float](2.0, 2.0)
  c = initPoint[float](0.0, 2.0)
  d = initPoint[float](2.0, 0.0)

let
  l1 = initLine(a, b)
  l2 = initLine(c, d)

doAssert intersect(l1, l2)

let p = crosspoint(l1, l2)

doAssert p.re == 1.0
doAssert p.im == 1.0
~~~

## Complexity

Basic operations are constant time.

## Notes

- Floating-point comparisons use tolerant comparisons.
- This is a practical competitive-programming geometry template, not an exact geometry package.
