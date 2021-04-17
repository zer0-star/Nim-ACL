when not declared ATCODER_EXTRA_DIJKSTRA_HPP:
  const ATCODER_EXTRA_DIJKSTRA_HPP* = 1
  import std/heapqueue, std/sequtils, std/algorithm
  import std/deques
  import atcoder/extra/graph/graph_template
  import atcoder/extra/other/inf

  type DijkstraObj*[T, U] = object
    src*, dst*: U
    weight*: T
  proc `<`*[T, U](a, b:DijkstraObj[T, U]):bool = a.weight < b.weight
  proc initDijkstraObj[T, U](src, dst:U, weight:T):DijkstraObj[T, U] =
    DijkstraObj[T, U](src:src, dst:dst, weight:weight)
  type DijkstraResult*[T, U] = object
    s*: U
    dist*: seq[T]
    prev*: seq[U]
    when U isnot int:
      id*: proc(u:U):int
  proc `[]`*[T, U](d:DijkstraResult[T, U], u:U):T =
    let u = when U isnot int: d.id(u) else: u
    d.dist[u]

  proc dijkstra01*[G:Graph](g:G, s:G.U): auto = 
    var
      n = g.len
      dist = newSeqWith(n,G.T.inf)
      Q = initDeque[DijkstraObj[G.T, G.U]]()
      prev_set = newSeqWith(n, false)
      prev = newSeq[G.U](n)
    dist[g.id(s)] = G.T(0)
    Q.addFirst(DijkstraObj[G.T, G.U](dst:s, weight:G.T(0)))
    while Q.len > 0:
      var e = Q.popFirst()
      let u = g.id(e.dst)
      if prev_set[u]: continue
      prev_set[u] = true
      prev[u] = e.src
      for f in g[e.dst]:
        var w = e.weight + f.weight
        let v = g.id(f.dst)
        if dist[v] > w:
          dist[v] = w;
          if f.weight == 0:
            Q.addFirst(initDijkstraObj(e.dst, f.dst, w))
          else:
            Q.addLast(initDijkstraObj(e.dst, f.dst, w))
    result = DijkstraResult[G.T, G.U](s:s, dist:dist, prev:prev)
    when G.U isnot int: result.id = g.id

  proc dijkstra*[G:Graph](g:G, s:G.U): auto = 
    var
      n = g.len
      dist = newSeqWith(n,g.T.inf)
      Q = initHeapQueue[DijkstraObj[G.T, G.U]]()
      prev_set = newSeqWith(n, false)
      prev = newSeq[G.U](n)
    dist[g.id(s)] = g.T(0)
    Q.push(initDijkstraObj(s,s,g.T(0)))
    while Q.len > 0:
      var e = Q.pop()
#      if dist[e.dst] < e.weight: continue
      let eid = g.id(e.dst)
      if prev_set[eid]: continue
      prev_set[eid] = true
      prev[eid] = e.src
      for f in g[e.dst]:
        var w = e.weight + f.weight
        let fid = g.id(f.dst)
        if dist[fid] > w:
          dist[fid] = w;
          Q.push(initDijkstraObj(e.dst, f.dst, w))
    result = DijkstraResult[G.T, G.U](s:s, dist:dist, prev:prev)
    when G.U isnot int: result.id = g.id
  
  proc path*[T, U](d:DijkstraResult[T, U], t:U): seq[U] = 
    var u = t
    while u >= 0:
      result.add(u)
      if u == d.s: break
      u = d.prev[u]
    result.reverse()
