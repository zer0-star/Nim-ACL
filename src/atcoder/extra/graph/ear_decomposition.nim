when not declared ATCODER_EAR_DECOMPOSITION_HPP:
  const ATCODER_EAR_DECOMPOSITION_HPP* = 1
  import atcoder/extra/graph/graph_template
  import sequtils
  proc ear_decomposition*(g:Graph):seq[seq[seq[tuple[u, i:int]]]] =
    var
      parent_edge_index = newSeqWith(g.len, -1)
      dfs_visited, ear_visited = newSeq[bool](g.len)
      edge_visited = newSeq[seq[bool]](g.len)
    for u in g.len:
      edge_visited[u] = newSeq[bool](g[u].len)
    proc parent(u:int):int =
      if parent_edge_index[u] == -1: return -1
      else: return g[u][parent_edge_index[u]].dst
    for root in 0 ..< g.len:
      if dfs_visited[root]:
        continue
      # Perform a DFS
      var queue: seq[int]
      proc dfs(u:int) =
        dfs_visited[u] = true
        queue.add(u)
        for i, e in g[u]:
          let v = e.dst
          if dfs_visited[v]: continue
          parent_edge_index[v] = e.rev
          dfs(v)
      dfs(root)
      var ears:seq[seq[tuple[u, i:int]]]
      for u in queue:
        for i,e in g[u]:
          let v = e.dst
          if edge_visited[u][i]: continue
          if parent_edge_index[u] == i or parent_edge_index[v] == e.rev:
            continue
          # Found a backedge. Now traverse the ear.
          var ear = @[(u, i)]
          ear_visited[u] = true
          #edge_visited[u][i] = true # いらない?
          edge_visited[v][e.rev] = true
          var x = v
          while true:
            if ear_visited[x]:
              break
            ear.add((x, parent_edge_index[x]))
            ear_visited[x] = true
            x = parent(x)
          ears.add(ear)
      result.add(ears)
