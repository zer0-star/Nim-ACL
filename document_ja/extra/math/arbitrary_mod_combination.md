# Arbitrary Mod Combination

`ArbitraryModBinomial` は、任意 mod で二項係数 `n choose k` を計算するための構造です。

素数 mod だけでなく、合成数 mod も扱えます。

## import

~~~nim
import atcoder/extra/math/arbitrary_mod_combination
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/math/arbitrary_mod_combination

let binom = initArbitraryModBinomial(1000, 100)

doAssert binom.C(20, 10) == 756
doAssert binom.C(5, 2) == 10
doAssert binom.C(5, 6) == 0
~~~

## initArbitraryModBinomial

~~~nim
let binom = initArbitraryModBinomial(md, N_MAX)
~~~

`md` を法とする二項係数計算用の構造を初期化します。

- `md`: 法
- `N_MAX`: 事前計算で想定する最大値

`md = 1` の場合、すべての値は `0` になります。

## C

~~~nim
binom.C(n, k)
~~~

`n choose k` を `md` で割った余りを返します。

範囲外の場合は `0` を返します。

~~~nim
doAssert binom.C(5, -1) == 0
doAssert binom.C(5, 6) == 0
~~~

## 注意

- `md` は `1 <= md < 2^30` 程度を想定しています。
- 内部では `md` を素数冪に分解し、中国剰余定理で合成します。
- 大きい `N_MAX` を指定すると事前計算量が増えます。

## 計算量

`md` の素因数分解と、各素数冪ごとの前計算を行います。  
各 `C(n, k)` は、素数冪ごとの計算結果を CRT で合成します。
