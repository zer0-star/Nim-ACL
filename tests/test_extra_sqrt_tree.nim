discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/sqrt_tree

test "SqrtTree range sum":
  proc add(a, b: int): int = a + b

  let tree = initSqrtTree(
    @[1, 2, 3, 4, 5, 6, 7, 8, 9],
    identity = 0,
    op = add,
  )

  check tree.len == 9
  check tree.prod(0, 1) == 1
  check tree.prod(0, 9) == 45
  check tree.prod(2, 7) == 25
  check tree[(3, 6)] == 15
  check tree.allProd == 45

test "SqrtTree noncommutative concatenation":
  proc concat(a, b: string): string = a & b

  let tree = initSqrtTree(
    @["a", "b", "c", "d", "e", "f", "g", "h"],
    identity = "",
    op = concat,
  )

  check tree.prod(0, 8) == "abcdefgh"
  check tree.prod(1, 7) == "bcdefg"
  check tree.prod(3, 4) == "d"
  check tree.prod(2, 6) == "cdef"

test "SqrtTree agrees with brute force":
  proc add(a, b: int): int = a + b

  for n in 1 .. 80:
    var values = newSeq[int](n)

    for i in 0 ..< n:
      values[i] = (i * i + 7 * i + 11) mod 31 - 15

    let tree = initSqrtTree(
      values,
      identity = 0,
      op = add,
    )

    for l in 0 ..< n:
      var expected = 0

      for r in l + 1 .. n:
        expected += values[r - 1]

        check tree.prod(l, r) == expected

test "SqrtTree small and empty arrays":
  proc add(a, b: int): int = a + b

  let
    emptyTree = initSqrtTree(
      newSeq[int](),
      identity = 0,
      op = add,
    )
    oneTree = initSqrtTree(
      @[42],
      identity = 0,
      op = add,
    )

  check emptyTree.len == 0
  check emptyTree.allProd == 0

  check oneTree.len == 1
  check oneTree.prod(0, 1) == 42
  check oneTree.allProd == 42
