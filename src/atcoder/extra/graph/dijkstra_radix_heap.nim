when not declared ATCODER_DIJKSTRA_RADIX_HEAP_HPP:
  const ATCODER_DIJKSTRA_RADIX_HEAP_HPP* = 1
  import std/sequtils
  import atcoder/extra/graph/graph_template
  import atcoder/extra/structure/radix_heap

  proc dijkstra_radix_heap*[G:Graph](g:G, s:int): seq[G.T] =
    let n = g.len
    var
      dist = newSeqWith(n, G.T.inf)
      prev = newSeqWith(n, -1)

    var heap = initRadixHeap[G.T, Edge[G.T, G.U]]()
    dist[s] = 0
    heap.push(dist[s], initEdge(-2, s, G.T(0)))
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
