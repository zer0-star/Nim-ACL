# Chu-Liu/Edmonds

`minimumSpanningTreeArborescence(es, V, start)` は、有向 graph の最小全域有向木、つまり rooted directed MST / minimum arborescence を求めます。

根を `start` とし、各頂点へ根から到達できるように、各頂点 `v != start` にちょうど 1 本の入辺を選びます。その重み合計を最小化します。

## import

~~~nim
import std/options
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/chu_liu_edmonds
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import std/options
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/chu_liu_edmonds

let es: Edges[int, int] = @[
  initEdge[int, int](0, 1, 1),
  initEdge[int, int](0, 2, 5),
  initEdge[int, int](1, 2, 1),
  initEdge[int, int](2, 3, 1),
]

let ans = minimumSpanningTreeArborescence(es, 4, 0)

doAssert ans.isSome

let (cost, parent) = ans.get

doAssert cost == 3
doAssert parent == @[0, 0, 1, 2]
~~~

## 戻り値

~~~nim
Option[(T, seq[int])]
~~~

到達可能な全域有向木が存在する場合は `some((cost, parent))` を返します。

- `cost`: 選ばれた辺の重み合計
- `parent[v]`: 有向木における `v` の親
- `parent[start] == start`

全頂点を根 `start` から到達可能にできない場合は `none` を返します。

## 注意

- 入力は辺列 `Edges[T, int]` です。
- 辺は有向辺として扱われます。
- 頂点番号は `0 ..< V` を仮定します。
- 戻り値を使うには `std/options` の `isSome`, `isNone`, `get` などを使います。

## 計算量

辺数を `m`、頂点数を `n` とすると、おおよそ

- `O(m log n)`

です。

<!-- NIM_ACL_JAPANESE_FACADE_V1 -->
## 機能名・日本語名による別名

~~~nim
import atcoder/extra/graph/minimum_arborescence

let ans = minimumArborescence(es, V, start)
~~~

~~~nim
import "atcoder/extra/ja/graph/最小全域有向木"

let ans = 最小全域有向木(es, V, start)
~~~

従来の `minimumSpanningTreeArborescence` も維持されます。
<!-- /NIM_ACL_JAPANESE_FACADE_V1 -->
