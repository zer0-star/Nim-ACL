# グラフのテンプレート

## コンストラクタ

グラフを作成します。ノードの型を$U$, 重みの型を$T$としています。

```nim
var g = initGraph(n:int, T:typedesc)
```

頂点数$n$, 重みの型が$T$のグラフを作成。第2引数の$T$は省略可能で省略した場合はintとなります。この呼び方においてはノードの型Uはintが自動で指定されます。

```nim
var g = initGraph(n:int, id:proc(u:U):int, T:typedesc)
```

頂点数$n$, ノードの型が$U$, 重み型が$T$のグラフを作成します。
第2引数のidは$U$からint($n$未満の非負整数)を返す関数で異なるノード$U$ごとに違う値を返さなければなりません。
id関数は最短路問題等でノードに紐付けられたデータを一次元の配列として扱うためのもので必須です。
$U$の型はid関数によって特定されます。第3引数の$T$は省略可能で省略した場合はintとなります。

```nim
var g = initGraph(n:int, id:proc(u:U):int, adj:proc(u:U):seq[tuple[dst:U, weight:T]])
var g = initGraph(n:int, id:proc(u:U):int, adj:iterator(u:U):tuple[dst:U, weight:T])
```

隣接点をprocやiterator(adj)で指定できます。この場合、各アルゴリズムで隣接点探索をする際にadjが呼び出されます。
iteratorはclosureでなくてはなりません。
この呼び方でグラフを作った場合、辺はadj procやadj iteratorで決められるので、下記のaddEdge関数は使えません。

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

## 辺の追加

```nim
g.addEdge(u:U, v:U, w:T)
```

頂点$u$から頂点$v$へ重み$w$の有向辺を追加する。
$w$は省略可能。省略した場合はT(1)と解釈される。

**@{keyword.constraints}**

- $0 \leq u, v < n$

```nim
g.addBiEdge(u:U, v:U, w:T)
```

頂点$u$と頂点$v$を結ぶ重み$w$の無向辺を追加
$w$は省略可能。省略した場合は1と解釈される。

**@{keyword.constraints}**

- $0 \leq u, v < n$

## 配列指定によるグラフ作成

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

