# グラフのテンプレート

## コンストラクタ

```nim
var g = initGraph[T](n:int)
```

頂点数$n$, 重みの型がTのグラフを作成

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

## 辺の追加

```nim
g.addEdge(u:int, v:int, w:T)
```

頂点$u$から頂点$v$へ重み$w$の有向辺を追加する。
$w$は省略可能。省略した場合は1と解釈される。

**@{keyword.constraints}**

- $0 \leq u, v < n$

```nim
g.addBiEdge(u:int, v:int, w:T)
```

頂点$u$と頂点$v$を結ぶ重み$w$の無向辺を追加
$w$は省略可能。省略した場合は1と解釈される。

**@{keyword.constraints}**

- $0 \leq u, v < n$

## 最短経路の取得

```nim
initDirectedGraph[T](n:int, a:seq[int], b:seq[int], w:seq[T])
```

aの長さを$m$としたとき、各$i = 0, 1, \ldots, m - 1$について、a[i]からb[i]へ重み$w[i]$の辺を持つ有向グラフを作成。a, b, wは0-basedでなくてはならないことに注意。

```nim
initUnDirectedGraph[T](n:int, a:seq[int], b:seq[int], w:seq[T])
```

aの長さを$m$としたとき、各$i = 0, 1, \ldots, m - 1$について、a[i]とb[i]を結ぶ重み$w[i]$の辺を持つ無向グラフを作成。a, b, wは0-basedでなくてはならないことに注意。

**@{keyword.complexity}**

- $O(n + m)$

