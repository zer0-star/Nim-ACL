# ダイクストラ法

重みが非負のグラフの単一始点最短距離を計算します。

## 通常のダイクストラ法

```nim
var d = dijkstra(g:Graph, s:U or seq[U])
```

グラフ$g$の頂点$s$を始点とするダイクストラ法を実行。
$s$はseqでも指定することができます。その場合は複数始点($s$の元はすべて距離0)で実行できます。
$d$は内部的にはDijkstraResultというobjectで渡されていて、下記のような呼び出しが可能である。

### 距離の取得
```nim
d[u:int]:T
```
$s$から$u$までの距離を返します。
### 直前ノードの取得
```nim
d.prev(u):U
```
$s$から$u$までの最短経路上で$u$の前のノード(の1つ)を返します。
### 最短経路の取得
```nim
d.path(t:int):seq[int]
```
頂点$t$までの最短経路を取得。
戻り値は$s$で始まり$t$で終わるノード列となる。(Edge[T]で返すべきか。。。)



**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

追加した辺の本数を $m$ として
- $O((n + m) \log n)$だと思う(たぶん)

## 01ダイクストラ法

```nim
var d = dijkstra01(g:Graph, s:U or seq[U])
```

辺の重みが0または1であるグラフ$g$の頂点$s$を始点とする最短距離と直前ノードを計算
0, 1以外の辺の重みがある場合は未定義である。
戻り値の型はDijkstraResult型であり、呼び出し方法は上に同じです。

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

追加した辺の本数を $m$ として
- $O(n + m)$だと思う(たぶん)

## Radix-Heapを用いたダイクストラ法

```nim
var d = dijkstra_radix_heap(g:Graph, s:U or seq[U])
```

Radix Heapを用いたDijkstra法です。距離が小さいときは高速化が期待されます。
戻り値の型はDijkstraResult型であり、呼び出し方法は上に同じです。

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

追加した辺の本数を $m$ として
- $O((n + m) \log n)$だと思う(たぶん)

**@{keyword.complexity}**

- $O(n)$

## 基本例

`dijkstra(g, s)` は、始点 `s` からの最短距離を返します。結果は `d[v]` で距離、`d.path(v)` で復元パスを取得できます。

```nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra

var g = initGraph(4)
g.addEdge(0, 1, 2)
g.addEdge(0, 2, 5)
g.addEdge(1, 2, 1)
g.addEdge(2, 3, 1)

var d = dijkstra(g, 0)

doAssert d[3] == 4
doAssert d.path(3) == @[0, 1, 2, 3]
```

辺重みが `0` または `1` の場合は `dijkstra01(g, s)` も使えます。

```nim
var h = initGraph(3)
h.addEdge(0, 1, 0)
h.addEdge(1, 2, 1)

var e = dijkstra01(h, 0)

doAssert e[2] == 1
```
