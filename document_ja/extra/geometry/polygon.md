# Polygon

`polygon` は、二次元 polygon に対する基本操作を提供します。

凸性判定、凸包、点包含判定、面積、凸多角形の直径などを扱えます。

## import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon
~~~

## 型

~~~nim
type Polygon[Real] = seq[Point[Real]]
~~~

polygon は点列として表されます。

## 定義

~~~nim
proc isConvex[Real](p: Polygon[Real]): bool
proc convexHull[Real](p: Polygon[Real], strict = false): Polygon[Real]
proc convex_cut[Real](p: Polygon[Real], l: Line[Real]): Polygon[Real]
proc convex_diameter[Real](p: Polygon[Real]): Real

type State = enum
  OUT
  ON
  IN

proc contains[Real](p: Polygon[Real], q: Point[Real]): State
proc area[Real](p: Polygon[Real]): Real
proc area[Real](p: Polygon[Real], c: Circle[Real]): Real
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
let square: Polygon[float] = @[
  initPoint[float](0.0, 0.0),
  initPoint[float](2.0, 0.0),
  initPoint[float](2.0, 2.0),
  initPoint[float](0.0, 2.0),
]

doAssert area(square) == 4.0
doAssert contains(square, initPoint[float](1.0, 1.0)) == State.IN
doAssert contains(square, initPoint[float](2.0, 1.0)) == State.ON
doAssert contains(square, initPoint[float](3.0, 1.0)) == State.OUT
~~~

## 計算量

- `area`: `O(n)`
- `contains`: `O(n)`
- `convexHull`: `O(n log n)`
- `isConvex`: `O(n)`
- `convex_diameter`: `O(n)`
