# 集合冪級数の対数

空集合の係数が `1` である集合冪級数の対数を計算します。

## 一般形

~~~nim
let logarithm =
  logOfSetPowerSeries(
    values,
  )
~~~

## 引数・型

- `values`: 集合冪級数の係数列
- `T`: 係数型

長さが `2^k` の場合、indexは `k` 要素集合の部分集合をbit maskで表します。

係数型 `T` は可換環として `+`, `-`, `*` をサポートし、整数 `1` から
構築できる必要があります。

入力列は変更されません。

## 前提条件

- `values.len` は正の2冪
- `values[0] == T(1)`

ここで `values[0]` は空集合の係数です。

前提条件を満たさない場合は `ValueError` を送出します。

## 返り値

返り値は入力と同じ長さの `seq[T]` です。

空集合の係数は `0` になります。

~~~nim
logOfSetPowerSeries(
  expOfSetPowerSeries(f),
) == f
~~~

および、空集合の係数が `1` である `g` について、

~~~nim
expOfSetPowerSeries(
  logOfSetPowerSeries(g),
) == g
~~~

が成り立ちます。

## 具体例

~~~nim
import atcoder/extra/math/log_of_set_power_series

let values =
  @[
    1'i64,
    2,
    3,
    11,
  ]

let logarithm =
  logOfSetPowerSeries(
    values,
  )

doAssert logarithm ==
  @[
    0'i64,
    2,
    3,
    5,
  ]
~~~

## 関連API

- `expOfSetPowerSeries`: 空集合の係数が `0` の集合冪級数の指数関数
- `subsetConvolution`: 部分集合畳み込み

内部では、変数を1つずつ分離する再帰と部分集合畳み込みを使います。
再帰中で空集合の係数が `1` の集合冪級数の逆元も計算しますが、
逆元は独立した公開APIにはしていません。

`expOfSetPowerSeries` と `logOfSetPowerSeries` を合わせて、
集合冪級数のExp・Log中核APIを構成します。

## 計算量と内部実装

`values.len = 2^k` とします。

- 時間: `O(k^2 2^k)`
- メモリ: `O(k 2^k)`

内部計算は `subsetConvolution` を利用します。
