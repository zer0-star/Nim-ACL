discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/disjoint_sparse_table

test "DisjointSparseTable range sum":
  proc add(a, b: int): int = a + b

  let dst = initDisjointSparseTable(@[1, 2, 3, 4, 5], add)

  check dst.len == 5
  check dst.prod(0, 1) == 1
  check dst.prod(0, 5) == 15
  check dst.prod(1, 4) == 9
  check dst[(2, 5)] == 12

test "DisjointSparseTable noncommutative concatenation":
  proc concat(a, b: string): string = a & b

  let dst = initDisjointSparseTable(
    @["a", "b", "c", "d", "e", "f"],
    concat,
  )

  check dst.prod(0, 6) == "abcdef"
  check dst.prod(1, 5) == "bcde"
  check dst.prod(3, 4) == "d"

test "DisjointSparseTable maximum":
  proc maximum(a, b: int): int = max(a, b)

  let dst = initDisjointSparseTable(@[3, 1, 4, 1, 5, 9, 2], maximum)

  check dst.prod(0, 7) == 9
  check dst.prod(0, 4) == 4
  check dst.prod(4, 7) == 9
  check dst.prod(1, 2) == 1
