discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/algorithm/run_length_encoding

test "run-length encode string":
  let runs = runLengthEncode("aaabbcaaaa")

  check runs == @[
    (value: 'a', count: 3),
    (value: 'b', count: 2),
    (value: 'c', count: 1),
    (value: 'a', count: 4),
  ]

  check runs.compressedLength == 4
  check runs.originalLength == 10
  check runLengthDecodeString(runs) == "aaabbcaaaa"

test "run-length encode generic sequence":
  let runs = rle(@[1, 1, 2, 3, 3, 3, 2])

  check runs == @[
    (value: 1, count: 2),
    (value: 2, count: 1),
    (value: 3, count: 3),
    (value: 2, count: 1),
  ]

  check runLengthDecode(runs) == @[1, 1, 2, 3, 3, 3, 2]

test "run-length encode empty":
  let
    stringRuns = runLengthEncode("")
    integerRuns = runLengthEncode(newSeq[int]())

  check stringRuns.len == 0
  check integerRuns.len == 0
  check runLengthDecodeString(stringRuns) == ""
  check runLengthDecode(integerRuns).len == 0
