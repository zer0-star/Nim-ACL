when not declared ATCODER_KRUSKAL_HPP:
  const ATCODER_KRUSKAL_HPP* = 1
  import atcoder/extra/graph/graph_template
  import atcoder/dsu
  proc kruskal*[T](g:Graph[T]):(T, seq[Edge[T]]) =
    var es = newSeq[Edge[T]]()
    for u in 0..<g.len:
      for e in g[u]:
        es.add(e)
    es.sort()
    var
      ret = newSeq[Edge[T]]()
      uf = initDSU(g.len)
      total = T(0)
    for e in es:
      if not uf.same(e.src, e.dst):
        uf.merge(e.src, e.dst)
        total += e.weight
        ret.add(e)
    return (total, ret)
