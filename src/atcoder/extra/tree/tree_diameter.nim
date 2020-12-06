when not declared ATCODER_TREE_DIAMETER_HPP:
  const ATCODER_TREE_DIAMETER_HPP* = 1
  import atcoder/extra/graph/graph_template
  import std/sequtils
  proc treeDiameter*[T](g:Graph[T]):(T, seq[int]) =
    var next = newSeq[int](g.len)
    proc dfs(idx, par:int):(T, int) =
      result[1] = idx
      for i,e in g[idx]:
        if e.dst == par: continue
        var cost = dfs(e.dst, idx)
        cost[0] += e.weight
        if result[0] < cost[0]:
          next[idx] = i
          result = cost
    let p = dfs(0, -1)
    next = newSeqWith(g.len, -1)
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
