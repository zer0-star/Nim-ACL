when not declared ATCODER_EXTRA_GEOMETRY_MINKOWSKI_SUM_HPP:
  const
    ATCODER_EXTRA_GEOMETRY_MINKOWSKI_SUM_HPP* = 1

  import std/algorithm

  import atcoder/extra/geometry/geometry


  proc makePoint[T](
      x,
      y: T,
  ): Point2[T] {.inline.} =
    initPoint(
      x,
      y,
    )


  proc addPoint[T](
      left,
      right: Point2[T],
  ): Point2[T] {.inline.} =
    makePoint(
      left.re + right.re,
      left.im + right.im,
    )


  proc subtractPoint[T](
      left,
      right: Point2[T],
  ): Point2[T] {.inline.} =
    makePoint(
      left.re - right.re,
      left.im - right.im,
    )


  proc crossValue[T](
      left,
      right: Point2[T],
  ): T {.inline.} =
    left.re * right.im -
      left.im * right.re


  proc crossValue[T](
      origin,
      left,
      right: Point2[T],
  ): T {.inline.} =
    crossValue(
      subtractPoint(
        left,
        origin,
      ),
      subtractPoint(
        right,
        origin,
      ),
    )


  proc compareMinkowskiPoint[T](
      left,
      right: Point2[T],
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


  proc normalizePointHull[T](
      points: openArray[
        Point2[T]
      ],
  ): seq[Point2[T]] =
    var ordered =
      newSeq[
        Point2[T]
      ](
        points.len
      )

    for index in 0 ..< points.len:
      ordered[index] =
        points[index]

    ordered.sort(
      compareMinkowskiPoint[T]
    )

    var uniquePoints:
      seq[Point2[T]]

    for point in ordered:
      if uniquePoints.len == 0 or
          uniquePoints[^1] != point:
        uniquePoints.add(point)

    if uniquePoints.len <= 1:
      return uniquePoints

    let zero =
      default(T)

    var lower:
      seq[Point2[T]]

    for point in uniquePoints:
      while lower.len >= 2 and
          crossValue(
            lower[^2],
            lower[^1],
            point,
          ) <= zero:
        discard lower.pop()

      lower.add(point)

    var upper:
      seq[Point2[T]]

    var index =
      uniquePoints.high

    while index >= 0:
      let point =
        uniquePoints[index]

      while upper.len >= 2 and
          crossValue(
            upper[^2],
            upper[^1],
            point,
          ) <= zero:
        discard upper.pop()

      upper.add(point)

      dec index

    discard lower.pop()
    discard upper.pop()

    result =
      lower & upper


  proc rotateToLowest[T](
      polygon: var seq[
        Point2[T]
      ],
  ) =
    if polygon.len <= 1:
      return

    var best =
      0

    for index in 1 ..< polygon.len:
      if polygon[index].im <
          polygon[best].im or
          (
            polygon[index].im ==
            polygon[best].im and
            polygon[index].re <
            polygon[best].re
          ):
        best =
          index

    if best == 0:
      return

    var rotated =
      newSeq[
        Point2[T]
      ](
        polygon.len
      )

    for index in 0 ..< polygon.len:
      rotated[index] =
        polygon[
          (best + index) mod
          polygon.len
        ]

    polygon =
      rotated


  proc polygonEdges[T](
      polygon: openArray[
        Point2[T]
      ],
  ): seq[Point2[T]] =
    result =
      newSeq[
        Point2[T]
      ](
        polygon.len
      )

    for index in 0 ..< polygon.len:
      result[index] =
        subtractPoint(
          polygon[
            (index + 1) mod
            polygon.len
          ],
          polygon[index],
        )


  proc angleHalf[T](
      vector: Point2[T],
  ): int {.inline.} =
    let zero =
      default(T)

    if vector.im > zero or
        (
          vector.im == zero and
          vector.re >= zero
        ):
      0
    else:
      1


  proc compareEdgeAngle[T](
      left,
      right: Point2[T],
  ): int {.inline.} =
    result =
      cmp(
        angleHalf(left),
        angleHalf(right),
      )

    if result != 0:
      return

    let value =
      crossValue(
        left,
        right,
      )

    let zero =
      default(T)

    if value > zero:
      result =
        -1

    elif value < zero:
      result =
        1


  proc minkowskiSum*[T](
      leftInput,
      rightInput: openArray[
        Point2[T]
      ],
  ): seq[Point2[T]] =
    ## Returns the Minkowski sum of the convex hulls of two point sets.
    ##
    ## The result is a strict counterclockwise convex polygon. Its first
    ## vertex has the smallest y-coordinate and then the smallest x-coordinate.

    if leftInput.len == 0 or
        rightInput.len == 0:
      return newSeq[
        Point2[T]
      ]()

    var
      left =
        normalizePointHull(
          leftInput
        )

      right =
        normalizePointHull(
          rightInput
        )

    if left.len == 1:
      result =
        newSeq[
          Point2[T]
        ](
          right.len
        )

      for index, point in right:
        result[index] =
          addPoint(
            left[0],
            point,
          )

      result.rotateToLowest()
      return

    if right.len == 1:
      result =
        newSeq[
          Point2[T]
        ](
          left.len
        )

      for index, point in left:
        result[index] =
          addPoint(
            point,
            right[0],
          )

      result.rotateToLowest()
      return

    left.rotateToLowest()
    right.rotateToLowest()

    let
      leftEdges =
        polygonEdges(left)

      rightEdges =
        polygonEdges(right)

    var
      leftIndex =
        0

      rightIndex =
        0

      current =
        addPoint(
          left[0],
          right[0],
        )

    result.add(current)

    while leftIndex < leftEdges.len or
        rightIndex < rightEdges.len:
      var edge:
        Point2[T]

      if leftIndex ==
          leftEdges.len:
        edge =
          rightEdges[rightIndex]

        inc rightIndex

      elif rightIndex ==
          rightEdges.len:
        edge =
          leftEdges[leftIndex]

        inc leftIndex

      else:
        let order =
          compareEdgeAngle(
            leftEdges[leftIndex],
            rightEdges[rightIndex],
          )

        if order < 0:
          edge =
            leftEdges[leftIndex]

          inc leftIndex

        elif order > 0:
          edge =
            rightEdges[rightIndex]

          inc rightIndex

        else:
          edge =
            addPoint(
              leftEdges[leftIndex],
              rightEdges[rightIndex],
            )

          inc leftIndex
          inc rightIndex

      current =
        addPoint(
          current,
          edge,
        )

      result.add(current)

    if result.len > 1 and
        result[^1] == result[0]:
      discard result.pop()

    result =
      normalizePointHull(
        result
      )

    result.rotateToLowest()
