# Polygon

`polygon` provides basic operations on two-dimensional polygons.

It supports convexity checks, convex hulls, point containment, area, and diameter of a convex polygon.

## Import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon
~~~

## Polygon

~~~nim
type Polygon[Real] = seq[Point[Real]]
~~~

A polygon is represented as a sequence of points.

## area

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon

let square: Polygon[float] = @[
  initPoint[float](0.0, 0.0),
  initPoint[float](2.0, 0.0),
  initPoint[float](2.0, 2.0),
  initPoint[float](0.0, 2.0),
]

doAssert area(square) == 4.0
~~~

`area(p)` returns the signed area. It is positive for counterclockwise order and negative for clockwise order.

## contains

~~~nim
contains(poly, point)
~~~

Returns whether a point is inside, on the boundary of, or outside the polygon.

The return value is `State`:

- `State.IN`
- `State.ON`
- `State.OUT`

~~~nim
doAssert contains(square, initPoint[float](1.0, 1.0)) == State.IN
doAssert contains(square, initPoint[float](2.0, 1.0)) == State.ON
doAssert contains(square, initPoint[float](3.0, 1.0)) == State.OUT
~~~

## convexHull

~~~nim
let h = convexHull(points)
~~~

Returns the convex hull of a point set.

~~~nim
let points: Polygon[float] = @[
  initPoint[float](0.0, 0.0),
  initPoint[float](2.0, 0.0),
  initPoint[float](2.0, 2.0),
  initPoint[float](0.0, 2.0),
  initPoint[float](1.0, 1.0),
]

let h = convexHull(points)

doAssert h.len == 4
~~~

## isConvex

~~~nim
isConvex(poly)
~~~

Returns `true` if the polygon is convex.

## convex_diameter

~~~nim
convex_diameter(poly)
~~~

Returns the diameter of a convex polygon: the maximum distance between two vertices.

## Complexity

- `area`: `O(n)`
- `contains`: `O(n)`
- `convexHull`: `O(n log n)`
- `isConvex`: `O(n)`
- `convex_diameter`: `O(n)`
