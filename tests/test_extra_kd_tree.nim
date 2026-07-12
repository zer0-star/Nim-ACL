import std/[
  options,
  unittest,
]

import atcoder/extra/structure/kd_tree


proc bruteSquaredDistance[
    D: static[int],
](
    left,
    right: KDPoint[D, int64],
): int64 =
  for dimension in 0 ..< D:
    let difference =
      left[dimension] -
      right[dimension]

    result +=
      difference * difference


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state =
    state xor (state shl 7)

  state =
    state xor (state shr 9)

  state =
    state xor (state shl 8)

  state


suite "KD-tree":
  test "empty tree":
    let tree =
      initKDTree(
        newSeq[
          KDPoint[2, int64]
        ]()
      )

    check tree.len == 0

    check tree.nearest(
      [0'i64, 0]
    ).isNone

    check tree.rangeSearch(
      [-10'i64, -10],
      [10'i64, 10],
    ).len == 0

  test "known nearest point and duplicate tie":
    let points:
      seq[KDPoint[2, int64]] =
        @[
          [3'i64, 4],
          [3'i64, 4],
          [10'i64, 10],
          [-2'i64, 1],
        ]

    let tree =
      initKDTree(points)

    let answer =
      tree.nearest(
        [3'i64, 4]
      ).get

    check answer.index == 0
    check answer.squaredDistance == 0

    let other =
      tree.nearest(
        [-1'i64, 1]
      ).get

    check other.index == 3
    check other.squaredDistance == 1

  test "half-open orthogonal range":
    let points:
      seq[KDPoint[2, int64]] =
        @[
          [0'i64, 0],
          [1'i64, 1],
          [2'i64, 2],
          [3'i64, 3],
        ]

    let tree =
      initKDTree(points)

    check tree.rangeSearch(
      [1'i64, 1],
      [3'i64, 3],
    ) == @[1, 2]

    check tree.rangeSearch(
      [2'i64, 2],
      [2'i64, 4],
    ).len == 0

    expect ValueError:
      discard tree.rangeSearch(
        [3'i64, 0],
        [2'i64, 4],
      )

  test "random differential and input preservation":
    var state =
      0x510e_527f_ade6_82d1'u64

    for pointCount in 0 .. 80:
      for _ in 0 ..< 8:
        var points =
          newSeq[
            KDPoint[2, int64]
          ](
            pointCount
          )

        for index in 0 ..< pointCount:
          points[index] =
            [
              int64(
                nextRandom(state) mod 101'u64
              ) - 50,
              int64(
                nextRandom(state) mod 101'u64
              ) - 50,
            ]

        let original =
          points

        let tree =
          initKDTree(points)

        check points ==
          original

        check tree.len ==
          pointCount

        for _ in 0 ..< 16:
          let query:
            KDPoint[2, int64] =
              [
                int64(
                  nextRandom(state) mod 121'u64
                ) - 60,
                int64(
                  nextRandom(state) mod 121'u64
                ) - 60,
              ]

          if points.len == 0:
            check tree.nearest(
              query
            ).isNone

          else:
            var
              bestIndex =
                0

              bestDistance =
                bruteSquaredDistance(
                  points[0],
                  query,
                )

            for index in 1 ..< points.len:
              let distance =
                bruteSquaredDistance(
                  points[index],
                  query,
                )

              if distance < bestDistance or
                  (
                    distance == bestDistance and
                    index < bestIndex
                  ):
                bestIndex =
                  index

                bestDistance =
                  distance

            let answer =
              tree.nearest(
                query
              ).get

            check answer.index ==
              bestIndex

            check answer.squaredDistance ==
              bestDistance

          let
            x1 =
              int64(
                nextRandom(state) mod 121'u64
              ) - 60

            x2 =
              int64(
                nextRandom(state) mod 121'u64
              ) - 60

            y1 =
              int64(
                nextRandom(state) mod 121'u64
              ) - 60

            y2 =
              int64(
                nextRandom(state) mod 121'u64
              ) - 60

            lower:
              KDPoint[2, int64] =
                [
                  min(x1, x2),
                  min(y1, y2),
                ]

            upper:
              KDPoint[2, int64] =
                [
                  max(x1, x2) + 1,
                  max(y1, y2) + 1,
                ]

          var expected:
            seq[int]

          for index, point in points:
            if lower[0] <= point[0] and
                point[0] < upper[0] and
                lower[1] <= point[1] and
                point[1] < upper[1]:
              expected.add(index)

          check tree.rangeSearch(
            lower,
            upper,
          ) == expected
