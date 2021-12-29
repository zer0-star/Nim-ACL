when not declared ATCODER_MINCOSTFLOW_LOWERBOUND_HPP:
  const ATCODER_MINCOSTFLOW_LOWERBOUND_HPP* = 1
  import lib/graph/mincostflow_generalized
  import std/options
  
  type MinCostFlowLowerBound*[Cap, Cost] = object
    flow: MCFGraph[Cap, Cost, GRAPHTYPE_POSITIVEEDGE]
    in_cap, up_cap: seq[Cap]
    #typename F< flow_t >::edge *latte, *malta;
    #latte, malta:int
    X, Y, V:int
    sum:Cap
  
  proc initMinCostFlowLowerBound*[Cap, Cost, GraphType](V:int):MinCostFlowLowerBound[Cap, Cost] =
    MinCostFlowLowerBound[Cap, Cost](V:V, flow:initMCFGraph[Cap, Cost, GraphType](V + 2), X:V, Y:V + 1, sum:Cap(0), in_cap:newSeq[Cap](V))
  
  proc add_edge*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], src, dst:int, low, high: Cap, cost:Cost) =
    doAssert src != dst
    self.flow.add_edge(src, dst, high - low, cost)
    self.in_cap[src] -= low
    self.in_cap[dst] += low
    self.up_cap.add(high)
  
  proc build*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost]) =
    for i in 0..<self.V:
      if self.in_cap[i] > 0:
        self.flow.add_edge(self.X, i, self.in_cap[i], Cost(0)) # TODO: cost直す
        self.sum += self.in_cap[i]
      elif self.in_cap[i] < 0:
        self.flow.add_edge(i, self.Y, -self.in_cap[i], Cost(0))
  
  proc can_flow*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost]):bool =
    self.build()
    var ret = self.flow.flow(self.X, self.Y)
    echo "base: ", ret
    return ret.cap >= self.sum
  
  proc can_flow*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], s, t:int):bool =
    assert s != t
    self.flow.add_edge(t, s, Cap.inf div 10, 0)
    #self.latte = &flow.graph[t].back()
    #self.malta = &flow.graph[s].back()
    return self.can_flow()
  
  proc max_flow*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], s, t:int):Option[(Cap, Cost)] =
    if self.can_flow(s, t):
#      self.flow.reset
      return self.flow.flow(s, t).some
    else:
      return result.T.none
  
  proc slope*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], s, t:int):Option[seq[(Cap, Cost)]] =
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
  
  
  
