import std/unittest

import atcoder/extra/math/min_plus_convolution


proc naiveMinPlusConvolution(
    left,
    right: openArray[int64],
): seq[int64] =
  if left.len == 0 or right.len == 0:
    return @[]

  result =
    newSeq[int64](
      left.len + right.len - 1
    )

  for index in 0 ..< result.len:
    var
      initialized = false
      best: int64

    for leftIndex in 0 ..< left.len:
      let rightIndex =
        index - leftIndex

      if rightIndex < 0 or
         rightIndex >= right.len:
        continue

      let candidate =
        left[leftIndex] +
        right[rightIndex]

      if not initialized or
         candidate < best:
        initialized = true
        best = candidate

    doAssert initialized
    result[index] = best


proc nextRandom(
    state: var uint64,
): uint64 =
  state =
    state xor (
      state shl 7
    )

  state =
    state xor (
      state shr 9
    )

  state =
    state xor (
      state shl 8
    )

  state


proc randomInt(
    state: var uint64,
    low,
    high: int64,
): int64 =
  doAssert low <= high

  low +
    int64(
      nextRandom(state) mod
      uint64(high - low + 1)
    )


proc randomConvexSequence(
    state: var uint64,
    length: int,
): seq[int64] =
  if length == 0:
    return @[]

  result =
    newSeq[int64](length)

  result[0] =
    randomInt(
      state,
      -20,
      20,
    )

  var slope =
    randomInt(
      state,
      -8,
      8,
    )

  for index in 1 ..< length:
    slope +=
      randomInt(
        state,
        0,
        4,
      )

    result[index] =
      result[index - 1] +
      slope


proc randomSequence(
    state: var uint64,
    length: int,
): seq[int64] =
  result =
    newSeq[int64](length)

  for value in result.mitems:
    value =
      randomInt(
        state,
        -30,
        30,
      )


suite "Min-plus convolution convex-arbitrary":
  test "known case":
    let
      convex =
        @[0'i64, 1, 3]

      arbitrary =
        @[5'i64, 2]

    check minPlusConvolutionConvexArbitrary(
      convex,
      arbitrary,
    ) == @[5'i64, 2, 3, 5]

  test "empty input":
    let
      empty: seq[int64] = @[]
      values = @[1'i64, 2]

    check minPlusConvolutionConvexArbitrary(
      empty,
      values,
    ).len == 0

    check minPlusConvolutionConvexArbitrary(
      values,
      empty,
    ).len == 0

  test "input preservation":
    let
      convex =
        @[2'i64, 1, 1, 2, 4]

      arbitrary =
        @[7'i64, -1, 3]

      convexBefore = convex
      arbitraryBefore = arbitrary

    discard minPlusConvolutionConvexArbitrary(
      convex,
      arbitrary,
    )

    check convex == convexBefore
    check arbitrary == arbitraryBefore

  test "invalid convex input":
    expect ValueError:
      discard minPlusConvolutionConvexArbitrary(
        @[0'i64, 2, 1],
        @[0'i64],
      )

  test "random differential":
    var state =
      0x6A09E667F3BCC909'u64

    for convexLength in 0 .. 14:
      for arbitraryLength in 0 .. 14:
        for repetition in 0 ..< 12:
          discard repetition

          let
            convex =
              randomConvexSequence(
                state,
                convexLength,
              )

            arbitrary =
              randomSequence(
                state,
                arbitraryLength,
              )

            expected =
              naiveMinPlusConvolution(
                convex,
                arbitrary,
              )

            actual =
              minPlusConvolutionConvexArbitrary(
                convex,
                arbitrary,
              )

          check actual == expected
