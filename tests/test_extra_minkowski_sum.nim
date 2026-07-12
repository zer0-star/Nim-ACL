import std/[
  algorithm,
  unittest,
]

import atcoder/extra/geometry/geometry
import atcoder/extra/geometry/minkowski_sum


proc pointI64(
    x,
    y: int64,
): Point2[int64] =
  initPoint(
    x,
    y,
  )


proc comparePoint(
    left,
    right: Point2[int64],
): int =
  result =
    cmp(
      left.re,
      right.re,
    )

  if result == 0:
    result =
      cmp(
        left.im,
        right.im,
      )


proc crossValue(
    origin,
    left,
    right: Point2[int64],
): int64 =
  let
    firstX =
      left.re -
      origin.re

    firstY =
      left.im -
      origin.im

    secondX =
      right.re -
      origin.re

    secondY =
      right.im -
      origin.im

  firstX * secondY -
    firstY * secondX


proc bruteHull(
    points: openArray[
      Point2[int64]
    ],
): seq[Point2[int64]] =
  var ordered =
    newSeq[
      Point2[int64]
    ](
      points.len
    )

  for index in 0 ..< points.len:
    ordered[index] =
      points[index]

  ordered.sort(
    comparePoint
  )

  var uniquePoints:
    seq[Point2[int64]]

  for value in ordered:
    if uniquePoints.len == 0 or
        uniquePoints[^1] != value:
      uniquePoints.add(value)

  if uniquePoints.len <= 1:
    return uniquePoints

  var lower:
    seq[Point2[int64]]

  for value in uniquePoints:
    while lower.len >= 2 and
        crossValue(
          lower[^2],
          lower[^1],
          value,
        ) <= 0:
      discard lower.pop()

    lower.add(value)

  var upper:
    seq[Point2[int64]]

  var index =
    uniquePoints.high

  while index >= 0:
    let value =
      uniquePoints[index]

    while upper.len >= 2 and
        crossValue(
          upper[^2],
          upper[^1],
          value,
        ) <= 0:
      discard upper.pop()

    upper.add(value)

    dec index

  discard lower.pop()
  discard upper.pop()

  result =
    lower & upper

  if result.len <= 1:
    return

  var best =
    0

  for index in 1 ..< result.len:
    if result[index].im <
        result[best].im or
        (
          result[index].im ==
          result[best].im and
          result[index].re <
          result[best].re
        ):
      best =
        index

  if best != 0:
    var rotated =
      newSeq[
        Point2[int64]
      ](
        result.len
      )

    for index in 0 ..< result.len:
      rotated[index] =
        result[
          (best + index) mod
          result.len
        ]

    result =
      rotated


proc bruteMinkowskiHull(
    left,
    right: openArray[
      Point2[int64]
    ],
): seq[Point2[int64]] =
  if left.len == 0 or
      right.len == 0:
    return newSeq[
      Point2[int64]
    ]()

  var sums:
    seq[Point2[int64]]

  for leftPoint in left:
    for rightPoint in right:
      sums.add(
        pointI64(
          leftPoint.re +
            rightPoint.re,
          leftPoint.im +
            rightPoint.im,
        )
      )

  bruteHull(sums)


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


suite "Minkowski sum":
  test "empty input":
    check minkowskiSum(
      newSeq[
        Point2[int64]
      ](),
      @[pointI64(0, 0)],
    ).len == 0

  test "translation by a point":
    let polygon =
      @[
        pointI64(0, 0),
        pointI64(2, 0),
        pointI64(0, 1),
      ]

    let translation =
      @[pointI64(3, -2)]

    check minkowskiSum(
      polygon,
      translation,
    ) == bruteMinkowskiHull(
      polygon,
      translation,
    )

  test "segments":
    let
      left =
        @[
          pointI64(0, 0),
          pointI64(3, 0),
        ]

      right =
        @[
          pointI64(0, 0),
          pointI64(0, 2),
        ]

    check minkowskiSum(
      left,
      right,
    ) == bruteMinkowskiHull(
      left,
      right,
    )

  test "known rectangles":
    let
      left =
        @[
          pointI64(0, 0),
          pointI64(1, 0),
          pointI64(1, 1),
          pointI64(0, 1),
        ]

      right =
        @[
          pointI64(-1, -2),
          pointI64(2, -2),
          pointI64(2, 3),
          pointI64(-1, 3),
        ]

    check minkowskiSum(
      left,
      right,
    ) == @[
      pointI64(-1, -2),
      pointI64(3, -2),
      pointI64(3, 4),
      pointI64(-1, 4),
    ]

  test "random differential and input preservation":
    var state =
      0x1f83_d9ab_fb41_bd6b'u64

    for leftCount in 1 .. 12:
      for rightCount in 1 .. 12:
        for _ in 0 ..< 24:
          var
            left =
              newSeq[
                Point2[int64]
              ](
                leftCount
              )

            right =
              newSeq[
                Point2[int64]
              ](
                rightCount
              )

          for index in 0 ..< left.len:
            left[index] =
              pointI64(
                int64(
                  nextRandom(state) mod 41'u64
                ) - 20,
                int64(
                  nextRandom(state) mod 41'u64
                ) - 20,
              )

          for index in 0 ..< right.len:
            right[index] =
              pointI64(
                int64(
                  nextRandom(state) mod 41'u64
                ) - 20,
                int64(
                  nextRandom(state) mod 41'u64
                ) - 20,
              )

          let
            leftBefore =
              left

            rightBefore =
              right

          check minkowskiSum(
            left,
            right,
          ) == bruteMinkowskiHull(
            left,
            right,
          )

          check left ==
            leftBefore

          check right ==
            rightBefore
