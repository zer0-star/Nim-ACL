# ダイクストラ法

重みが非負のグラフの単一始点最短距離を計算します。

## 通常のダイクストラ法

```nim
let (dist, prev) = dijkstra(g:Graph[T], s:int)
```

グラフ$g$の頂点$s$を始点とする最短距離と直前ノードを計算

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

追加した辺の本数を $m$ として
- $O((n + m) \log n)$だと思う(たぶん)

## 01ダイクストラ法

```nim
let (dist, prev) = dijkstra01(g:Graph[T], s:int)
```

辺の重みが0または1であるグラフ$g$の頂点$s$を始点とする最短距離と直前ノードを計算
0, 1以外の辺の重みがある場合は未定義である。

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

追加した辺の本数を $m$ として
- $O(n + m)$だと思う(たぶん)


## 最短経路の取得

```nim
path(prev:seq[int], t:int):seq[int]
```

頂点$t$までの最短経路を取得。
戻り値は$s$で始まり$t$で終わるノード列となる。(Edge[T]で返すべきか。。。)

**@{keyword.complexity}**

- $O(n)$

