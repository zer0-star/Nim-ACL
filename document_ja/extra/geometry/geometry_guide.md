# Geometry Guide

Nim-ACL の geometry library は、既存の競技プログラミング向け短縮表記を保ちつつ、読みやすい facade module も提供しています。

新しく書くコードでは、まず次の import を使うのがおすすめです。

~~~nim
import atcoder/extra/geometry/geometry
~~~

## 基本型

### 定義

~~~nim
type Point[Real]
type Line[Real]
type Segment[Real]
type Circle[Real]
type Polygon[Real] = seq[Point[Real]]
~~~

facade module では次の alias も使えます。

~~~nim
type Point2[Real] = Point[Real]
type Line2[Real] = Line[Real]
type Segment2[Real] = Segment[Real]
type Circle2[Real] = Circle[Real]
type Polygon2[Real] = Polygon[Real]
~~~

## 推奨 constructor

### 定義

~~~nim
proc point[Real](x, y: Real): Point[Real]
proc line[Real](a, b: Point[Real]): Line[Real]
proc segment[Real](a, b: Point[Real]): Segment[Real]
proc circle[Real](center: Point[Real], radius: Real): Circle[Real]
~~~

### 使用例

~~~nim
let
  a = point(0.0, 0.0)
  b = point(3.0, 4.0)

doAssert dist(a, b) == 5.0
~~~

## 従来 constructor

### 定義

~~~nim
proc initPoint[Real](x, y: Real): Point[Real]
proc initLine[Real](a, b: Point[Real]): Line[Real]
proc initSegment[Real](a, b: Point[Real]): Segment[Real]
proc initCircle[Real](center: Point[Real], radius: Real): Circle[Real]
~~~

既存の書き方もそのまま使えます。

~~~nim
let p = initPoint[float](1.0, 2.0)
~~~

## 名前の対応表

| facade | 従来名 | 意味 |
|---|---|---|
| `point(x, y)` | `initPoint[Real](x, y)` | 点 |
| `line(a, b)` | `initLine(a, b)` | 直線 |
| `segment(a, b)` | `initSegment(a, b)` | 線分 |
| `circle(p, r)` | `initCircle(p, r)` | 円 |
| `dist(a, b)` | `distance(a, b)` | 距離 |
| `intersects(a, b)` | `intersect(a, b)` | 交差判定 |
| `intersection(a, b)` | `crosspoint(a, b)` | 交点 |

## 基本演算

### 定義

~~~nim
proc cross[Real](a, b: Point[Real]): Real
proc dot[Real](a, b: Point[Real]): Real
proc norm[Real](a: Point[Real]): Real
proc ccw[Real](a, b, c: Point[Real]): CCWState
~~~

## polygon

### 定義

~~~nim
proc convexHull[Real](p: Polygon[Real], strict = false): Polygon[Real]
proc area[Real](p: Polygon[Real]): Real
proc contains[Real](p: Polygon[Real], q: Point[Real]): State
proc isConvex[Real](p: Polygon[Real]): bool
proc convex_diameter[Real](p: Polygon[Real]): Real
~~~

## triangle

### 定義

~~~nim
proc centroid[Real](a, b, c: Point[Real]): Point[Real]
proc incenter[Real](a, b, c: Point[Real]): Point[Real]
proc circumcenter[Real](a, b, c: Point[Real]): Point[Real]
proc orthocenter[Real](a, b, c: Point[Real]): Point[Real]
proc incircle[Real](a, b, c: Point[Real]): Circle[Real]
proc circumcircle[Real](a, b, c: Point[Real]): Circle[Real]
~~~

## tangent

### 定義

~~~nim
proc tangent[Real](c: Circle[Real], p: Point[Real]): (Point[Real], Point[Real])
proc tangent[Real](c1, c2: Circle[Real]): seq[Line[Real]]
~~~

## 使い分け

通常は次だけで十分です。

~~~nim
import atcoder/extra/geometry/geometry
~~~

個別 module だけを import したい場合は、従来通り次も使えます。

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
