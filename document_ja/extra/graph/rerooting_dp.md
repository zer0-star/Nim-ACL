# Rerooting DP

`Rerooting DP` は、木 DP をすべての頂点を root とした場合について高速に求める technique です。

通常の木 DP は root を 1 つ決めて「子 subtree から親へ」計算します。  
しかし問題によっては、「各頂点を root にしたときの答え」が欲しいことがあります。

各頂点ごとに root を変えて DFS すると `O(n^2)` になりますが、Rerooting DP では全頂点の答えをまとめて `O(n)` または `O(n log n)` 程度で求められます。

## 使いどころ

次のような問題でよく使います。

- 各頂点から全頂点への距離和を求める
- 各頂点を root にしたときの最長距離を求める
- 木の各頂点を中心にした subtree DP の答えを求める
- 木上の DP で、親方向からの寄与も含めたい
- ABC/ARC の木 DP 問題

## 考え方

木 DP の値を「隣接頂点から来る寄与」として考えます。

各頂点 `v` の答えは、隣接する全方向からの寄与を `merge` し、最後に `addRoot` することで得られます。

子方向からの寄与は普通の DFS で求められます。  
親方向からの寄与は、`v` の全隣接方向の寄与を prefix/suffix で集約し、特定の子だけを除いた値から作ります。

この module では、次の 3 つの関数を渡します。

- `merge(a, b)`: 複数方向からの寄与をまとめる
- `addRoot(x, v)`: 頂点 `v` 自身を加味して DP 値にする
- `addEdge(x, edgeId, fromVertex, toVertex)`: edge を 1 本またいだときの変換

## import

~~~nim
import atcoder/extra/graph/rerooting_dp
~~~

## 型

~~~nim
type RerootingEdge
type RerootingGraph
~~~

## コンストラクタ

~~~nim
proc initRerootingGraph(n: int): RerootingGraph
proc addEdge(g: var RerootingGraph, u, v: int): int
~~~

- `initRerootingGraph(n)` は `n` 頂点の木 container を作ります。
- `addEdge(u, v)` は無向辺を追加し、edge id を返します。

## 実行

~~~nim
proc rerooting[T](
  g: RerootingGraph,
  identity: T,
  merge: proc(a, b: T): T,
  addRoot: proc(x: T, v: int): T,
  addEdge: proc(x: T, edgeId: int, fromVertex: int, toVertex: int): T
): seq[T]

proc rerooting[T](
  g: RerootingGraph,
  identity: T,
  merge: proc(a, b: T): T,
  addRoot: proc(x: T, v: int): T
): seq[T]
~~~

`addEdge` を省略した場合、edge をまたいでも値が変わらないものとして扱います。

`rerootingDP` という alias もあります。

## 使用例: 各頂点から全頂点への距離和

~~~nim
import std/sequtils
import atcoder/extra/graph/rerooting_dp

type DP = tuple[size, dist: int]

var g = initRerootingGraph(4)

discard g.addEdge(0, 1)
discard g.addEdge(1, 2)
discard g.addEdge(2, 3)

proc merge(a, b: DP): DP =
  (size: a.size + b.size, dist: a.dist + b.dist)

proc addRoot(x: DP, v: int): DP =
  (size: x.size + 1, dist: x.dist)

proc addEdge(x: DP, edgeId: int, fromVertex: int, toVertex: int): DP =
  (size: x.size, dist: x.dist + x.size)

let ans = g.rerooting((size: 0, dist: 0), merge, addRoot, addEdge)

doAssert ans.mapIt(it.dist) == @[6, 4, 4, 6]
~~~

`size` はその方向にある頂点数、`dist` は現在の root からの距離和です。  
edge を 1 本またぐと、その成分の全頂点への距離が 1 増えるので、`dist + size` になります。

## 使用例: 全頂点からの最遠距離

~~~nim
var g = initRerootingGraph(6)

discard g.addEdge(0, 1)
discard g.addEdge(0, 2)
discard g.addEdge(1, 3)
discard g.addEdge(1, 4)
discard g.addEdge(4, 5)

proc merge(a, b: int): int = max(a, b)
proc addRoot(x: int, v: int): int = x
proc addEdge(x: int, edgeId: int, fromVertex: int, toVertex: int): int = x + 1

let ans = g.rerootingDP(0, merge, addRoot, addEdge)

doAssert ans == @[3, 2, 4, 3, 3, 4]
~~~

## Nim らしい使い方

`merge`, `addRoot`, `addEdge` を普通の proc として書き、UFCS で呼べます。

~~~nim
let ans = g.rerooting(identity, merge, addRoot, addEdge)
~~~

edge 重みなどを使いたい場合は、`addEdge` 内で `edgeId` を使って外側の配列を参照できます。

~~~nim
proc addEdge(x: DP, edgeId: int, fromVertex: int, toVertex: int): DP =
  let w = weight[edgeId]
  ...
~~~

## 計算量

頂点数を `n` とすると、

- 構築: `O(n)`
- rerooting: `O(n * merge/addRoot/addEdge のコスト)`
- memory: `O(n)`

です。

## 注意

- `graph` は木である必要があります。
- `merge` は結合法則を満たす必要があります。
- `identity` は `merge` の単位元である必要があります。
- この実装では 0 番頂点を内部 root として前計算します。ただし答えは全頂点 root のものが得られます。
- `addEdge` を省略した overload は、edge をまたいでも値が変わらない場合にだけ使ってください。

## 関連資料・他言語ライブラリ

- AtCoder / ABC / ARC: 木 DP rerooting 型問題
- ei1333 Library: ReRooting
- Nyaan Library: Rerooting
- AtCoder Library Practice 周辺の tree DP 解説
