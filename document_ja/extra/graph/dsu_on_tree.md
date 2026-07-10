# DSUOnTree

`DSUOnTree` は、木の各頂点 `v` について「`v` の subtree に含まれる情報」を効率よく集計する technique です。

別名として `Sack` や `small-to-large on tree` と呼ばれることもあります。

## 使いどころ

次のような問題でよく使います。

- 各頂点 `v` について、subtree 内の色の種類数を求める
- subtree 内で最も多い色の個数を求める
- subtree 内の値の頻度表を使った query
- 各 subtree に対して multiset / counter を使う DP
- 全頂点について「subtree query」をしたいが、毎回 DFS すると `O(n^2)` になる問題

Codeforces 600E “Lomsat gelral” のような subtree 色頻度問題が典型です。

## 考え方

各頂点で subtree 全体の情報を素朴に作ると、同じ頂点を何度も追加・削除してしまい `O(n^2)` になりがちです。

DSU on Tree では、各頂点について一番大きい子 subtree、つまり heavy child を残し、それ以外の light child の情報だけを追加し直します。

処理の流れは次の通りです。

1. light child を先に処理し、処理後に消す
2. heavy child を処理し、その情報を残す
3. light child の subtree の頂点をもう一度 `add` する
4. 自分自身を `add` する
5. 現在の状態で `answer(v)` を呼ぶ
6. 必要なら subtree 全体を `remove` する

各頂点が light edge を通って追加される回数は高々 `O(log n)` 回なので、全体で効率よく処理できます。

## import

~~~nim
import atcoder/extra/graph/dsu_on_tree
~~~

## 型

~~~nim
type DSUOnTree
~~~

## コンストラクタ

~~~nim
proc initDSUOnTree(graph: seq[seq[int]], root: int = 0): DSUOnTree
~~~

`graph` は無向木の adjacency list です。

## metadata

~~~nim
proc len(dt: DSUOnTree): int
proc subtreeVertices(dt: DSUOnTree, v: int): seq[int]
~~~

`DSUOnTree` は次の field も公開しています。

~~~nim
n: int
root: int
graph: seq[seq[int]]
parent: seq[int]
depth: seq[int]
subtreeSize: seq[int]
heavy: seq[int]
tin: seq[int]
tout: seq[int]
order: seq[int]
~~~

- `parent[v]`: 親
- `depth[v]`: root からの深さ
- `subtreeSize[v]`: subtree サイズ
- `heavy[v]`: 最大 subtree を持つ子。なければ `-1`
- `tin`, `tout`, `order`: subtree を連続区間として扱うための Euler order

## 実行

~~~nim
proc run(
  dt: DSUOnTree,
  add: proc(v: int),
  remove: proc(v: int),
  answer: proc(v: int)
)

proc runDSUOnTree(
  dt: DSUOnTree,
  add: proc(v: int),
  remove: proc(v: int),
  answer: proc(v: int)
)
~~~

`answer(v)` が呼ばれる時点で、現在の data structure には **ちょうど `v` の subtree の頂点だけ** が入っています。

- `add(v)`: 頂点 `v` を現在の状態に追加する
- `remove(v)`: 頂点 `v` を現在の状態から削除する
- `answer(v)`: 頂点 `v` の答えを記録する

## 使用例: subtree の色種類数

~~~nim
import std/tables
import atcoder/extra/graph/dsu_on_tree

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

let
  dt = initDSUOnTree(g)
  color = @[1, 2, 1, 2, 3, 1, 3]

var
  freq = initTable[int, int]()
  distinctCount = 0
  ans = newSeq[int](7)

proc addVertex(v: int) =
  let c = color[v]
  let old = freq.getOrDefault(c, 0)

  if old == 0:
    distinctCount.inc

  freq[c] = old + 1

proc removeVertex(v: int) =
  let c = color[v]
  let old = freq.getOrDefault(c, 0)

  if old == 1:
    freq.del(c)
    distinctCount.dec
  else:
    freq[c] = old - 1

proc answerVertex(v: int) =
  ans[v] = distinctCount

dt.run(addVertex, removeVertex, answerVertex)

doAssert ans == @[3, 2, 2, 1, 1, 1, 1]
~~~

## Nim らしい使い方

callback を普通の proc として書き、UFCS で `dt.run(...)` と呼べます。

~~~nim
dt.run(addVertex, removeVertex, answerVertex)
~~~

`subtreeVertices(v)` も補助的に使えます。

~~~nim
for u in dt.subtreeVertices(v):
  echo u
~~~

## 計算量

頂点数を `n` とします。

- 前計算: `O(n)`
- `run`: `O(n log n * add/remove のコスト)` 程度
- memory: `O(n)`

典型的な色頻度集計では、実用上かなり高速に動きます。

## 注意

- `graph` は木である必要があります。
- `answer(v)` の時点では、現在状態は `v` の subtree だけです。
- `add` と `remove` は互いに整合するように実装してください。
- この実装は明示 stack を使っているため、深い木でも recursive DFS より stack overflow しにくいです。

## 関連資料・他言語ライブラリ

- Codeforces 600E: Lomsat gelral
- cp-algorithms: tree queries / small-to-large merging concepts
- Nyaan Library: DSU on Tree
- ei1333 Library: DSU on Tree / Sack
