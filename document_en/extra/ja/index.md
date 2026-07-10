# Japanese API facades (experimental)

These thin facades make existing Nim-ACL implementations available through Japanese import paths and API names.

The algorithms are not duplicated. Each facade delegates to the canonical ASCII API, so return values, complexity, and preconditions remain unchanged.

## Policy

- The canonical stable APIs remain the ASCII APIs.
- Japanese facades live under `atcoder/extra/ja`.
- CI checks parity between Japanese and canonical calls.
- CI also checks Unicode-normalization collisions in module paths.

## Minimum spanning tree

~~~nim
import atcoder/extra/graph/graph_template
import "atcoder/extra/ja/graph/最小全域木"

var g = initGraph(4)

g.addBiEdge(0, 1, 1)
g.addBiEdge(1, 2, 2)
g.addBiEdge(0, 2, 5)
g.addBiEdge(2, 3, 1)

let (cost, edges) = 最小全域木(g)

doAssert cost == 4
doAssert edges.len == 3
~~~

The canonical API is `kruskal(g)`.

## Minimum arborescence

~~~nim
import std/options
import atcoder/extra/graph/graph_template
import "atcoder/extra/ja/graph/最小全域有向木"

let es: Edges[int, int] = @[
  initEdge[int, int](0, 1, 1),
  initEdge[int, int](0, 2, 5),
  initEdge[int, int](1, 2, 1),
  initEdge[int, int](2, 3, 1),
]

let ans = 最小全域有向木(es, 4, 0)

doAssert ans.isSome
doAssert ans.get[0] == 3
~~~

The functional English name is `minimumArborescence`; the historical API remains `minimumSpanningTreeArborescence`.

## Disjoint-set union

~~~nim
import "atcoder/extra/ja/structure/素集合データ構造"

var uf = 素集合データ構造を初期化(5)

discard uf.併合(0, 1)
discard uf.併合(1, 2)

doAssert uf.同じ集合か(0, 2)
doAssert uf.集合の大きさ(0) == 3
~~~

The canonical API remains `initDSU`, `merge`, `same`, `leader`, `size`, and `groups`.
