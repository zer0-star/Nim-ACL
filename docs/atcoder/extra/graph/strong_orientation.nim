when not declared ATCODER_STRONG_ORIENTATION_HPP:
  const ATCODER_STRONG_ORIENTATION_HPP* = 1
  import atcoder/extra/graph/graph_template
  import std/sequtils
  proc strong_orienation*[G:Graph](g:G, es:Edges[G.T, G.U]):seq[int] =
    let
      N = g.len
      M = es.len
    var
      tin = newSeqWith(N, -1)
      low = newSeqWith(N, -1)
      bridge_cnt = 0
      ans = newSeq[int](M)
      edge_used = newSeq[bool](M)
      time = 0
    proc find_bridges(v:int) =
      low[v] = time
      tin[v] = time
      time.inc
      for e in g[v]:
        let i = e.weight
        if edge_used[i]: continue
        edge_used[i] = true
        ans[i] = if v == es[i].src: 1 else: -1
        let nv = e.dst;
        if tin[nv] == -1: # if nv is not visited yet
          find_bridges(nv)
          low[v] = min(low[v], low[nv])
          if low[nv] > tin[v]:
            # a bridge between v and nv
            bridge_cnt.inc
        else:
          low[v] = min(low[v], low[nv])
    for v in 0..<N:
      if tin[v] == -1:
        find_bridges(v)
    return ans


