when not declared ATCODER_MAXFLOW_HPP:
  const ATCODER_MAXFLOW_HPP* = 1
  
  import src/nim_acl/internal_queue
  import std/algorithm

  type edge[Cap] = object
    dst, rev:int
    cap:Cap
  
  type mf_graph[Cap] = object
    n:int
    pos:seq[(int,int)]
    g:seq[seq[edge[Cap]]]
  
  proc init_mf_graph*[Cap](n:int):auto = mf_graph[Cap](n:n, g:newSeq[seq[edge[Cap]]](n))
  
  proc add_edge*[Cap](self: var mf_graph[Cap], src, dst:int, cap:Cap):int {.discardable.}=
    assert src in 0..<self.n
    assert dst in 0..<self.n
    assert 0 <= cap
    let m = self.pos.len
    self.pos.add((src, self.g[src].len))
    self.g[src].add(edge[Cap](dst:dst, rev:self.g[dst].len, cap:cap))
    self.g[dst].add(edge[Cap](dst:src, rev:self.g[src].len - 1, cap:0))
    return m
  
  type edge_info[Cap] = object
    src*, dst*:int
    cap*, flow*:Cap
  
  proc get_edge*[Cap](self: mf_graph[Cap], i:int):edge_info[Cap] =
    let m = self.pos.len
    assert i in 0..<m
    let e = self.g[self.pos[i][0]][self.pos[i][1]]
    let re = self.g[e.dst][e.rev]
    return edge_info[Cap](src:self.pos[i][0], dst:e.dst, cap:e.cap + re.cap, flow:re.cap)

  proc edges*[Cap](self: mf_graph[Cap]):seq[edge_info[Cap]] =
    let m = self.pos.len
    result = newSeqOfCap[edge_info[Cap]](m)
    for i in 0..<m:
      result.add(self.get_edge(i))

  proc change_edge*[Cap](self: var mf_graph[Cap], i:int, new_cap, new_flow:Cap) =
    let m = self.pos.len
    assert i in 0..<m
    assert new_flow in 0..new_cap
    var e = self.g[self.pos[i][0]][self.pos[i][1]].addr
    var re = self.g[e[].dst][e[].rev].addr
    e[].cap = new_cap - new_flow
    re[].cap = new_flow


  proc flow*[Cap](self: var mf_graph[Cap], s, t:int, flow_limit:Cap):Cap =
    assert s in 0..<self.n
    assert t in 0..<self.n
  
    var level, iter = newSeq[int](self.n)
    var que = init_simple_queue[int]()
#    internal::simple_queue<int> que;
  
    proc bfs(self: mf_graph[Cap]) =
      level.fill(-1)
      level[s] = 0
      que.clear()
      que.push(s)
      while not que.empty():
        let v = que.front()
        que.pop()
        for e in self.g[v]:
          if e.cap == 0 or level[e.dst] >= 0: continue
          level[e.dst] = level[v] + 1
          if e.dst == t: return
          que.push(e.dst)
    proc dfs(self: var mf_graph[Cap], v:int, up:Cap):Cap =
      if v == s: return up
      result = Cap(0)
      let level_v = level[v]
      var i = iter[v].addr
      while i[] < self.g[v].len:
        let e = self.g[v][i[]].addr
        if level_v <= level[e[].dst] or self.g[e[].dst][e[].rev].cap == 0:
          i[].inc
          continue
        let d = self.dfs(e.dst, min(up - result, self.g[e[].dst][e[].rev].cap))
        if d <= 0:
          i[].inc
          continue
        self.g[v][i[]].cap += d
        self.g[e[].dst][e[].rev].cap -= d
        result += d
        if result == up: break
        i[].inc

    var flow = Cap(0)
    while flow < flow_limit:
      self.bfs()
      if level[t] == -1: break
      iter.fill(0)
      while flow < flow_limit:
        let f = self.dfs(t, flow_limit - flow)
        if f == Cap(0): break
        flow += f
    return flow

  proc flow*[Cap](self: var mf_graph[Cap], s,t:int):auto = self.flow(s, t, Cap.high)

  proc min_cut*[Cap](self:mf_graph[Cap], s:int):seq[bool] =
    var visited = newSeq[bool](self.n)
    var que = init_simple_queue[int]()
    que.push(s)
    while not que.empty():
      let p = que.front()
      que.pop()
      visited[p] = true
      for e in self.g[p]:
        if e.cap != Cap(0) and not visited[e.dst]:
          visited[e.dst] = true
          que.push(e.dst)
    return visited
