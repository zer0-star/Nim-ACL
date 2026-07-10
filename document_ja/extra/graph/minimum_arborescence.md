# Minimum Arborescence

`minimumArborescence(es, vertexCount, root)` は、Chu–Liu/Edmonds 実装の機能名による別名です。

従来の `minimumSpanningTreeArborescence` も引き続き利用できます。

## import

~~~nim
import std/options
import atcoder/extra/graph/minimum_arborescence
~~~

## 使用例

~~~nim
import std/options
import atcoder/extra/graph/minimum_arborescence

let es: Edges[int, int] = @[
  initEdge[int, int](0, 1, 1),
  initEdge[int, int](0, 2, 5),
  initEdge[int, int](1, 2, 1),
  initEdge[int, int](2, 3, 1),
]

let ans = minimumArborescence(es, 4, 0)

doAssert ans.isSome
doAssert ans.get[0] == 3
~~~

戻り値と計算量は `minimumSpanningTreeArborescence` と同一です。
