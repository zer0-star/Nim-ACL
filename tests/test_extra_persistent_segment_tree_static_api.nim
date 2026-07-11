discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, unittest]

import atcoder/extra/structure/persistent_segment_tree

proc pstTestSumOp9281(
  left,
  right: int
): int =
  left + right

proc pstTestZero9281(): int =
  0

proc pstTestConcatOp9281(
  left,
  right: string
): string =
  left & right

proc pstTestEmpty9281(): string =
  ""

test "standard-style static monoid API":
  var tree = initPersistentSegmentTree(
    @[1, 2, 3, 4],
    pstTestSumOp9281,
    pstTestZero9281,
    expectedUpdates = 8,
  )

  let
    version0 = tree.initialVersion
    version1 = tree.set(
      1,
      20,
      version0,
    )
    version2 = tree.set(
      ^1,
      40,
      version1,
    )

  check tree.toSeq(version0) ==
    @[1, 2, 3, 4]

  check tree.toSeq(version1) ==
    @[1, 20, 3, 4]

  check tree.toSeq(version2) ==
    @[1, 20, 3, 40]

  check tree.get(1, version0) == 2
  check tree.get(1, version1) == 20
  check tree.get(^1, version2) == 40

  check tree.prod(
    0 ..< 4,
    version0,
  ) == 10

  check tree.prod(
    1 .. ^1,
    version2,
  ) == 63

  check tree.prod(
    1,
    4,
    version2,
  ) == 63

  check tree.all_prod(version0) == 10
  check tree.allProd(version2) == 64


test "direct static tuple generic style":
  var tree =
    PersistentSegTree[
      int,
      (
        op: pstTestSumOp9281,
        e: pstTestZero9281,
      ),
    ].init(
      @[2, 4, 6, 8],
      expectedUpdates = 4,
    )

  let
    version0 = tree.initialVersion
    version1 = tree.set(
      2,
      60,
      version0,
    )

  check tree.prod(
    0 ..< 4,
    version0,
  ) == 20

  check tree.prod(
    1 ..< 4,
    version1,
  ) == 72

  check tree.get(
    2,
    version0,
  ) == 6

  check tree.get(
    2,
    version1,
  ) == 60

test "explicit PersistentSegTreeType":
  var tree =
    PersistentSegTreeType[int](
      pstTestSumOp9281,
      pstTestZero9281,
    ).init(
      5,
      expectedUpdates = 2,
    )

  let
    version0 = tree.initialVersion
    version1 = tree.set(
      2,
      7,
      version0,
    )

  check tree.toSeq(version0) ==
    @[0, 0, 0, 0, 0]

  check tree.toSeq(version1) ==
    @[0, 0, 7, 0, 0]

test "noncommutative static monoid":
  var tree = initPersistentSegmentTree(
    @["a", "b", "c", "d"],
    pstTestConcatOp9281,
    pstTestEmpty9281,
  )

  let
    version0 = tree.initialVersion
    version1 = tree.set(
      1,
      "X",
      version0,
    )

  check tree.prod(
    0 ..< 4,
    version0,
  ) == "abcd"

  check tree.prod(
    1 ..< 4,
    version0,
  ) == "bcd"

  check tree.prod(
    0 ..< 4,
    version1,
  ) == "aXcd"

test "small expectedUpdates does not affect correctness":
  const UpdateCount = 200

  var tree = initPersistentSegmentTree(
    32,
    pstTestSumOp9281,
    pstTestZero9281,
    expectedUpdates = 0,
  )

  var version = tree.initialVersion

  for step in 0 ..< UpdateCount:
    version = tree.set(
      step mod 32,
      step + 1,
      version,
    )

  check tree.nodeCount > 0

  for position in 0 ..< 32:
    check tree.get(
      position,
      version,
    ) > 0

test "randomized version differential":
  var rng = initRand(
    20260711
  )

  for caseId in 0 ..< 120:
    discard caseId

    let
      length = rand(
        rng,
        1 .. 24,
      )
      updateCount = rand(
        rng,
        20 .. 80,
      )

    var initial = newSeq[int](
      length
    )

    for position in 0 ..< length:
      initial[position] = rand(
        rng,
        -30 .. 30,
      )

    var tree = initPersistentSegmentTree(
      initial,
      pstTestSumOp9281,
      pstTestZero9281,
      expectedUpdates = updateCount div 3,
    )

    var
      versions = @[
        tree.initialVersion
      ]
      snapshots = @[
        initial
      ]

    for step in 0 ..< updateCount:
      discard step

      let
        base = rand(
          rng,
          0 .. versions.high,
        )
        position = rand(
          rng,
          0 ..< length,
        )
        value = rand(
          rng,
          -100 .. 100,
        )

      var next = snapshots[base]
      next[position] = value

      let nextVersion = tree.set(
        position,
        value,
        versions[base],
      )

      versions.add nextVersion
      snapshots.add next

      let queryVersion = rand(
        rng,
        0 .. versions.high,
      )

      let left = rand(
        rng,
        0 .. length,
      )

      let right = rand(
        rng,
        left .. length,
      )

      var expected = 0

      for index in left ..< right:
        expected += snapshots[
          queryVersion
        ][index]

      check tree.prod(
        left,
        right,
        versions[queryVersion],
      ) == expected

      let point = rand(
        rng,
        0 ..< length,
      )

      check tree.get(
        point,
        versions[queryVersion],
      ) == snapshots[
        queryVersion
      ][point]
