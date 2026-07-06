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
    var default_val: tuple[dist:G.T, prev_set:bool, prev:G.U]
    default_val.dist = G.T.inf
    default_val.prev_set = false
    let n = g.len
    var a = initNodeArray(g, default_val, g.len)
    static:
      echo a.type

    var heap = initRadixHeap[G.T, Edge[G.T, G.U]]()
    when s is G.U:
#      let si = g.id(s)
      var x = a[s]
      x[].dist = G.T(0)
#      dist[si] = G.T(0)
      heap.push(G.T(0), initEdge(s, s, G.T(0)))
    else:
      for s in s:
        #let si = g.id(s)
        var x = a[s]
        x[].dist = G.T(0)
        #dist[si] = G.T(0)
        heap.push(G.T(0), initEdge(s, s, G.T(0)))
    while not heap.empty():
      let (cost, p) = heap.pop()
      var x = a[p.dst]
#      let ui = g.id(p.dst)
#      if prev_set[ui]: continue
      if x[].prev_set: continue
      x[].prev_set = true
#      prev_set[ui] = true
      x[].prev = p.src
#      prev[ui] = p.src
      for e in g[p.dst]:
        let next_cost = cost + e.weight
        var x = a[e.dst]
#        let vi = g.id(e.dst)
        if x[].dist <= next_cost: continue
        x[].dist = next_cost
        heap.push(x[].dist, e)
    result = DijkstraResult[G.T, G.U, G.useId](a:a)
