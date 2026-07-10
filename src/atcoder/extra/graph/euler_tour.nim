when not declared ATCODER_EXTRA_GRAPH_EULER_TOUR_HPP:
  const ATCODER_EXTRA_GRAPH_EULER_TOUR_HPP* = 1

  import atcoder/extra/graph/graph_template

  type
    EulerTourFrame = object
      vertex: int
      nextEdge: int

    EulerTour* = object
      ## Euler Tour preprocessing result.
      ##
      ## The original graph is not retained.
      n*: int
      root*: int

      parent*: seq[int]
      depth*: seq[int]

      tin*: seq[int]
      tout*: seq[int]
      order*: seq[int]

      walk*: seq[int]
      first*: seq[int]

  template eulerTourDestination(
    item: untyped
  ): int =
    when item is SomeInteger:
      int(item)
    elif compiles(int(item.dst)):
      int(item.dst)
    elif compiles(int(item.to)):
      int(item.to)
    else:
      {.error:
        "Euler Tour adjacency entries must be integer vertices " &
        "or edge objects with a dst/to field."
      .}

  template eulerTourDeclaredVertexCount(
    graph: untyped,
    root: int
  ): int =
    ## Ordinary adjacency lists expose `len`.
    ##
    ## Nim-ACL Graph does not currently expose a public graph-level `len`,
    ## so its storage starts at `root + 1` and grows as connected vertices
    ## are discovered.
    when compiles(graph.len):
      int(graph.len)
    else:
      root + 1

  proc ensureVertexStorage(
    tour: var EulerTour,
    vertex: int
  ) =
    doAssert vertex >= 0

    if vertex < tour.parent.len:
      return

    let
      oldLength = tour.parent.len
      newLength = vertex + 1

    tour.parent.setLen(newLength)
    tour.depth.setLen(newLength)

    tour.tin.setLen(newLength)
    tour.tout.setLen(newLength)
    tour.first.setLen(newLength)

    for index in oldLength ..< newLength:
      tour.parent[index] = -1
      tour.tin[index] = -1
      tour.tout[index] = -1
      tour.first[index] = -1

  proc initEulerTour*[G](
    graph: G,
    root: int = 0
  ): EulerTour =
    ## Builds preorder subtree intervals and a full Euler walk.
    ##
    ## Supported inputs:
    ##
    ## - sequence-backed Nim-ACL Graph
    ## - `seq[seq[int]]`
    ##
    ## The input must be a connected undirected tree whose vertex ids are
    ## contiguous non-negative integers.
    doAssert root >= 0

    let initialLength =
      eulerTourDeclaredVertexCount(
        graph,
        root,
      )

    doAssert initialLength > root

    result.root = root
    result.n = initialLength

    result.parent = newSeq[int](initialLength)
    result.depth = newSeq[int](initialLength)

    result.tin = newSeq[int](initialLength)
    result.tout = newSeq[int](initialLength)
    result.first = newSeq[int](initialLength)

    for vertex in 0 ..< initialLength:
      result.parent[vertex] = -1
      result.tin[vertex] = -1
      result.tout[vertex] = -1
      result.first[vertex] = -1

    result.parent[root] = root
    result.tin[root] = 0
    result.first[root] = 0

    result.order = @[root]
    result.walk = @[root]

    var stack = @[
      EulerTourFrame(
        vertex: root,
        nextEdge: 0,
      )
    ]

    while stack.len > 0:
      let
        top = stack.len - 1
        vertex = stack[top].vertex

      if stack[top].nextEdge < graph[vertex].len:
        let edgeIndex =
          stack[top].nextEdge

        stack[top].nextEdge.inc

        let destination =
          eulerTourDestination(
            graph[vertex][edgeIndex]
          )

        doAssert destination >= 0

        result.ensureVertexStorage(
          destination
        )

        if destination == result.parent[vertex]:
          continue

        doAssert result.parent[destination] == -1

        result.parent[destination] = vertex
        result.depth[destination] =
          result.depth[vertex] + 1

        result.tin[destination] =
          result.order.len

        result.order.add destination

        result.first[destination] =
          result.walk.len

        result.walk.add destination

        stack.add EulerTourFrame(
          vertex: destination,
          nextEdge: 0,
        )
      else:
        result.tout[vertex] =
          result.order.len

        stack.setLen(top)

        if stack.len > 0:
          result.walk.add(
            stack[^1].vertex
          )

    result.n = result.parent.len

    when compiles(graph.len):
      doAssert result.n == graph.len

    doAssert result.order.len == result.n
    doAssert result.walk.len == 2 * result.n - 1

    for vertex in 0 ..< result.n:
      doAssert result.parent[vertex] >= 0
      doAssert result.tin[vertex] >= 0
      doAssert result.tout[vertex] >= 0

  proc len*(
    tour: EulerTour
  ): int {.inline.} =
    tour.n

  proc subtreeRange*(
    tour: EulerTour,
    vertex: int
  ): tuple[l, r: int] =
    doAssert 0 <= vertex
    doAssert vertex < tour.n

    (
      l: tour.tin[vertex],
      r: tour.tout[vertex],
    )

  proc subtreeSize*(
    tour: EulerTour,
    vertex: int
  ): int =
    let interval =
      tour.subtreeRange(vertex)

    interval.r - interval.l

  proc isAncestor*(
    tour: EulerTour,
    ancestor, descendant: int
  ): bool =
    doAssert 0 <= ancestor
    doAssert ancestor < tour.n

    doAssert 0 <= descendant
    doAssert descendant < tour.n

    tour.tin[ancestor] <=
      tour.tin[descendant] and
    tour.tout[descendant] <=
      tour.tout[ancestor]

  proc vertexAt*(
    tour: EulerTour,
    preorderIndex: int
  ): int =
    doAssert 0 <= preorderIndex
    doAssert preorderIndex < tour.n

    tour.order[preorderIndex]

  proc subtreeVertices*(
    tour: EulerTour,
    vertex: int
  ): seq[int] =
    let interval =
      tour.subtreeRange(vertex)

    for index in interval.l ..< interval.r:
      result.add tour.order[index]
