# ConvexHullTrickAddMonotone

`ConvexHullTrickAddMonotone` は、傾きが単調に追加される一次関数集合に対して、指定した `x` における最小値または最大値を求める data structure です。

一次関数 `f(x) = ax + b` を追加し、`query(x)` で最適値を取得します。

## import

~~~nim
import atcoder/extra/structure/convex_hull_trick_add_monotone
~~~

## 型

~~~nim
type ConvexHullTrickAddMonotone[T]
~~~

`T` は係数や評価値の型です。通常は `int`, `int64` などを使います。

## コンストラクタ

~~~nim
proc initConvexHullTrickAddMonotone[T](isMin: bool): ConvexHullTrickAddMonotone[T]
~~~

- `isMin = true`: 最小値 query
- `isMin = false`: 最大値 query

## 操作

~~~nim
proc add[T](cht: var ConvexHullTrickAddMonotone[T], a, b: T)
proc query[T](cht: ConvexHullTrickAddMonotone[T], x: T): T
proc query_monotone_inc[T](cht: var ConvexHullTrickAddMonotone[T], x: T): T
proc query_monotone_dec[T](cht: var ConvexHullTrickAddMonotone[T], x: T): T
~~~

- `add(a, b)` は直線 `f(x) = ax + b` を追加します。
- `query(x)` は現在の直線集合に対する最小値または最大値を返します。
- `query_monotone_inc(x)` は `x` が単調増加に与えられる場合に使います。
- `query_monotone_dec(x)` は `x` が単調減少に与えられる場合に使います。

## 使用例

<!-- nim-line-numbers -->
~~~nim
var cht = initConvexHullTrickAddMonotone[int](true)

cht.add(0, 5)
cht.add(1, 1)
cht.add(2, 0)

doAssert cht.query(0) == 0
doAssert cht.query(2) == 4
~~~

## 制約

追加する直線の傾き `a` は単調である必要があります。  
単調でない順に追加する場合は、通常の Li Chao Tree などを検討してください。

## 計算量

- `add`: 償却 `O(1)`
- `query`: `O(log n)`
- `query_monotone_inc`, `query_monotone_dec`: 償却 `O(1)`

です。
