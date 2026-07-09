# Geometry Guide

Nim-ACL の geometry library は、既存の競技プログラミング向け短縮表記を保ちつつ、読みやすい facade module も提供しています。

新しく書くコードでは、まず次の import を使うのがおすすめです。

~~~nim
import atcoder/extra/geometry/geometry
~~~

この module は、基本幾何・polygon・triangle・tangent・closest pair をまとめて re-export し、読みやすい constructor / alias も追加します。

## 推奨スタイル

### 点

~~~nim
let
  a = point(0.0, 0.0)
  b = point(3.0, 4.0)

doAssert dist(a, b) == 5.0
~~~

従来の書き方も使えます。

~~~nim
let a = initPoint[float](0.0, 0.0)
~~~

### 直線・線分

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

従来の短縮表記も残っています。

~~~nim
let l = a -- b
let s = a !! b
~~~

### 円

~~~nim
let c = circle(point(0.0, 0.0), 2.0)
~~~

3点を通る円も作れます。

~~~nim
let c = circle(a, b, c)
~~~

## 名前の対応表

新しい facade 名と従来名の対応です。

| facade | 従来名 | 意味 |
|---|---|---|
| `point(x, y)` | `initPoint[Real](x, y)` | 点 |
| `line(a, b)` | `initLine(a, b)` | 直線 |
| `segment(a, b)` | `initSegment(a, b)` | 線分 |
| `circle(p, r)` | `initCircle(p, r)` | 円 |
| `dist(a, b)` | `distance(a, b)` | 距離 |
| `intersects(a, b)` | `intersect(a, b)` | 交差判定 |
| `intersection(a, b)` | `crosspoint(a, b)` | 交点 |

## よく使う処理

### 外積・内積

~~~nim
cross(a, b)
dot(a, b)
norm(a)
~~~

### ccw

~~~nim
ccw(a, b, c)
~~~

戻り値は次の enum です。

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

## 使い分け

基本的には次で十分です。

~~~nim
import atcoder/extra/geometry/geometry
~~~

個別 module だけを軽く import したい場合は、従来通り次も使えます。

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon
import atcoder/extra/geometry/triangle
import atcoder/extra/geometry/tangent
import atcoder/extra/geometry/closest_pair
~~~

## 注意

- geometry は浮動小数点誤差の影響を受けます。
- 厳密幾何ではなく、競技プログラミング向けの実用的な geometry library です。
- 既存の短縮表記は互換性のため残し、新しい facade は読みやすさのために追加されています。
