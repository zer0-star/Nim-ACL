discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, unittest]

import atcoder/extra/structure/fast_set

proc bruteCount(
    present: openArray[bool],
): int =
  for value in present:
    if value:
      result.inc

proc bruteNextGE(
    present: openArray[bool],
    x: int,
): int =
  let start = max(0, x)

  if start >= present.len:
    return -1

  for value in start ..< present.len:
    if present[value]:
      return value

  -1

proc brutePrevLE(
    present: openArray[bool],
    x: int,
): int =
  if present.len == 0 or x < 0:
    return -1

  let start = min(x, present.len - 1)

  for value in countdown(start, 0):
    if present[value]:
      return value

  -1

proc expectedItems(
    present: openArray[bool],
): seq[int] =
  for value, exists in present:
    if exists:
      result.add(value)

proc validate(
    fastSet: FastSet,
    present: openArray[bool],
    rng: var Rand,
) =
  let expectedLen = bruteCount(present)

  check fastSet.len == expectedLen
  check fastSet.empty == (expectedLen == 0)

  check fastSet.minValue ==
    bruteNextGE(present, 0)

  check fastSet.maxValue ==
    brutePrevLE(
      present,
      present.len - 1,
    )

  var actualItems: seq[int] = @[]

  for value in fastSet:
    actualItems.add(value)

  check actualItems == expectedItems(present)

  for queryId in 0 ..< 20:
    let x = rand(
      rng,
      -4 .. present.len + 4,
    )

    check fastSet.contains(x) == (
      0 <= x and
      x < present.len and
      present[x]
    )

    check fastSet.nextGE(x) ==
      bruteNextGE(present, x)

    check fastSet.lowerBound(x) ==
      bruteNextGE(present, x)

    check fastSet.prevLE(x) ==
      brutePrevLE(present, x)

    check fastSet.upperBound(x) ==
      bruteNextGE(present, x + 1)

    check fastSet.prevLT(x) ==
      brutePrevLE(present, x - 1)

test "FastSet randomized differential operations":
  var rng = initRand(0x46535426)

  for caseId in 0 ..< 220:
    let n = rand(rng, 0 .. 260)

    var fastSet = initFastSet(n)
    var present = newSeq[bool](n)

    validate(
      fastSet,
      present,
      rng,
    )

    for operationId in 0 ..< 360:
      let operation = rand(rng, 0 .. 99)

      if n > 0 and operation < 45:
        let value = rand(rng, 0 .. n - 1)
        let expected = not present[value]

        check fastSet.insert(value) ==
          expected

        present[value] = true

      elif n > 0 and operation < 78:
        let value = rand(rng, 0 .. n - 1)
        let expected = present[value]

        check fastSet.erase(value) ==
          expected

        present[value] = false

      elif n > 0 and operation < 88:
        let value = rand(rng, 0 .. n - 1)

        fastSet.incl(value)
        present[value] = true

      elif n > 0 and operation < 96:
        let value = rand(rng, 0 .. n - 1)

        fastSet.excl(value)
        present[value] = false

      validate(
        fastSet,
        present,
        rng,
      )
