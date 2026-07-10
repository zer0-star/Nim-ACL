# Mod Sqrt

`modSqrt(a)` は、modint 上で `x^2 = a` を満たす `x` をひとつ求めます。

平方根が存在する場合は `some(x)`、存在しない場合は `none` を返します。

## import

~~~nim
import std/options
import atcoder/modint
import atcoder/extra/math/mod_sqrt
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import std/options
import atcoder/modint
import atcoder/extra/math/mod_sqrt

type mint = modint998244353

let r = modSqrt(mint(4))

doAssert r.isSome

let x = r.get

doAssert x * x == mint(4)
~~~

## 戻り値

~~~nim
Option[T]
~~~

`std/options` の `isSome`, `isNone`, `get` などを使って値を取り出します。

## 注意

- 法は素数であることを仮定します。
- 戻り値の平方根は、存在する平方根のうちどちらか一方です。
- 平方根が存在しない場合は `none` です。

## 計算量

法を `p` とすると、おおよそ

- `O(log^2 p)`

です。
