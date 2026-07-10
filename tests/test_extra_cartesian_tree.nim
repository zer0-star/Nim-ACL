discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/cartesian_tree

test "CartesianTree min tree":
  let tree = initCartesianTree(@[3, 1, 4, 0, 2])

  check tree.root == 3
  check tree.parent == @[1, 3, 1, -1, 3]
  check tree.left == @[-1, 0, -1, 1, -1]
  check tree.right == @[-1, 2, -1, 4, -1]
  check tree.inorder == @[0, 1, 2, 3, 4]
  check tree.children(3) == @[1, 4]

test "CartesianTree max tree":
  let tree = initMaxCartesianTree(@[3, 1, 4, 0, 2])

  check tree.root == 2
  check tree.inorder == @[0, 1, 2, 3, 4]

  let a = @[3, 1, 4, 0, 2]

  for v in 0 ..< tree.len:
    if tree.left[v] >= 0:
      check a[v] >= a[tree.left[v]]

    if tree.right[v] >= 0:
      check a[v] >= a[tree.right[v]]

test "CartesianTree stable equal values":
  let tree = initCartesianTree(@[2, 2, 1])

  check tree.root == 2
  check tree.left[2] == 0
  check tree.right[0] == 1
  check tree.parent[0] == 2
  check tree.parent[1] == 0
  check tree.inorder == @[0, 1, 2]

test "CartesianTree custom comparator":
  proc greater(a, b: int): bool = a > b

  let tree = initCartesianTree(@[1, 5, 2, 4], greater)

  check tree.root == 1
  check tree.inorder == @[0, 1, 2, 3]

test "CartesianTree empty":
  let tree = initCartesianTree(newSeq[int]())

  check tree.empty
  check tree.root == -1
  check tree.inorder.len == 0
