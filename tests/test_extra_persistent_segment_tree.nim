discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/persistent_segment_tree

test "PersistentSegmentTree sum versions":
  proc add(a, b: int): int = a + b

  var tree = initPersistentSegmentTree(
    @[1, 2, 3, 4],
    identity = 0,
    op = add,
    expectedUpdates = 10,
  )

  let
    root0 = tree.root
    root1 = tree.setValue(root0, 1, 20)
    root2 = tree.update(root1, 3, 40)

  check tree.toSeq(root0) == @[1, 2, 3, 4]
  check tree.toSeq(root1) == @[1, 20, 3, 4]
  check tree.toSeq(root2) == @[1, 20, 3, 40]

  check tree.prod(root0, 0, 4) == 10
  check tree.prod(root1, 0, 4) == 28
  check tree.prod(root2, 1, 4) == 63

  check tree.get(root0, 1) == 2
  check tree.get(root1, 1) == 20

  check tree.allProd(root0) == 10
  check tree.allProd(root2) == 64

test "PersistentSegmentTree branches from old versions":
  proc add(a, b: int): int = a + b

  var tree = initPersistentSegmentTree(
    5,
    identity = 0,
    op = add,
  )

  let
    root0 = tree.root
    rootA = tree.setValue(root0, 2, 7)
    rootB = tree.setValue(root0, 2, 100)
    rootC = tree.setValue(rootA, 4, 9)

  check tree.toSeq(root0) == @[0, 0, 0, 0, 0]
  check tree.toSeq(rootA) == @[0, 0, 7, 0, 0]
  check tree.toSeq(rootB) == @[0, 0, 100, 0, 0]
  check tree.toSeq(rootC) == @[0, 0, 7, 0, 9]

test "PersistentSegmentTree noncommutative operation":
  proc concat(a, b: string): string = a & b

  var tree = initPersistentSegmentTree(
    @["a", "b", "c", "d"],
    identity = "",
    op = concat,
  )

  let
    root0 = tree.root
    root1 = tree.setValue(root0, 1, "X")

  check tree.prod(root0, 0, 4) == "abcd"
  check tree.prod(root0, 1, 4) == "bcd"
  check tree.prod(root1, 0, 4) == "aXcd"
  check tree.prod(root1, 1, 3) == "Xc"

test "PersistentSegmentTree creates logarithmic nodes":
  proc add(a, b: int): int = a + b

  var tree = initPersistentSegmentTree(
    newSeq[int](16),
    identity = 0,
    op = add,
  )

  let before = tree.nodeCount

  discard tree.setValue(tree.root, 5, 1)

  let added = tree.nodeCount - before

  check added == 5
