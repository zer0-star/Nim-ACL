when not declared ATCODER_TREE_DIAMETER_HPP:
  const ATCODER_TREE_DIAMETER_HPP* = 1
  import atcoder/extra/graph/graph_template

  proc treeDiameter*[G:Graph](g:G):tuple[len:G.T, path:seq[G.U]] =
    var next = newSeq[int](g.len)
    proc dfs(idx, par:int):(G.T, int) =
      result = (G.T(0), idx)
      for i,e in g[idx]:
        if e.dst == par: continue
        var cost = dfs(e.dst, idx)
        cost[0] += e.weight
        if result[0] < cost[0]:
          next[idx] = i
          result = cost
    let p = dfs(0, -1)
    next.fill(-1)
    let q = dfs(p[1], -1)
    var
      ans = newSeq[int]()
      u = p[1]
    while true:
      ans.add(u)
      let idx = next[u]
      if idx == -1:break
      u = g[u][idx].dst
    return (q[0], ans)
  proc centroid*[U](path:seq[U]):seq[U] =
    let u = path.len div 2
    if path.len mod 2 == 0:
      @[path[u - 1], path[u]]
    else:
      @[path[u]]
