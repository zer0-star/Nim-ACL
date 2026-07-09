# Radix Heap Dijkstra

`dijkstra_radix_heap(g, s)` は、Radix Heap を用いて非負整数重み graph の単一始点最短路を求めます。

通常の `dijkstra(g, s)` と同じく、戻り値は `DijkstraResult` です。距離は `d[v]`、復元経路は `d.path(v)` で取得できます。

## import

~~~nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra_radix_heap
~~~

## 使用例

~~~nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra_radix_heap

var g = initGraph(5)
g.addEdge(0, 1, 2)
g.addEdge(0, 2, 9)
g.addEdge(1, 2, 1)
g.addEdge(2, 3, 1)
g.addEdge(3, 4, 3)

var d = dijkstra_radix_heap(g, 0)

doAssert d[4] == 7
doAssert d.path(4) == @[0, 1, 2, 3, 4]
~~~

## 複数始点

始点には頂点ひとつだけでなく、頂点列も渡せます。この場合、与えた始点すべての距離を `0` として最短距離を計算します。

~~~nim
var d = dijkstra_radix_heap(g, @[0, 3])
~~~

## 制約

- 辺重みの型 `G.T` は整数型である必要があります。
- 辺重みは非負である必要があります。
- 負辺がある場合は `bellman_ford` を使ってください。

## 計算量

頂点数を `n`、辺数を `m`、距離の最大値に依存する Radix Heap のビット幅を `B` とすると、おおよそ

- `O((n + m) B)`

です。通常の binary heap 版 `dijkstra` と同じ `DijkstraResult` interface で使えます。
