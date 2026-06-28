when not declared ATCODER_DIJKSTRA_RESULT_HPP:
  const ATCODER_DIJKSTRA_RESULT_HPP* = 1
  import std/algorithm
  import atcoder/extra/graph/graph_template
  type DijkstraResult*[T, U, useId] = object
    a*: NodeArray[U, tuple[dist:T, prev_set:bool, prev:U], useId]
  proc contains*[T, U, useId](d:var DijkstraResult[T, U, useId], u:U):bool =
    u in d.a
  proc `[]`*[T, U, useId](d:var DijkstraResult[T, U, useId], u:U):T =
    d.a[u][].dist
  proc prev*[T, U, useId](d:var DijkstraResult[T, U, useId], u:U):U =
    d.a[u][].prev
  proc path*[T, U, useId](d:var DijkstraResult[T, U, useId], t:U): seq[U] = 
    var u = t
    while true:
      result.add(u)
#      if u == d.s: break
      var p = d.prev(u)
      if u == p: break
      u = p
    result.reverse()
