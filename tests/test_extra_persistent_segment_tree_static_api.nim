import std/[
  sequtils,
  unittest,
]

import atcoder/extra/structure/persistent_segment_tree


proc sumOp(
    left,
    right: int,
): int {.inline.} =
  left + right


proc sumE(): int {.inline.} =
  0


proc concatOp(
    left,
    right: string,
): string {.inline.} =
  left & right


proc concatE(): string {.inline.} =
  ""


type
  SumPersistentTree =
    PersistentSegTreeType[int](
      sumOp,
      sumE,
    )

  StringPersistentTree =
    PersistentSegTreeType[string](
      concatOp,
      concatE,
    )


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state = state xor (state shl 7)
  state = state xor (state shr 9)
  state = state xor (state shl 8)
  state


suite "PersistentSegTree version-first API":
  test "initialization and version-first operations":
    var tree =
      SumPersistentTree.init(
        @[1, 2, 3, 4],
        expectedUpdates = 8,
      )

    let version0 =
      tree.initialVersion

    let version1 =
      tree.set(
        version0,
        1,
        20,
      )

    check tree.get(
      version0,
      1,
    ) == 2

    check tree.get(
      version1,
      1,
    ) == 20

    check tree.prod(
      version0,
      0 .. 3,
    ) == 10

    check tree.prod(
      version1,
      0,
      4,
    ) == 28

    check tree.allProd(
      version0
    ) == 10

    check tree.allProd(
      version1
    ) == 28

    check tree.toSeq(
      version0
    ) == @[1, 2, 3, 4]

    check tree.toSeq(
      version1
    ) == @[1, 20, 3, 4]

  test "flat and nested indexing":
    var tree =
      SumPersistentTree.init(
        4,
        expectedUpdates = 8,
      )

    let zeroVersion =
      tree.initialVersion

    var version =
      zeroVersion

    tree[version, 1] = 5

    check tree[
      version,
      1,
    ] == 5

    check tree[
      version,
      0 .. 3,
    ] == 5

    tree[version][3] = 9

    check tree[version][3] == 9
    check tree[version][0 .. 3] == 14

    check tree[zeroVersion][1] == 0
    check tree[zeroVersion][3] == 0

  test "stored write view updates its version":
    var tree =
      SumPersistentTree.init(
        3,
        expectedUpdates = 4,
      )

    let version0 =
      tree.initialVersion

    var version =
      version0

    var view =
      tree[version]

    view[2] = 7

    check tree[version][2] == 7
    check tree[version0][2] == 0

  test "persistent branches remain independent":
    var tree =
      SumPersistentTree.init(
        4,
        expectedUpdates = 16,
      )

    let version0 =
      tree.initialVersion

    var firstBranch =
      version0

    tree[firstBranch][2] = 7

    var secondBranch =
      firstBranch

    tree[secondBranch][0] = 4

    check tree[firstBranch][0] == 0
    check tree[firstBranch][2] == 7

    check tree[secondBranch][0] == 4
    check tree[secondBranch][2] == 7

    check tree[version0][0 .. 3] == 0

  test "noncommutative operation":
    var tree =
      StringPersistentTree.init(
        @["a", "b", "c"],
        expectedUpdates = 2,
      )

    let version0 =
      tree.initialVersion

    let version1 =
      tree.set(
        version0,
        1,
        "X",
      )

    check tree.prod(
      version0,
      0 .. 2,
    ) == "abc"

    check tree.prod(
      version1,
      0 .. 2,
    ) == "aXc"

  test "multiple anonymous monoids remain distinct":
    type
      AnonymousSumTree =
        PersistentSegTreeType[int](
          proc(
              left,
              right: int,
          ): int =
            left + right,

          proc(): int =
            0,
        )

      AnonymousMaxTree =
        PersistentSegTreeType[int](
          proc(
              left,
              right: int,
          ): int =
            max(left, right),

          proc(): int =
            low(int),
        )

    var
      sumTree =
        AnonymousSumTree.init(
          @[2, 3, 5]
        )

      maxTree =
        AnonymousMaxTree.init(
          @[2, 3, 5]
        )

    check sumTree.allProd(
      sumTree.initialVersion
    ) == 10

    check maxTree.allProd(
      maxTree.initialVersion
    ) == 5

  test "shorthand constructors":
    var sequenceTree =
      initPersistentSegmentTree(
        @[1, 2, 3],
        sumOp,
        sumE,
        expectedUpdates = 4,
      )

    check sequenceTree.allProd(
      sequenceTree.initialVersion
    ) == 6

    var lengthTree =
      initPersistentSegmentTree(
        4,
        sumOp,
        sumE,
        expectedUpdates = 4,
      )

    var version =
      lengthTree.initialVersion

    lengthTree[version][2] = 7

    check lengthTree.allProd(
      version
    ) == 7

  test "randomized version differential":
    const
      Length = 16
      OperationCount = 300

    var tree =
      SumPersistentTree.init(
        Length,
        expectedUpdates = OperationCount,
      )

    var
      versions =
        @[tree.initialVersion]

      models =
        @[newSeq[int](Length)]

      state =
        0xa75b_91c3_4d2e_f680'u64

    for _ in 0 ..< OperationCount:
      let base =
        int(
          nextRandom(state) mod uint64(versions.len)
        )

      var
        version =
          versions[base]

        model =
          models[base].toSeq

      let position =
        int(
          nextRandom(state) mod uint64(Length)
        )

      let value =
        int(
          nextRandom(state) mod 1000'u64
        )

      tree[version][position] = value
      model[position] = value

      versions.add(version)
      models.add(model)

      let queryVersion =
        int(
          nextRandom(state) mod uint64(versions.len)
        )

      let left =
        int(
          nextRandom(state) mod uint64(Length)
        )

      let right =
        left + int(
          nextRandom(state) mod uint64(Length - left)
        )

      var expected = 0

      for index in left .. right:
        expected +=
          models[queryVersion][index]

      check tree[
        versions[queryVersion]
      ][left .. right] == expected

      check tree.toSeq(
        versions[queryVersion]
      ) == models[queryVersion]
