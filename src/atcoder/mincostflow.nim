when not declared ATCODER_MINCOSTFLOW_HPP:
  const ATCODER_MINCOSTFLOW_HPP* = 1

  import std/heapqueue, std/algorithm
  import atcoder/internal_csr, atcoder/internal_queue, atcoder/internal_heap

  type MCFEdge*[Cap, Cost] = object
    src*, dst*: int
    cap*, flow*: Cap
    cost*: Cost

  type MCFInternalEdge[Cap, Cost] = object
    dst, rev: int
    cap: Cap
    cost: Cost

  type MCFGraph*[Cap, Cost] = object
    n:int
    edges:seq[MCFEdge[Cap, Cost]]
  
  proc initMCFGraph*[Cap, Cost](n:int):MCFGraph[Cap, Cost] = result.n = n
  proc initMinCostFLow*[Cap, Cost](n:int):MCFGraph[Cap, Cost] = result.n = n

  proc add_edge*[Cap, Cost](self: var MCFGraph[Cap, Cost], src, dst:int, cap:Cap, cost:Cost):int {.discardable.} =
    assert src in 0..<self.n
    assert dst in 0..<self.n
    assert 0 <= cap
    assert 0 <= cost
    var m = self.edges.len
    self.edges.add(MCFEdge[Cap, Cost](src:src, dst:dst, cap:cap, flow:0, cost:cost))
    return m

  proc get_edge*[Cap, Cost](self:MCFGraph[Cap, Cost], i:int): MCFEdge[Cap, Cost] =
    let m = self.edges.len
    assert i in 0..<m
    return self.edges[i]

  proc edges*[Cap, Cost](self:var MCFGraph[Cap, Cost]):seq[MCFEdge[Cap, Cost]] = self.edges
  type MCFQ[Cost] = object
    key:Cost
    dst:int
  proc `<`*[Cost](l, r:MCFQ[Cost]):bool = l.key > r.key

  proc slope*[Cap, Cost](self: MCFGraph[Cap, Cost], g:var csr[MCFInternalEdge[Cap, Cost]], s, t:int, flow_limit:Cap):seq[tuple[cap:Cap, cost:Cost]] =
    ## variants (C = maxcost):
    ## -(n-1)C <= dual[s] <= dual[i] <= dual[t] = 0
    ## reduced cost (= e.cost + dual[e.src] - dual[e.to]) >= 0 for all edge

    ## dual_dist[i] = (dual[i], dist[i])
    var
      dual_dist = newSeq[tuple[dual, dist:Cost]](self.n)
      prev_e = newSeq[int](self.n)
      vis = newSeq[bool](self.n)
      que_min = newSeq[int]()
      que = newSeq[MCFQ[Cost]]()
    proc dual_ref(g:csr[MCFInternalEdge[Cap, Cost]]):bool =
      for i in 0..<self.n: dual_dist[i].dist = Cost.high
      vis.fill(false)
      que_min.setLen(0)
      que.setLen(0)

      # que[0..heap_r) was heapified
      var heap_r = 0

      dual_dist[s].dist = 0
      que_min.add(s)
      while que_min.len > 0 or que.len > 0:
        var v:int
        if que_min.len > 0:
          v = que_min.pop()
        else:
          while heap_r < que.len:
            heap_r.inc
            que.push_heap(0 ..< heap_r)
          v = que[0].dst
          que.pop_heap(0 ..< que.len)
          discard que.pop()
          heap_r.dec
        if vis[v]: continue
        vis[v] = true
        if v == t: break
        ## dist[v] = shortest(s, v) + dual[s] - dual[v]
        ## dist[v] >= 0 (all reduced cost are positive)
        ## dist[v] <= (n-1)C
        let (dual_v, dist_v) = dual_dist[v]
        for i in g.start[v] ..< g.start[v + 1]:
          let e = g.elist[i]
          if e.cap == Cap(0): continue
          ## |-dual[e.to] + dual[v]| <= (n-1)C
          ## cost <= C - -(n-1)C + 0 = nC
          let cost = e.cost - dual_dist[e.dst].dual + dual_v
          if dual_dist[e.dst].dist - dist_v > cost:
            let dist_to = dist_v + cost
            dual_dist[e.dst].dist = dist_to
            prev_e[e.dst] = e.rev
            if dist_to == dist_v:
              que_min.add(e.dst)
            else:
              que.add(MCFQ[Cost](key:dist_to, dst:e.dst))
      if not vis[t]:
        return false

      for v in 0..<self.n:
        if not vis[v]: continue
        # dual[v] = dual[v] - dist[t] + dist[v]
        #     = dual[v] - (shortest(s, t) + dual[s] - dual[t]) +
        #     (shortest(s, v) + dual[s] - dual[v]) = - shortest(s,
        #     t) + dual[t] + shortest(s, v) = shortest(s, v) -
        #     shortest(s, t) >= 0 - (n-1)C
        dual_dist[v].dual -= dual_dist[t].dist - dual_dist[v].dist
      return true
    var
      flow:Cap = 0
      cost:Cost = 0
      prev_cost_per_flow:Cost = -1
    result = @[(Cap(0), Cost(0))]
    while flow < flow_limit:
      if not g.dual_ref(): break
      var c = flow_limit - flow
      block:
        var v = t
        while v != s:
          c = min(c, g.elist[g.elist[prev_e[v]].rev].cap)
          v = g.elist[prev_e[v]].dst
      block:
        var v = t
        while v != s:
          var e = g.elist[prev_e[v]].addr
          e[].cap += c
          g.elist[e[].rev].cap -= c
          v = g.elist[prev_e[v]].dst
      let d = -dual_dist[s].dual
      flow += c
      cost += c * d
      if prev_cost_per_flow == d:
        discard result.pop()
      result.add((flow, cost))
      prev_cost_per_flow = d

  proc slope*[Cap, Cost](self:var MCFGraph[Cap, Cost], s, t:int, flow_limit:Cap):seq[tuple[cap:Cap, cost:Cost]] =
    assert s in 0..<self.n
    assert t in 0..<self.n
    assert s != t

    let m = self.edges.len
    var edge_idx = newSeq[int](m)

    var g = block:
      var degree = newSeq[int](self.n)
      var redge_idx = newSeq[int](m)
      var elist = newSeqOfCap[(int, MCFInternalEdge[Cap, Cost])](2 * m)
      for i in 0..<m:
        let e = self.edges[i]
        edge_idx[i] = degree[e.src]
        degree[e.src].inc
        redge_idx[i] = degree[e.dst]
        degree[e.dst].inc
        elist.add((e.src, MCFInternalEdge[Cap, Cost](dst: e.dst, rev: -1, cap:e.cap - e.flow, cost:e.cost)))
        elist.add((e.dst, MCFInternalEdge[Cap, Cost](dst: e.src, rev: -1, cap:e.flow, cost: -e.cost)))
      var g = initCSR[MCFInternalEdge[Cap, Cost]](self.n, elist)
      for i in 0..<m:
        let e = self.edges[i]
        edge_idx[i] += g.start[e.src]
        redge_idx[i] += g.start[e.dst]
        g.elist[edge_idx[i]].rev = redge_idx[i];
        g.elist[redge_idx[i]].rev = edge_idx[i];
      g

    result = self.slope(g, s, t, flow_limit)

    for i in 0..<m:
      let e = g.elist[edge_idx[i]]
      self.edges[i].flow = self.edges[i].cap - e.cap
  proc flow*[Cap, Cost](self:var MCFGraph[Cap, Cost], s, t:int, flow_limit:Cap):tuple[cap:Cap, cost:Cost] = self.slope(s, t, flow_limit)[^1]
  proc flow*[Cap, Cost](self:var MCFGraph[Cap, Cost], s, t:int):tuple[cap:Cap, cost:Cost] = self.flow(s, t, Cap.high)
  proc slope*[Cap, Cost](self:var MCFGraph[Cap, Cost], s, t:int):seq[tuple[cap:Cap, cost:Cost]] = self.slope(s, t, Cap.high)

  #### chaemon added
  proc reset*[Cap, Cost](self: var MCFGraph[Cap, Cost]) =
    for e in self.edges.mitems:
      e.flow = 0

  proc set_edge*[Cap, Cost](self: var MCFGraph[Cap, Cost], i:int, cap:Cap, cost:Cost) =
    assert 0 <= cap
    assert 0 <= cost
    var m = self.edges.len
    assert i in 0 ..< m
    edges[i].cap = cap
    edges[i].cost = cost
