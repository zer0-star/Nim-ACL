when not declared ATCODER_CYCLE_DETECTION_HPP:
  const ATCODER_CYCLE_DETECTION_HPP* = 1
  import atcoder/extra/graph/graph_template
  import std/options, std/sequtils

  proc cycleDetection*[G:Graph](g:G):Option[seq[Edge[G.T, G.U]]] =
    type E = Edge[G.T, G.U]
    var
      used = newSeq[int](g.len)
      pre = newSeq[Edge[G.T, G.U]](g.len)
      circle = newSeq[E]()
    proc dfs(idx:int):bool =
      used[idx] = 1
      for e in g[idx]:
        if used[e.dst] == 0:
          pre[e.dst] = e
          if dfs(e.dst): return true
        elif used[e.dst] == 1:
          var cur = idx
          while cur != e.dst:
            circle.add(pre[cur])
            cur = pre[cur].src
          circle.add(e)
          return true
      used[idx] = 2
      return false

    for i in 0..<g.len:
      if used[i] == 0 and dfs(i):
        circle.reverse
        return circle.some
    return seq[E].none

  proc cycleDetectionUndirected*[G:Graph](g:G):Option[seq[Edge[G.T, G.U]]] =
    type E = Edge[G.T, G.U]
    var
      vis = newSeqWith(g.len, false)
      ancestor = newSeqWith(g.len, -1)
      circle = newSeq[E]()
    proc dfs(u, p = -1, h = 0):bool =
      vis[u] = true
      ancestor[u] = h
      for i,e in g[u]:
        if i == p: continue
        if ancestor[e.dst] >= 0:
          circle = circle[ancestor[e.dst]..<circle.len] & e
          return true
        circle.add(e)
        if dfs(e.dst, e.rev, h + 1): return true
        discard circle.pop()
      ancestor[u] = -1
      return false
    for u in 0..<g.len:
      if vis[u]: continue
      if dfs(u): return circle.some
    return seq[E].none
