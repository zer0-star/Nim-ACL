discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/red_black_tree

test "RedBlackTree low-level ordered nodes":
  var rb: RedBlackTree[int]

  # RedBlackTree is a low-level backend.
  # The root is an explicit End sentinel node with id = -2.
  var End = RedBlackTreeNode[int](id: -2)
  End.cnt = 0
  End.color = Color.black

  rb.init(End)

  let n3 = rb.insert(End, 3)
  discard rb.insert(n3, 1)
  discard rb.insert(End, 4)
  discard rb.insert(End, 5)

  rb.checkTree()

  var xs: seq[int] = @[]
  var it = rb.begin()
  while it != End:
    xs.add(*it)
    it.inc

  check xs == @[1, 3, 4, 5]

  discard rb.erase(n3)
  rb.checkTree()

  xs.setLen(0)
  it = rb.begin()
  while it != End:
    xs.add(*it)
    it.inc

  check xs == @[1, 4, 5]
