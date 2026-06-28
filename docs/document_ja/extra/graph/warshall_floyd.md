# ワーシャル・フロイト法

重みが任意のグラフの全頂点間最短距離を計算します。

```nim
var d = warshall_floyd[T](g:seq[seq[T]])
```

距離を表す2次元配列$g$のワーシャルフロイト法を実行します。$g[i][j]$には$i\to j$の距離を表します。
$d$は内部的にはWarshallFloydResultというobjectで渡されていて、下記のような呼び出しが可能です。

## 距離の取得
```nim
d[s:int]:seq[T]
```
$s$からの距離の配列を返します。

```nim
d[s, t:int]:T
```
$s$から$t$への距離を返します


## パスの取得
```nim
d.path(s, t)
```
$s$から$t$までの最短経路パスを返します


**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

- $O(n^3)$

