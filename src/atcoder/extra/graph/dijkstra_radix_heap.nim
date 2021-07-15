when not declared ATCODER_DIJKSTRA_RADIX_HEAP_HPP:
  const ATCODER_DIJKSTRA_RADIX_HEAP_HPP* = 1
  import std/sequtils
  import atcoder/extra/graph/graph_template
  import atcoder/extra/structure/radix_heap
  import atcoder/extra/other/inf

  include atcoder/extra/graph/dijkstra_result

  proc dijkstra_radix_heap*[G:Graph](g:G, s:G.U or seq[G.U]): auto =
    static:
      assert G.T is SomeInteger, "weight type must be integer"
    let n = g.len
    var
      dist = newSeqWith(n, G.T.inf)
      prev_set = newSeqWith(n, false)
      prev = newSeq[G.U](n)

    var heap = initRadixHeap[G.T, Edge[G.T, G.U]]()
    when s is G.U:
      let si = g.id(s)
      dist[si] = G.T(0)
      heap.push(dist[si], initEdge(s, s, G.T(0)))
    else:
      for s in s:
        let si = g.id(s)
        dist[si] = G.T(0)
        heap.push(dist[si], initEdge(s, s, G.T(0)))
    while not heap.empty():
      let (cost, p) = heap.pop()
      let ui = g.id(p.dst)
      if prev_set[ui]: continue
      prev_set[ui] = true
      prev[ui] = p.src
      for e in g[p.dst]:
        let next_cost = cost + e.weight
        let vi = g.id(e.dst)
        if dist[vi] <= next_cost: continue
        dist[vi] = next_cost
        heap.push(dist[vi], e)
    result = DijkstraResult[G.T, G.U](dist:dist, prev:prev)
    when G.U isnot int: result.id = g.id
