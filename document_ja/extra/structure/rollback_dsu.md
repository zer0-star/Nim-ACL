# RollbackDSU

`RollbackDSU` は、merge 操作を巻き戻せる Union-Find です。

通常の DSU は、一度 `merge(a, b)` すると過去の状態に戻れません。  
`RollbackDSU` は merge 前の情報を stack に保存しておき、あとから `undo()` や `rollback(snapshot)` で元の状態に戻せます。

## 使いどころ

次のような問題でよく使います。

- 辺の追加・削除がある graph を offline に処理する
- Segment tree over time + DSU rollback
- 分割統治と DSU を組み合わせる問題
- MST 判定や edge set query を offline に処理する問題
- `Online` では難しいが、全 query が先に与えられる dynamic connectivity

## 考え方

通常の DSU は高速化のために path compression を使います。  
しかし path compression は多くの親 pointer を変更するため、巻き戻しに向きません。

Rollback DSU では path compression を使わず、union by size だけを使います。

`merge(a, b)` のたびに、変更前の root 情報を stack に保存します。

- root `x` の `parentOrSize[x]`
- root `y` の `parentOrSize[y]`
- 実際に merge したかどうか

`undo()` では stack の最後を取り出し、保存していた値に戻します。  
これにより、1 回の merge を `O(log n)` 程度で行い、undo も `O(1)` で処理できます。

## import

~~~nim
import atcoder/extra/structure/rollback_dsu
~~~

## 型

~~~nim
type RollbackDSU
type RollbackDSUHistory
~~~

## コンストラクタ

~~~nim
proc initRollbackDSU(n: int): RollbackDSU
~~~

`n` 頂点の Rollback DSU を作ります。

## 操作

~~~nim
proc len(uf: RollbackDSU): int
proc componentCount(uf: RollbackDSU): int

proc leader(uf: RollbackDSU, a: int): int
proc size(uf: RollbackDSU, a: int): int
proc same(uf: RollbackDSU, a, b: int): bool
proc merge(uf: var RollbackDSU, a, b: int): bool

proc snapshot(uf: RollbackDSU): int
proc time(uf: RollbackDSU): int

proc undo(uf: var RollbackDSU): bool
proc rollback(uf: var RollbackDSU): bool
proc rollback(uf: var RollbackDSU, snap: int)

proc groups(uf: RollbackDSU): seq[seq[int]]
~~~

- `merge(a, b)` は `a`, `b` の連結成分を併合します。
- `same(a, b)` は同じ連結成分かを返します。
- `size(a)` は `a` の連結成分サイズを返します。
- `snapshot()` は現在の状態を表す rollback point を返します。
- `undo()` は直前の `merge` を 1 回戻します。
- `rollback(snap)` は指定した snapshot まで戻します。
- `componentCount()` は現在の連結成分数を返します。

## 使用例

<!-- nim-line-numbers -->
~~~nim
var uf = initRollbackDSU(5)

discard uf.merge(0, 1)
discard uf.merge(2, 3)

let s = uf.snapshot

discard uf.merge(1, 2)

doAssert uf.same(0, 3)
doAssert uf.size(0) == 4

uf.rollback(s)

doAssert uf.same(0, 1)
doAssert uf.same(2, 3)
doAssert not uf.same(0, 2)
~~~

## undo

`undo()` は直前の `merge` を 1 回だけ戻します。

~~~nim
var uf = initRollbackDSU(3)

discard uf.merge(0, 1)

doAssert uf.same(0, 1)

discard uf.undo()

doAssert not uf.same(0, 1)
~~~

すでに同じ連結成分だった場合の `merge` も history に積まれます。  
そのため、`merge` 回数と `undo` 回数を対応させやすくなっています。

## Nim らしい使い方

`componentCount`, `snapshot`, `time` は UFCS で自然に読めます。

~~~nim
let s = uf.snapshot

discard uf.merge(0, 1)

echo uf.componentCount

uf.rollback(s)
~~~

## 計算量

頂点数を `n` とすると、

- `leader`: `O(log n)`
- `same`: `O(log n)`
- `size`: `O(log n)`
- `merge`: `O(log n)`
- `undo`: `O(1)`
- `rollback(snap)`: 戻す merge 数に比例
- `groups`: `O(n log n)`

です。

path compression をしないため、通常の DSU より少し遅いですが、rollback 可能になります。

## 注意

- path compression は使っていません。
- `snapshot` は `merge` history の長さです。
- `rollback(snap)` には、以前取得した snapshot を渡してください。
- fully online な edge deletion にはそのままでは使えません。offline 処理と組み合わせるのが典型です。

<!-- NIM_ACL_PROBLEM_EXAMPLES_V1 -->
## このライブラリが使える問題

<details class="problem-examples">
<summary>問題例を表示する（解法のネタバレを含む可能性があります）</summary>
<ul>
  <li><a href="https://judge.yosupo.jp/problem/dynamic_graph_vertex_add_component_sum" target="_blank" rel="noopener">Library Checker - Dynamic Graph Vertex Add Component Sum</a></li>
</ul>
</details>
<!-- /NIM_ACL_PROBLEM_EXAMPLES_V1 -->

## 関連資料・他言語ライブラリ

- [cp-algorithms: Deleting from a data structure in O(T(n) log n)](https://cp-algorithms.com/data_structures/deleting_in_log_n.html)
- [Library Checker: Dynamic Graph Vertex Add Component Sum](https://judge.yosupo.jp/problem/dynamic_graph_vertex_add_component_sum)
- Nyaan Library: Offline Dynamic Connectivity
- ei1333 Library: Union-Find rollback / offline dynamic connectivity
