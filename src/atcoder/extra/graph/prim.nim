when not declared ATCODER_PRIM_HPP:
  const ATCODER_PRIM_HPP* = 1
  import atcoder/extra/graph/graph_template
  import std/heapqueue, std/sequtils
  
  proc prim*(g:Graph, s:int = 0):(g.T, seq[Edge[g.T]]) =
    var
      total = g.T(0)
      used = newSeqWith(g.len, false)
      que = initHeapQueue[Edge[g.T]]()
      es = newSeq[Edge[g.T]]()
    que.push(initEdge(-1, s, g.T(0)))
    while que.len > 0:
      let p = que.pop()
      if used[p.dst]: continue
      used[p.dst] = true;
      if p.src != -1: es.add(p)
      total += p.weight
      for e in g[p.dst]: que.push(e)
    return (total, es)
