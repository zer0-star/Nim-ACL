when not declared ATCODER_CENTROID_DECOMPOSITION_HPP:
  const ATCODER_CENTROID_DECOMPOSITION_HPP* = 1
  import atcoder/extra/graph/graph_template

  proc CentroidDecomposition*[G:Graph](g:G, root = 0):auto =
    var
      sub = newSeq[int](g.len)
      v = newSeq[bool](g.len)
      tree = initGraph[int](g.len)

    proc build_dfs(idx, par:int):int =
      sub[idx] = 1
      for e in g[idx]:
        if e.dst == par or v[e.dst]: continue
        sub[idx] += build_dfs(e.dst, idx)
      return sub[idx]

    proc search_centroid(idx, par:int, mid:int):int =
      for e in g[idx]:
        if e.dst == par or v[e.dst]: continue
        if sub[e.dst] > mid: return search_centroid(e.dst, idx, mid)
      return idx

    proc build_dfs(idx:int):int =
      let centroid = search_centroid(idx, -1, build_dfs(idx, -1) div 2)
      v[centroid] = true
      for e in g[centroid]:
        if not v[e.dst]: tree.add_edge(centroid, build_dfs(e.dst))
      v[centroid] = false
      return centroid
    let c = build_dfs(root)
    return (c, tree)
