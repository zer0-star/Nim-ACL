when not declared ATCODER_BFLOW_HPP:
  const ATCODER_BFLOW_HPP* = 1
  import atcoder/maxflow
  import atcoder/extra/graph/mcf_costscaling
  import std/algorithm

  type BFlow*[CAP, COST] = object
    N, E:int
    cost_bias: COST
    infeasible*: bool
    mf: MFGraph[CAP]
    mcf: MCFCostscaling[CAP, COST]
    b, fbias, f*: seq[CAP]
    fdir: seq[int]
    potential*: seq[COST]

  proc initBFlow*[CAP, COST](N = 0): BFlow[CAP, Cost] =
    BFlow[CAP, COST](N: N, E: 0, cost_bias: 0, infeasible: false, mf:initMFGraph[CAP](N + 2), mcf:initMCFCostScaling[CAP, COST](N + 2), b: newSeq[CAP](N))

  proc add_supply*[CAP, COST](self: var BFlow[CAP, COST], v: int, supply: CAP) = self.b[v] += supply
  proc add_demand*[CAP, COST](self: var BFlow[CAP, COST], v: int, demand: CAP) = self.b[v] -= demand
  proc add_edge*[CAP, COST](self: var BFlow[CAP, COST], s, t: int, lower_cap, upper_cap: CAP, cost: COST) =
    assert s in 0 ..< self.N
    assert t in 0 ..< self.N
    if lower_cap > upper_cap:
      self.infeasible = true
      return
    var (lower_cap, upper_cap) = (lower_cap, upper_cap)
    self.E.inc
    if s == t:
      if cost > 0:
        upper_cap = lower_cap
      else:
        lower_cap = upper_cap
    if cost < 0:
      self.fbias.add(lower_cap)
      self.fdir.add(-1)
      self.cost_bias += cost * upper_cap
      self.b[s] -= upper_cap
      self.b[t] += upper_cap
      self.mf.add_edge(t, s, upper_cap - lower_cap)
      self.mcf.add_edge(t, s, upper_cap - lower_cap, -cost)
    else:
      self.fbias.add(upper_cap)
      self.fdir.add(1)
      if lower_cap < 0:
        self.cost_bias += cost * lower_cap; self.b[s] -= lower_cap; self.b[t] += lower_cap
        upper_cap -= lower_cap; lower_cap = 0
      if lower_cap > 0:
        self.cost_bias += cost * lower_cap
        self.b[s] -= lower_cap
        self.b[t] += lower_cap
        upper_cap -= lower_cap
      self.mf.add_edge(s, t, upper_cap)
      self.mcf.add_edge(s, t, upper_cap, cost)

  proc solve*[CAP, COST](self: var BFlow[CAP, COST]): (bool, COST) =
    if self.infeasible: return (false, 0)
    var bsum, bsum_negative = CAP(0)
    for i in 0 ..< self.N:
      if self.b[i] > 0:
        self.mf.add_edge(self.N, i, self.b[i]); self.mcf.add_edge(self.N, i, self.b[i], 0); bsum += self.b[i]
      else:
        self.mf.add_edge(i, self.N + 1, -self.b[i]); self.mcf.add_edge(i, self.N + 1, -self.b[i], 0)
        bsum_negative -= self.b[i]
    if bsum != bsum_negative or self.mf.flow(self.N, self.N + 1) < bsum: return (false, 0)
    self.b.fill(CAP(0))
    self.mcf.add_supply(self.N, bsum)
    self.mcf.add_demand(self.N + 1, bsum)
    let ret = self.mcf.solve()
    self.potential = self.mcf.potential(); self.potential.setLen(self.N)
    let cost_ret = self.cost_bias + ret
    self.cost_bias = 0;
    self.f = self.fbias
    let edges = self.mcf.edges()
    for e in 0 ..< self.E: self.f[e] -= self.fdir[e] * (edges[e].cap - edges[e].flow)
    return (true, cost_ret)
  

