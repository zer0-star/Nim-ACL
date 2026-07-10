# Geometry

`atcoder/extra/geometry/geometry` は、二次元幾何 library を使いやすくするための facade module です。

詳しい使い方の流れは [Geometry Guide](./geometry_guide.html) も参照してください。

既存の `geometry_template`, `polygon`, `closest_pair`, `triangle`, `tangent` を re-export しつつ、読みやすい constructor / alias を追加します。

## import

~~~nim
import atcoder/extra/geometry/geometry
~~~

## Re-export

この module は次を re-export します。

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/closest_pair
import atcoder/extra/geometry/polygon
import atcoder/extra/geometry/triangle
import atcoder/extra/geometry/tangent
~~~

## 型 alias

### 定義

~~~nim
type Point2[Real] = Point[Real]
type Line2[Real] = Line[Real]
type Segment2[Real] = Segment[Real]
type Circle2[Real] = Circle[Real]
type Polygon2[Real] = Polygon[Real]
~~~

既存型の読みやすい別名です。

## Friendly constructors

### 定義

~~~nim
proc point[Real](x, y: Real): Point[Real]

proc line[Real](a, b: Point[Real]): Line[Real]
proc line[Real](A, B, C: Real): Line[Real]

proc segment[Real](a, b: Point[Real]): Segment[Real]

proc circle[Real](center: Point[Real], radius: Real): Circle[Real]
proc circle[Real](a, b, c: Point[Real]): Circle[Real]
~~~

既存の `initPoint`, `initLine`, `initSegment`, `initCircle` の読みやすい別名です。

## Friendly operations

### 定義

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

- `dist` は `distance` の別名です。
- `intersects` は `intersect` の別名です。
- `intersection` は `crosspoint` の別名です。

## 使用例

<!-- nim-line-numbers -->
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

## 方針

既存 API は壊さず、読みやすい別名を追加しています。  
既存の `a -- b` や `a !! b` などの競技プログラミング向け短縮表記も引き続き利用できます。
