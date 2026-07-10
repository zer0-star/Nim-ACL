# Combination Table

`combination_table` は、二項係数や階乗を必要に応じて遅延構築する小さな補助 module です。

`int.C(n, r)` のように、型に対して method 風に呼び出せます。

## import

~~~nim
import atcoder/extra/math/combination_table
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/math/combination_table

doAssert int.C(5, 2) == 10
doAssert int.H(3, 2) == 6
doAssert int.P(5, 2) == 20
doAssert int.fact(5) == 120
~~~

## API

### C

~~~nim
T.C(n, r)
~~~

二項係数 `n choose r` を返します。範囲外では `0` を返します。

### H

~~~nim
T.H(n, r)
~~~

重複組合せを返します。

### P

~~~nim
T.P(n, r)
~~~

順列数を返します。

### fact

~~~nim
T.fact(k)
~~~

`k!` を返します。

### resetCombination

~~~nim
T.resetCombination()
~~~

内部 table を初期化します。

## 計算量

必要な値まで table を拡張します。

- 新しい `n` までの初回構築: `O(n^2)`
- 構築済み範囲の取得: `O(1)`
