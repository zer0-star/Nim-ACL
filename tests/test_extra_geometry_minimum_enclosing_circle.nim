import std/[
  math,
  options,
  unittest,
]

import atcoder/extra/geometry/geometry
import atcoder/extra/geometry/minimum_enclosing_circle


const
  Epsilon = 1.0e-8


proc approximatelyEqual(
    left,
    right: float64,
    epsilon = Epsilon,
): bool =
  abs(left - right) <= epsilon


proc pointDistance(
    left,
    right: Point[float64],
): float64 =
  let
    dx = left.re - right.re
    dy = left.im - right.im

  sqrt(
    dx * dx +
    dy * dy
  )


proc coveredBy(
    value: Circle[float64],
    pointValue: Point[float64],
): bool =
  pointDistance(
    pointValue,
    value.p,
  ) <= value.r + Epsilon


proc circleFromPair(
    first,
    second: Point[float64],
): Circle[float64] =
  let center =
    initPoint[float64](
      (
        first.re +
        second.re
      ) / 2.0,
      (
        first.im +
        second.im
      ) / 2.0,
    )

  circle(
    center,
    pointDistance(
      first,
      center,
    ),
  )


proc circleFromTriple(
    first,
    second,
    third: Point[float64],
): Option[Circle[float64]] =
  let
    ax = first.re
    ay = first.im
    bx = second.re
    by = second.im
    cx = third.re
    cy = third.im

    denominator =
      2.0 * (
        ax * (by - cy) +
        bx * (cy - ay) +
        cx * (ay - by)
      )

  if abs(denominator) <= 1.0e-12:
    return none(Circle[float64])

  let
    aa = ax * ax + ay * ay
    bb = bx * bx + by * by
    cc = cx * cx + cy * cy

    center =
      initPoint[float64](
        (
          aa * (by - cy) +
          bb * (cy - ay) +
          cc * (ay - by)
        ) / denominator,
        (
          aa * (cx - bx) +
          bb * (ax - cx) +
          cc * (bx - ax)
        ) / denominator,
      )

  some(
    circle(
      center,
      pointDistance(
      first,
      center,
    ),
    )
  )


proc coversAll(
    value: Circle[float64],
    points: openArray[Point[float64]],
): bool =
  for pointValue in points:
    if not value.coveredBy(pointValue):
      return false

  true


proc bruteMinimumRadius(
    points: openArray[Point[float64]],
): float64 =
  if points.len == 0:
    return 0.0

  var best =
    Inf

  for pointValue in points:
    let candidate =
      circle(
        pointValue,
        0.0,
      )

    if candidate.coversAll(points):
      best =
        min(
          best,
          candidate.r,
        )

  for first in 0 ..< points.len:
    for second in first + 1 ..< points.len:
      let candidate =
        circleFromPair(
          points[first],
          points[second],
        )

      if candidate.coversAll(points):
        best =
          min(
            best,
            candidate.r,
          )

  for first in 0 ..< points.len:
    for second in first + 1 ..< points.len:
      for third in second + 1 ..< points.len:
        let candidate =
          circleFromTriple(
            points[first],
            points[second],
            points[third],
          )

        if candidate.isSome and
           candidate.get().coversAll(points):
          best =
            min(
              best,
              candidate.get().r,
            )

  best


proc nextRandom(
    state: var uint64,
): uint64 =
  state = state xor (state shl 7)
  state = state xor (state shr 9)
  state = state xor (state shl 8)
  state


proc randomCoordinate(
    state: var uint64,
): float64 =
  float64(
    int64(
      nextRandom(state) mod 41
    ) - 20
  )


suite "Minimum enclosing circle":
  test "empty input":
    let points: seq[Point[float64]] = @[]

    check minimumEnclosingCircle(points).isNone

  test "singleton and duplicates":
    let
      singleton =
        @[initPoint[float64](3.0, -2.0)]

      duplicated =
        @[
          initPoint[float64](1.0, 1.0),
          initPoint[float64](1.0, 1.0),
          initPoint[float64](1.0, 1.0),
        ]

    let singletonCircle =
      minimumEnclosingCircle(singleton)

    check singletonCircle.isSome
    check approximatelyEqual(
      singletonCircle.get().p.re,
      3.0,
    )
    check approximatelyEqual(
      singletonCircle.get().p.im,
      -2.0,
    )
    check approximatelyEqual(
      singletonCircle.get().r,
      0.0,
    )

    let duplicateCircle =
      minimumEnclosingCircle(duplicated)

    check duplicateCircle.isSome
    check approximatelyEqual(
      duplicateCircle.get().r,
      0.0,
    )

  test "known right triangle":
    let points =
      @[
        initPoint[float64](0.0, 0.0),
        initPoint[float64](2.0, 0.0),
        initPoint[float64](0.0, 2.0),
      ]

    let answer =
      minimumEnclosingCircle(points)

    check answer.isSome
    check approximatelyEqual(answer.get().p.re, 1.0)
    check approximatelyEqual(answer.get().p.im, 1.0)
    check approximatelyEqual(answer.get().r, sqrt(2.0))

  test "collinear and obtuse":
    let
      collinear =
        @[
          initPoint[float64](-2.0, 0.0),
          initPoint[float64](1.0, 0.0),
          initPoint[float64](4.0, 0.0),
        ]

      obtuse =
        @[
          initPoint[float64](0.0, 0.0),
          initPoint[float64](6.0, 0.0),
          initPoint[float64](1.0, 1.0),
        ]

    let lineCircle =
      minimumEnclosingCircle(collinear)

    check lineCircle.isSome
    check approximatelyEqual(lineCircle.get().p.re, 1.0)
    check approximatelyEqual(lineCircle.get().r, 3.0)

    let obtuseCircle =
      minimumEnclosingCircle(obtuse)

    check obtuseCircle.isSome
    check approximatelyEqual(obtuseCircle.get().p.re, 3.0)
    check approximatelyEqual(obtuseCircle.get().p.im, 0.0)
    check approximatelyEqual(obtuseCircle.get().r, 3.0)

  test "input preservation and deterministic result":
    let points =
      @[
        initPoint[float64](-3.0, 2.0),
        initPoint[float64](5.0, -1.0),
        initPoint[float64](1.0, 6.0),
        initPoint[float64](0.0, 0.0),
      ]

    let before = points
    let first = minimumEnclosingCircle(points)
    let second = minimumEnclosingCircle(points)

    check points == before
    check first.isSome
    check second.isSome

    check approximatelyEqual(
      first.get().p.re,
      second.get().p.re,
      1.0e-12,
    )

    check approximatelyEqual(
      first.get().p.im,
      second.get().p.im,
      1.0e-12,
    )

    check approximatelyEqual(
      first.get().r,
      second.get().r,
      1.0e-12,
    )

  test "random differential":
    var state =
      0x243F6A8885A308D3'u64

    for length in 1 .. 8:
      for repetition in 0 ..< 30:
        discard repetition

        var points =
          newSeq[Point[float64]](length)

        for pointValue in points.mitems:
          pointValue =
            initPoint[float64](
              randomCoordinate(state),
              randomCoordinate(state),
            )

        let answer =
          minimumEnclosingCircle(points)

        check answer.isSome
        check answer.get().coversAll(points)

        let bruteRadius =
          bruteMinimumRadius(points)

        check approximatelyEqual(
          answer.get().r,
          bruteRadius,
          1.0e-7,
        )
