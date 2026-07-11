# 二部グラフ辺彩色

二部多重グラフの各辺を、同じ頂点に接続する辺同士が異なる色になるように
彩色します。使用する色数は最大次数 `Δ` であり、最適です。

平行辺にも対応します。

## 一般形

~~~nim
let colors =
  bipartiteEdgeColoring(
    leftCount,
    rightCount,
    edges,
  )
~~~

## 引数

- `leftCount`: 左側頂点の個数
- `rightCount`: 右側頂点の個数
- `edges`: 辺の列。各辺は `(left, right)` で表します

左側頂点は `0 ..< leftCount`、右側頂点は
`0 ..< rightCount` で番号付けします。

`edges`の入力順序は保持され、変更されません。

## 前提条件

- `leftCount >= 0`
- `rightCount >= 0`
- 各辺 `(left, right)` について
  `0 <= left < leftCount`
- 各辺 `(left, right)` について
  `0 <= right < rightCount`

頂点数が負の場合や、端点が範囲外の場合は `ValueError` を送出します。

## 返り値

返り値は `edges.len` と同じ長さの `seq[int]` です。

~~~nim
colors[edgeId]
~~~

は `edges[edgeId]` に割り当てられた色です。

辺が存在する場合、色は

~~~text
0 ..< Δ
~~~

のすべてを使用します。ここで `Δ` は二部多重グラフの最大次数です。
同じ頂点に接続する2辺が同じ色になることはありません。

辺が存在しない場合は空列を返します。

## 具体例

~~~nim
import atcoder/extra/graph/bipartite_edge_coloring

let edges =
  @[
    (0, 0),
    (0, 1),
    (1, 0),
  ]

let colors =
  bipartiteEdgeColoring(
    2,
    2,
    edges,
  )

doAssert colors.len == edges.len
doAssert colors[0] != colors[1]
doAssert colors[0] != colors[2]
~~~

色番号そのものは一意ではないため、特定の色配列には依存しないでください。

## 関連API

- `HopcroftKarp`: 二部グラフの最大マッチング
- `EulerianTrail`: オイラー路・オイラー閉路の列挙

内部では両側を同じ頂点数へ拡張し、ダミー辺を追加して `Δ` 正則な
二部多重グラフを作ります。その後、完全マッチングを `Δ` 回取り出します。
ダミー平行辺は本数だけを保持し、1本ずつ格納しません。

## 計算量

`N = max(leftCount, rightCount)`、`M = edges.len`、
`Δ` を最大次数とします。

- 時間: `O(Δ (M + N) sqrt(N))`
- メモリ: `O(M + N)`

内部の Hopcroft–Karp 実装に基づく上界です。
