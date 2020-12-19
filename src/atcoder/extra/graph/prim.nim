when not declared ATCODER_PRIM_HPP:
  const ATCODER_PRIM_HPP* = 1
  import atcoder/extra/graph/graph_template
  import std/heapqueue, std/sequtils
  
  proc prim*[T](g:Graph[T], s:int = 0):(T, seq[Edge[T]]) =
    var
      total = T(0)
      used = newSeqWith(g.len, false)
      que = initHeapQueue[Edge[T]]()
      es = newSeq[Edge[T]]()
    que.push(initEdge[T](-1, s, 0))
    while que.len > 0:
      let p = que.pop()
      if used[p.dst]: continue
      used[p.dst] = true;
      if p.src != -1: es.add(p)
      total += p.weight
      for e in g[p.dst]: que.push(e)
    return (total, es)
