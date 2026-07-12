# Minkowski Sum

2つの点集合の凸包についてMinkowski和を計算します。

## 一般形

~~~nim
let result =
  minkowskiSum(
    left,
    right,
  )
~~~

## 引数・型

- `left`, `right`: `Point2[T]`の列
- `T`: 座標型
- 返り値: `seq[Point2[T]]`

入力は任意順で構いません。重複点、凸包内部の点、辺上の不要な点を含められます。
両入力を内部で凸包へ正規化してからMinkowski和を求めます。

入力列は変更されません。

## 前提条件

`T`は次をサポートするexact ordered ring型である必要があります。

- 比較
- 加算・減算
- 乗算
- 零値

典型的には`int64`を使用します。座標演算と外積が`T`の範囲に収まる必要があります。

## 返り値

どちらかの入力が空なら空列を返します。

空でない場合、返り値は次の形式です。

- 反時計回りのstrict convex polygon
- 同一直線上の不要な中間頂点を含まない
- 先頭は`y`が最小、同率なら`x`が最小の頂点
- 終点として先頭頂点を重複させない

点や線分へ退化する場合にも対応します。

## 具体例

~~~nim
import atcoder/extra/geometry/geometry
import atcoder/extra/geometry/minkowski_sum

let left =
  @[
    initPoint(0'i64, 0'i64),
    initPoint(1'i64, 0'i64),
    initPoint(1'i64, 1'i64),
    initPoint(0'i64, 1'i64),
  ]

let right =
  @[
    initPoint(-1'i64, -2'i64),
    initPoint(2'i64, -2'i64),
    initPoint(2'i64, 3'i64),
    initPoint(-1'i64, 3'i64),
  ]

doAssert minkowskiSum(
  left,
  right,
) == @[
  initPoint(-1'i64, -2'i64),
  initPoint(3'i64, -2'i64),
  initPoint(3'i64, 4'i64),
  initPoint(-1'i64, 4'i64),
]
~~~

## 関連API

- `Point2[T]`: 2次元点型
- `convexHull`: 点集合の凸包
- `cross`: 2次元外積

このAPIは任意の点集合を受け取り、両凸包の辺vectorを偏角順にmergeします。

## 計算量と内部実装

入力点数を`n`, `m`とします。

- 凸包正規化: `O(n log n + m log m)`
- 凸包辺のmerge: `O(n + m)`
- 全体: `O(n log n + m log m)`
- メモリ: `O(n + m)`

すでに凸多角形であっても、公開APIの一貫した正規形を保証するため内部で正規化します。
