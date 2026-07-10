# CartesianTree

`CartesianTree` is a binary tree whose inorder traversal preserves array indices while its values satisfy a heap condition.

A min Cartesian tree has parent values no greater than child values. It is useful for Range Minimum Query reductions, LCA relations, and monotonic-stack techniques.

## Import and construction

~~~nim
import atcoder/extra/structure/cartesian_tree

proc initCartesianTree[T](a: openArray[T]): CartesianTree
proc initMinCartesianTree[T](a: openArray[T]): CartesianTree
proc initMaxCartesianTree[T](a: openArray[T]): CartesianTree
~~~

## Fields

~~~nim
root: int
parent: seq[int]
left: seq[int]
right: seq[int]
~~~

Missing parents and children are represented by `-1`.

## Example

~~~nim
let tree = initCartesianTree(@[3, 1, 4, 0, 2])

doAssert tree.root == 3
doAssert tree.inorder == @[0, 1, 2, 3, 4]
~~~

## Complexity

- build: `O(n)`
- memory: `O(n)`
