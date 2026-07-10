# Factorial

`factorial[ModInt](n)` は、modint 上で `n!` を求めます。

## import

~~~nim
import atcoder/modint
import atcoder/extra/math/factorial
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/modint
import atcoder/extra/math/factorial

type mint = modint998244353

doAssert factorial[mint](0) == mint(1)
doAssert factorial[mint](5) == mint(120)
doAssert factorial[mint](10) == mint(3628800)
~~~

## 注意

`n >= ModInt.mod()` の場合は `0` を返します。

## 計算量

内部で formal power series を使って高速に計算します。小さい `n` に対しても通常の `n!` と同じ値を返します。
