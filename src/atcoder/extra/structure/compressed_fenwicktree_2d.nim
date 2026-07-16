when not declared ATCODER_EXTRA_STRUCTURE_COMPRESSED_FENWICKTREE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_COMPRESSED_FENWICKTREE_2D_HPP* = 1

  import std/algorithm
  import atcoder/extra/monoid/monoid

  type
    CompressedFenwickPoint2D* =
      tuple[
        x,
        y: int
      ]

    CompressedFenwickTree2D*[
        CG: CommutativeGroup
    ] = object
      registeredPoints:
        seq[CompressedFenwickPoint2D]

      xCoordinates:
        seq[int]

      yCoordinates:
        seq[seq[int]]

      data:
        seq[seq[CG.value_type]]

      pointValues:
        seq[CG.value_type]

      totalValue:
        CG.value_type

    CompressedFenwickTree2DBuilder* =
      object
        points:
          seq[CompressedFenwickPoint2D]

  proc comparePoints(
      a,
      b: CompressedFenwickPoint2D
  ): int {.inline.} =
    result =
      cmp(
        a.x,
        b.x,
      )

    if result == 0:
      result =
        cmp(
          a.y,
          b.y,
        )

  proc sortAndUnique(
      values: var seq[int]
  ) =
    values.sort()

    var uniqueValues:
      seq[int]

    for value in values:
      if uniqueValues.len == 0 or
         uniqueValues[^1] != value:
        uniqueValues.add(
          value
        )

    values =
      uniqueValues

  proc pointIndex[
      CG: CommutativeGroup
  ](
      tree: CompressedFenwickTree2D[CG],
      x,
      y: int
  ): int =
    var left =
      0

    var right =
      tree.registeredPoints.len

    while left < right:
      let middle =
        (left + right) shr 1

      let point =
        tree.registeredPoints[middle]

      if point.x < x or
         (
           point.x == x and
           point.y < y
         ):
        left =
          middle + 1
      else:
        right =
          middle

    if left < tree.registeredPoints.len and
       tree.registeredPoints[left].x == x and
       tree.registeredPoints[left].y == y:
      left
    else:
      -1

  proc initCompressedFenwickTree2D*[
      CG: CommutativeGroup
  ](
      points:
        openArray[
          CompressedFenwickPoint2D
        ],
      _: typedesc[CG]
  ): CompressedFenwickTree2D[CG] =
    for point in points:
      result.registeredPoints.add(
        point
      )

    result.registeredPoints.sort(
      proc (
          a,
          b: CompressedFenwickPoint2D
      ): int =
        comparePoints(
          a,
          b,
        )
    )

    var uniquePoints:
      seq[CompressedFenwickPoint2D]

    for point in result.registeredPoints:
      if uniquePoints.len == 0 or
         uniquePoints[^1] != point:
        uniquePoints.add(
          point
        )

    result.registeredPoints =
      uniquePoints

    for point in result.registeredPoints:
      if result.xCoordinates.len == 0 or
         result.xCoordinates[^1] != point.x:
        result.xCoordinates.add(
          point.x
        )

    result.yCoordinates =
      newSeq[seq[int]](
        result.xCoordinates.len + 1
      )

    for point in result.registeredPoints:
      let xRank =
        lowerBound(
          result.xCoordinates,
          point.x,
        )

      var xi =
        xRank + 1

      while xi <= result.xCoordinates.len:
        result.yCoordinates[xi].add(
          point.y
        )

        xi +=
          xi and -xi

    result.data =
      newSeq[seq[CG.value_type]](
        result.xCoordinates.len + 1
      )

    for xi in 1 .. result.xCoordinates.len:
      sortAndUnique(
        result.yCoordinates[xi]
      )

      result.data[xi] =
        newSeq[CG.value_type](
          result.yCoordinates[xi].len + 1
        )

      for yi in 0 ..< result.data[xi].len:
        result.data[xi][yi] =
          CG.e()

    result.pointValues =
      newSeq[CG.value_type](
        result.registeredPoints.len
      )

    for index in 0 ..< result.pointValues.len:
      result.pointValues[index] =
        CG.e()

    result.totalValue =
      CG.e()

  proc initCompressedFenwickTree2DBuilder*():
      CompressedFenwickTree2DBuilder =
    discard

  proc addPoint*(
      builder:
        var CompressedFenwickTree2DBuilder,
      x,
      y: int
  ) =
    builder.points.add(
      (
        x: x,
        y: y,
      )
    )

  proc registerPoint*(
      builder:
        var CompressedFenwickTree2DBuilder,
      x,
      y: int
  ) {.inline.} =
    builder.addPoint(
      x,
      y,
    )

  proc addPoints*(
      builder:
        var CompressedFenwickTree2DBuilder,
      points:
        openArray[
          CompressedFenwickPoint2D
        ]
  ) =
    for point in points:
      builder.points.add(
        point
      )

  proc build*[
      CG: CommutativeGroup
  ](
      builder:
        CompressedFenwickTree2DBuilder,
      _: typedesc[CG]
  ): CompressedFenwickTree2D[CG] =
    initCompressedFenwickTree2D(
      builder.points,
      CG,
    )

  proc containsPoint*[
      CG: CommutativeGroup
  ](
      tree:
        CompressedFenwickTree2D[CG],
      x,
      y: int
  ): bool {.inline.} =
    tree.pointIndex(
      x,
      y,
    ) >= 0

  proc pointCount*[
      CG: CommutativeGroup
  ](
      tree:
        CompressedFenwickTree2D[CG]
  ): int {.inline.} =
    tree.registeredPoints.len

  proc add*[
      CG: CommutativeGroup
  ](
      tree:
        var CompressedFenwickTree2D[CG],
      x,
      y: int,
      delta:
        CG.value_type
  ) =
    let index =
      tree.pointIndex(
        x,
        y,
      )

    doAssert index >= 0,
      "CompressedFenwickTree2D.add requires a registered point"

    tree.pointValues[index] =
      CG.op(
        tree.pointValues[index],
        delta,
      )

    tree.totalValue =
      CG.op(
        tree.totalValue,
        delta,
      )

    let xRank =
      lowerBound(
        tree.xCoordinates,
        x,
      )

    var xi =
      xRank + 1

    while xi <= tree.xCoordinates.len:
      let yRank =
        lowerBound(
          tree.yCoordinates[xi],
          y,
        )

      doAssert yRank <
        tree.yCoordinates[xi].len

      doAssert tree.yCoordinates[xi][yRank] ==
        y

      var yi =
        yRank + 1

      while yi < tree.data[xi].len:
        tree.data[xi][yi] =
          CG.op(
            tree.data[xi][yi],
            delta,
          )

        yi +=
          yi and -yi

      xi +=
        xi and -xi

  proc prefixSum*[
      CG: CommutativeGroup
  ](
      tree:
        CompressedFenwickTree2D[CG],
      xRight,
      yRight: int
  ): CG.value_type =
    result =
      CG.e()

    var xi =
      lowerBound(
        tree.xCoordinates,
        xRight,
      )

    while xi > 0:
      var yi =
        lowerBound(
          tree.yCoordinates[xi],
          yRight,
        )

      while yi > 0:
        result =
          CG.op(
            result,
            tree.data[xi][yi],
          )

        yi -=
          yi and -yi

      xi -=
        xi and -xi

  proc sum*[
      CG: CommutativeGroup
  ](
      tree:
        CompressedFenwickTree2D[CG],
      xLeft,
      xRight,
      yLeft,
      yRight: int
  ): CG.value_type =
    doAssert xLeft <= xRight
    doAssert yLeft <= yRight

    result =
      tree.prefixSum(
        xRight,
        yRight,
      )

    result =
      CG.op(
        result,
        CG.inv(
          tree.prefixSum(
            xLeft,
            yRight,
          )
        ),
      )

    result =
      CG.op(
        result,
        CG.inv(
          tree.prefixSum(
            xRight,
            yLeft,
          )
        ),
      )

    result =
      CG.op(
        result,
        tree.prefixSum(
          xLeft,
          yLeft,
        ),
      )

  proc get*[
      CG: CommutativeGroup
  ](
      tree:
        CompressedFenwickTree2D[CG],
      x,
      y: int
  ): CG.value_type =
    let index =
      tree.pointIndex(
        x,
        y,
      )

    if index < 0:
      CG.e()
    else:
      tree.pointValues[index]

  proc allSum*[
      CG: CommutativeGroup
  ](
      tree:
        CompressedFenwickTree2D[CG]
  ): CG.value_type {.inline.} =
    tree.totalValue

  proc `[]`*[
      CG: CommutativeGroup
  ](
      tree:
        CompressedFenwickTree2D[CG],
      x,
      y: int
  ): CG.value_type {.inline.} =
    tree.get(
      x,
      y,
    )
