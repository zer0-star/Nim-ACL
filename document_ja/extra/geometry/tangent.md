# Tangent

`tangent` は、円に対する接線を求める module です。

外部点から円への接点と、2つの円の共通接線を扱えます。

## import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/tangent
~~~

## 点から円への接線

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/tangent

let
  c = initCircle(initPoint[float](0.0, 0.0), 1.0)
  p = initPoint[float](2.0, 0.0)

let (u, v) = tangent(c, p)

doAssert distance(c.p, u) == c.r
doAssert distance(c.p, v) == c.r
~~~

`tangent(c, p)` は、点 `p` から円 `c` に引いた2本の接線の接点を返します。

## 2つの円の共通接線

~~~nim
let
  c1 = initCircle(initPoint[float](0.0, 0.0), 1.0)
  c2 = initCircle(initPoint[float](4.0, 0.0), 1.0)

let lines = tangent(c1, c2)

doAssert lines.len == 4
~~~

`tangent(c1, c2)` は、2つの円の共通接線を `seq[Line[Real]]` として返します。

## 注意

- 接線が存在しない場合、返る本数は少なくなります。
- 円が重なっている場合や同心円の場合は、状況に応じて空列になります。
- 浮動小数点型では誤差が発生します。
