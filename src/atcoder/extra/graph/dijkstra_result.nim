when not declared ATCODER_DIJKSTRA_RESULT_HPP:
  const ATCODER_DIJKSTRA_RESULT_HPP* = 1
  import std/algorithm
  type DijkstraResult*[T, U] = object
    dist*: seq[T]
    prev*: seq[U]
    when U isnot int:
      id*: proc(u:U):int
  proc `[]`*[T, U](d:DijkstraResult[T, U], u:U):T =
    let u = when U isnot int: d.id(u) else: u
    d.dist[u]
  proc prev*[T, U](d:DijkstraResult[T, U], u:U):U =
    let u = when U isnot int: d.id(u) else: u
    d.prev[u]
  proc path*[T, U](d:DijkstraResult[T, U], t:U): seq[U] = 
    var u = t
    while u >= 0:
      result.add(u)
#      if u == d.s: break
      if u == d.prev[u]: break
      u = d.prev[u]
    result.reverse()
