when not defined ATCODER_SCC_HPP:
  const ATCODER_SCC_HPP = 1

  import sequtils, src/nim_acl/internal_scc

  type scc_graph = object
    internal: internal_scc_graph

  proc initSccGraph(n:int):auto = init_internal_scc_graph(n)
  
  proc add_edge(self:var scc_graph, src, dst:int) =
    let n = self.internal.num_vertices()
    assert 0 <= src and dst < n
    assert 0 <= dst and dst < n
    self.internal.add_edge(src, dst)

  proc scc(self:scc_graph):auto = self.internal.scc()
