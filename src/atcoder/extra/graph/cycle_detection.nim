when not declared ATCODER_CYCLE_DETECTION_HPP:
  const ATCODER_CYCLE_DETECTION_HPP* = 1
  import atcoder/extra/graph/graph_template
  import options

  proc cycleDetection*[T](g:Graph[T]):Option[seq[Edge[T]]] =
    var
      used = newSeq[int](g.len)
      pre = newSeq[Edge[T]](g.len)
      circle = newSeq[Edge[T]]()
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
    return seq[Edge[T]].none
