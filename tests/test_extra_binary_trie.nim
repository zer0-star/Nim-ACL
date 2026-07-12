discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/binary_trie

proc bruteMinXor(xs: seq[int], x: int): int =
  result = int.high
  for y in xs:
    result = min(result, x xor y)

proc bruteMaxXor(xs: seq[int], x: int): int =
  result = int.low
  for y in xs:
    result = max(result, x xor y)

test "BinaryTrie basic multiset operations":
  var tr = initBinaryTrie[int](maxLog = 4)

  check tr.empty()
  check tr.len == 0

  tr.insert(0)
  tr.insert(5)
  tr.insert(7)
  tr.insert(5)

  check not tr.empty()
  check tr.len == 4
  check 5 in tr
  check 6 notin tr
  check tr.count(5) == 2
  check tr.count(7) == 1

  check tr.minXor(2) == 2
  check tr.maxXor(2) == 7
  check tr.minElementXor(2) == 0
  check tr.maxElementXor(2) == 5

  tr.erase(5)

  check tr.len == 3
  check tr.count(5) == 1
  check 5 in tr

  tr.erase(5)

  check tr.len == 2
  check tr.count(5) == 0
  check 5 notin tr

test "BinaryTrie agrees with brute force":
  var tr = initBinaryTrie[int](maxLog = 4)
  var xs: seq[int] = @[]

  for x in @[0, 1, 1, 2, 7, 8, 15, 15, 15]:
    tr.insert(x)
    xs.add(x)

  for q in 0 .. 15:
    check tr.minXor(q) == bruteMinXor(xs, q)
    check tr.maxXor(q) == bruteMaxXor(xs, q)

  tr.erase(15)
  xs.delete(xs.find(15))

  for q in 0 .. 15:
    check tr.minXor(q) == bruteMinXor(xs, q)
    check tr.maxXor(q) == bruteMaxXor(xs, q)

test "BinaryTrie uint64":
  var tr = initBinaryTrie[uint64](maxLog = 5)

  tr.insert(1'u64)
  tr.insert(32'u64)
  tr.insert(63'u64)

  check tr.minXor(0'u64) == 1'u64
  check tr.maxXor(0'u64) == 63'u64
  check tr.maxXor(31'u64) == 63'u64 # 31 xor 32
