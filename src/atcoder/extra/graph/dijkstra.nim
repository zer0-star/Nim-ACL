when not declared ATCODER_EXTRA_DIJKSTRA_HPP:
  const ATCODER_EXTRA_DIJKSTRA_HPP* = 1
  import std/heapqueue, std/sequtils
  import std/deques, std/options, std/sets, std/tables
  import atcoder/extra/graph/graph_template
  import atcoder/extra/other/inf


  type DijkstraObj*[T, U] = object
    src*, dst*: U
    weight*: T
  proc `<`*[T, U](a, b:DijkstraObj[T, U]):bool = a.weight < b.weight
  proc initDijkstraObj[T, U](src, dst:U, weight:T):DijkstraObj[T, U] =
    DijkstraObj[T, U](src:src, dst:dst, weight:weight)

  include atcoder/extra/graph/dijkstra_result

  proc dijkstra01*[G:Graph](g:G, s:G.U or seq[G.U]): auto = 
    var default_val: tuple[dist:G.T, prev_set:bool, prev:G.U]
    default_val.dist = G.T.inf
    default_val.prev_set = false
    var
      a = initNodeArray(g, default_val, g.len)
      Q = initDeque[DijkstraObj[G.T, G.U]]()
    when s is G.U:
      var p = a[s]
      p[].dist = G.T(0)
      p[].prev = s
      Q.addFirst(DijkstraObj[G.T, G.U](src:s, dst:s, weight:G.T(0)))
    else:
      for s in s:
        var p = a[s]
        p[].dist = G.T(0)
        p[].prev = s
        Q.addFirst(DijkstraObj[G.T, G.U](src: s, dst:s, weight:G.T(0)))
    while Q.len > 0:
      var e = Q.popFirst()
      var p = a[e.dst]
      if p[].prev_set: continue
      p[].prev_set = true
      p[].prev = e.src
      for f in g[e.dst]:
        var w = e.weight + f.weight
        var p = a[f.dst]
        if p[].dist > w:
          p[].dist = w;
          if f.weight == 0:
            Q.addFirst(initDijkstraObj(e.dst, f.dst, w))
          else:
            Q.addLast(initDijkstraObj(e.dst, f.dst, w))
    result = DijkstraResult[G.T, G.U, G.useId](a:a)

  proc dijkstra*[G:Graph](g:var G, s:G.U or seq[G.U]): auto = 
    var default_val: tuple[dist:G.T, prev_set:bool, prev:G.U]
    default_val.dist = G.T.inf
    default_val.prev_set = false
    var
      a = initNodeArray(g, default_val, g.len)
      Q = initHeapQueue[DijkstraObj[G.T, G.U]]()
    when s is G.U:
      var p = a[s]
      p[].dist = g.T(0)
      Q.push(initDijkstraObj(s,s,g.T(0)))
    else:
      for s in s:
        var p = a[s]
        p[].dist = g.T(0)
        Q.push(initDijkstraObj(s,s,g.T(0)))
    while Q.len > 0:
      var e = Q.pop()
      var p = a[e.dst]
      if p.prev_set: continue
      p[].prev_set = true
      p[].prev = e.src
      for f in g[e.dst]:
        var w = e.weight + f.weight
        var p = a[f.dst]
        if p[].dist > w:
          p[].dist = w;
          Q.push(initDijkstraObj(e.dst, f.dst, w))
    result = DijkstraResult[G.T, G.U, G.useId](a:a)
