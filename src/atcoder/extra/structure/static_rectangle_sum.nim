when not declared ATCODER_EXTRA_STRUCTURE_STATIC_RECTANGLE_SUM_HPP:
  const ATCODER_EXTRA_STRUCTURE_STATIC_RECTANGLE_SUM_HPP* = 1

  import std/algorithm

  type
    StaticRectangleSum*[S; Ops] = object
      pointCountValue:
        int
      xCoordinates:
        seq[int]
      yCoordinates:
        seq[int]
      roots:
        seq[int]
      leftChild:
        seq[int]
      rightChild:
        seq[int]
      nodeValue:
        seq[S]
      yTreeSize:
        int
      totalValue:
        S

  proc cloneNode[S; Ops](
      structure:
        var StaticRectangleSum[S, Ops],
      sourceNode:
        int
  ): int =
    result =
      structure.nodeValue.len

    structure.leftChild.add(
      structure.leftChild[sourceNode]
    )

    structure.rightChild.add(
      structure.rightChild[sourceNode]
    )

    structure.nodeValue.add(
      structure.nodeValue[sourceNode]
    )

  proc addAt[S; Ops](
      structure:
        var StaticRectangleSum[S, Ops],
      sourceNode,
      lower,
      upper,
      index:
        int,
      delta:
        S
  ): int =
    mixin add

    let newNode =
      structure.cloneNode(
        sourceNode
      )

    structure.nodeValue[newNode] =
      add(
        Ops,
        structure.nodeValue[newNode],
        delta,
      )

    if upper - lower == 1:
      return newNode

    let middle =
      (lower + upper) shr 1

    if index < middle:
      structure.leftChild[newNode] =
        structure.addAt(
          structure.leftChild[newNode],
          lower,
          middle,
          index,
          delta,
        )
    else:
      structure.rightChild[newNode] =
        structure.addAt(
          structure.rightChild[newNode],
          middle,
          upper,
          index,
          delta,
        )

    newNode

  proc rangeValue[S; Ops](
      structure:
        StaticRectangleSum[S, Ops],
      node,
      lower,
      upper,
      beginIndex,
      endIndex:
        int
  ): S =
    mixin zero, add

    if node == 0 or
        endIndex <= lower or
        upper <= beginIndex:
      return zero(Ops)

    if beginIndex <= lower and
        upper <= endIndex:
      return structure.nodeValue[node]

    let middle =
      (lower + upper) shr 1

    add(
      Ops,
      structure.rangeValue(
        structure.leftChild[node],
        lower,
        middle,
        beginIndex,
        endIndex,
      ),
      structure.rangeValue(
        structure.rightChild[node],
        middle,
        upper,
        beginIndex,
        endIndex,
      ),
    )

  proc initStaticRectangleSum*[
      S;
      Ops
  ](
      points:
        seq[
          tuple[
            x:
              int,
            y:
              int,
            weight:
              S
          ]
        ],
      _:
        typedesc[
          Ops
        ]
  ): StaticRectangleSum[S, Ops] =
    ## Constructs a static weighted point-set rectangle-sum
    ## structure.
    ##
    ## Duplicate coordinates are retained as records and
    ## their weights are added.
    ##
    ## Ops must provide:
    ##
    ## zero(Ops): S
    ## add(Ops, a: S, b: S): S
    ## sub(Ops, a: S, b: S): S

    mixin zero, add

    result.pointCountValue =
      points.len

    result.yTreeSize =
      1

    result.leftChild =
      @[0]

    result.rightChild =
      @[0]

    result.nodeValue =
      @[zero(Ops)]

    result.roots =
      @[0]

    result.totalValue =
      zero(Ops)

    if points.len == 0:
      return

    result.yCoordinates =
      newSeq[int](
        points.len
      )

    var sortedPoints =
      newSeq[
        tuple[
          x:
            int,
          y:
            int,
          weight:
            S
        ]
      ](
        points.len
      )

    for index in 0 ..< points.len:
      result.yCoordinates[index] =
        points[index].y

      sortedPoints[index] =
        points[index]

    result.yCoordinates.sort()

    var uniqueY =
      newSeq[int]()

    for y in result.yCoordinates:
      if uniqueY.len == 0 or
          uniqueY[^1] != y:
        uniqueY.add(
          y
        )

    result.yCoordinates =
      uniqueY

    while result.yTreeSize <
        result.yCoordinates.len:
      result.yTreeSize =
        result.yTreeSize shl 1

    proc comparePoints(
        first,
        second:
          tuple[
            x:
              int,
            y:
              int,
            weight:
              S
          ]
    ): int =
      if first.x < second.x:
        return -1

      if second.x < first.x:
        return 1

      if first.y < second.y:
        return -1

      if second.y < first.y:
        return 1

      0

    sortedPoints.sort(
      comparePoints
    )

    var pointIndex =
      0

    var currentRoot =
      0

    while pointIndex <
        sortedPoints.len:
      let currentX =
        sortedPoints[
          pointIndex
        ].x

      while pointIndex <
          sortedPoints.len and
          sortedPoints[
            pointIndex
          ].x == currentX:
        let yIndex =
          lowerBound(
            result.yCoordinates,
            sortedPoints[
              pointIndex
            ].y,
          )

        currentRoot =
          result.addAt(
            currentRoot,
            0,
            result.yTreeSize,
            yIndex,
            sortedPoints[
              pointIndex
            ].weight,
          )

        result.totalValue =
          add(
            Ops,
            result.totalValue,
            sortedPoints[
              pointIndex
            ].weight,
          )

        pointIndex.inc

      result.xCoordinates.add(
        currentX
      )

      result.roots.add(
        currentRoot
      )

  proc pointCount*[S; Ops](
      structure:
        StaticRectangleSum[S, Ops]
  ): int {.inline.} =
    structure.pointCountValue

  proc sum*[S; Ops](
      structure:
        StaticRectangleSum[S, Ops],
      xBegin,
      xEnd,
      yBegin,
      yEnd:
        int
  ): S =
    ## Returns the sum over:
    ##
    ## [xBegin, xEnd) x [yBegin, yEnd).

    mixin zero, sub

    doAssert xBegin <= xEnd
    doAssert yBegin <= yEnd

    if xBegin == xEnd or
        yBegin == yEnd or
        structure.pointCountValue == 0:
      return zero(Ops)

    let leftRootIndex =
      lowerBound(
        structure.xCoordinates,
        xBegin,
      )

    let rightRootIndex =
      lowerBound(
        structure.xCoordinates,
        xEnd,
      )

    let lowerYIndex =
      lowerBound(
        structure.yCoordinates,
        yBegin,
      )

    let upperYIndex =
      lowerBound(
        structure.yCoordinates,
        yEnd,
      )

    let leftValue =
      structure.rangeValue(
        structure.roots[
          leftRootIndex
        ],
        0,
        structure.yTreeSize,
        lowerYIndex,
        upperYIndex,
      )

    let rightValue =
      structure.rangeValue(
        structure.roots[
          rightRootIndex
        ],
        0,
        structure.yTreeSize,
        lowerYIndex,
        upperYIndex,
      )

    sub(
      Ops,
      rightValue,
      leftValue,
    )

  proc allSum*[S; Ops](
      structure:
        StaticRectangleSum[S, Ops]
  ): S {.inline.} =
    structure.totalValue
