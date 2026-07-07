discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/randomized_binary_search_tree_with_parent

test "RandomizedBinarySearchTree sequence operations":
  var rbst = initRandomizedBinarySearchTree[int](seed = 20260707)

  rbst.build(@[1, 2, 3])
  check rbst.to_vec(rbst.root) == @[1, 2, 3]

  rbst.insert_index(rbst.root, 1, 10)
  check rbst.to_vec(rbst.root) == @[1, 10, 2, 3]

  rbst.erase_index(rbst.root, 2)
  check rbst.to_vec(rbst.root) == @[1, 10, 3]

  rbst[1] = 20
  check rbst.to_vec(rbst.root) == @[1, 20, 3]

  discard rbst.check_tree()
