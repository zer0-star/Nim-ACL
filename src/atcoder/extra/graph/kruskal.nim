when not declared ATCODER_KRUSKAL_HPP:
  const ATCODER_KRUSKAL_HPP* = 1
  import atcoder/extra/graph/graph_template
  import atcoder/dsu
  proc kruskal*(g:Graph):(g.T, seq[Edge[g.T]]) =
    var es = newSeq[Edge[g.T]]()
    for u in 0..<g.len:
      for e in g[u]:
        es.add(e)
    es.sort()
    var
      ret = newSeq[Edge[g.T]]()
      uf = initDSU(g.len)
      total = g.T(0)
    for e in es:
      if not uf.same(e.src, e.dst):
        uf.merge(e.src, e.dst)
        total += e.weight
        ret.add(e)
    return (total, ret)
