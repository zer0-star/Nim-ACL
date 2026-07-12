when not declared ATCODER_EXTRA_STRUCTURE_KD_TREE_HPP:
  const ATCODER_EXTRA_STRUCTURE_KD_TREE_HPP* = 1

  import std/[algorithm, options]

  type
    KDPoint*[D: static[int], T] = array[D, T]

    KDNearestResult*[T] = tuple[
      index: int,
      squaredDistance: T,
    ]

    KDNode[D: static[int], T] = object
      pointIndex: int
      left: int
      right: int
      minimum: KDPoint[D, T]
      maximum: KDPoint[D, T]

    KDTree*[D: static[int], T] = object
      points: seq[KDPoint[D, T]]
      nodes: seq[KDNode[D, T]]
      root: int

    KDKeyedIndex[D: static[int], T] = object
      key: T
      point: KDPoint[D, T]
      index: int


  proc compareKDKeyedIndex[D: static[int], T](
      left,
      right: KDKeyedIndex[D, T],
  ): int =
    result =
      cmp(
        left.key,
        right.key,
      )

    if result != 0:
      return

    for dimension in 0 ..< D:
      result =
        cmp(
          left.point[dimension],
          right.point[dimension],
        )

      if result != 0:
        return

    result =
      cmp(
        left.index,
        right.index,
      )


  proc squaredDistance[D: static[int], T](
      left,
      right: KDPoint[D, T],
  ): T {.inline.} =
    result =
      default(T)

    for dimension in 0 ..< D:
      let difference =
        left[dimension] -
        right[dimension]

      result =
        result +
        difference * difference


  proc boxSquaredDistance[D: static[int], T](
      point,
      minimum,
      maximum: KDPoint[D, T],
  ): T {.inline.} =
    result =
      default(T)

    for dimension in 0 ..< D:
      var difference =
        default(T)

      if point[dimension] <
          minimum[dimension]:
        difference =
          minimum[dimension] -
          point[dimension]

      elif point[dimension] >
          maximum[dimension]:
        difference =
          point[dimension] -
          maximum[dimension]

      result =
        result +
        difference * difference


  proc buildNode[D: static[int], T](
      tree: var KDTree[D, T],
      indices: seq[int],
      depth: int,
  ): int =
    if indices.len == 0:
      return -1

    let axis =
      depth mod D

    var keyed =
      newSeq[
        KDKeyedIndex[D, T]
      ](
        indices.len
      )

    for position, pointIndex in indices:
      keyed[position] =
        KDKeyedIndex[D, T](
          key:
            tree.points[pointIndex][axis],
          point:
            tree.points[pointIndex],
          index:
            pointIndex,
        )

    keyed.sort(
      compareKDKeyedIndex[D, T]
    )

    let middle =
      keyed.len div 2

    var leftIndices =
      newSeq[int](middle)

    var rightIndices =
      newSeq[int](
        keyed.len -
        middle -
        1
      )

    for position in 0 ..< middle:
      leftIndices[position] =
        keyed[position].index

    for position in 0 ..< rightIndices.len:
      rightIndices[position] =
        keyed[
          middle + 1 + position
        ].index

    let middleIndex =
      keyed[middle].index

    let point =
      tree.points[middleIndex]

    result =
      tree.nodes.len

    tree.nodes.add(
      KDNode[D, T](
        pointIndex:
          middleIndex,
        left:
          -1,
        right:
          -1,
        minimum:
          point,
        maximum:
          point,
      )
    )

    let left =
      tree.buildNode(
        leftIndices,
        depth + 1,
      )

    let right =
      tree.buildNode(
        rightIndices,
        depth + 1,
      )

    tree.nodes[result].left =
      left

    tree.nodes[result].right =
      right

    for child in [left, right]:
      if child < 0:
        continue

      for dimension in 0 ..< D:
        tree.nodes[result].minimum[dimension] =
          min(
            tree.nodes[result].minimum[dimension],
            tree.nodes[child].minimum[dimension],
          )

        tree.nodes[result].maximum[dimension] =
          max(
            tree.nodes[result].maximum[dimension],
            tree.nodes[child].maximum[dimension],
          )


  proc initKDTree*[D: static[int], T](
      points: openArray[KDPoint[D, T]],
  ): KDTree[D, T] =
    ## Builds a static D-dimensional KD-tree.
    ##
    ## Point indices are the indices in the original input sequence.

    when D <= 0:
      {.error: "KDTree dimension must be positive".}

    result.points =
      newSeq[
        KDPoint[D, T]
      ](
        points.len
      )

    for index in 0 ..< points.len:
      result.points[index] =
        points[index]

    result.nodes =
      newSeqOfCap[
        KDNode[D, T]
      ](
        points.len
      )

    var indices =
      newSeq[int](points.len)

    for index in 0 ..< points.len:
      indices[index] =
        index

    result.root =
      result.buildNode(
        indices,
        0,
      )


  proc len*[D: static[int], T](
      tree: KDTree[D, T],
  ): int {.inline.} =
    tree.points.len


  proc searchNearest[D: static[int], T](
      tree: KDTree[D, T],
      node: int,
      query: KDPoint[D, T],
      bestIndex: var int,
      bestDistance: var T,
  ) =
    if node < 0:
      return

    let currentIndex =
      tree.nodes[node].pointIndex

    let currentDistance =
      squaredDistance(
        tree.points[currentIndex],
        query,
      )

    if bestIndex < 0 or
        currentDistance < bestDistance or
        (
          currentDistance == bestDistance and
          currentIndex < bestIndex
        ):
      bestIndex =
        currentIndex

      bestDistance =
        currentDistance

    let left =
      tree.nodes[node].left

    let right =
      tree.nodes[node].right

    if left >= 0 and right >= 0:
      var first =
        left

      var second =
        right

      var firstDistance =
        boxSquaredDistance(
          query,
          tree.nodes[first].minimum,
          tree.nodes[first].maximum,
        )

      var secondDistance =
        boxSquaredDistance(
          query,
          tree.nodes[second].minimum,
          tree.nodes[second].maximum,
        )

      if secondDistance <
          firstDistance:
        swap(
          first,
          second,
        )

        swap(
          firstDistance,
          secondDistance,
        )

      if firstDistance <=
          bestDistance:
        tree.searchNearest(
          first,
          query,
          bestIndex,
          bestDistance,
        )

      if secondDistance <=
          bestDistance:
        tree.searchNearest(
          second,
          query,
          bestIndex,
          bestDistance,
        )

    elif left >= 0:
      let distance =
        boxSquaredDistance(
          query,
          tree.nodes[left].minimum,
          tree.nodes[left].maximum,
        )

      if distance <= bestDistance:
        tree.searchNearest(
          left,
          query,
          bestIndex,
          bestDistance,
        )

    elif right >= 0:
      let distance =
        boxSquaredDistance(
          query,
          tree.nodes[right].minimum,
          tree.nodes[right].maximum,
        )

      if distance <= bestDistance:
        tree.searchNearest(
          right,
          query,
          bestIndex,
          bestDistance,
        )


  proc nearest*[D: static[int], T](
      tree: KDTree[D, T],
      query: KDPoint[D, T],
  ): Option[KDNearestResult[T]] =
    ## Returns the nearest input point and its squared distance.
    ##
    ## Ties are resolved by the smallest original input index.

    if tree.root < 0:
      return none(
        KDNearestResult[T]
      )

    var bestIndex =
      -1

    var bestDistance =
      default(T)

    tree.searchNearest(
      tree.root,
      query,
      bestIndex,
      bestDistance,
    )

    some(
      (
        index:
          bestIndex,
        squaredDistance:
          bestDistance,
      )
    )


  proc rangeIntersects[D: static[int], T](
      node: KDNode[D, T],
      lower,
      upper: KDPoint[D, T],
  ): bool {.inline.} =
    for dimension in 0 ..< D:
      if node.maximum[dimension] <
          lower[dimension] or
          node.minimum[dimension] >=
          upper[dimension]:
        return false

    true


  proc searchRange[D: static[int], T](
      tree: KDTree[D, T],
      node: int,
      lower,
      upper: KDPoint[D, T],
      answer: var seq[int],
  ) =
    if node < 0:
      return

    if not rangeIntersects(
        tree.nodes[node],
        lower,
        upper,
    ):
      return

    let pointIndex =
      tree.nodes[node].pointIndex

    let point =
      tree.points[pointIndex]

    var contained =
      true

    for dimension in 0 ..< D:
      if point[dimension] <
          lower[dimension] or
          point[dimension] >=
          upper[dimension]:
        contained =
          false

        break

    if contained:
      answer.add(pointIndex)

    tree.searchRange(
      tree.nodes[node].left,
      lower,
      upper,
      answer,
    )

    tree.searchRange(
      tree.nodes[node].right,
      lower,
      upper,
      answer,
    )


  proc rangeSearch*[D: static[int], T](
      tree: KDTree[D, T],
      lower,
      upper: KDPoint[D, T],
  ): seq[int] =
    ## Returns original input indices in the half-open box [lower, upper).
    ##
    ## The returned indices are sorted increasingly.

    for dimension in 0 ..< D:
      if lower[dimension] >
          upper[dimension]:
        raise newException(
          ValueError,
          "lower must not exceed upper",
        )

    tree.searchRange(
      tree.root,
      lower,
      upper,
      result,
    )

    result.sort()
