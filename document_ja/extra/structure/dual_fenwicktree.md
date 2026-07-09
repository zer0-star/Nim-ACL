# DualFenwickTree

`DualFenwickTree` は、区間加算・一点取得を行う Fenwick Tree です。

通常の Fenwick Tree が「一点加算・区間和取得」を扱うのに対し、Dual Fenwick Tree は「区間加算・一点取得」を扱います。

## import

~~~nim
import atcoder/extra/structure/dual_fenwicktree
~~~

## 型

~~~nim
type DualFenwickTree[T, U]
~~~

通常は `initDualFenwickTree[T](n)` から生成します。

## コンストラクタ

~~~nim
proc initDualFenwickTree[T](n: int): auto
~~~

長さ `n` の列を `0` で初期化します。

## 操作

~~~nim
proc add[FT: DualFenwickTree](fw: var FT, r: RangeType, x: FT.T)
proc `[]`[FT: DualFenwickTree](fw: FT, p: IndexType): FT.T
~~~

- `add(fw, r, x)` は区間 `r` に `x` を加算します。
- `fw[p]` は位置 `p` の値を返します。

## 使用例

~~~nim
var fw = initDualFenwickTree[int](5)

fw.add(1 .. 3, 10)
fw.add(2 .. 4, -3)

doAssert fw[0] == 0
doAssert fw[1] == 10
doAssert fw[2] == 7
doAssert fw[3] == 7
doAssert fw[4] == -3
~~~

## 計算量

- 区間加算: `O(log n)`
- 一点取得: `O(log n)`
