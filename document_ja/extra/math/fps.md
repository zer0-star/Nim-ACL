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

## SageMath 風の文字列宣言

`useFPSDecl` を使うと、SageMath 風に近い文字列宣言もできます。

~~~nim
useFPSDecl(H = mint{z}, prec = 6)

let f = H(z)
let g = f.exp()
~~~

これは `H` を constructor 名、`mint` を係数型、`z` を形式変数名、`6` を既定精度として宣言します。

より基本的な Nim 構文は次の形です。

~~~nim
useFPS(mint{z}, H, prec = 6)
~~~

`useFPSDecl` は読みやすさを優先した convenience helper です。型解決や補完を重視する場合は、通常の `useFPS(mint{z}, H, prec = 6)` を使ってください。

文字列で書くこともできます。

~~~nim
useFPSDecl("H = mint{z}", prec = 6)
~~~

## angle bracket 形式の文字列宣言

文字列宣言では、`mint{z}` だけでなく `mint<z>` も使えます。

~~~nim
useFPSDecl("L = mint<t>", prec = 9)

let f = L(t)
~~~

`mint<t>` は文字列内だけの convenience syntax です。通常の Nim 構文では `useFPSDecl(L = mint{t}, prec = 9)` または `useFPS(mint{t}, L, prec = 9)` を使ってください。

## 既定精度と既存演算

`fps` facade の constructor は、長さを省略すると `prec` で指定した長さまで resize します。

そのため、既存の FPS method が入力 series の長さを使う場合、constructor で指定した既定精度がそのまま効きます。

~~~nim
useFPS(mint{x}, F, prec = 8)

let f = F(1 + x)   # 長さ 8
let g = f.inv()    # 長さ 8
let h = f.exp()    # 長さ 8
~~~

明示的に長さを渡した場合は、constructor の既定精度よりも明示指定が優先されます。

~~~nim
let f = F(1 + x, 4)
doAssert f.len == 4
~~~

## 既定精度と追加演算の例

`fps` facade は `formal_power_series_sqrt` もまとめて import/export しているため、`sqrt` も同じ入口から使えます。

~~~nim
import std/options
import atcoder/extra/math/fps

type mint = modint998244353
useFPS(mint{x}, F, prec = 8)

let f = F(1 + 2 * x + x^2)
let g = f.sqrt()

doAssert g.isSome
doAssert g.get.len == 8
~~~

`powMod` や `eval` など既存の `formal_power_series` の演算も、そのまま利用できます。

~~~nim
let base = F(@[0, 1])
let m = F(@[-1, 0, 0, 1], 4) # x^3 - 1
let r = base.powMod(5, m)    # x^5 mod (x^3 - 1) = x^2

doAssert r[2] == mint(1)

let h = F(@[1, 2, 3])
doAssert h.eval(mint(2)) == mint(17)
~~~

## 文字列 constructor と log / exp

`F("x")` のように、文字列から FPS を作る constructor も既定精度に従います。

~~~nim
useFPS(mint{x}, F, prec = 8)

let f = F("x")
doAssert f.len == 8
~~~

`log` / `exp` も、入力 series の長さに従って使えます。

~~~nim
let f = F(1 + x)
let g = f.log()
let h = g.exp()

doAssert g.len == 8
doAssert h.len == 8
doAssert h[0] == mint(1)
doAssert h[1] == mint(1)
~~~

明示的な長さ指定も従来通り優先されます。

~~~nim
let g = f.log(5)
let h = g.exp(5)

doAssert g.len == 5
doAssert h.len == 5
~~~
