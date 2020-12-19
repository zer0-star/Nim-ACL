when not declared ATCODER_BELLMAN_FORD_HPP:
  const ATCODER_BELLMAN_FORD_HPP* = 1
  import std/sequtils
  import atcoder/extra/graph/graph_template
  proc bellman_ford*[T](g:Graph[T], s:int): (bool,seq[T],seq[int]) =
    let n = g.len
    var
      dist = newSeqWith(n,T.inf)
      prev = newSeqWith(n,-2)
      negative_cycle = false
    dist[s] = 0
    for k in 0..<n:
      for u in 0..<n:
        if dist[u] == T.inf: continue
        for e in g[u]:
          let t = dist[e.src] + e.weight
          if dist[e.dst] > t:
            dist[e.dst] = t
            prev[e.dst] = e.src
            if k == n-1:
              dist[e.dst] = -T.inf
              negative_cycle = true
    if negative_cycle:
      for k in 0..<n:
        for u in 0..<n:
          if dist[u] != -T.inf: continue
          for e in g[u]:
            dist[e.dst] = -T.inf
    return (not negative_cycle, dist, prev)
