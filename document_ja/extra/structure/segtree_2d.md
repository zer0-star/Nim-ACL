# SegTree2D

`SegTree2D` は、二次元座標上の点に値を持たせ、矩形範囲の集約値を取得する data structure です。

あらかじめ現れる点 `(x, y)` をすべて渡しておき、座標圧縮した二次元 segment tree を構築します。

## import

~~~nim
import atcoder/extra/structure/segtree_2d
~~~

## 型

~~~nim
type SegTree2D[S, SegTree]
~~~

通常は `initSegTree2D` から生成します。

## コンストラクタ

~~~nim
proc initSegTree2D[S](
  points: seq[tuple[x, y: int]],
  op: static[proc(a, b: S): S],
  e: static[proc(): S]
): auto
~~~

- `points`: あらかじめ使う点集合
- `op`: 集約演算
- `e`: 単位元

## 操作

~~~nim
proc add[ST: SegTree2D](st: var ST, x, y: int, v: ST.S)
proc get[ST: SegTree2D](st: var ST, x, y: int): ST.S
proc prod[ST: SegTree2D](st: var ST, xp, yp: Slice[int] or int): ST.S
proc `[]`[ST: SegTree2D](st: var ST, x, y: int): ST.S
proc `[]`[ST: SegTree2D](st: var ST, xp, yp: Slice[int] or int): ST.S
~~~

- `add(x, y, v)` は点 `(x, y)` に `v` を加算します。
- `get(x, y)` は点 `(x, y)` の値を返します。
- `prod(xp, yp)` は矩形 `xp × yp` の集約値を返します。

## 使用例

~~~nim
proc op(a, b: int): int = a + b
proc e(): int = 0

var st = initSegTree2D[int](@[
  (x: 0, y: 0),
  (x: 0, y: 1),
  (x: 1, y: 0),
  (x: 2, y: 2),
], op, e)

st.add(0, 0, 5)
st.add(0, 0, 7)
st.add(0, 1, 3)
st.add(1, 0, 11)
st.add(2, 2, 13)

doAssert st.get(0, 0) == 12
doAssert st.prod(0 .. 1, 0 .. 1) == 26
doAssert st.prod(0 .. 2, 0 .. 2) == 39
~~~

## 制約

`add`, `get`, `prod` で使う点は、コンストラクタに渡した点集合に含まれている必要があります。

## 計算量

点数を `n` とすると、おおよそ

- 構築: `O(n log n)`
- 点加算: `O(log^2 n)`
- 点取得: `O(log^2 n)`
- 矩形集約: `O(log^2 n)`

です。
