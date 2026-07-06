# 形式的べき級数ライブラリ

形式的べき級数を扱うライブラリです。加減乗除や逆元、exp, logなどが計算できます。
形式的べき級数については[https://trap.jp/post/1657/](https://trap.jp/post/1657/)を参照してください。

## importのしかた

形式的べき級数ライブラリを使うためには畳み込みを指定する必要があります。

```nim
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
```

modint等の有限modを用いる場合は畳み込み用にnttを用います。

```nim
import atcoder/extra/math/fft
import atcoder/extra/math/formal_power_series
```

float, Decimal等の浮動小数を用いる場合はFFTをimportします。(この使い方はatcoderで出現することが少なくあまり検証されていないかも)

## 形式的べき級数の宣言

```nim
var f = initFormalPowerSeries[T](n:int)
```

$T$型で$n$項の形式的べき級数を作成します。すべての項は$T(0)$で初期化されます。

```nim
var f = initFormalPowerSeries[T](a:seq[S] or array[S])
```

$T$型で配列(可変のseqまたは固定のarray)$a$に対応する形式的べき級数を作成します。つまり、$a=(a_1,a_2, \ldots ,a_n)$のときは
$f = \sum_{i=0}^n a_ix^i$となります。

# 種々の処理
以下の処理のいずれでも引数の最後にdegを指定することでdeg項まで求めることができます。指定しなかった場合は引数と同じ項数になります。

## 加減乗除
```nim
f, g:FormalPowerSeries[T]
f += g
f + g: FormalPowerSeries[T]
f -= g
f - g: FormalPowerSeries[T]
f *= g
f * g: FormalPowerSeries[T]
f / g
f /= g: FormalPowerSeries[T]
```

加減乗除が可能です。

**@{keyword.complexity}**

- 加算・減算: $O(n)$
- 乗算・除算: $O(n \log n)$

## log, シフト, pre
```nim
f: FormalPowerSeries[T]
log(f): FormalPowerSeries[T]
log(f, deg): FormalPowerSeries[T]
shl(f, sz:int)
shr(f, sz:int)
pre(f, sz:int)
```

log, シフト, preを行います。

## 逆元・exp・べき乗
```nim
f: FormalPowerSeries[T]
inv(f): FormalPowerSeries[T]
inv(f, deg:int): FormalPowerSeries[T]
exp(f): FormalPowerSeries[T]
exp(f, deg: int): FormalPowerSeries[T]
k:int
pow(f, k):FormalPowerSeries[T]
pow(f, k, deg):FormalPowerSeries[T]
```

逆元・expを計算します。逆元は$f*g=1$となる$g$, expは
$$
exp(f) = \sum_{i=0}^\infty \frac{x^i}{i!}
$$
です。べき乗は$f$を$k$回書けたものとなります。


**@{keyword.complexity}**
- $O(n\log n)$

## 微分・積分
```nim
f: FormalPowerSeries[T]
diff(f)
integral(f)
```

微分と積分をします。

## 割り算
```nim
f, g:FormalPowerSeries[T]
f div g
f.div=g
f mod g
f.mod=g
```

多項式としての割り算を行い商やあまりを求めます

```nim
powMod(f, n:int, g)
```

$f^n$を$g$で割ったあまりを求めます
