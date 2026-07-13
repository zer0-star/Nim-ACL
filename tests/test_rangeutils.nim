discard """
  cmd: "nim cpp -r -d:release $file"
"""

import atcoder/rangeutils
import atcoder/fenwicktree


template expectEndpoints(
    container,
    rangeValue,
    expectedL,
    expectedR: untyped
) =
  block:
    let (actualL, actualR) =
      container.halfOpenEndpoints(rangeValue)

    doAssert actualL == expectedL
    doAssert actualR == expectedR


block:
  let values =
    @[10, 20, 30, 40, 50, 60, 70, 80]

  let forwardClosed: Slice[int] =
    2 .. 4

  let forwardHalfOpen: Slice[int] =
    2 ..< 5

  let forwardBackwards:
      HSlice[int, BackwardsIndex] =
    2 .. ^1

  let backwardsBackwards:
      Slice[BackwardsIndex] =
    ^3 .. ^1

  let backwardsClosed:
      HSlice[BackwardsIndex, int] =
    ^3 .. 6

  let backwardsHalfOpen:
      HSlice[BackwardsIndex, int] =
    ^3 ..< 7

  let backwardsEmpty:
      HSlice[BackwardsIndex, int] =
    ^3 ..< 5

  let allByCaretZero:
      HSlice[int, BackwardsIndex] =
    0 ..< ^0

  let emptyAtEnd:
      Slice[BackwardsIndex] =
    ^0 ..< ^0

  let closedThroughCaretZero:
      HSlice[int, BackwardsIndex] =
    0 .. ^0

  let beforeStart:
      HSlice[BackwardsIndex, int] =
    ^9 .. 6

  expectEndpoints(values, forwardClosed, 2, 5)
  expectEndpoints(values, forwardHalfOpen, 2, 5)
  expectEndpoints(values, forwardBackwards, 2, 8)
  expectEndpoints(values, backwardsBackwards, 5, 8)
  expectEndpoints(values, backwardsClosed, 5, 7)
  expectEndpoints(values, backwardsHalfOpen, 5, 7)
  expectEndpoints(values, backwardsEmpty, 5, 5)

  expectEndpoints(values, allByCaretZero, 0, 8)
  expectEndpoints(values, emptyAtEnd, 8, 8)
  expectEndpoints(values, closedThroughCaretZero, 0, 9)
  expectEndpoints(values, beforeStart, -1, 7)

  doAssert halfOpenEndpoints(2 .. 4) == (2, 5)
  doAssert halfOpenEndpoints(2 ..< 2) == (2, 2)


block:
  let empty: seq[int] = @[]

  let allByCaretZero:
      HSlice[int, BackwardsIndex] =
    0 ..< ^0

  let emptyAtEnd:
      Slice[BackwardsIndex] =
    ^0 ..< ^0

  let closedThroughCaretZero:
      HSlice[int, BackwardsIndex] =
    0 .. ^0

  expectEndpoints(empty, allByCaretZero, 0, 0)
  expectEndpoints(empty, emptyAtEnd, 0, 0)
  expectEndpoints(empty, closedThroughCaretZero, 0, 1)


block:
  let maximumSafeClosed:
      Slice[int] =
    0 .. (high(int) - 1)

  doAssert halfOpenEndpoints(maximumSafeClosed) ==
    (0, high(int))


block:
  var tree = initFenwickTree[int](8)

  for i in 0 ..< 8:
    tree.add(i, i + 1)

  let backwardsClosed:
      HSlice[BackwardsIndex, int] =
    ^3 .. 6

  let backwardsHalfOpen:
      HSlice[BackwardsIndex, int] =
    ^3 ..< 7

  let backwardsEmpty:
      HSlice[BackwardsIndex, int] =
    ^3 ..< 5

  let allByCaretZero:
      HSlice[int, BackwardsIndex] =
    0 ..< ^0

  let emptyAtEnd:
      Slice[BackwardsIndex] =
    ^0 ..< ^0

  doAssert tree.sum(2 .. 4) == 12
  doAssert tree.sum(2 ..< 5) == 12
  doAssert tree.sum(2 .. ^1) == 33
  doAssert tree.sum(^3 .. ^1) == 21

  doAssert tree.sum(backwardsClosed) == 13
  doAssert tree.sum(backwardsHalfOpen) == 13
  doAssert tree.sum(backwardsEmpty) == 0

  doAssert tree.sum(allByCaretZero) == 36
  doAssert tree.sum(emptyAtEnd) == 0

  doAssert tree[backwardsClosed] == 13


echo "RANGEUTILS_CONTRACT_TEST_OK"
