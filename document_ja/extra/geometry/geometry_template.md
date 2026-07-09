# Geometry Template

新しく書くコードでは、読みやすい facade の [`atcoder/extra/geometry/geometry`](./geometry.html) も利用できます。

`geometry_template` は、二次元幾何でよく使う基本型と基本操作をまとめた module です。

点、直線、線分、円、外積・内積、ccw、交差判定、距離、交点などを提供します。

## import

~~~nim
import atcoder/extra/geometry/geometry_template
~~~

## Point

点は `Point[Real]` で表します。`initPoint[Real](x, y)` で作れます。

~~~nim
import atcoder/extra/geometry/geometry_template

let
  a = initPoint[float](0.0, 0.0)
  b = initPoint[float](3.0, 4.0)

doAssert distance(a, b) == 5.0
doAssert dot(b, b) == 25.0
~~~

主な操作です。

~~~nim
cross(a, b)      # 外積
dot(a, b)        # 内積
norm(a)          # dot(a, a)
distance(a, b)   # 点と点の距離
rotate(theta, p) # p を theta rad だけ反時計回りに回転
~~~

## Line / Segment

直線は `Line[Real]`、線分は `Segment[Real]` です。

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

`ccw(a, b, c)` は、点 `a -> b -> c` の位置関係を返します。

~~~nim
let
  a = initPoint[float](0.0, 0.0)
  b = initPoint[float](2.0, 0.0)
  c = initPoint[float](1.0, 1.0)

doAssert ccw(a, b, c) == CCWState.COUNTER_CLOCKWISE
~~~

返り値は次の enum です。

- `COUNTER_CLOCKWISE`
- `CLOCKWISE`
- `ON_SEGMENT`
- `ONLINE_FRONT`
- `ONLINE_BACK`

## 平行・直交・距離

~~~nim
parallel(l1, l2)
orthogonal(l1, l2)
distance(line, point)
distance(segment, point)
distance(segment1, segment2)
~~~

## Circle

円は `Circle[Real]` で表します。

~~~nim
let
  p = initPoint[float](0.0, 0.0)
  c = initCircle(p, 2.0)
~~~

## 注意

- 浮動小数点比較には `floatutils` の許容誤差付き比較が使われています。
- 競技プログラミング向けの geometry template なので、厳密計算ではありません。
- `Point[Real]` は内部的には complex-like な型です。通常は `initPoint` と geometry API 経由で使うのが安全です。
