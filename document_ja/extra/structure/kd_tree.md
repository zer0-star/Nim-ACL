# KD-tree

固定された多次元点集合に対して、最近傍点探索と直交範囲探索を行います。

## 一般形

~~~nim
let tree =
  initKDTree(points)

let nearestPoint =
  tree.nearest(query)

let indices =
  tree.rangeSearch(
    lower,
    upper,
  )
~~~

## 引数・型

- `D`: 次元数。正のcompile-time整数
- `T`: 座標および距離計算に使用する型
- `KDPoint[D, T]`: `array[D, T]`
- `KDTree[D, T]`: 構築済みの静的KD-tree
- `KDNearestResult[T]`: 元のindexと距離の2乗

`initKDTree`は入力点列をコピーします。元の入力は変更されません。

## 前提条件

- `D > 0`
- `T`は比較、加減算、乗算、零値をサポートする
- 座標差の2乗和が`T`の範囲に収まる
- tree構築後に点を追加・削除しない

## 返り値と副作用

`nearest(query)`は次を返します。

~~~nim
Option[
  tuple[
    index: int,
    squaredDistance: T,
  ]
]
~~~

空treeでは`none`です。距離が同じ場合は、元の入力indexが最小の点を返します。

`rangeSearch(lower, upper)`は、各次元について

~~~text
lower[d] <= point[d] < upper[d]
~~~

を満たす元の入力indexを昇順で返します。範囲は半開区間です。

`tree.len`で点数を取得できます。

## 具体例

~~~nim
import std/options
import atcoder/extra/structure/kd_tree

let points:
  seq[KDPoint[2, int64]] =
    @[
      [0'i64, 0],
      [5'i64, 1],
      [2'i64, 2],
    ]

let tree =
  initKDTree(points)

let nearestPoint =
  tree.nearest(
    [3'i64, 2]
  ).get

doAssert nearestPoint.index == 2
doAssert nearestPoint.squaredDistance == 1

doAssert tree.rangeSearch(
  [0'i64, 0],
  [6'i64, 2],
) == @[0, 1]
~~~

## 関連API

- `closestPair`: 全点対の中から最近点対を求めるgeometry API
- `segtree_2d`: 更新や集約演算を伴う2次元構造
- `rangeSearch`: 静的点集合の半開直交範囲探索

KD-treeは、最近傍探索と座標範囲による点列挙に向いています。

## 計算量と内部実装

点数を`n`、次元数を`D`、出力件数を`k`とします。

- 構築: `O(D n log^2 n)`
- 最近傍探索: 平均的には`O(log n)`、最悪`O(n)`
- 直交範囲探索: 平均的には`O(log n + k)`、最悪`O(n + k)`
- メモリ: `O(D n)`

各nodeは部分木のbounding boxを保持し、探索時に交差しない部分木を枝刈りします。
