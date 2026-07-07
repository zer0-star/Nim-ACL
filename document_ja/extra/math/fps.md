# FPS facade

`atcoder/extra/math/fps` は、modint 係数の形式的べき級数を短く書くための convenience facade です。

従来の `atcoder/extra/math/formal_power_series` はそのまま残します。より明示的に畳み込み backend を選びたい場合や、汎用的な係数型で使いたい場合は、従来の module を直接 import してください。

## import

~~~nim
import atcoder/extra/math/fps
~~~

`fps` は競技プログラミングでよく使う modint + NTT 用の入口です。`ntt`, `formal_power_series`, `formal_power_series_sqrt` などをまとめて利用できます。

## 基本的な使い方

~~~nim
import atcoder/extra/math/fps

type mint = modint998244353

useFPS(mint{x}, F, prec = 100)

let f = F(@[0, 1]) # 長さ 100 に resize
let g = f.exp()    # 長さ 100
let h = f.exp(50)  # 明示した長さ 50 が優先
~~~

`useFPS(mint{x}, F, prec = 100)` は、係数型 `mint`、変数名 `x`、constructor 名 `F`、既定精度 `100` を宣言します。

## 変数名を変える

~~~nim
useFPS(mint{y}, G, prec = 50)

let f = G(y)
~~~

`mint{y}` のように書くことで、注入される変数名を `y` にできます。

## 既定精度

`F(@[...])` や `F(x)` のように長さを省略した場合、`prec` で指定した長さに resize されます。

~~~nim
useFPS(mint{x}, F, prec = 8)

let f = F(@[0, 1])
doAssert f.len == 8
~~~

明示的に長さを渡した場合は、その値が優先されます。

~~~nim
let f = F(@[0, 1], 3)
doAssert f.len == 3
~~~

`f.exp()` など既存の FPS method は、基本的に入力 series の長さを使います。そのため、constructor 側で既定精度まで resize しておくと、`f.exp()` もその長さで計算できます。

## 従来 module との違い

- `formal_power_series` は互換性重視の低レイヤ module です。
- `fps` は modint + NTT を簡単に使うための facade です。
- 既存コードを壊さないため、従来の `formal_power_series` の挙動は変更しません。
