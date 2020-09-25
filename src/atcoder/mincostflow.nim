when not declared ATCODER_MINCOSTFLOW_HPP:
  const ATCODER_MINCOSTFLOW_HPP* = 1

  import std/heapqueue, std/sequtils

  type Edge*[Cap, Cost] = object
    dst, rev:int
    cap:Cap
    cost:Cost

  type MCFGraph*[Cap, Cost] = object
    n:int
    pos:seq[(int,int)]
    g:seq[seq[Edge[Cap, Cost]]]

  type EdgeInfo*[Cap, Cost] = object
    src*, dst*:int
    cap*, flow*: Cap
    cost*: Cost

  proc initMCFGraph*[Cap, Cost](n:int):auto = MCFGraph[Cap, Cost](n:n, g:newSeq[seq[Edge[Cap, Cost]]](n))

  proc add_edge*[Cap, Cost](self: var MCFGraph[Cap, Cost], src:int, dst:int, cap:Cap, cost:Cost):int {.discardable.} =
    assert src in 0..<self.n
    assert dst in 0..<self.n
    assert 0.Cap <= cap
    assert 0.Cost <= cost
    let m = self.pos.len
    self.pos.add((src, self.g[src].len))
    var
      src_id = self.g[src].len
      dst_id = self.g[dst].len
    if src == dst: dst_id.inc
    self.g[src].add(Edge[Cap, Cost](dst:dst, rev:dst_id, cap:cap, cost:cost))
    self.g[dst].add(Edge[Cap, Cost](dst:src, rev:src_id, cap:Cap(0), cost: -cost))
    return m

  proc get_edge*[Cap, Cost](self: MCFGraph[Cap, Cost], i:int):EdgeInfo[Cap, Cost] =
    let m = self.pos.len
    assert 0 <= i and i < m
    let e = self.g[self.pos[i][0]][self.pos[i][1]]
    let re = self.g[e.dst][e.rev]
    return EdgeInfo[Cap, Cost](src:self.pos[i][0], dst:e.dst, cap:e.cap + re.cap, flow:re.cap, cost:e.cost)

  proc edges*[Cap, Cost](self: MCFGraph[Cap, Cost]):seq[EdgeInfo[Cap, Cost]] =
    let m = self.pos.len
    result = newSeq[EdgeInfo[Cap, Cost]](m)
    for i in 0..<m:
      result[i] = self.get_edge(i)

  proc slope*[Cap, Cost](self: var MCFGraph[Cap, Cost], s, t:int, flow_limit:Cap):seq[(Cap, Cost)] =
    assert s in 0..<self.n
    assert t in 0..<self.n
    assert s != t
    # variants (C = maxcost):
    # -(n-1)C <= dual[s] <= dual[i] <= dual[t] = 0
    # reduced cost (= e.cost + dual[e.src] - dual[e.to]) >= 0 for all edge
    var
      dual = newSeqWith(self.n, Cost(0))
      dist = newSeq[Cost](self.n)
      pv, pe = newSeq[int](self.n)
      vis = newSeq[bool](self.n)
    proc dual_ref(self:var MCFGraph[Cap, Cost]):bool =
      for p in dist.mitems: p = Cost.high
      for p in pv.mitems: p = -1
      for p in pe.mitems: p = -1
      for p in vis.mitems: p = false
#      dist.fill(Cost.high)
#      pv.fill(-1)
#      pe.fill(-1)
#      vis.fill(false)
      type Q = tuple[key:Cost, dst:int]
      proc `<`(l,r:Q):bool = l.key < r.key

      var que = initHeapQueue[Q]()
      dist[s] = 0
      que.push((Cost(0), s))
      while que.len > 0:
        let v = que.pop().dst
        if vis[v]: continue
        vis[v] = true
        if v == t: break
        # dist[v] = shortest(s, v) + dual[s] - dual[v]
        # dist[v] >= 0 (all reduced cost are positive)
        # dist[v] <= (n-1)C
        for i in 0..<self.g[v].len:
          let e = self.g[v][i]
          if vis[e.dst] or e.cap == 0: continue
          # |-dual[e.dst] + dual[v]| <= (n-1)C
          # cost <= C - -(n-1)C + 0 = nC
          let cost = e.cost - dual[e.dst] + dual[v]
          if dist[e.dst] - dist[v] > cost:
            dist[e.dst] = dist[v] + cost
            pv[e.dst] = v
            pe[e.dst] = i
            que.push((dist[e.dst], e.dst))
      if not vis[t]:
        return false

      for v in 0..<self.n:
        if not vis[v]: continue
        # dual[v] = dual[v] - dist[t] + dist[v]
        #     = dual[v] - (shortest(s, t) + dual[s] - dual[t]) + (shortest(s, v) + dual[s] - dual[v])
        #     = - shortest(s, t) + dual[t] + shortest(s, v)
        #     = shortest(s, v) - shortest(s, t) >= 0 - (n-1)C
        dual[v] -= dist[t] - dist[v]
      return true
    var
      flow = Cap(0)
      cost = Cost(0)
      prev_cost_per_flow = -1
    result = newSeq[(Cap, Cost)]()
    result.add((flow, cost))
    while flow < flow_limit:
      if not self.dual_ref(): break
      var c = flow_limit - flow
      var v = t
      while v != s:
        c = min(c, self.g[pv[v]][pe[v]].cap)
        v = pv[v]
      v = t
      while v != s:
        var e = self.g[pv[v]][pe[v]].addr
        e[].cap -= c
        self.g[v][e[].rev].cap += c
        v = pv[v]
      let d = -dual[s]
      flow += c
      cost += c * d
      if prev_cost_per_flow == d:
        discard result.pop()
      result.add((flow, cost))
#      prev_cost_per_flow = cost
      prev_cost_per_flow = d
  proc flow*[Cap, Cost](self: var MCFGraph[Cap, Cost], s,t:int, flow_limit:Cap):(Cap, Cost) =
    self.slope(s, t, flow_limit)[^1]
  proc flow*[Cap, Cost](self: var MCFGraph[Cap, Cost], s,t:int):(Cap, Cost) =
    self.flow(s, t, Cap.high)
  proc slope*[Cap, Cost](self: var MCFGraph[Cap, Cost], s,t:int):seq[(Cap, Cost)] =
    self.slope(s, t, Cap.high)
