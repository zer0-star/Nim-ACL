when not declared ATCODER_LOWLINK_HPP:
  const ATCODER_LOWLINK_HPP* = 1
  import atcoder/extra/graph/graph_template
  proc LowLink*(g:Graph):tuple[articulation:seq[int], bridge:seq[(int,int)]] =
    var
      used = newSeq[bool](g.len)
      ord = newSeq[int](g.len)
      low = newSeq[int](g.len)
      bridge = newSeq[(int,int)]()
      articulation = newSeq[int]()
    proc dfs(idx, k, par:int):int =
      var k = k
      used[idx] = true
      ord[idx] = k
      k += 1
      low[idx] = ord[idx]
      var
        is_articulation = false
        cnt = 0
      for e in g[idx]:
        if not used[e.dst]:
          cnt += 1
          k = dfs(e.dst, k, idx)
          low[idx] = min(low[idx], low[e.dst]);
          is_articulation = (is_articulation or (par != -1 and low[e.dst] >= ord[idx]))
          if ord[idx] < low[e.dst]: bridge.add((min(idx, e.dst), max(idx, e.dst)))
        elif e.dst != par:
          low[idx] = min(low[idx], ord[e.dst]);
      is_articulation = (is_articulation or (par == -1) and cnt > 1)
      if is_articulation: articulation.add(idx)
      return k
  
    var k = 0
    for i in 0..<g.len:
      if not used[i]: k = dfs(i, k, -1)
    return (articulation, bridge)
