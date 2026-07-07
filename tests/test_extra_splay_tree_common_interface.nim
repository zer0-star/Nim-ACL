discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/splay_tree

test "SplayTree common sequence interface":
  var t = initSplayTree[int]()

  t.build(@[1, 2, 3])

  check t.toSeq == @[1, 2, 3]
  check t.len == 3

  t.insert_index(1, 10)
  check t.toSeq == @[1, 10, 2, 3]

  t.erase_index(2)
  check t.toSeq == @[1, 10, 3]

  t[1] = 20
  check t.toSeq == @[1, 20, 3]

  t.check_tree()

  let (l, r) = t.split_index(t.root, 1)
  t.root = t.merge(l, r)

  check t.toSeq == @[1, 20, 3]
