discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/fast_set

test "FastSet basic operations":
  var s = initFastSet(130)

  check s.empty
  check s.len == 0
  check s.minValue == -1
  check s.maxValue == -1

  check s.insert(0)
  check s.insert(5)
  check s.insert(64)
  check s.insert(65)
  check s.insert(129)
  check not s.insert(65)

  check s.len == 5
  check 64 in s
  check 63 notin s

  check s.nextGE(0) == 0
  check s.nextGE(1) == 5
  check s.nextGE(63) == 64
  check s.nextGE(66) == 129
  check s.nextGE(130) == -1

  check s.prevLE(129) == 129
  check s.prevLE(128) == 65
  check s.prevLE(64) == 64
  check s.prevLE(4) == 0
  check s.prevLE(-1) == -1

  check s.lowerBound(5) == 5
  check s.upperBound(5) == 64
  check s.prevLT(64) == 5

  check s.minValue == 0
  check s.maxValue == 129

  check s.erase(64)
  check not s.erase(64)
  check s.nextGE(63) == 65
  check s.len == 4

test "FastSet set-like aliases and iteration":
  var s = initFastSet(20, @[7, 3, 15, 3])

  s.incl(1)
  s.excl(7)

  var values: seq[int] = @[]

  for x in s:
    values.add x

  check values == @[1, 3, 15]
  check s.len == 3

test "FastSet agrees with brute force":
  const n = 200

  var
    s = initFastSet(n)
    present = newSeq[bool](n)

  for x in countup(0, n - 1, 3):
    discard s.insert(x)
    present[x] = true

  for x in countup(0, n - 1, 9):
    discard s.erase(x)
    present[x] = false

  for x in -2 .. n + 2:
    var expectedNext = -1

    for y in max(0, x) ..< n:
      if present[y]:
        expectedNext = y
        break

    var expectedPrev = -1

    if x >= 0:
      for y in countdown(min(x, n - 1), 0):
        if present[y]:
          expectedPrev = y
          break

    check s.nextGE(x) == expectedNext
    check s.prevLE(x) == expectedPrev

test "FastSet empty universe":
  let s = initFastSet(0)

  check s.empty
  check s.nextGE(0) == -1
  check s.prevLE(0) == -1
