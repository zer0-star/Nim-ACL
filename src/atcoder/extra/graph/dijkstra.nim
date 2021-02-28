when not declared ATCODER_EXTRA_DIJKSTRA_HPP:
  const ATCODER_EXTRA_DIJKSTRA_HPP* = 1
  import std/heapqueue, std/sequtils, std/algorithm
  import std/deques
  import atcoder/extra/graph/graph_template
  import atcoder/extra/other/inf

  proc dijkstra01*(g:Graph, s:int): tuple[dist:seq[g.T],prev:seq[int]] = 
    var
      n = g.len
      dist = newSeqWith(n,g.T.inf)
      Q = initDeque[Edge[g.T]]()
      prev = newSeqWith(n,-1)
    dist[s] = g.T(0)
    Q.addFirst(initEdge[g.T](-2,s,g.T(0)))
    while Q.len > 0:
      var e = Q.popFirst()
      if prev[e.dst] != -1: continue
      prev[e.dst] = e.src;
      for f in g[e.dst]:
        var w = e.weight + f.weight
        if dist[f.dst] > w:
          dist[f.dst] = w;
          if f.weight == 0:
            Q.addFirst(initEdge(f.src, f.dst, w))
          else:
            Q.addLast(initEdge(f.src, f.dst, w))
    return (dist,prev)

  proc dijkstra*(g:Graph, s:int): tuple[dist:seq[g.T],prev:seq[int]] = 
    var
      n = g.len
      dist = newSeqWith(n,g.T.inf)
      Q = initHeapQueue[Edge[g.T]]()
      prev = newSeqWith(n,-1)
    dist[s] = g.T(0)
    Q.push(initEdge(-2,s,g.T(0)))
    while Q.len > 0:
      var e = Q.pop()
#      if dist[e.dst] < e.weight: continue
      if prev[e.dst] != -1: continue
      prev[e.dst] = e.src;
      for f in g[e.dst]:
        var w = e.weight + f.weight
        if dist[f.dst] > w:
          dist[f.dst] = w;
          Q.push(initEdge(f.src, f.dst, w))
    return (dist,prev)
  
  proc path*(prev: seq[int], t:int): seq[int] = 
    var u = t
    while u >= 0:
      result.add(u)
      u = prev[u]
    result.reverse()
