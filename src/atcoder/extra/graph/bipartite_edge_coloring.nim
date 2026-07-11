when not declared ATCODER_EXTRA_GRAPH_BIPARTITE_EDGE_COLORING_HPP:
  const
    ATCODER_EXTRA_GRAPH_BIPARTITE_EDGE_COLORING_HPP* = 1

  import std/tables

  import atcoder/extra/graph/hopcroft_karp


  type
    BipartiteEdgeColoringBucket = object
      left: int
      right: int
      originalEdgeIds: seq[int]
      dummyCount: int


  proc getOrCreateBucket(
      bucketIndex: var Table[(int, int), int],
      buckets: var seq[BipartiteEdgeColoringBucket],
      left,
      right: int,
  ): int =
    let key =
      (left, right)

    if bucketIndex.hasKey(key):
      return bucketIndex[key]

    result =
      buckets.len

    bucketIndex[key] =
      result

    buckets.add(
      BipartiteEdgeColoringBucket(
        left: left,
        right: right,
      )
    )


  proc bipartiteEdgeColoring*(
      leftCount,
      rightCount: int,
      edges: openArray[(int, int)],
  ): seq[int] =
    ## Returns an optimal edge coloring of a bipartite multigraph.
    ##
    ## The returned color at index `edgeId` corresponds to
    ## `edges[edgeId]`. Parallel edges are supported.

    if leftCount < 0:
      raise newException(
        ValueError,
        "leftCount must be nonnegative",
      )

    if rightCount < 0:
      raise newException(
        ValueError,
        "rightCount must be nonnegative",
      )

    let vertexCount =
      max(
        leftCount,
        rightCount,
      )

    var
      leftDegree =
        newSeq[int](vertexCount)

      rightDegree =
        newSeq[int](vertexCount)

    for edge in edges:
      let
        left = edge[0]
        right = edge[1]

      if left < 0 or left >= leftCount:
        raise newException(
          ValueError,
          "left endpoint is out of range",
        )

      if right < 0 or right >= rightCount:
        raise newException(
          ValueError,
          "right endpoint is out of range",
        )

      inc leftDegree[left]
      inc rightDegree[right]

    var maximumDegree = 0

    for degree in leftDegree:
      maximumDegree =
        max(
          maximumDegree,
          degree,
        )

    for degree in rightDegree:
      maximumDegree =
        max(
          maximumDegree,
          degree,
        )

    result =
      newSeq[int](edges.len)

    if maximumDegree == 0:
      return

    var
      bucketIndex =
        initTable[(int, int), int]()

      buckets:
        seq[BipartiteEdgeColoringBucket]

    for edgeId, edge in edges:
      let bucketId =
        getOrCreateBucket(
          bucketIndex,
          buckets,
          edge[0],
          edge[1],
        )

      buckets[bucketId].originalEdgeIds.add(
        edgeId
      )

    var
      leftDeficit =
        newSeq[int](vertexCount)

      rightDeficit =
        newSeq[int](vertexCount)

    for vertex in 0 ..< vertexCount:
      leftDeficit[vertex] =
        maximumDegree - leftDegree[vertex]

      rightDeficit[vertex] =
        maximumDegree - rightDegree[vertex]

    var
      leftVertex = 0
      rightVertex = 0

    while leftVertex < vertexCount:
      while leftVertex < vertexCount and
          leftDeficit[leftVertex] == 0:
        inc leftVertex

      while rightVertex < vertexCount and
          rightDeficit[rightVertex] == 0:
        inc rightVertex

      if leftVertex == vertexCount:
        break

      if rightVertex == vertexCount:
        raise newException(
          AssertionDefect,
          "internal deficit mismatch",
        )

      let amount =
        min(
          leftDeficit[leftVertex],
          rightDeficit[rightVertex],
        )

      if amount <= 0:
        raise newException(
          AssertionDefect,
          "internal nonpositive deficit",
        )

      let bucketId =
        getOrCreateBucket(
          bucketIndex,
          buckets,
          leftVertex,
          rightVertex,
        )

      buckets[bucketId].dummyCount +=
        amount

      leftDeficit[leftVertex] -=
        amount

      rightDeficit[rightVertex] -=
        amount

    for deficit in leftDeficit:
      if deficit != 0:
        raise newException(
          AssertionDefect,
          "internal left deficit remained",
        )

    for deficit in rightDeficit:
      if deficit != 0:
        raise newException(
          AssertionDefect,
          "internal right deficit remained",
        )

    for color in 0 ..< maximumDegree:
      var matching =
        initHopcroftKarp(
          vertexCount,
          vertexCount,
        )

      for bucket in buckets:
        if bucket.originalEdgeIds.len > 0 or
            bucket.dummyCount > 0:
          matching.add_edge(
            bucket.left,
            bucket.right,
          )

      let pairs =
        matching.maximum_matching()

      if pairs.len != vertexCount:
        raise newException(
          AssertionDefect,
          "regularized graph has no perfect matching",
        )

      for pair in pairs:
        let
          key =
            (
              pair[0],
              pair[1],
            )

          bucketId =
            bucketIndex[key]

        if buckets[bucketId].originalEdgeIds.len > 0:
          let edgeId =
            buckets[bucketId].originalEdgeIds.pop()

          result[edgeId] =
            color

        elif buckets[bucketId].dummyCount > 0:
          dec buckets[bucketId].dummyCount

        else:
          raise newException(
            AssertionDefect,
            "matched an empty edge bucket",
          )

    for bucket in buckets:
      if bucket.originalEdgeIds.len != 0 or
          bucket.dummyCount != 0:
        raise newException(
          AssertionDefect,
          "edge bucket remained after decomposition",
        )
