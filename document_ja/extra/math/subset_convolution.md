# Subset Convolution（部分集合畳み込み）

集合関数`f`, `g`の部分集合畳み込みを計算します。

## 一般形

~~~nim
let result =
  subsetConvolution(
    f,
    g,
  )
~~~

## 引数

- `f`: 1個目の集合関数
- `g`: 2個目の集合関数
- `T`: 要素型。加算・減算・乗算を利用できる必要があります

長さが`2^k`の配列では、添字`mask`を`k`要素集合の部分集合として
扱います。

## 前提条件

- `f.len == g.len`
- 入力長は正の2冪
- 空列は使用できない

条件を満たさない場合は`ValueError`を送出します。

## 返り値

返り値は入力と同じ長さの`seq[T]`です。

各集合`S`について、

~~~text
result[S] = sum f[T] * g[S xor T]
~~~

です。和は`S`の全部分集合`T`について取ります。

入力`f`, `g`は変更しません。

## 具体例

~~~nim
import atcoder/modint
import atcoder/extra/math/subset_convolution

type mint = modint998244353

let
  f = @[
    mint.init(1),
    mint.init(2),
    mint.init(3),
    mint.init(4),
  ]

  g = @[
    mint.init(5),
    mint.init(6),
    mint.init(7),
    mint.init(8),
  ]

  result =
    subsetConvolution(
      f,
      g,
    )

doAssert result == @[
  mint.init(5),
  mint.init(16),
  mint.init(22),
  mint.init(60),
]
~~~

添字`0, 1, 2, 3`は、それぞれ空集合、`{0}`、`{1}`、`{0,1}`を
表します。

## 関連API

- `orConvolution`: OR畳み込み
- `andConvolution`: AND畳み込み
- `xorConvolution`: XOR畳み込み
- `zeta_transform`: subset/superset zeta transformを直接扱う低水準API

部分集合を互いに素な2つの部分へ分ける畳み込みには
`subsetConvolution`を使います。

## 計算量

入力長を`2^k`とすると、

- 時間: `O(k^2 * 2^k)`
- メモリ: `O(k * 2^k)`

内部ではrank付きゼータ変換とメビウス変換を使用します。
