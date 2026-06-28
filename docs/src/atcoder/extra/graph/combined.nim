import macros
macro Please(x): untyped = nnkStmtList.newTree()

Please use Nim-ACL
Please use Nim-ACL
Please use Nim-ACL


when not declared ATCODER_MAXFLOW_LOWERBOUND_HPP:
  const ATCODER_MAXFLOW_LOWERBOUND_HPP* = 1
  #[ import atcoder/maxflow ]#
  when not declared ATCODER_MAXFLOW_HPP:
    const ATCODER_MAXFLOW_HPP* = 1
    
    #[ import atcoder/internal_queue ]#
    when not declared ATCODER_INTERNAL_QUEUE_HPP:
      const ATCODER_INTERNAL_QUEUE_HPP* = 1
    
      type simple_queue[T] = object
        payload:seq[T]
        pos:int
      proc init_simple_queue*[T]():auto = simple_queue[T](payload:newSeq[T](), pos:0)
    # TODO
    #      void reserve(int n) { payload.reserve(n); }
      proc len*[T](self:simple_queue[T]):int = self.payload.len - self.pos
      proc empty*[T](self:simple_queue[T]):bool = self.pos == self.payload.len
      proc push*[T](self:var simple_queue[T], t:T) = self.payload.add(t)
      proc front*[T](self:simple_queue[T]):T = self.payload[self.pos]
      proc clear*[T](self:var simple_queue[T]) =
        self.payload.setLen(0)
        self.pos = 0;
      proc pop*[T](self:var simple_queue[T]) = self.pos.inc
      discard
    import std/algorithm
  
    type MFInternalEdge[Cap] = object
      dst, rev:int
      cap:Cap
    
    type MFGraph*[Cap] = object
      len*:int
      pos:seq[(int,int)]
      g:seq[seq[MFInternalEdge[Cap]]]
    
    proc init_mf_graph*[Cap](n:int):auto = MFGraph[Cap](len:n, g:newSeq[seq[MFInternalEdge[Cap]]](n))
    proc initMaxFlow*[Cap](n:int):auto = MFGraph[Cap](len:n, g:newSeq[seq[MFInternalEdge[Cap]]](n))
    
    proc add_edge*[Cap](self: var MFGraph[Cap], src, dst:int, cap:Cap):int {.discardable.}=
      assert src in 0..<self.len
      assert dst in 0..<self.len
      assert 0.Cap <= cap
      let m = self.pos.len
      self.pos.add((src, self.g[src].len))
      var src_id = self.g[src].len
      var dst_id = self.g[dst].len
      if src == dst: dst_id.inc
      self.g[src].add(MFInternalEdge[Cap](dst:dst, rev:dst_id, cap:cap))
      self.g[dst].add(MFInternalEdge[Cap](dst:src, rev:src_id, cap:0))
      return m
    
    type MFEdge*[Cap] = object
      src*, dst*:int
      cap*, flow*:Cap
    
    proc get_edge*[Cap](self: MFGraph[Cap], i:int):MFEdge[Cap] =
      let m = self.pos.len
      assert i in 0..<m
      let e = self.g[self.pos[i][0]][self.pos[i][1]]
      let re = self.g[e.dst][e.rev]
      return MFEdge[Cap](src:self.pos[i][0], dst:e.dst, cap:e.cap + re.cap, flow:re.cap)
  
    proc edges*[Cap](self: MFGraph[Cap]):seq[MFEdge[Cap]] =
      let m = self.pos.len
      result = newSeqOfCap[MFEdge[Cap]](m)
      for i in 0..<m:
        result.add(self.get_edge(i))
  
    proc change_edge*[Cap](self: var MFGraph[Cap], i:int, new_cap, new_flow:Cap) =
      let m = self.pos.len
      assert i in 0..<m
      assert new_flow in 0..new_cap
      var e = self.g[self.pos[i][0]][self.pos[i][1]].addr
      var re = self.g[e[].dst][e[].rev].addr
      e[].cap = new_cap - new_flow
      re[].cap = new_flow
  
    proc flow*[Cap](self: var MFGraph[Cap], s, t:int, flow_limit:Cap):Cap =
      assert s in 0..<self.len
      assert t in 0..<self.len
      assert s != t
    
      var level, iter = newSeq[int](self.len)
      var que = init_simple_queue[int]()
  #    internal::simple_queue<int> que;
    
      proc bfs(self: MFGraph[Cap]) =
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
      proc dfs(self: var MFGraph[Cap], v:int, up:Cap):Cap =
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
          if result == up: return
          i[].inc
        level[v] = self.len
  
      var flow = Cap(0)
      while flow < flow_limit:
        self.bfs()
        if level[t] == -1: break
        iter.fill(0)
        let f = self.dfs(t, flow_limit - flow)
        if f == Cap(0): break
        flow += f
      return flow
  
    proc flow*[Cap](self: var MFGraph[Cap], s,t:int):auto = self.flow(s, t, Cap.high)
  
    proc min_cut*[Cap](self:MFGraph[Cap], s:int):seq[bool] =
      var visited = newSeq[bool](self.len)
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
    discard
  import std/options
  
  type MaxFlowLowerBound*[Cap] = object
    flow: MFGraph[Cap]
    in_cap, up_cap: seq[Cap]
    #typename F< flow_t >::edge *latte, *malta;
    #latte, malta:int
    X, Y, V:int
    sum:Cap
  
  proc initMaxFlowLowerBound*[Cap](V:int):MaxFlowLowerBound[Cap] =
    MaxFlowLowerBound[Cap](V:V, flow:initMFGraph[Cap](V + 2), X:V, Y:V + 1, sum:Cap(0), in_cap:newSeq[Cap](V))
  
  proc add_edge*[Cap](self: var MaxFlowLowerBound[Cap], src, dst:int, low, high: Cap) =
    doAssert src != dst
    self.flow.add_edge(src, dst, high - low)
    self.in_cap[src] -= low
    self.in_cap[dst] += low
    self.up_cap.add(high)
  
  proc build*[Cap](self: var MaxFlowLowerBound[Cap]) =
    for i in 0..<self.V:
      if self.in_cap[i] > 0:
        self.flow.add_edge(self.X, i, self.in_cap[i]) # TODO: cost直す
        self.sum += self.in_cap[i]
      elif self.in_cap[i] < 0:
        self.flow.add_edge(i, self.Y, -self.in_cap[i])
  
  proc can_flow*[Cap](self: var MaxFlowLowerBound[Cap]):bool =
    self.build()
    var ret = self.flow.flow(self.X, self.Y)
    echo "base: ", ret
    return ret.cap >= self.sum
  
  proc can_flow*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):bool =
    assert s != t
    self.flow.add_edge(t, s, Cap.high div 10, 0)
    #self.latte = &flow.graph[t].back()
    #self.malta = &flow.graph[s].back()
    return self.can_flow()
  
  proc max_flow*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):Option[Cap] =
    if self.can_flow(s, t):
#      self.flow.reset
      return self.flow.flow(s, t).some
    else:
      return result.T.none
  
  proc slope*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):Option[seq[Cap]] =
    if self.can_flow(s, t):
#      self.flow.reset
  #    return self.flow.slope(s, t).some
      return self.flow.slope(s, t).some
    else:
      return result.T.none
  
  
  #flow_t min_flow(int s, int t) {
  #  if(can_flow(s, t)) {
  #    auto ret = flow.INF - latte->cap;
  #    latte->cap = malta->cap = 0;
  #    return ret - flow.max_flow(t, s);
  #  } else {
  #    return -1;
  #  }
  #}
  #
  #void output(int M) {
  #  vector< flow_t > ans(M);
  #  for(int i = 0; i < flow.graph.size(); i++) {
  #    for(auto &e : flow.graph[i]) {
  #      if(!e.isrev && ~e.idx) ans[e.idx] = up[e.idx] - e.cap;
  #    }
  #  }
  #  for(auto &p : ans) cout << p << endl;
  #}
  
var g = initMaxFlowLowerBound[int](3)
g.addEdge(0, 1, 1, 2)
g.addEdge(1, 2, 2, 3)
echo g.slope(0, 2)

