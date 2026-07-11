# Berlekamp–Massey（線形漸化式の推定）

有限列のprefixから、そのprefixを生成する最短の線形漸化式を求めます。

## API

```nim
proc berlekampMassey*[T](
    sequence: openArray[T],
): seq[T]
```

返り値を `coefficient` とすると、十分後ろの各項について

```text
sequence[n] =
  coefficient[0] * sequence[n - 1] +
  coefficient[1] * sequence[n - 2] +
  ...
```

が成り立ちます。

係数は「直前の項から順」に並びます。たとえばFibonacci数列では
`@[1, 1]`を返します。

## 使用例

```nim
import atcoder/modint
import atcoder/extra/math/berlekamp_massey

type mint = modint998244353

let sequence =
  @[
    mint.init(0),
    mint.init(1),
    mint.init(1),
    mint.init(2),
    mint.init(3),
    mint.init(5),
    mint.init(8),
  ]

let coefficient =
  berlekampMassey(sequence)

doAssert coefficient == @[
  mint.init(1),
  mint.init(1),
]
```

## 代数的要件

`T`は体のように振る舞い、次の演算を備える必要があります。

- `default(T)`が加法単位元
- `+`, `-`, `*`, `/`
- `==`, `!=`

通常は素数modの`modint`を使用します。

## 端のケース

- 空列は空の漸化式を返します。
- 全零列も空の漸化式を返します。
- 非零定数列は `@[1]` を返します。
- 与えたprefixだけから決定できる最短の関係を返します。

## 計算量

列の長さを `n` とすると、

- 時間計算量: `O(n^2)`
- 空間計算量: `O(n)`

です。

## Kitamasaとの関係

`berlekampMassey`は列から漸化式を推定します。
既知の漸化式から第`k`項を求める場合は`kitamasa`を使用できます。
