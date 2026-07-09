# Static Graph

`StaticGraph` は、辺を追加してから `build()` することで隣接リストを構築する graph です。

辺の追加が終わったあとに graph を固定して使う用途に向いています。

## import

~~~nim
import atcoder/extra/graph/static_graph
~~~

## 使用例

~~~nim
import atcoder/extra/graph/static_graph

var g = initStaticGraph[int](4)

discard g.addBiEdge(0, 1, 5)
discard g.addBiEdge(1, 2, 7)
discard g.addBiEdge(1, 3, 11)

g.build()

doAssert g.len == 4
doAssert g.degree(1) == 3

var to: seq[int] = @[]
for e in g[1]:
  to.add(e.dst)

doAssert 0 in to
doAssert 2 in to
doAssert 3 in to
~~~

## Edge

隣接辺 `e` は主に次の field を持ちます。

- `e.src`: 辺の始点
- `e.dst`: 辺の終点
- `e.weight`: 辺重み
- `e.rev`: 逆辺の位置

## addBiEdge

~~~nim
discard g.addBiEdge(u, v, w)
~~~

`u -> v` と `v -> u` の両方の辺を追加します。

## build

~~~nim
g.build()
~~~

辺の追加後に `build()` を呼ぶと、各頂点の隣接辺を `g[v]` で列挙できるようになります。

## 計算量

頂点数を `n`、追加した有向辺数を `m` とすると、

- `build()`: `O(n + m)`
- `degree(v)`: `O(1)`
- `g[v]` の走査: `O(degree(v))`

です。
