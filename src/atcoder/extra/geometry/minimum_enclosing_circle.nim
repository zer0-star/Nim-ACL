import std/[
  math,
  options,
]

import atcoder/extra/geometry/geometry


type
  MecCircle = object
    center: Point[float64]
    radiusSquared: float64

proc mecPoint(
    x,
    y: float64,
): Point[float64] {.inline.} =
  initPoint[float64](
    x,
    y,
  )


proc squaredDistance(
    left,
    right: Point[float64],
): float64 {.inline.} =
  let
    dx =
      left.re - right.re

    dy =
      left.im - right.im

  dx * dx + dy * dy


proc contains(
    circle: MecCircle,
    value: Point[float64],
): bool {.inline.} =
  if circle.radiusSquared < 0.0:
    return false

  let tolerance =
    1.0e-9 *
    max(
      1.0,
      circle.radiusSquared,
    )

  squaredDistance(
    circle.center,
    value,
  ) <= circle.radiusSquared + tolerance


proc circleFromPoint(
    value: Point[float64],
): MecCircle {.inline.} =
  MecCircle(
    center: value,
    radiusSquared: 0.0,
  )


proc circleFromPair(
    left,
    right: Point[float64],
): MecCircle =
  result.center =
    mecPoint(
      (left.re + right.re) / 2.0,
      (left.im + right.im) / 2.0,
    )

  result.radiusSquared =
    squaredDistance(
      result.center,
      left,
    )


proc circleFromFarthestPair(
    first,
    second,
    third: Point[float64],
): MecCircle =
  let
    firstSecond =
      squaredDistance(
        first,
        second,
      )

    firstThird =
      squaredDistance(
        first,
        third,
      )

    secondThird =
      squaredDistance(
        second,
        third,
      )

  if firstSecond >= firstThird and
      firstSecond >= secondThird:
    result =
      circleFromPair(
        first,
        second,
      )

  elif firstThird >= secondThird:
    result =
      circleFromPair(
        first,
        third,
      )

  else:
    result =
      circleFromPair(
        second,
        third,
      )


proc circleFromTriple(
    first,
    second,
    third: Point[float64],
): MecCircle =
  let denominator =
    2.0 * (
      first.re *
        (second.im - third.im) +
      second.re *
        (third.im - first.im) +
      third.re *
        (first.im - second.im)
    )

  if abs(denominator) <= 1.0e-12:
    return circleFromFarthestPair(
      first,
      second,
      third,
    )

  let
    firstNorm =
      first.re * first.re +
      first.im * first.im

    secondNorm =
      second.re * second.re +
      second.im * second.im

    thirdNorm =
      third.re * third.re +
      third.im * third.im

  result.center =
    mecPoint(
      (
        firstNorm *
          (second.im - third.im) +
        secondNorm *
          (third.im - first.im) +
        thirdNorm *
          (first.im - second.im)
      ) / denominator,
      (
        firstNorm *
          (third.re - second.re) +
        secondNorm *
          (first.re - third.re) +
        thirdNorm *
          (second.re - first.re)
      ) / denominator,
    )

  result.radiusSquared =
    squaredDistance(
      result.center,
      first,
    )


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


proc minimumEnclosingCircleSquared(
    values: openArray[Point[float64]],
): Option[MecCircle] =
  if values.len == 0:
    return none(MecCircle)

  var ordered =
    newSeq[Point[float64]](values.len)

  for index in 0 ..< values.len:
    ordered[index] =
      values[index]

  var state =
    0x9e37_79b9_7f4a_7c15'u64 xor
    uint64(values.len)

  var index =
    ordered.high

  while index > 0:
    let other =
      int(
        nextRandom(state) mod
        uint64(index + 1)
      )

    swap(
      ordered[index],
      ordered[other],
    )

    dec index

  var circle =
    MecCircle(
      radiusSquared: -1.0,
    )

  for firstIndex in 0 ..< ordered.len:
    if circle.contains(
        ordered[firstIndex]
    ):
      continue

    circle =
      circleFromPoint(
        ordered[firstIndex]
      )

    for secondIndex in 0 ..< firstIndex:
      if circle.contains(
          ordered[secondIndex]
      ):
        continue

      circle =
        circleFromPair(
          ordered[firstIndex],
          ordered[secondIndex],
        )

      for thirdIndex in 0 ..< secondIndex:
        if circle.contains(
            ordered[thirdIndex]
        ):
          continue

        circle =
          circleFromTriple(
            ordered[firstIndex],
            ordered[secondIndex],
            ordered[thirdIndex],
          )

  some(circle)
proc minimumEnclosingCircle*(
    points: openArray[Point[float64]],
): Option[Circle[float64]] =
  ## Returns the minimum circle containing all input points.
  ##
  ## The input sequence is preserved.
  ## Empty input returns `none`.
  ## This initial interface uses `float64` geometry.
  let internal =
    minimumEnclosingCircleSquared(points)

  if internal.isNone:
    return none(Circle[float64])

  let value =
    internal.get()

  some(
    circle(
      value.center,
      sqrt(
        max(
          0.0,
          value.radiusSquared,
        )
      ),
    )
  )
