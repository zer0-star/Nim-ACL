# Geometry

`atcoder/extra/geometry/geometry` は、二次元幾何 library を使いやすくするための facade module です。

既存の `geometry_template`, `polygon`, `closest_pair`, `triangle`, `tangent` を re-export しつつ、読みやすい constructor / alias を追加します。

## import

~~~nim
import atcoder/extra/geometry/geometry
~~~

## 基本例

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

既存の `initPoint`, `initLine`, `initSegment`, `initCircle` に加えて、短く読みやすい名前を使えます。

~~~nim
let p = point(1.0, 2.0)
let l = line(point(0.0, 0.0), point(1.0, 1.0))
let s = segment(point(0.0, 0.0), point(1.0, 1.0))
let c = circle(point(0.0, 0.0), 2.0)
~~~

## Friendly aliases

型 alias も用意しています。

~~~nim
Point2[float]
Line2[float]
Segment2[float]
Circle2[float]
Polygon2[float]
~~~

これらは既存型の別名です。

## Friendly operations

~~~nim
dist(a, b)
intersects(a, b)
intersection(a, b)
~~~

- `dist`: 距離
- `intersects`: 交差判定
- `intersection`: 交点

既存の `distance`, `intersect`, `crosspoint` もそのまま使えます。

## Re-export

この module は次を re-export します。

~~~nim
atcoder/extra/geometry/geometry_template
atcoder/extra/geometry/closest_pair
atcoder/extra/geometry/polygon
atcoder/extra/geometry/triangle
atcoder/extra/geometry/tangent
~~~

そのため、次のような関数もこの import だけで使えます。

~~~nim
closest_pair(points)
convexHull(points)
area(poly)
contains(poly, p)
centroid(a, b, c)
incenter(a, b, c)
tangent(circle, point)
~~~

## 方針

既存 API は壊さず、読みやすい別名を足しています。  
既存の `a -- b` や `a !! b` などの競プロ向け短縮表記も引き続き利用できます。
