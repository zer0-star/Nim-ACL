# Polynomial Interpolation（多項式補間）

相異なる点 `(xs[i], ys[i])` をすべて通る、次数が `xs.len` 未満の
一意な多項式を構成します。

## 一般形

~~~nim
let coefficients =
  polynomialInterpolation(
    xs,
    ys,
  )
~~~

## 引数

- `xs`: 各標本点の x 座標
- `ys`: 各標本点での多項式の値
- `T`: 係数型。現在の高速実装ではNTT backendを利用できる有限体を使います

典型的な係数型は `modint998244353` です。

## 前提条件

- `xs.len == ys.len`
- `xs`の要素は互いに異なる
- 条件を満たさない場合は`ValueError`を送出する

空列を2個渡した場合は空の多項式を返します。

## 返り値

返り値は`FormalPowerSeries[T]`です。

~~~nim
coefficients[i]
~~~

は \(x^i\) の係数を表します。係数は次数の昇順です。

`n = xs.len`のとき、返り値の長さは常に`n`です。最高次係数が0でも
末尾の0を保持します。

## 具体例

\(f(x)=3+2x+5x^2\)を3点から復元します。

~~~nim
import atcoder/modint
import atcoder/extra/math/polynomial_interpolation

type mint = modint998244353

let
  xs = @[
    mint.init(0),
    mint.init(1),
    mint.init(2),
  ]

  ys = @[
    mint.init(3),
    mint.init(10),
    mint.init(27),
  ]

  coefficients =
    polynomialInterpolation(
      xs,
      ys,
    )

doAssert coefficients == @[
  mint.init(3),
  mint.init(2),
  mint.init(5),
]
~~~

## 関連API

- `multipointEvaluation(f, xs)`:
  既知の多項式`f`を複数の点で評価する
- `lagrange_polynomial(y, t)`:
  x座標が`0, 1, ..., y.len - 1`である場合に、補間多項式の`t`での値だけを求める
- `subproduct_tree(xs)`:
  積木を直接扱う低水準API

多項式そのものが必要な場合は`polynomialInterpolation`を使います。
1点での値だけが必要で、x座標が連続整数なら`lagrange_polynomial`が簡潔です。

## 計算量

`n = xs.len`、多項式乗算の計算量を`M(n)`とすると、

- 時間: `O(M(n) log n)`
- メモリ: `O(n log n)`

NTTを使用する場合、時間計算量は`O(n log^2 n)`です。
