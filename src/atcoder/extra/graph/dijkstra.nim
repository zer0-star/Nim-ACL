when not declared ATCODER_EXTRA_DIJKSTRA_HPP:
  const ATCODER_EXTRA_DIJKSTRA_HPP* = 1
  import std/heapqueue, std/sequtils, std/algorithm
  import std/deques
  import atcoder/extra/graph/graph_template

  proc dijkstra01*[T](g:Graph[T], s:int): (seq[T],seq[int]) = 
    var
      n = g.len
      dist = newSeqWith(n,T.inf)
      prev = newSeqWith(n,-1)
      Q = initDeque[Edge[T]]()
    dist[s] = T(0)
    Q.addFirst(initEdge[T](-2,s,T(0)))
    while Q.len > 0:
      var e = Q.popFirst()
      if prev[e.dst] != -1: continue
      prev[e.dst] = e.src;
      for f in g[e.dst]:
        var w = e.weight + f.weight;
        if dist[f.dst] > w:
          dist[f.dst] = w;
          if f.weight == 0:
            Q.addFirst(initEdge[T](f.src, f.dst, w))
          else:
            Q.addLast(initEdge[T](f.src, f.dst, w))
    return (dist,prev)

  proc dijkstra*[T](g:Graph[T], s:int): (seq[T],seq[int]) = 
    var
      n = g.len
      dist = newSeqWith(n,T.inf)
      prev = newSeqWith(n,-1)
      Q = initHeapQueue[Edge[T]]()
    dist[s] = T(0)
    Q.push(initEdge[T](-2,s,T(0)))
    while Q.len > 0:
      var e = Q.pop()
      if prev[e.dst] != -1: continue
      prev[e.dst] = e.src;
      for f in g[e.dst]:
        var w = e.weight + f.weight;
        if dist[f.dst] > w:
          dist[f.dst] = w;
          Q.push(initEdge[T](f.src, f.dst, w))
      discard
    return (dist,prev)
  
  proc path*(prev: seq[int], t:int): seq[int] = 
    var u = t
    while u >= 0:
      result.add(u)
      u = prev[u]
    result.reverse()
# }}}
