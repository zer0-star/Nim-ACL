# PartiallyPersistentDSU

`PartiallyPersistentDSU` は、過去の時刻に対して連結判定・連結成分サイズ取得ができる Union-Find です。

辺を追加する時刻 `t` を指定して `merge` し、任意の時刻 `t` における状態を query できます。

## import

~~~nim
import atcoder/extra/structure/partially_persistent_dsu
~~~

## 型

~~~nim
type PartiallyPersistentDSU
~~~

## コンストラクタ

~~~nim
proc initPartiallyPersistentDSU(n: int): PartiallyPersistentDSU
~~~

`n` 頂点の部分永続 DSU を作ります。

## 操作

~~~nim
proc merge(uf: var PartiallyPersistentDSU, t, x, y: int): bool

proc leader(uf: var PartiallyPersistentDSU, t, x: int): int
proc same(uf: var PartiallyPersistentDSU, t, x, y: int): bool
proc size(uf: var PartiallyPersistentDSU, t, x: int): int
~~~

- `merge(t, x, y)` は時刻 `t` に `x` と `y` を併合します。
- `leader(t, x)` は時刻 `t` における `x` の代表元を返します。
- `same(t, x, y)` は時刻 `t` において `x`, `y` が同じ成分かを返します。
- `size(t, x)` は時刻 `t` における `x` の連結成分サイズを返します。

## 使用例

<!-- nim-line-numbers -->
~~~nim
var uf = initPartiallyPersistentDSU(4)

discard uf.merge(1, 0, 1)
discard uf.merge(3, 1, 2)

doAssert uf.same(0, 0, 1) == false
doAssert uf.same(1, 0, 1) == true
doAssert uf.same(2, 0, 2) == false
doAssert uf.same(3, 0, 2) == true

doAssert uf.size(0, 0) == 1
doAssert uf.size(1, 0) == 2
doAssert uf.size(3, 0) == 3
~~~

## 制約

`merge` に渡す時刻は、通常は単調増加にしてください。

## 計算量

- `merge`: ほぼ `O(α(n))`
- `leader`, `same`: ほぼ `O(α(n))`
- `size`: `O(log n)`

です。
