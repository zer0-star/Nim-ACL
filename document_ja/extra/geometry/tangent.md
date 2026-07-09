# Tangent

`tangent` は、円に対する接線を求める module です。

外部点から円への接点と、2つの円の共通接線を扱えます。

## import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/tangent
~~~

## 定義

~~~nim
proc tangent[Real](c: Circle[Real], p: Point[Real]): (Point[Real], Point[Real])
proc tangent[Real](c1, c2: Circle[Real]): seq[Line[Real]]
~~~

- `tangent(c, p)` は、点 `p` から円 `c` に引いた 2 本の接線の接点を返します。
- `tangent(c1, c2)` は、2 つの円の共通接線を返します。

## 使用例

~~~nim
let
  c = initCircle(initPoint[float](0.0, 0.0), 1.0)
  p = initPoint[float](2.0, 0.0)

let (u, v) = tangent(c, p)

doAssert distance(c.p, u) == c.r
doAssert distance(c.p, v) == c.r
~~~

## 制約

- 接線が存在しない場合、返る本数は少なくなります。
- 円が重なっている場合や同心円の場合は、状況に応じて空列になります。
- 浮動小数点型では誤差が発生します。
