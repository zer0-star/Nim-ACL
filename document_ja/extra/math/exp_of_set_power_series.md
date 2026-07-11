# Exp of Set Power Series（集合冪級数の指数関数）

集合冪級数`f`の指数関数を計算します。

## 一般形

~~~nim
let result =
  expOfSetPowerSeries(
    f
  )
~~~

## 引数

- `f`: 集合冪級数
- `T`: 係数型。加算・減算・乗算と、整数`1`からの変換を利用できる必要があります

長さが`2^k`の配列では、添字`mask`を`k`要素集合の部分集合として
扱います。

## 前提条件

- 入力長は正の2冪
- `f[0] == 0`
- 空列は使用できない

`f[0]`は空集合の係数です。

条件を満たさない場合は`ValueError`を送出します。

## 返り値

返り値は入力と同じ長さの`seq[T]`です。

空集合について、

~~~text
result[0] = 1
~~~

です。

空でない集合`S`について、`result[S]`は`S`の集合分割全体にわたる

~~~text
product f[block]
~~~

の和です。

入力`f`は変更しません。

## 具体例

~~~nim
import atcoder/modint
import atcoder/extra/math/exp_of_set_power_series

type mint = modint998244353

let f = @[
  mint.init(0),
  mint.init(2),
  mint.init(3),
  mint.init(5),
]

let result =
  expOfSetPowerSeries(
    f
  )

doAssert result == @[
  mint.init(1),
  mint.init(2),
  mint.init(3),
  mint.init(11),
]
~~~

最後の係数は、

~~~text
f[{0,1}] + f[{0}] * f[{1}]
= 5 + 2 * 3
= 11
~~~

です。

## 関連API

- `subsetConvolution(f, g)`:
  集合を互いに素な2部分へ分ける部分集合畳み込み
- `zeta_transform`:
  subset/superset zeta transformを直接扱う低水準API

`expOfSetPowerSeries`は内部で段階的に`subsetConvolution`を使用します。

## 計算量

入力長を`2^k`とすると、

- 時間: `O(k^2 * 2^k)`
- メモリ: `O(k * 2^k)`
