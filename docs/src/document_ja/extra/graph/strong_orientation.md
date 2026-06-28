# 強連結な向き付け

橋のない無向グラフ$G$とその辺のリスト$es$が与えられたときに、$G$を強連結有向グラフとなるような$es$の向きを返す。

```nim
var d = strong_orientation(g:Graph, es:Edges[T, U]):seq[int]
```

$G$の各辺の重みは対応する$es$のインデックス(0-based)の値を入れておく。
$i$番目の戻り値は$d[i]$が1ならば$es[i]$と同じ向き、$-1$ならば$es[i]$と逆向きを表す。

本アルゴリズムを利用する問題としてはARC111Dを参照。


**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

- $O(n)$

