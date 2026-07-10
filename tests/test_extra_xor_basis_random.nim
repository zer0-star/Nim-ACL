discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, unittest]

import atcoder/extra/math/xor_basis

proc xorClosure(values: openArray[int], limit: int): seq[bool] =
  result = newSeq[bool](limit)

  for mask in 0 ..< (1 shl values.len):
    var value = 0

    for i, x in values:
      if ((mask shr i) and 1) != 0:
        value = value xor x

    result[value] = true

proc closureRank(closure: openArray[bool]): int =
  var closureSize = 0

  for present in closure:
    if present:
      closureSize.inc

  var power = 1
  while power < closureSize:
    power *= 2
    result.inc

test "XorBasis randomized differential closure and optimization":
  var rng = initRand(0xA0B12026)

  for caseId in 0 ..< 320:
    let n = rand(rng, 0 .. 8)

    var values = newSeq[int](n)
    for i in 0 ..< n:
      values[i] = rand(rng, 0 .. 63)

    var basis = initXorBasis[int](maxLog = 5)

    for x in values:
      discard basis.add(x)

    let closure = xorClosure(values, 64)
    let expectedRank = closure.closureRank

    check basis.rank == expectedRank
    check basis.len == expectedRank
    check basis.empty == (expectedRank == 0)

    for value in 0 .. 63:
      check basis.contains(value) == closure[value]
      check (value in basis) == closure[value]

    for query in 0 .. 63:
      var expectedMin = int.high
      var expectedMax = int.low

      for value in 0 .. 63:
        if closure[value]:
          expectedMin = min(expectedMin, query xor value)
          expectedMax = max(expectedMax, query xor value)

      check basis.minXor(query) == expectedMin
      check basis.maxXor(query) == expectedMax

    var left = initXorBasis[int](maxLog = 5)
    var right = initXorBasis[int](maxLog = 5)

    for i, x in values:
      if (i and 1) == 0:
        discard left.add(x)
      else:
        discard right.add(x)

    let merged = merge(left, right)

    check merged.rank == expectedRank

    for value in 0 .. 63:
      check merged.contains(value) == closure[value]
