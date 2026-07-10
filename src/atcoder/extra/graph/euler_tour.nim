when not declared ATCODER_EXTRA_GRAPH_EULER_TOUR_HPP:
  const ATCODER_EXTRA_GRAPH_EULER_TOUR_HPP* = 1

  type
    EulerTourFrame = object
      vertex*: int
      nextEdge*: int

    EulerTour* = object
      n*: int
      root*: int
      graph*: seq[seq[int]]

      parent*: seq[int]
      depth*: seq[int]

      tin*: seq[int]
      tout*: seq[int]
      order*: seq[int]

      walk*: seq[int]
      first*: seq[int]

  proc initEulerTour*(
    graph: seq[seq[int]],
    root: int = 0
  ): EulerTour =
    ## Builds preorder subtree intervals and a full Euler walk.
    ##
    ## `graph` must be an undirected tree.
    let n = graph.len

    doAssert n > 0
    doAssert 0 <= root and root < n

    result.n = n
    result.root = root
    result.graph = graph

    result.parent = newSeq[int](n)
    result.depth = newSeq[int](n)
    result.tin = newSeq[int](n)
    result.tout = newSeq[int](n)
    result.first = newSeq[int](n)

    for v in 0 ..< n:
      result.parent[v] = -1
      result.tin[v] = -1
      result.tout[v] = -1
      result.first[v] = -1

    result.parent[root] = root
    result.tin[root] = 0
    result.first[root] = 0
    result.order = @[root]
    result.walk = @[root]

    var stack = @[
      EulerTourFrame(vertex: root, nextEdge: 0)
    ]

    while stack.len > 0:
      let top = stack.len - 1
      let v = stack[top].vertex

      if stack[top].nextEdge < graph[v].len:
        let edgeIndex = stack[top].nextEdge
        stack[top].nextEdge.inc

        let to = graph[v][edgeIndex]

        doAssert 0 <= to and to < n

        if to == result.parent[v]:
          continue

        doAssert result.parent[to] == -1

        result.parent[to] = v
        result.depth[to] = result.depth[v] + 1
        result.tin[to] = result.order.len
        result.order.add to

        result.first[to] = result.walk.len
        result.walk.add to

        stack.add EulerTourFrame(
          vertex: to,
          nextEdge: 0,
        )
      else:
        result.tout[v] = result.order.len
        stack.setLen(top)

        if stack.len > 0:
          result.walk.add stack[^1].vertex

    doAssert result.order.len == n
    doAssert result.walk.len == 2 * n - 1

    for v in 0 ..< n:
      doAssert result.tin[v] >= 0
      doAssert result.tout[v] >= 0

  proc len*(tour: EulerTour): int {.inline.} =
    tour.n

  proc subtreeRange*(
    tour: EulerTour,
    v: int
  ): tuple[l, r: int] =
    ## Returns the half-open preorder interval of the subtree of `v`.
    doAssert 0 <= v and v < tour.n

    (
      l: tour.tin[v],
      r: tour.tout[v],
    )

  proc subtreeSize*(
    tour: EulerTour,
    v: int
  ): int =
    ## Returns the number of vertices in the subtree of `v`.
    let range = tour.subtreeRange(v)
    range.r - range.l

  proc isAncestor*(
    tour: EulerTour,
    ancestor, descendant: int
  ): bool =
    ## Returns whether `ancestor` is an ancestor of `descendant`.
    doAssert 0 <= ancestor and ancestor < tour.n
    doAssert 0 <= descendant and descendant < tour.n

    tour.tin[ancestor] <= tour.tin[descendant] and
      tour.tout[descendant] <= tour.tout[ancestor]

  proc vertexAt*(
    tour: EulerTour,
    preorderIndex: int
  ): int =
    ## Converts a preorder index back to an original vertex id.
    doAssert 0 <= preorderIndex and preorderIndex < tour.n

    tour.order[preorderIndex]

  proc subtreeVertices*(
    tour: EulerTour,
    v: int
  ): seq[int] =
    ## Returns vertices in the subtree of `v` in preorder.
    let range = tour.subtreeRange(v)

    for i in range.l ..< range.r:
      result.add tour.order[i]
