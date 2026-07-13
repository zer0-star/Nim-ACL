# Minimum Enclosing Circle（最小包含円）

二次元平面上のすべての入力点を含む、半径が最小の円を求めます。

## 一般形

~~~nim
minimumEnclosingCircle(
  points: openArray[Point[float64]],
): Option[Circle[float64]]
~~~

### 引数

- `points: openArray[Point[float64]]`:
  円に含める二次元点の列です。

入力列および各点は変更されません。
重複点および同一直線上の点も扱えます。

### 返り値

- `Option[Circle[float64]]`:
  入力点をすべて含む最小半径の円を返します。

空の点列では`none`を返します。
点が1個の場合は、その点を中心とする半径0の円を返します。

### 制約

- 座標型は`float64`
- 座標演算が`float64`の有限範囲に収まる
- 浮動小数点演算のため、結果には丸め誤差が含まれる場合がある

### 計算量

点数を`n`とします。

- 期待時間: `O(n)`
- 最悪時間: `O(n^3)`
- 追加メモリ: `O(n)`

現在の実装は、入力をコピーして決定的に並べ替えた後、
randomized incremental algorithmを使用します。

## 使用例

~~~nim
import std/options

import atcoder/extra/geometry/geometry
import atcoder/extra/geometry/minimum_enclosing_circle

let points: seq[Point[float64]] =
  @[
    initPoint[float64](0.0, 0.0),
    initPoint[float64](2.0, 0.0),
    initPoint[float64](0.0, 2.0),
  ]

let result =
  minimumEnclosingCircle(points)

doAssert result.isSome
~~~

## import方法

~~~nim
import atcoder/extra/geometry/minimum_enclosing_circle
~~~

点や円を直接構築・参照する場合は、
`atcoder/extra/geometry/geometry`もimportします。

## 主なAPI

- `minimumEnclosingCircle`
