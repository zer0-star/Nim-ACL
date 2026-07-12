# KD-tree

固定された多次元点集合に対して、最近傍点探索と直交範囲探索を行います。

点を追加・削除しない静的な点集合に適しています。

## 型

- `D`: 次元数を表す正のcompile-time整数
- `T`: 座標および距離の2乗の計算に使用する型
- `KDPoint[D, T]`: `array[D, T]`
- `KDTree[D, T]`: 構築済みの静的KD-tree
- `KDNearestResult[T]`: 元の入力indexと距離の2乗を保持する型

## コンストラクタ

~~~nim
initKDTree[D: static[int], T](
  points: openArray[KDPoint[D, T]],
): KDTree[D, T]
~~~

### 引数

- `points: openArray[KDPoint[D, T]]`:
  KD-treeに格納する点の列です。
  すべての点は同じ次元`D`と座標型`T`を持ちます。

`initKDTree`は`points`を内部へコピーします。
元の入力列と各点は変更されません。

### 返り値

- `KDTree[D, T]`:
  `points`を格納した静的KD-treeを返します。

元の入力順は保持され、検索結果のindexは`points`内のindexを表します。

### 制約

- `D > 0`
- `T`は比較、加減算、乗算、零値をサポートする
- 座標差の2乗和が`T`の範囲に収まる
- 構築後に点を追加・削除しない

### 計算量

点数を`n`とします。

- 時間: `O(D n log^2 n)`
- メモリ: `O(D n)`

## nearest

~~~nim
tree.nearest(
  query: KDPoint[D, T],
): Option[KDNearestResult[T]]
~~~

`query`に最も近い点を検索します。
距離にはユークリッド距離の2乗を使用します。

### 引数

- `query: KDPoint[D, T]`:
  最近傍を問い合わせる点です。
  KD-tree内の点と同じ次元`D`および座標型`T`を使用します。

### 返り値

- `Option[KDNearestResult[T]]`:
  最近傍点が存在する場合は、次の値を持つ`some`を返します。

~~~nim
tuple[
  index: int,
  squaredDistance: T,
]
~~~

- `index`:
  最近傍点の元の`points`内でのindex
- `squaredDistance`:
  `query`と最近傍点のユークリッド距離の2乗

空のKD-treeでは`none`を返します。

距離が等しい点が複数ある場合は、
元の入力indexが最小の点を返します。

### 計算量

点数を`n`とします。

- 平均的には`O(log n)`
- 最悪`O(n)`

## rangeSearch

~~~nim
tree.rangeSearch(
  lower: KDPoint[D, T],
  upper: KDPoint[D, T],
): seq[int]
~~~

軸に平行な半開直方体に含まれる点を検索します。

各次元`d`について、次を満たす点が対象です。

~~~text
lower[d] <= point[d] < upper[d]
~~~

### 引数

- `lower: KDPoint[D, T]`:
  検索領域の各次元の下端です。
  下端は検索範囲に含まれます。
- `upper: KDPoint[D, T]`:
  検索領域の各次元の上端です。
  上端は検索範囲に含まれません。

各次元について`lower[d] <= upper[d]`を満たすものとします。

### 返り値

- `seq[int]`:
  範囲内にある点の、元の`points`内でのindexを昇順で返します。

範囲内に点がない場合は空列を返します。

### 計算量

点数を`n`、出力件数を`k`とします。

- 平均的には`O(log n + k)`
- 最悪`O(n + k)`

## len

~~~nim
tree.len: int
~~~

KD-treeに格納されている点数を返します。

## 使用例

~~~nim
import std/options

import atcoder/extra/structure/kd_tree

let points: seq[KDPoint[2, int64]] =
  @[
    [0'i64, 0],
    [5'i64, 1],
    [2'i64, 2],
  ]

let tree =
  initKDTree(points)

let query: KDPoint[2, int64] =
  [3'i64, 2]

let nearestPoint =
  tree.nearest(query).get

doAssert nearestPoint.index == 2
doAssert nearestPoint.squaredDistance == 1

let lower: KDPoint[2, int64] =
  [0'i64, 0]

let upper: KDPoint[2, int64] =
  [6'i64, 2]

doAssert tree.rangeSearch(
  lower,
  upper,
) == @[0, 1]

doAssert tree.len == 3
~~~

## 内部実装

各nodeは部分木のbounding boxを保持します。

最近傍探索と範囲探索では、
条件を満たす点を含まない部分木をbounding boxによって枝刈りします。

## 関連API

- `closestPair`:
  全点対の中から最近点対を求めるgeometry API
- `segtree_2d`:
  更新や集約演算を伴う2次元構造
- `rangeSearch`:
  静的点集合の半開直交範囲探索
