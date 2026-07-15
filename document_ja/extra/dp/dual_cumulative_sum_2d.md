# Dual Cumulative Sum 2D

`DualCumulativeSum2D` は、二次元の矩形加算・一点取得を行う imos 構造です。

## import

~~~nim
import atcoder/extra/dp/dual_cumulative_sum_2d
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/dp/dual_cumulative_sum_2d

var ds = initDualCumulativeSum2D[int](4, 4)

ds.add(1 .. 2, 0 .. 1, 10)
ds.add(0 .. 3, 3 .. 3, 5)
ds.add(2, 2, -4)

ds.build()

doAssert ds[1, 0] == 10
doAssert ds[2, 1] == 10
doAssert ds[2, 2] == -4
doAssert ds[3, 3] == 5
~~~

## API

### initDualCumulativeSum2D

~~~nim
var ds = initDualCumulativeSum2D[int](W, H)
~~~

### add

~~~nim
ds.add(x1 .. x2, y1 .. y2, z)
ds.add(x, y, z)
~~~

閉矩形 `[x1, x2] × [y1, y2]` に `z` を加算します。  
`ds.add(x, y, z)` は一点加算です。

### build

~~~nim
ds.build()
~~~

imos の累積を反映します。

### []

~~~nim
ds[x, y]
~~~

座標 `(x, y)` の値を返します。


<!-- DUAL-CUMULATIVE-SUM-2D-HALF-OPEN:BEGIN -->
## 半開矩形API

5整数版の `add` は半開矩形へ値を加算します。

~~~nim
ds.add(
  xLeft,
  xRight,
  yLeft,
  yRight,
  value,
)
~~~

対象領域は次の通りです。

~~~text
[xLeft, xRight) × [yLeft, yRight)
~~~

`get(x, y)` は `ds[x, y]` と同じ点取得です。

従来の `add(rx, ry, value)` は終端を含む `Slice` APIとして維持されます。
<!-- DUAL-CUMULATIVE-SUM-2D-HALF-OPEN:END -->

## 計算量

- `add`: `O(1)`
- `build`: `O(W H)`
- 一点取得: `O(1)`
