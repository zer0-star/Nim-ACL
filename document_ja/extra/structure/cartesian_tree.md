# CartesianTree

`CartesianTree` は、配列の index 順序を inorder traversal として保ちながら、値について heap 条件を満たす二分木です。

min Cartesian Tree では親の値が子の値以下になります。配列の区間最小値と LCA の関係、Range Minimum Query、単調 stack の応用などで使われます。

## 考え方

配列を左から見て単調 stack を管理します。

新しい値が stack top より小さい間は pop し、最後に pop した subtree を新しい node の左の子にします。残った stack top が新しい node の親になります。

これにより `O(n)` で構築できます。

## import

~~~nim
import atcoder/extra/structure/cartesian_tree
~~~

## 構築

~~~nim
proc initCartesianTree[T](a: openArray[T]): CartesianTree
proc initMinCartesianTree[T](a: openArray[T]): CartesianTree
proc initMaxCartesianTree[T](a: openArray[T]): CartesianTree

proc initCartesianTree[T](
  a: openArray[T],
  less: proc(x, y: T): bool
): CartesianTree
~~~

## field と操作

~~~nim
root: int
parent: seq[int]
left: seq[int]
right: seq[int]

proc children(tree: CartesianTree, v: int): seq[int]
proc inorder(tree: CartesianTree): seq[int]
~~~

存在しない親・子は `-1` です。

## 使用例

<!-- nim-line-numbers -->
~~~nim
let tree = initCartesianTree(@[3, 1, 4, 0, 2])

doAssert tree.root == 3
doAssert tree.inorder == @[0, 1, 2, 3, 4]
doAssert tree.children(3) == @[1, 4]
~~~

同値の場合、先に現れた index が上側に残る stable な構築です。

## 計算量

- 構築: `O(n)`
- memory: `O(n)`
- `children`: `O(1)`
- `inorder`: `O(n)`

## 関連資料・他言語ライブラリ

- [cp-algorithms: Cartesian Tree](https://cp-algorithms.com/data_structures/treap.html)
- Library Checker: Cartesian Tree
- Nyaan Library: Cartesian Tree
