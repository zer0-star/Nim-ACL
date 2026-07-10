# Triangle

`triangle` は三角形の代表的な中心や円を求める module です。

重心、内心、傍心、外心、垂心、内接円、傍接円、外接円を扱えます。

## import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/triangle
~~~

## 定義

~~~nim
proc centroid[Real](a, b, c: Point[Real]): Point[Real]

proc incircle[Real](a, b, c: Point[Real]): Circle[Real]
proc incenter[Real](a, b, c: Point[Real]): Point[Real]

proc excircle[Real](a, b, c: Point[Real]): array[3, Circle[Real]]
proc excenter[Real](a, b, c: Point[Real]): array[3, Point[Real]]

proc circumcircle[Real](a, b, c: Point[Real]): Circle[Real]
proc circumcenter[Real](a, b, c: Point[Real]): Point[Real]

proc orthocenter[Real](a, b, c: Point[Real]): Point[Real]
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
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

## 制約

- 入力の 3 点は非退化な三角形を仮定します。
- 浮動小数点型では誤差が発生します。

## 計算量

各関数は定数時間です。
