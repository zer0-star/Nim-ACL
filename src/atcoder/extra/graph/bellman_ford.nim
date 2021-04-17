when not declared ATCODER_BELLMAN_FORD_HPP:
  const ATCODER_BELLMAN_FORD_HPP* = 1
  import std/sequtils
  import atcoder/extra/other/inf
  import atcoder/extra/graph/graph_template
  proc bellman_ford*[G:Graph](g:G, s:G.U): (bool,seq[G.T],seq[int]) =
    let n = g.len
    var
      dist = newSeqWith(n,G.T.inf)
      prev = newSeqWith(n,-2)
      negative_cycle = false
    dist[s] = 0
    for k in 0..<n:
      for u in 0..<n:
        if dist[u] == G.T.inf: continue
        for e in g[u]:
          let t = dist[e.src] + e.weight
          if dist[e.dst] > t:
            dist[e.dst] = t
            prev[e.dst] = e.src
            if k == n-1:
              dist[e.dst] = -G.T.inf
              negative_cycle = true
    if negative_cycle:
      for k in 0..<n:
        for u in 0..<n:
          if dist[u] != -G.T.inf: continue
          for e in g[u]:
            dist[e.dst] = -G.T.inf
    return (not negative_cycle, dist, prev)
