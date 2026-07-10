when not declared ATCODER_EXTRA_GRAPH_REROOTING_DP_HPP:
  const ATCODER_EXTRA_GRAPH_REROOTING_DP_HPP* = 1

  type
    RerootingEdge* = object
      to*, id*: int

    RerootingGraph* = object
      n*: int
      graph*: seq[seq[RerootingEdge]]
      edgeCount*: int

  proc initRerootingGraph*(n: int): RerootingGraph =
    ## Creates an undirected tree container for rerooting DP.
    doAssert n >= 0

    result.n = n
    result.graph = newSeq[seq[RerootingEdge]](n)
    result.edgeCount = 0

  proc len*(g: RerootingGraph): int {.inline.} =
    g.n

  proc addEdge*(g: var RerootingGraph, u, v: int): int =
    ## Adds an undirected edge and returns its edge id.
    doAssert 0 <= u and u < g.n
    doAssert 0 <= v and v < g.n

    result = g.edgeCount
    g.edgeCount.inc

    g.graph[u].add RerootingEdge(to: v, id: result)
    g.graph[v].add RerootingEdge(to: u, id: result)

  proc buildParentOrder(g: RerootingGraph): tuple[parent, order: seq[int]] =
    let n = g.n

    result.parent = newSeq[int](n)
    result.order = @[]

    for i in 0 ..< n:
      result.parent[i] = -1

    if n == 0:
      return

    var stack = @[0]
    result.parent[0] = 0

    while stack.len > 0:
      let v = stack[^1]
      stack.setLen(stack.len - 1)

      result.order.add v

      for e in g.graph[v]:
        let to = e.to

        if to == result.parent[v]:
          continue

        doAssert result.parent[to] == -1

        result.parent[to] = v
        stack.add to

    doAssert result.order.len == n

  proc rerooting*[T](
    g: RerootingGraph,
    identity: T,
    merge: proc(a, b: T): T {.closure.},
    addRoot: proc(x: T, v: int): T {.closure.},
    addEdge: proc(x: T, edgeId: int, fromVertex: int, toVertex: int): T {.closure.}
  ): seq[T] =
    ## Runs generic rerooting DP.
    ##
    ## `identity` is the neutral element of `merge`.
    ## `addRoot(x, v)` converts merged neighbor contributions into the DP value rooted at `v`.
    ## `addEdge(x, edgeId, fromVertex, toVertex)` converts a DP value across an edge.
    let n = g.n

    result = newSeq[T](n)

    if n == 0:
      return

    let po = g.buildParentOrder()
    let parent = po.parent
    let order = po.order

    var
      down = newSeq[T](n)
      fromParent = newSeq[T](n)

    for idx in countdown(n - 1, 0):
      let v = order[idx]

      var acc = identity

      for e in g.graph[v]:
        let to = e.to

        if parent[to] == v:
          acc = merge(acc, addEdge(down[to], e.id, to, v))

      down[v] = addRoot(acc, v)

    for v in order:
      let deg = g.graph[v].len

      var
        vals = newSeq[T](deg)
        prefix = newSeq[T](deg + 1)
        suffix = newSeq[T](deg + 1)

      prefix[0] = identity
      suffix[deg] = identity

      for i in 0 ..< deg:
        let e = g.graph[v][i]
        let to = e.to

        if parent[to] == v:
          vals[i] = addEdge(down[to], e.id, to, v)
        else:
          vals[i] = fromParent[v]

        prefix[i + 1] = merge(prefix[i], vals[i])

      for i in countdown(deg - 1, 0):
        suffix[i] = merge(vals[i], suffix[i + 1])

      result[v] = addRoot(prefix[deg], v)

      for i in 0 ..< deg:
        let e = g.graph[v][i]
        let to = e.to

        if parent[to] == v:
          let withoutChild = merge(prefix[i], suffix[i + 1])
          let sideAtV = addRoot(withoutChild, v)

          fromParent[to] = addEdge(sideAtV, e.id, v, to)

  proc rerooting*[T](
    g: RerootingGraph,
    identity: T,
    merge: proc(a, b: T): T {.closure.},
    addRoot: proc(x: T, v: int): T {.closure.}
  ): seq[T] =
    ## Runs rerooting DP with identity edge transition.
    proc idEdge(x: T, edgeId: int, fromVertex: int, toVertex: int): T =
      x

    g.rerooting(identity, merge, addRoot, idEdge)

  proc rerootingDP*[T](
    g: RerootingGraph,
    identity: T,
    merge: proc(a, b: T): T {.closure.},
    addRoot: proc(x: T, v: int): T {.closure.},
    addEdge: proc(x: T, edgeId: int, fromVertex: int, toVertex: int): T {.closure.}
  ): seq[T] =
    ## Alias of `rerooting`.
    g.rerooting(identity, merge, addRoot, addEdge)

  proc rerootingDP*[T](
    g: RerootingGraph,
    identity: T,
    merge: proc(a, b: T): T {.closure.},
    addRoot: proc(x: T, v: int): T {.closure.}
  ): seq[T] =
    ## Alias of `rerooting`.
    g.rerooting(identity, merge, addRoot)
