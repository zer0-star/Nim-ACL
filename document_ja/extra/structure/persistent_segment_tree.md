# Persistent Segment Tree

`PersistentSegmentTree` は、更新前の version を破壊せずに残す Segment Tree です。

通常の Segment Tree では点更新すると過去の状態が失われます。永続 Segment Tree では、更新経路上の node だけを複製し、変更されない subtree を古い version と共有します。

## 使いどころ

- 過去時刻の配列に対する query
- version ごとに異なる更新を分岐させる
- 区間 k-th などの persistent frequency tree
- rollback ではなく、任意の過去 version を直接参照したい
- offline query

## 考え方

点更新で変更される node は root から leaf までの `O(log n)` 個だけです。

それらだけを新しく作り、反対側の子は古い node をそのまま共有します。各 version は root node の index だけで表せます。

## import

~~~nim
import atcoder/extra/structure/persistent_segment_tree
~~~

ローカル短縮 import：

~~~nim
import lib/structure/persistent_segment_tree
~~~

## コンストラクタ

~~~nim
proc initPersistentSegmentTree[T](
  n: int,
  identity: T,
  op: proc(a, b: T): T,
  expectedUpdates: int = 0
): PersistentSegmentTree[T]

proc initPersistentSegmentTree[T](
  values: openArray[T],
  identity: T,
  op: proc(a, b: T): T,
  expectedUpdates: int = 0
): PersistentSegmentTree[T]
~~~

## 操作

~~~nim
proc setValue(
  tree: var PersistentSegmentTree[T],
  root, position: int,
  value: T
): int

proc update(
  tree: var PersistentSegmentTree[T],
  root, position: int,
  value: T
): int

proc prod(
  tree: PersistentSegmentTree[T],
  root, l, r: int
): T

proc get(tree, root, position): T
proc allProd(tree, root): T
proc toSeq(tree, root): seq[T]
~~~

`setValue` は元の version を変更せず、新しい root index を返します。

## 使用例

~~~nim
proc add(a, b: int): int = a + b

var tree = initPersistentSegmentTree(
  @[1, 2, 3, 4],
  identity = 0,
  op = add,
)

let
  root0 = tree.root
  root1 = tree.setValue(root0, 1, 20)
  root2 = tree.setValue(root1, 3, 40)

doAssert tree.toSeq(root0) == @[1, 2, 3, 4]
doAssert tree.toSeq(root1) == @[1, 20, 3, 4]
doAssert tree.toSeq(root2) == @[1, 20, 3, 40]

doAssert tree.prod(root0, 0, 4) == 10
doAssert tree.prod(root2, 1, 4) == 63
~~~

古い version から別の branch を作れます。

~~~nim
let rootA = tree.setValue(root0, 0, 100)
let rootB = tree.setValue(root0, 0, 200)
~~~

## 計算量

- 初期構築: `O(n)`
- 点更新: `O(log n)` 時間・追加 memory
- 区間積: `O(log n)`
- point get: `O(log n)`
- version の保持: root index 1個

## 注意

- `op` は結合法則を満たす必要があります。
- `identity` は `op` の単位元です。
- version は root index として利用者が保持します。
- 区間は半開区間 `[l, r)` です。

## 関連資料

- [AtCoder Algorithm Lectures](https://info.atcoder.jp/entry/algorithm_lectures/index)
- Persistent data structures
- Library Checker の persistent / range query 問題
