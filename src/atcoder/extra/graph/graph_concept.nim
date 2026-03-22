when not declared ATCODER_EXTRA_GRAPH_CONCEPT_HPP:
  const ATCODER_EXTRA_GRAPH_CONCEPT_HPP* = 1
  type GraphC* = concept g
    len(g) is int
    var u:int
    for e in g[u]:
      e.dst is int
      e.weight is g.T
