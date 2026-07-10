# Cumulative Sum

`CumulativeSum` は、点加算と区間和取得を行うための一次元累積和です。

通常の `seq` から初期化することも、長さだけを指定して空の状態から値を追加することもできます。

## import

~~~nim
import atcoder/extra/dp/cumulative_sum
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/dp/cumulative_sum

var cs = initCumulativeSum(@[1, 2, 3, 4, 5])

doAssert cs.sum(3) == 6      # a[0] + a[1] + a[2]
doAssert cs[1 .. 3] == 9     # a[1] + a[2] + a[3]
doAssert cs[0 .. 4] == 15
~~~

## 空の状態から使う

~~~nim
var cs = initCumulativeSum[int](5)

cs.add(0, 3)
cs.add(2, 7)
cs.add(4, 11)

doAssert cs[0 .. 4] == 21
doAssert cs[1 .. 3] == 7
~~~

## API

### initCumulativeSum

~~~nim
var cs = initCumulativeSum(@[1, 2, 3])
var cs2 = initCumulativeSum[int](n)
~~~

### add

~~~nim
cs.add(i, x)
~~~

位置 `i` に `x` を加算します。

### sum

~~~nim
cs.sum(k)
~~~

先頭 `k` 個の和を返します。

### []

~~~nim
cs[l .. r]
~~~

閉区間 `[l, r]` の和を返します。

## 計算量

必要な分だけ遅延して累積和を伝播します。

- `add`: `O(1)`
- `sum(k)`: 償却 `O(k)`、全体では伝播した分だけ
- `cs[l .. r]`: `sum` 2 回分
