# Geometry Template

`geometry_template` は、二次元幾何で使う基本型と基本関数を提供します。

点、直線、線分、円、外積・内積、ccw、交差判定、距離、交点などを扱えます。

新しく書くコードでは、読みやすい facade の [`atcoder/extra/geometry/geometry`](./geometry.html) も利用できます。

## import

~~~nim
import atcoder/extra/geometry/geometry_template
~~~

## 型

~~~nim
type Point[Real]
type Line[Real]
type Segment[Real]
type Circle[Real]
~~~

`Real` には通常 `float` などの実数型を指定します。

## Point

### 定義

~~~nim
proc initPoint[Real](x, y: Real): Point[Real]
~~~

座標 `(x, y)` の点を返します。

### 使用例

~~~nim
let p = initPoint[float](1.0, 2.0)
~~~

## Line / Segment

### 定義

~~~nim
proc initLine[Real](a, b: Point[Real]): Line[Real]
proc initLine[Real](A, B, C: Real): Line[Real]
proc initSegment[Real](a, b: Point[Real]): Segment[Real]
~~~

- `initLine(a, b)` は 2 点 `a`, `b` を通る直線を返します。
- `initLine(A, B, C)` は直線 `Ax + By = C` を返します。
- `initSegment(a, b)` は端点 `a`, `b` の線分を返します。

既存の短縮表記として、次も使えます。

~~~nim
proc `--`[Real](a, b: Point[Real]): Line[Real]
proc `!!`[Real](a, b: Point[Real]): Segment[Real]
~~~

## Circle

### 定義

~~~nim
proc initCircle[Real](p: Point[Real], r: Real): Circle[Real]
proc initCircle[Real](a, b, c: Point[Real]): Circle[Real]
~~~

- `initCircle(p, r)` は中心 `p`、半径 `r` の円を返します。
- `initCircle(a, b, c)` は 3 点 `a`, `b`, `c` を通る円を返します。

## 基本演算

### 定義

~~~nim
proc cross[Real](a, b: Point[Real]): Real
proc dot[Real](a, b: Point[Real]): Real
proc norm[Real](a: Point[Real]): Real
proc distance[Real](a, b: Point[Real]): Real
proc rotate[Real](theta: Real, p: Point[Real]): Point[Real]
proc radianToDegree[Real](r: Real): Real
proc degreeToRadian[Real](d: Real): Real
~~~

- `cross(a, b)` は外積を返します。
- `dot(a, b)` は内積を返します。
- `norm(a)` は `dot(a, a)` を返します。
- `distance(a, b)` は 2 点間距離を返します。
- `rotate(theta, p)` は点 `p` を `theta` rad だけ反時計回りに回転します。

## ccw

### 定義

~~~nim
type CCWState = enum
  ONLINE_FRONT
  CLOCKWISE
  ON_SEGMENT
  COUNTER_CLOCKWISE
  ONLINE_BACK

proc ccw[Real](a, b, c: Point[Real]): CCWState
~~~

点 `a`, `b`, `c` の位置関係を返します。

## 交差判定・距離・交点

### 定義

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

## 使用例

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

## 計算量

各基本操作は定数時間です。

## 注意

- 浮動小数点比較には許容誤差付き比較が使われます。
- 厳密幾何ではなく、競技プログラミング向けの実用的な geometry template です。
