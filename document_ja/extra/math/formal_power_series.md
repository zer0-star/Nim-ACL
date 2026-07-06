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
$f = \sum_i=0^n a_ix^i$となります。

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

加減乗除が可能である。

