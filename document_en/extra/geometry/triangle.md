# Triangle

`triangle` provides helpers for common triangle centers and circles.

It supports centroid, incenter, excenters, circumcenter, orthocenter, incircle, excircles, and circumcircle.

## Import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/triangle
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/triangle

let
  a = initPoint[float](0.0, 0.0)
  b = initPoint[float](4.0, 0.0)
  c = initPoint[float](0.0, 3.0)

let g = centroid(a, b, c)
let ic = incircle(a, b, c)
let cc = circumcircle(a, b, c)

doAssert g.re == 4.0 / 3.0
doAssert g.im == 1.0

doAssert ic.p.re == 1.0
doAssert ic.p.im == 1.0
doAssert ic.r == 1.0

doAssert cc.p.re == 2.0
doAssert cc.p.im == 1.5
doAssert cc.r == 2.5
~~~

## API

### centroid

~~~nim
centroid(a, b, c)
~~~

Returns the centroid.

### incircle / incenter

~~~nim
incircle(a, b, c)
incenter(a, b, c)
~~~

Returns the incircle or the incenter.

### excircle / excenter

~~~nim
excircle(a, b, c)
excenter(a, b, c)
~~~

Returns the three excircles or the three excenters.

### circumcircle / circumcenter

~~~nim
circumcircle(a, b, c)
circumcenter(a, b, c)
~~~

Returns the circumcircle or the circumcenter.

### orthocenter

~~~nim
orthocenter(a, b, c)
~~~

Returns the orthocenter.

## Notes

- The three input points are assumed to form a nondegenerate triangle.
- Floating-point errors may occur.
