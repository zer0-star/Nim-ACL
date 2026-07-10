# Euler Tour

`EulerTour` は、木をDFSし、各subtreeをpreorder上の連続区間へ変換するutilityです。

頂点 `v` のsubtreeは半開区間 `[tin[v], tout[v])` に対応します。この区間をFenwick TreeやSegment Treeへ渡すことで、subtree queryを通常の区間queryへ変換できます。

## 対応するグラフ形式

標準的な形式として、sequence-backedなNim-ACL `Graph` に対応します。

軽量な隣接リスト `seq[seq[int]]` も同じ `initEulerTour` へ渡せます。両形式は同じDFS実装を利用し、構築後の `EulerTour` は入力graphを保持しません。

## import

~~~nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/euler_tour
~~~

ローカル短縮import：

~~~nim
import lib/graph/graph_template
import lib/graph/euler_tour
~~~

## API

~~~nim
proc initEulerTour*[G](
  graph: G,
  root: int = 0
): EulerTour

proc subtreeRange(
  tour: EulerTour,
  vertex: int
): tuple[l, r: int]

proc subtreeSize(
  tour: EulerTour,
  vertex: int
): int

proc subtreeVertices(
  tour: EulerTour,
  vertex: int
): seq[int]

proc isAncestor(
  tour: EulerTour,
  ancestor, descendant: int
): bool
~~~

## 使用例：Nim-ACL Graph

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/euler_tour

var graph = initGraph(5)

graph.addBiEdge(0, 1)
graph.addBiEdge(0, 2)
graph.addBiEdge(1, 3)
graph.addBiEdge(1, 4)

let tour = initEulerTour(graph)

doAssert tour.subtreeSize(1) == 3

let interval = tour.subtreeRange(1)

doAssert interval.r - interval.l == 3
~~~

## 使用例：軽量な隣接リスト

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/graph/euler_tour

var graph = newSeq[seq[int]](5)

proc addEdge(u, v: int) =
  graph[u].add v
  graph[v].add u

addEdge(0, 1)
addEdge(0, 2)
addEdge(1, 3)
addEdge(1, 4)

let tour = initEulerTour(graph)

doAssert tour.subtreeSize(1) == 3
~~~

## 計算量

頂点数を `n` とすると、

- 構築：`O(n)`
- subtree interval：`O(1)`
- ancestor判定：`O(1)`
- subtree頂点列挙：`O(subtree size)`
- memory：`O(n)`

## 注意

- 入力は連結な無向木である必要があります。
- 頂点番号は `0 ..< n` の連続した非負整数とします。
- Nim-ACL Graphはsequence-backedな隣接リストを対象とします。
- subtree区間は半開区間 `[AtCoder Algorithm Lectures: オイラーツアーテクニック](https://info.atcoder.jp/entry/algorithm_lectures/euler_tour_technique)
- [Heavy-Light Decomposition](../tree/heavy_light_decomposition.html)
- [AC Library: Fenwick Tree](https://atcoder.github.io/ac-library/production/document_ja/fenwicktree.html)
- [AC Library: Segment Tree](https://atcoder.github.io/ac-library/production/document_ja/segtree.html)
