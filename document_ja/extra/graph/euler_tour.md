# Euler Tour

`EulerTour` は、木を DFS し、各 subtree を preorder 上の連続区間へ変換する utility です。

頂点 `v` の subtree は、半開区間

```text
[tin[v], tout[v])
```

に対応します。この区間へ頂点の値を並べることで、subtree query を Fenwick Tree や Segment Tree の区間 query に変換できます。

## 使いどころ

- subtree 内の和・最小値・最大値
- subtree に対する一括更新
- 木を配列へ変換して Fenwick Tree / Segment Tree を使う
- LCA 用の full Euler walk
- ancestor 判定
- 木 DP の前処理

## 2種類の順序

この module は、次の2種類を保持します。

### Preorder

~~~nim
order
tin
tout
~~~

各頂点は1回だけ現れ、subtree が連続区間になります。

### Full Euler walk

~~~nim
walk
first
~~~

子から親へ戻るときにも親を追加するため、長さは `2*n-1` になります。RMQ による LCA などで利用できます。

## import

~~~nim
import atcoder/extra/graph/euler_tour
~~~

ローカル短縮 import：

~~~nim
import lib/graph/euler_tour
~~~

## API

~~~nim
proc initEulerTour(
  graph: seq[seq[int]],
  root: int = 0
): EulerTour

proc subtreeRange(
  tour: EulerTour,
  v: int
): tuple[l, r: int]

proc subtreeSize(tour: EulerTour, v: int): int
proc subtreeVertices(tour: EulerTour, v: int): seq[int]
proc isAncestor(tour: EulerTour, a, b: int): bool
proc vertexAt(tour: EulerTour, preorderIndex: int): int
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
var graph = newSeq[seq[int]](5)

proc addEdge(u, v: int) =
  graph[u].add v
  graph[v].add u

addEdge(0, 1)
addEdge(0, 2)
addEdge(1, 3)
addEdge(1, 4)

let tour = initEulerTour(graph)

let range = tour.subtreeRange(1)

doAssert range.r - range.l == 3

for i in range.l ..< range.r:
  let originalVertex = tour.order[i]
  echo originalVertex
~~~

## 計算量

頂点数を `n` とすると、

- 構築: `O(n)`
- subtree range / ancestor 判定: `O(1)`
- subtree vertex 列挙: `O(subtree size)`
- memory: `O(n)`

## 注意

- `graph` は無向木である必要があります。
- subtree 区間は半開区間 `[l, r)` です。
- 実装は明示 stack を使うため、深い木でも再帰 stack overflow を起こしにくいです。

## 関連資料

- [AtCoder Algorithm Lectures](https://info.atcoder.jp/entry/algorithm_lectures/index)
- Heavy-Light Decomposition
- Fenwick Tree / Segment Tree
