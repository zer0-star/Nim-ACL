when not declared ATCODER_INTERNAL_SCC_HPP:
  const ATCODER_INTERNAL_SCC_HPP* = 1
  
  import std/sequtils
  import atcoder/internal_csr

  
  type edge* = object
    dst:int
  # Reference:
  # R. Tarjan,
  # Depth-First Search and Linear Graph Algorithms
  type internal_scc_graph* = object
    n:int
    edges:seq[(int,edge)]

  proc init_internal_scc_graph*(n:int):auto = internal_scc_graph(n:n, edges:newSeq[(int,edge)]())
  
  proc num_vertices*(self: internal_scc_graph):int =  self.n

  proc add_edge*(self: var internal_scc_graph, src, dst:int) = self.edges.add((src, edge(dst:dst)))

  # @return pair of (# of scc, scc id)
  proc scc_ids*(self: internal_scc_graph):(int,seq[int]) =
    var g = initCsr[edge](self.n, self.edges)
    var now_ord, group_num = 0
    var
      visited = newSeqOfCap[int](self.n)
      low = newSeq[int](self.n)
      ord = newSeqWith(self.n, -1)
      ids = newSeq[int](self.n)
    proc dfs(v:int) =
      low[v] = now_ord
      ord[v] = now_ord
      now_ord.inc
      visited.add(v)
      for i in g.start[v] ..< g.start[v + 1]:
        let dst = g.elist[i].dst
        if ord[dst] == -1:
          dfs(dst)
          low[v] = min(low[v], low[dst])
        else:
          low[v] = min(low[v], ord[dst])
      if low[v] == ord[v]:
        while true:
          let u = visited[^1]
          discard visited.pop()
          ord[u] = self.n
          ids[u] = group_num
          if u == v: break
        group_num.inc
    for i in 0..<self.n:
      if ord[i] == -1: dfs(i)
    ids.applyIt(group_num - 1 - it)
    return (group_num, ids)

  proc scc*(self: internal_scc_graph):auto =
    let
      ids = self.scc_ids()
      group_num = ids[0]
    var counts = newSeq[int](group_num)
    for x in ids[1]: counts[x].inc
    result = newSeq[seq[int]](ids[0])
    for i in 0..<group_num:
      result[i] = newSeqOfCap[int](counts[i])
    for i in 0..<self.n:
      result[ids[1][i]].add(i)
