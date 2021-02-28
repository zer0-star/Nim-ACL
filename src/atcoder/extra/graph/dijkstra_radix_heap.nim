when not declared ATCODER_DIJKSTRA_RADIX_HEAP_HPP:
  const ATCODER_DIJKSTRA_RADIX_HEAP_HPP* = 1
  import std/sequtils
  import atcoder/extra/graph/graph_template
  import atcoder/extra/structure/radix_heap

  proc dijkstra_radix_heap*[T](g:Graph[T], s:int): seq[T] =
    let n = g.len
    var
      dist = newSeqWith(n, T.inf)
      prev = newSeqWith(n,-1)

    var heap = initRadixHeap[T, Edge[T]]()
    dist[s] = 0
    heap.push(dist[s], initEdge(-2, s, T(0)))
    while not heap.empty():
      let (cost, p) = heap.pop()
#      if dist[p.dst] < cost: continue
      if prev[p.dst] != -1: continue
      prev[p.dst] = p.src
      for e in g[p.dst]:
        let next_cost = cost + e.weight
        if dist[e.dst] <= next_cost: continue
        dist[e.dst] = next_cost
        heap.push(dist[e.dst], e)
    return dist
