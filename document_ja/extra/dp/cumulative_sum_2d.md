# Cumulative Sum 2D

`CumulativeSum2D` は、二次元配列の矩形和を求めるための二次元累積和です。

## import

~~~nim
import atcoder/extra/dp/cumulative_sum_2d
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/dp/cumulative_sum_2d

let a = @[
  @[1, 2, 3],
  @[4, 5, 6],
  @[7, 8, 9],
]

var cs = initCumulativeSum2D(a)

doAssert cs[0 .. 1, 0 .. 1] == 12
doAssert cs[1 .. 2, 1 .. 2] == 28
doAssert cs[0 .. 2, 0 .. 2] == 45
~~~

## 空の状態から使う

~~~nim
var cs = initCumulativeSum2D[int](3, 3)

cs.add(0, 0, 5)
cs.add(2, 1, 7)
cs.build()

doAssert cs[0 .. 2, 0 .. 2] == 12
doAssert cs[2 .. 2, 1 .. 1] == 7
~~~

## API

### initCumulativeSum2D

~~~nim
var cs = initCumulativeSum2D(a)
var cs2 = initCumulativeSum2D[int](W, H)
~~~

### add

~~~nim
cs.add(x, y, z)
~~~

座標 `(x, y)` に `z` を加算します。`build()` の前に呼んでください。

### build

~~~nim
cs.build()
~~~

累積和を構築します。

### []

~~~nim
cs[x1 .. x2, y1 .. y2]
~~~

閉矩形 `[x1, x2] × [y1, y2]` の和を返します。

## 計算量

- `add`: `O(1)`
- `build`: `O(W H)`
- 矩形和取得: `O(1)`
