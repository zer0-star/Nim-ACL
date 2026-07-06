
discard """
  cmd: "nim cpp -r $file"
"""

import std/math
import atcoder/extra/structure/sparse_table

block:
  proc mn(a, b: int): int = min(a, b)
  proc inf(): int = int.high

  let st = initSparseTable[int](@[5, 2, 7, 1, 3], mn, inf)

  doAssert st[0..<5] == 1
  doAssert st[0..<3] == 2
  doAssert st[2..<3] == 7
  doAssert st[3..4] == 1
  doAssert st[2..<2] == int.high

block:
  proc mx(a, b: int): int = max(a, b)
  proc negInf(): int = int.low

  let st = initSparseTable[int](@[-5, 10, 7, 10, 3], mx, negInf)

  doAssert st[0..<5] == 10
  doAssert st[2..4] == 10
  doAssert st[4..4] == 3

block:
  proc g(a, b: int): int = gcd(a, b)
  proc zero(): int = 0

  let st = initSparseTable[int](@[24, 36, 60, 48], g, zero)

  doAssert st[0..<4] == 12
  doAssert st[1..3] == 12
  doAssert st[2..2] == 60
