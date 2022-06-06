when not declared ATCODER_MAXFLOW_LOWERBOUND_HPP:
  const ATCODER_MAXFLOW_LOWERBOUND_HPP* = 1
  import atcoder/maxflow
  import std/options
  
  type MaxFlowLowerBound*[Cap] = object
    flow: MFGraph[Cap]
    in_cap, up_cap: seq[Cap]
    #typename F< flow_t >::edge *latte, *malta;
    #latte, malta:int
    X, Y, V: int
    sum: Cap
  
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
    #echo "base: ", ret
    return ret >= self.sum
  
  proc can_flow*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):bool =
    assert s != t
    self.flow.add_edge(t, s, Cap.high div 10)
    #self.latte = &flow.graph[t].back()
    #self.malta = &flow.graph[s].back()
    return self.can_flow()
  
  proc max_flow*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):Option[Cap] =
    if self.can_flow(s, t):
#      self.flow.reset
      return self.flow.flow(s, t).some
    else:
      return result.T.none
  
  #proc slope*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):Option[seq[Cap]] =
  #  if self.can_flow(s, t):
# #     self.flow.reset
  ##    return self.flow.slope(s, t).some
  #    return self.flow.slope(s, t).some
  #  else:
  #    return result.T.none
  
  
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
  
#var g = initMaxFlowLowerBound[int](3)
#g.addEdge(0, 1, 1, 2)
#g.addEdge(1, 2, 2, 3)
#echo g.max_flow(0, 2)

