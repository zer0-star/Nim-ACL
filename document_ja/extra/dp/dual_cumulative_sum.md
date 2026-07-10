# Dual Cumulative Sum

`DualCumulativeSum` は、区間加算・一点取得を行うための一次元 imos 構造です。

## import

~~~nim
import atcoder/extra/dp/dual_cumulative_sum
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/dp/dual_cumulative_sum

var ds = initDualCumulativeSum[int](5)

ds.add(1 .. 3, 10)
ds.add(2, -3)

doAssert ds[0] == 0
doAssert ds[1] == 10
doAssert ds[2] == 7
doAssert ds[3] == 10
doAssert ds[4] == 0
~~~

## API

### initDualCumulativeSum

~~~nim
var ds = initDualCumulativeSum[int](n)
~~~

### add

~~~nim
ds.add(l .. r, x)
ds.add(i, x)
~~~

閉区間 `[l, r]` に `x` を加算します。`ds.add(i, x)` は一点加算です。

### []

~~~nim
ds[i]
~~~

位置 `i` の値を返します。

## 計算量

- `add`: `O(1)`
- `ds[i]`: 必要な位置まで累積し、全体で償却 `O(n)`
