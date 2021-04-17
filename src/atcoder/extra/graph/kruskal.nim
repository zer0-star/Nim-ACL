when not declared ATCODER_KRUSKAL_HPP:
  const ATCODER_KRUSKAL_HPP* = 1
  import atcoder/extra/graph/graph_template
  import atcoder/dsu
  proc kruskal*[G:Graph](g:G):(G.T, seq[Edge[G.T, G.U]]) =
    var es = newSeq[Edge[G.T, G.U]]()
    for u in 0..<g.len:
      for e in g[u]:
        es.add(e)
    es.sort()
    var
      ret = newSeq[Edge[G.T, G.U]]()
      uf = initDSU(g.len)
      total = G.T(0)
    for e in es:
      if not uf.same(e.src, e.dst):
        uf.merge(e.src, e.dst)
        total += e.weight
        ret.add(e)
    return (total, ret)
