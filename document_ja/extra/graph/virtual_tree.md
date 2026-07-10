# VirtualTree

`VirtualTree` は、木の中から重要な頂点だけを取り出し、それらの LCA を追加して作る小さい補助木です。

元の木全体に対して毎回 DP すると重い場合でも、query ごとに重要頂点数を `k` とすると、`O(k log k)` 程度で小さい木を作って処理できます。

## 使いどころ

次のような問題でよく使います。

- 木上で、query ごとに指定された頂点集合だけが重要
- 重要頂点をすべて結ぶ最小部分木が欲しい
- 指定頂点集合に対して木 DP をしたい
- LCA を使った圧縮木で距離や親子関係を処理したい
- 元の木が大きく、毎 query で全体を走査できない

## 考え方

指定された重要頂点だけを見ると、元の木上の経路が途中で交わることがあります。  
その交点は、重要頂点同士の LCA です。

そこで、重要頂点を DFS order で並べ、隣り合う頂点の LCA を追加します。  
この集合を DFS order で sort し、stack を使って親子関係を復元すると、重要頂点と必要な LCA だけからなる小さい木ができます。

Virtual Tree の edge の長さは、元の木上の距離です。

## import

~~~nim
import atcoder/extra/graph/virtual_tree
~~~

## 型

~~~nim
type VirtualTree
type BuiltVirtualTree

type VirtualTreeEdge = tuple[parent, child, dist: int]
type VirtualTreeAdjEdge = tuple[to, dist: int]
~~~

`VirtualTree` は元の木に対する LCA 前計算を持つ builder です。  
`BuiltVirtualTree` は query ごとに作られる圧縮木です。

## コンストラクタ

~~~nim
proc initVirtualTree(graph: seq[seq[int]], root: int = 0): VirtualTree
~~~

`graph` は無向木の adjacency list です。

## LCA / 距離

~~~nim
proc isAncestor(vt: VirtualTree, a, b: int): bool
proc lca(vt: VirtualTree, a, b: int): int
proc dist(vt: VirtualTree, a, b: int): int
~~~

- `isAncestor(a, b)` は `a` が `b` の ancestor かを返します。
- `lca(a, b)` は LCA を返します。
- `dist(a, b)` は元の木上の距離を返します。

## Virtual Tree の構築

~~~nim
proc buildVirtualTree(vt: VirtualTree, keys: openArray[int]): BuiltVirtualTree
~~~

`keys` に含まれる重要頂点と、必要な LCA からなる virtual tree を作ります。

`BuiltVirtualTree` の主な field は次です。

~~~nim
root: int
vertices: seq[int]
edges: seq[VirtualTreeEdge]
adj: seq[seq[VirtualTreeAdjEdge]]
~~~

- `root` は virtual tree の root の元頂点番号です。
- `vertices[i]` は compressed node `i` に対応する元頂点番号です。
- `edges` は元頂点番号で見た edge list です。
- `adj[i]` は compressed node `i` からの子を表します。`to` は compressed index です。

## 使用例

<!-- nim-line-numbers -->
~~~nim
var g = newSeq[seq[int]](7)

proc addEdge(u, v: int) =
  g[u].add v
  g[v].add u

addEdge(0, 1)
addEdge(0, 2)
addEdge(1, 3)
addEdge(1, 4)
addEdge(2, 5)
addEdge(2, 6)

let vt = initVirtualTree(g)
let built = vt.buildVirtualTree(@[3, 4, 5])

doAssert built.root == 0
doAssert built.vertices == @[0, 1, 3, 4, 5]

doAssert built.edges == @[
  (parent: 0, child: 1, dist: 1),
  (parent: 1, child: 3, dist: 1),
  (parent: 1, child: 4, dist: 1),
  (parent: 0, child: 5, dist: 2),
]
~~~

## compressed adjacency

`adj` は compressed index で持っています。元頂点番号が必要な場合は `vertices[to]` を見ます。

~~~nim
for e in built.adj[0]:
  let childOriginalVertex = built.vertices[e.to]
  echo childOriginalVertex, " dist = ", e.dist
~~~

## Nim らしい使い方

`lca`, `dist`, `buildVirtualTree` は UFCS で自然に読めます。

~~~nim
let c = vt.lca(u, v)
let d = vt.dist(u, v)
let tree = vt.buildVirtualTree(keys)
~~~

## 計算量

元の木の頂点数を `n`、重要頂点数を `k`、virtual tree の頂点数を `K` とします。

- 前計算: `O(n log n)`
- `lca`: `O(log n)`
- `dist`: `O(log n)`
- `buildVirtualTree`: `O(k log k + k log n)`
- memory: 前計算 `O(n log n)`, 構築結果 `O(K)`

です。

## 注意

- `graph` は木である必要があります。
- `keys` は空にできません。
- `keys` に重複があっても、構築時に除かれます。
- `adj` の `to` は元頂点番号ではなく compressed index です。
- edge の `dist` は元の木上での距離です。

## 関連資料・他言語ライブラリ

- cp-algorithms: Lowest Common Ancestor / auxiliary tree concepts
- Nyaan Library: Virtual Tree
- ei1333 Library: Auxiliary Tree
- Codeforces: important vertices on tree / auxiliary tree 型の問題
