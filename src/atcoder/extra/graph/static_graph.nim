when not declared ATCODER_STATIC_GRAPH_HPP:
  const ATCODER_STATIC_GRAPH_HPP* = 1
  import atcoder/internal_csr
  type Edge0*[T] = object
    src*, dst*, rev*: int
    weight: T
  type Edges0*[T] = object
    n*: int
    edges*: seq[Edge0[T]]
  type StaticGraph*[T] = csr[Edge0[T]]

  proc add_edge*[T](self: var Edges0[T], src, dst:int, w = T(1)):int {.discardable.} =
    assert src in 0..<self.n
    assert dst in 0..<self.n
    var m = self.edges.len
    self.edges.add(Edge0[T](src:src, dst:dst, weight:w))
    return m

  proc build*[T](self:Edges0[T]): StaticGraph[T] =
    let m = self.edges.len
    var edge_idx = newSeq[int](m)

    var g = block:
      var degree = newSeq[int](self.n)
      var redge_idx = newSeq[int](m)
      var elist = newSeqOfCap[(int, Edge0[T])](2 * m)
      for i in 0..<m:
        let e = self.edges[i]
        edge_idx[i] = degree[e.src]
        degree[e.src].inc
        redge_idx[i] = degree[e.dst]
        degree[e.dst].inc
        elist.add((e.src, Edge0[T](src: e.src, dst: e.dst, rev: -1, weight: e.weight)))
        elist.add((e.dst, Edge0[T](src: e.dst, dst: e.src, rev: -1, weight: e.weight)))
      var g = initCSR[Edge0[T]](self.n, elist.move)
      for i in 0..<m:
        let e = self.edges[i]
        edge_idx[i] += g.start[e.src]
        redge_idx[i] += g.start[e.dst]
        g.elist[edge_idx[i]].rev = redge_idx[i];
        g.elist[redge_idx[i]].rev = edge_idx[i];
      g
    return g

  iterator `[]`*[T](self: StaticGraph[T], u:int):Edge0[T] =
    for i in self.start[u] ..< self.start[u + 1]:
      yield self.elist[i]

  proc degree*[T](self: StaticGraph[T], u:int):int = self.start[u + 1] - self.start[u]
