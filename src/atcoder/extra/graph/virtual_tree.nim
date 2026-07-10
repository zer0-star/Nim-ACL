when not declared ATCODER_EXTRA_GRAPH_VIRTUAL_TREE_HPP:
  const ATCODER_EXTRA_GRAPH_VIRTUAL_TREE_HPP* = 1

  import std/algorithm

  type
    VirtualTreeEdge* = tuple[parent, child, dist: int]
    VirtualTreeAdjEdge* = tuple[to, dist: int]

    VirtualTree* = object
      n*: int
      log*: int
      graph*: seq[seq[int]]
      tin*, tout*, depth*: seq[int]
      up*: seq[seq[int]]

    BuiltVirtualTree* = object
      root*: int
      vertices*: seq[int]
      edges*: seq[VirtualTreeEdge]
      adj*: seq[seq[VirtualTreeAdjEdge]]

  proc initVirtualTree*(graph: seq[seq[int]], root: int = 0): VirtualTree =
    ## Builds LCA metadata for virtual tree construction.
    let n = graph.len
    doAssert n > 0
    doAssert 0 <= root and root < n

    var log = 1
    while (1 shl log) <= max(1, n):
      log.inc

    result.n = n
    result.log = log
    result.graph = graph
    result.tin = newSeq[int](n)
    result.tout = newSeq[int](n)
    result.depth = newSeq[int](n)
    result.up = newSeq[seq[int]](log)

    for j in 0 ..< log:
      result.up[j] = newSeq[int](n)

    for i in 0 ..< n:
      result.tin[i] = -1

    var
      parent = newSeq[int](n)
      it = newSeq[int](n)
      stack = @[root]
      timer = 0

    for i in 0 ..< n:
      parent[i] = -1

    parent[root] = root

    while stack.len > 0:
      let v = stack[^1]

      if it[v] == 0:
        result.tin[v] = timer
        timer.inc
        result.up[0][v] = parent[v]

        for j in 1 ..< log:
          result.up[j][v] = result.up[j - 1][result.up[j - 1][v]]

      if it[v] < graph[v].len:
        let to = graph[v][it[v]]
        it[v].inc

        if to == parent[v]:
          continue

        doAssert 0 <= to and to < n
        doAssert parent[to] == -1

        parent[to] = v
        result.depth[to] = result.depth[v] + 1
        stack.add to
      else:
        result.tout[v] = timer
        discard stack.pop()

    for i in 0 ..< n:
      doAssert result.tin[i] >= 0

  proc isAncestor*(vt: VirtualTree, a, b: int): bool =
    ## Returns whether `a` is an ancestor of `b`.
    doAssert 0 <= a and a < vt.n
    doAssert 0 <= b and b < vt.n
    vt.tin[a] <= vt.tin[b] and vt.tout[b] <= vt.tout[a]

  proc lca*(vt: VirtualTree, a, b: int): int =
    ## Returns the lowest common ancestor of `a` and `b`.
    doAssert 0 <= a and a < vt.n
    doAssert 0 <= b and b < vt.n

    var
      x = a
      y = b

    if vt.depth[x] < vt.depth[y]:
      swap(x, y)

    let diff = vt.depth[x] - vt.depth[y]

    for j in 0 ..< vt.log:
      if ((diff shr j) and 1) != 0:
        x = vt.up[j][x]

    if x == y:
      return x

    for j in countdown(vt.log - 1, 0):
      if vt.up[j][x] != vt.up[j][y]:
        x = vt.up[j][x]
        y = vt.up[j][y]

    vt.up[0][x]

  proc dist*(vt: VirtualTree, a, b: int): int =
    ## Returns the tree distance between `a` and `b`.
    let c = vt.lca(a, b)
    vt.depth[a] + vt.depth[b] - 2 * vt.depth[c]

  proc sortedUniqueByTin(vt: VirtualTree, xs: seq[int]): seq[int] =
    var a = xs

    a.sort(proc(x, y: int): int =
      cmp(vt.tin[x], vt.tin[y])
    )

    for x in a:
      if result.len == 0 or result[^1] != x:
        result.add x

  proc buildVirtualTree*(vt: VirtualTree, keys: openArray[int]): BuiltVirtualTree =
    ## Builds a virtual tree induced by `keys`.
    ##
    ## The result contains all keys and necessary LCAs.
    ## `result.vertices[i]` is the original vertex id of compressed node `i`.
    ## `result.adj[i]` stores children as compressed indices.
    doAssert keys.len > 0

    var nodes: seq[int] = @[]

    for v in keys:
      doAssert 0 <= v and v < vt.n
      nodes.add v

    nodes = vt.sortedUniqueByTin(nodes)

    var allNodes = nodes

    for i in 0 ..< nodes.len - 1:
      allNodes.add vt.lca(nodes[i], nodes[i + 1])

    allNodes = vt.sortedUniqueByTin(allNodes)

    result.root = allNodes[0]
    result.vertices = allNodes
    result.adj = newSeq[seq[VirtualTreeAdjEdge]](allNodes.len)

    var stack: seq[int] = @[0]

    for i in 1 ..< allNodes.len:
      let v = allNodes[i]

      while stack.len > 0 and not vt.isAncestor(allNodes[stack[^1]], v):
        discard stack.pop()

      doAssert stack.len > 0

      let pIndex = stack[^1]
      let p = allNodes[pIndex]
      let d = vt.depth[v] - vt.depth[p]

      result.edges.add (parent: p, child: v, dist: d)
      result.adj[pIndex].add (to: i, dist: d)

      stack.add i
