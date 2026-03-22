when not declared ATCODER_STATIC_GRAPH_HPP:
  const ATCODER_STATIC_GRAPH_HPP* = 1
  import atcoder/internal_csr
  type Edge0*[T] = object
    src*, dst*, rev*: int
    weight*: T
  type Edges0*[T] = object
    n*: int
    edges*: seq[Edge0[T]]
  type StaticGraph*[T] = object
    n*:int
    g*:csr[Edge0[T]]
  proc len*[T](self:StaticGraph[T]):int = self.n

  proc initStaticGraph*[T](n: int):StaticGraph[T] = StaticGraph[T](n:n)

  proc addBiEdge*[T](self: var StaticGraph[T], src, dst:int, w = T(1)):int {.discardable.} =
    assert src in 0..<self.n
    assert dst in 0..<self.n
    var m = self.g.elist.len
    self.g.elist.add(Edge0[T](src:src, dst:dst, weight:w))
    return m

  proc build*[T](self:var StaticGraph[T]) =
    let
      edges = self.g.elist.move
      m = edges.len
    var edge_idx = newSeq[int](m)

    var
      degree = newSeq[int](self.n)
      redge_idx = newSeq[int](m)
      elist = newSeqOfCap[(int, Edge0[T])](2 * m)
    for i in 0..<m:
      let e = edges[i]
      edge_idx[i] = degree[e.src]
      degree[e.src].inc
      redge_idx[i] = degree[e.dst]
      degree[e.dst].inc
      elist.add((e.src, Edge0[T](src: e.src, dst: e.dst, rev: -1, weight: e.weight)))
      elist.add((e.dst, Edge0[T](src: e.dst, dst: e.src, rev: -1, weight: e.weight)))
    self.g = initCSR[Edge0[T]](self.n, elist.move)
    for i in 0..<m:
      let e = edges[i]
      edge_idx[i] += self.g.start[e.src]
      redge_idx[i] += self.g.start[e.dst]
      self.g.elist[edge_idx[i]].rev = redge_idx[i];
      self.g.elist[redge_idx[i]].rev = edge_idx[i];

  iterator `[]`*[T](self: StaticGraph[T], u:int):Edge0[T] =
    for i in self.g.start[u] ..< self.g.start[u + 1]:
      yield self.g.elist[i]

  proc degree*[T](self: StaticGraph[T], u:int):int = self.start[u + 1] - self.start[u]

  proc initStaticBiGraph*[T](n: int, u, v: seq[int]):StaticGraph[T] =
    var g = initStaticGraph[T](n)
    for i in 0 ..< u.len:
      g.addBiEdge(u[i], v[i])
    g.build
    return g
