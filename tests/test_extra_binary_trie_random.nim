discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, unittest]

import atcoder/extra/structure/binary_trie

proc bruteCount(xs: openArray[int], x: int): int =
  for y in xs:
    if y == x:
      result.inc

proc bruteMinXor(xs: openArray[int], x: int): int =
  result = int.high
  for y in xs:
    result = min(result, x xor y)

proc bruteMaxXor(xs: openArray[int], x: int): int =
  result = int.low
  for y in xs:
    result = max(result, x xor y)

proc eraseOne(xs: var seq[int], x: int) =
  for i, y in xs:
    if y == x:
      xs.delete(i)
      return

  doAssert false

test "BinaryTrie randomized differential multiset operations":
  var rng = initRand(0xB17A2026)

  for caseId in 0 ..< 120:
    var trie = initBinaryTrie[int](maxLog = 5)
    var values: seq[int] = @[]

    for operationId in 0 ..< 240:
      let operation = rand(rng, 0 .. 99)
      let x = rand(rng, 0 .. 63)

      if values.len == 0 or operation < 55:
        if operation mod 7 == 0:
          let copies = rand(rng, 0 .. 3)
          trie.add(x, copies)

          for copyId in 0 ..< copies:
            values.add(x)
        else:
          trie.insert(x)
          values.add(x)

      elif operation < 80:
        let index = rand(rng, 0 .. values.high)
        let erased = values[index]

        trie.erase(erased)
        values.eraseOne(erased)

      check trie.len == values.len
      check trie.empty == (values.len == 0)

      let probe = rand(rng, 0 .. 63)

      check trie.count(probe) == bruteCount(values, probe)
      check trie.contains(probe) == (bruteCount(values, probe) > 0)

      if values.len > 0:
        let expectedMin = bruteMinXor(values, probe)
        let expectedMax = bruteMaxXor(values, probe)
        let minElement = trie.minElementXor(probe)
        let maxElement = trie.maxElementXor(probe)

        check trie.minXor(probe) == expectedMin
        check trie.maxXor(probe) == expectedMax
        check (probe xor minElement) == expectedMin
        check (probe xor maxElement) == expectedMax
        check bruteCount(values, minElement) > 0
        check bruteCount(values, maxElement) > 0

    for x in 0 .. 63:
      check trie.count(x) == bruteCount(values, x)
      check trie.contains(x) == (bruteCount(values, x) > 0)
