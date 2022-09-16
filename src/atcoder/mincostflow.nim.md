---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_heap.nim
    title: atcoder/internal_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_heap.nim
    title: atcoder/internal_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/min_cost_flow_test.nim
    title: verify/min_cost_flow_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/min_cost_flow_test.nim
    title: verify/min_cost_flow_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MINCOSTFLOW_HPP:\n  const ATCODER_MINCOSTFLOW_HPP*\
    \ = 1\n\n  import std/heapqueue, std/algorithm\n  import atcoder/internal_csr,\
    \ atcoder/internal_queue, atcoder/internal_heap\n\n  type MCFEdge*[Cap, Cost]\
    \ = object\n    src*, dst*: int\n    cap*, flow*: Cap\n    cost*: Cost\n\n  type\
    \ MCFInternalEdge[Cap, Cost] = object\n    dst, rev: int\n    cap: Cap\n    cost:\
    \ Cost\n\n  type MCFGraph*[Cap, Cost] = object\n    n:int\n    edges:seq[MCFEdge[Cap,\
    \ Cost]]\n  \n  proc initMCFGraph*[Cap, Cost](n:int):MCFGraph[Cap, Cost] = result.n\
    \ = n\n  proc initMinCostFLow*[Cap, Cost](n:int):MCFGraph[Cap, Cost] = result.n\
    \ = n\n\n  proc add_edge*[Cap, Cost](self: var MCFGraph[Cap, Cost], src, dst:int,\
    \ cap:Cap, cost:Cost):int {.discardable.} =\n    assert src in 0..<self.n\n  \
    \  assert dst in 0..<self.n\n    assert 0 <= cap\n    assert 0 <= cost\n    var\
    \ m = self.edges.len\n    self.edges.add(MCFEdge[Cap, Cost](src:src, dst:dst,\
    \ cap:cap, flow:0, cost:cost))\n    return m\n\n  proc get_edge*[Cap, Cost](self:MCFGraph[Cap,\
    \ Cost], i:int): MCFEdge[Cap, Cost] =\n    let m = self.edges.len\n    assert\
    \ i in 0..<m\n    return self.edges[i]\n\n  proc edges*[Cap, Cost](self:var MCFGraph[Cap,\
    \ Cost]):seq[MCFEdge[Cap, Cost]] = self.edges\n  type MCFQ[Cost] = object\n  \
    \  key:Cost\n    dst:int\n  proc `<`*[Cost](l, r:MCFQ[Cost]):bool = l.key > r.key\n\
    \n  proc slope*[Cap, Cost](self: MCFGraph[Cap, Cost], g:var csr[MCFInternalEdge[Cap,\
    \ Cost]], s, t:int, flow_limit:Cap):seq[tuple[cap:Cap, cost:Cost]] =\n    ## variants\
    \ (C = maxcost):\n    ## -(n-1)C <= dual[s] <= dual[i] <= dual[t] = 0\n    ##\
    \ reduced cost (= e.cost + dual[e.src] - dual[e.to]) >= 0 for all edge\n\n   \
    \ ## dual_dist[i] = (dual[i], dist[i])\n    var\n      dual_dist = newSeq[tuple[dual,\
    \ dist:Cost]](self.n)\n      prev_e = newSeq[int](self.n)\n      vis = newSeq[bool](self.n)\n\
    \      que_min = newSeq[int]()\n      que = newSeq[MCFQ[Cost]]()\n    proc dual_ref(g:csr[MCFInternalEdge[Cap,\
    \ Cost]]):bool =\n      for i in 0..<self.n: dual_dist[i].dist = Cost.high\n \
    \     vis.fill(false)\n      que_min.setLen(0)\n      que.setLen(0)\n\n      #\
    \ que[0..heap_r) was heapified\n      var heap_r = 0\n\n      dual_dist[s].dist\
    \ = 0\n      que_min.add(s)\n      while que_min.len > 0 or que.len > 0:\n   \
    \     var v:int\n        if que_min.len > 0:\n          v = que_min.pop()\n  \
    \      else:\n          while heap_r < que.len:\n            heap_r.inc\n    \
    \        que.push_heap(0 ..< heap_r)\n          v = que[0].dst\n          que.pop_heap(0\
    \ ..< que.len)\n          discard que.pop()\n          heap_r.dec\n        if\
    \ vis[v]: continue\n        vis[v] = true\n        if v == t: break\n        ##\
    \ dist[v] = shortest(s, v) + dual[s] - dual[v]\n        ## dist[v] >= 0 (all reduced\
    \ cost are positive)\n        ## dist[v] <= (n-1)C\n        let (dual_v, dist_v)\
    \ = dual_dist[v]\n        for i in g.start[v] ..< g.start[v + 1]:\n          let\
    \ e = g.elist[i]\n          if e.cap == Cap(0): continue\n          ## |-dual[e.to]\
    \ + dual[v]| <= (n-1)C\n          ## cost <= C - -(n-1)C + 0 = nC\n          let\
    \ cost = e.cost - dual_dist[e.dst].dual + dual_v\n          if dual_dist[e.dst].dist\
    \ - dist_v > cost:\n            let dist_to = dist_v + cost\n            dual_dist[e.dst].dist\
    \ = dist_to\n            prev_e[e.dst] = e.rev\n            if dist_to == dist_v:\n\
    \              que_min.add(e.dst)\n            else:\n              que.add(MCFQ[Cost](key:dist_to,\
    \ dst:e.dst))\n      if not vis[t]:\n        return false\n\n      for v in 0..<self.n:\n\
    \        if not vis[v]: continue\n        # dual[v] = dual[v] - dist[t] + dist[v]\n\
    \        #     = dual[v] - (shortest(s, t) + dual[s] - dual[t]) +\n        # \
    \    (shortest(s, v) + dual[s] - dual[v]) = - shortest(s,\n        #     t) +\
    \ dual[t] + shortest(s, v) = shortest(s, v) -\n        #     shortest(s, t) >=\
    \ 0 - (n-1)C\n        dual_dist[v].dual -= dual_dist[t].dist - dual_dist[v].dist\n\
    \      return true\n    var\n      flow:Cap = 0\n      cost:Cost = 0\n      prev_cost_per_flow:Cost\
    \ = -1\n    result = @[(Cap(0), Cost(0))]\n    while flow < flow_limit:\n    \
    \  if not g.dual_ref(): break\n      var c = flow_limit - flow\n      block:\n\
    \        var v = t\n        while v != s:\n          c = min(c, g.elist[g.elist[prev_e[v]].rev].cap)\n\
    \          v = g.elist[prev_e[v]].dst\n      block:\n        var v = t\n     \
    \   while v != s:\n          var e = g.elist[prev_e[v]].addr\n          e[].cap\
    \ += c\n          g.elist[e[].rev].cap -= c\n          v = g.elist[prev_e[v]].dst\n\
    \      let d = -dual_dist[s].dual\n      flow += c\n      cost += c * d\n    \
    \  if prev_cost_per_flow == d:\n        discard result.pop()\n      result.add((flow,\
    \ cost))\n      prev_cost_per_flow = d\n\n  proc slope*[Cap, Cost](self:var MCFGraph[Cap,\
    \ Cost], s, t:int, flow_limit:Cap):seq[tuple[cap:Cap, cost:Cost]] =\n    assert\
    \ s in 0..<self.n\n    assert t in 0..<self.n\n    assert s != t\n\n    let m\
    \ = self.edges.len\n    var edge_idx = newSeq[int](m)\n\n    var g = block:\n\
    \      var degree = newSeq[int](self.n)\n      var redge_idx = newSeq[int](m)\n\
    \      var elist = newSeqOfCap[(int, MCFInternalEdge[Cap, Cost])](2 * m)\n   \
    \   for i in 0..<m:\n        let e = self.edges[i]\n        edge_idx[i] = degree[e.src]\n\
    \        degree[e.src].inc\n        redge_idx[i] = degree[e.dst]\n        degree[e.dst].inc\n\
    \        elist.add((e.src, MCFInternalEdge[Cap, Cost](dst: e.dst, rev: -1, cap:e.cap\
    \ - e.flow, cost:e.cost)))\n        elist.add((e.dst, MCFInternalEdge[Cap, Cost](dst:\
    \ e.src, rev: -1, cap:e.flow, cost: -e.cost)))\n      var g = initCSR[MCFInternalEdge[Cap,\
    \ Cost]](self.n, elist)\n      for i in 0..<m:\n        let e = self.edges[i]\n\
    \        edge_idx[i] += g.start[e.src]\n        redge_idx[i] += g.start[e.dst]\n\
    \        g.elist[edge_idx[i]].rev = redge_idx[i];\n        g.elist[redge_idx[i]].rev\
    \ = edge_idx[i];\n      g\n\n    result = self.slope(g, s, t, flow_limit)\n\n\
    \    for i in 0..<m:\n      let e = g.elist[edge_idx[i]]\n      self.edges[i].flow\
    \ = self.edges[i].cap - e.cap\n  proc flow*[Cap, Cost](self:var MCFGraph[Cap,\
    \ Cost], s, t:int, flow_limit:Cap):tuple[cap:Cap, cost:Cost] = self.slope(s, t,\
    \ flow_limit)[^1]\n  proc flow*[Cap, Cost](self:var MCFGraph[Cap, Cost], s, t:int):tuple[cap:Cap,\
    \ cost:Cost] = self.flow(s, t, Cap.high)\n  proc slope*[Cap, Cost](self:var MCFGraph[Cap,\
    \ Cost], s, t:int):seq[tuple[cap:Cap, cost:Cost]] = self.slope(s, t, Cap.high)\n\
    \n  #### chaemon added\n  proc reset*[Cap, Cost](self: var MCFGraph[Cap, Cost])\
    \ =\n    for e in self.edges.mitems:\n      e.flow = 0\n\n  proc set_edge*[Cap,\
    \ Cost](self: var MCFGraph[Cap, Cost], i:int, cap:Cap, cost:Cost) =\n    assert\
    \ 0 <= cap\n    assert 0 <= cost\n    var m = self.edges.len\n    assert i in\
    \ 0 ..< m\n    edges[i].cap = cap\n    edges[i].cost = cost\n"
  dependsOn:
  - atcoder/internal_queue.nim
  - atcoder/internal_heap.nim
  - atcoder/internal_csr.nim
  - atcoder/internal_queue.nim
  - atcoder/internal_csr.nim
  - atcoder/internal_heap.nim
  isVerificationFile: false
  path: atcoder/mincostflow.nim
  requiredBy: []
  timestamp: '2021-12-21 01:39:48+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/min_cost_flow_test.nim
  - verify/min_cost_flow_test.nim
documentation_of: atcoder/mincostflow.nim
layout: document
redirect_from:
- /library/atcoder/mincostflow.nim
- /library/atcoder/mincostflow.nim.html
title: atcoder/mincostflow.nim
---
