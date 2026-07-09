# Geometry Guide

Nim-ACL's geometry library keeps existing competitive-programming shorthand APIs while also providing a readable facade module.

For new code, start with:

~~~nim
import atcoder/extra/geometry/geometry
~~~

## Basic types

### Definition

~~~nim
type Point[Real]
type Line[Real]
type Segment[Real]
type Circle[Real]
type Polygon[Real] = seq[Point[Real]]
~~~

The facade module also provides aliases:

~~~nim
type Point2[Real] = Point[Real]
type Line2[Real] = Line[Real]
type Segment2[Real] = Segment[Real]
type Circle2[Real] = Circle[Real]
type Polygon2[Real] = Polygon[Real]
~~~

## Recommended constructors

### Definition

~~~nim
proc point[Real](x, y: Real): Point[Real]
proc line[Real](a, b: Point[Real]): Line[Real]
proc segment[Real](a, b: Point[Real]): Segment[Real]
proc circle[Real](center: Point[Real], radius: Real): Circle[Real]
~~~

## Original constructors

### Definition

~~~nim
proc initPoint[Real](x, y: Real): Point[Real]
proc initLine[Real](a, b: Point[Real]): Line[Real]
proc initSegment[Real](a, b: Point[Real]): Segment[Real]
proc initCircle[Real](center: Point[Real], radius: Real): Circle[Real]
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

## Basic operations

### Definition

~~~nim
proc cross[Real](a, b: Point[Real]): Real
proc dot[Real](a, b: Point[Real]): Real
proc norm[Real](a: Point[Real]): Real
proc ccw[Real](a, b, c: Point[Real]): CCWState
~~~

## polygon

### Definition

~~~nim
proc convexHull[Real](p: Polygon[Real], strict = false): Polygon[Real]
proc area[Real](p: Polygon[Real]): Real
proc contains[Real](p: Polygon[Real], q: Point[Real]): State
proc isConvex[Real](p: Polygon[Real]): bool
proc convex_diameter[Real](p: Polygon[Real]): Real
~~~

## triangle

### Definition

~~~nim
proc centroid[Real](a, b, c: Point[Real]): Point[Real]
proc incenter[Real](a, b, c: Point[Real]): Point[Real]
proc circumcenter[Real](a, b, c: Point[Real]): Point[Real]
proc orthocenter[Real](a, b, c: Point[Real]): Point[Real]
proc incircle[Real](a, b, c: Point[Real]): Circle[Real]
proc circumcircle[Real](a, b, c: Point[Real]): Circle[Real]
~~~

## tangent

### Definition

~~~nim
proc tangent[Real](c: Circle[Real], p: Point[Real]): (Point[Real], Point[Real])
proc tangent[Real](c1, c2: Circle[Real]): seq[Line[Real]]
~~~
