discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/algorithm/coordinate_compression

test "CoordinateCompression basic":
  let
    a = @[100, -5, 100, 7, -5, 42]
    cc = initCoordinateCompression(a)

  check cc.values == @[-5, 7, 42, 100]
  check cc.len == 4
  check not cc.empty

  check cc.encode(-5) == 0
  check cc.encode(7) == 1
  check cc.encode(42) == 2
  check cc.encode(100) == 3

  check cc.indexOf(8) == -1
  check 42 in cc
  check 8 notin cc

  check cc.compress(a) == @[3, 0, 3, 1, 0, 2]
  check cc.restore(@[3, 0, 1, 2]) == @[100, -5, 7, 42]

test "CoordinateCompression bounds":
  let cc = initCoordinateCompression(@[10, 20, 40])

  check cc.lowerBoundIndex(5) == 0
  check cc.lowerBoundIndex(10) == 0
  check cc.lowerBoundIndex(11) == 1
  check cc.lowerBoundIndex(50) == 3

  check cc.upperBoundIndex(5) == 0
  check cc.upperBoundIndex(10) == 1
  check cc.upperBoundIndex(20) == 2
  check cc.upperBoundIndex(50) == 3

test "CoordinateCompression strings":
  let cc = initCoordinateCompression(@["pear", "apple", "pear", "orange"])

  check cc.values == @["apple", "orange", "pear"]
  check cc.compress(@["pear", "apple"]) == @[2, 0]
  check cc.decode(1) == "orange"

test "CoordinateCompression empty":
  let cc = initCoordinateCompression(newSeq[int]())

  check cc.empty
  check cc.len == 0
  check cc.lowerBoundIndex(10) == 0
  check cc.upperBoundIndex(10) == 0
