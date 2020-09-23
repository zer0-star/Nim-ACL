---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: test/example/mincostflow_practice.nim
    title: test/example/mincostflow_practice.nim
  - icon: ':warning:'
    path: test/example/mincostflow_practice.nim
    title: test/example/mincostflow_practice.nim
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MINCOSTFLOW_HPP:\n  const ATCODER_MINCOSTFLOW_HPP*\
    \ = 1\n\n  import std/heapqueue, std/sequtils\n\n  type edge*[Cap, Cost] = object\n\
    \    dst, rev:int\n    cap:Cap\n    cost:Cost\n\n  type mcf_graph*[Cap, Cost]\
    \ = object\n    n:int\n    pos:seq[(int,int)]\n    g:seq[seq[edge[Cap, Cost]]]\n\
    \n  type edge_info*[Cap, Cost] = object\n    src, dst:int\n    cap, flow: Cap\n\
    \    cost: Cost\n\n  proc initMCFGraph*[Cap, Cost](n:int):auto = mcf_graph[Cap,\
    \ Cost](n:n, g:newSeq[seq[edge[Cap, Cost]]](n))\n\n  proc add_edge*[Cap, Cost](self:\
    \ var mcf_graph[Cap, Cost], src:int, dst:int, cap:Cap, cost:Cost):int {.discardable.}\
    \ =\n    assert src in 0..<self.n\n    assert dst in 0..<self.n\n    let m = self.pos.len\n\
    \    self.pos.add((src, self.g[src].len))\n    self.g[src].add(edge[Cap, Cost](dst:dst,\
    \ rev:self.g[dst].len, cap:cap, cost:cost))\n    self.g[dst].add(edge[Cap, Cost](dst:src,\
    \ rev:self.g[src].len - 1, cap:Cap(0), cost: -cost))\n    return m\n\n  proc get_edge*[Cap,\
    \ Cost](self: mcf_graph[Cap, Cost], i:int):edge_info[Cap, Cost] =\n    let m =\
    \ self.pos.len\n    assert 0 <= i and i < m\n    let e = self.g[self.pos[i][0]][self.pos[i][1]]\n\
    \    let re = self.g[e.dst][e.rev]\n    return edge_info[Cap, Cost](src:self.pos[i][0],\
    \ dst:e.dst, cap:e.cap + re.cap, flow:re.cap, cost:e.cost)\n\n  proc edges*[Cap,\
    \ Cost](self: mcf_graph[Cap, Cost]):seq[edge_info[Cap, Cost]] =\n    let m = self.pos.len\n\
    \    result = newSeq[edge_info[Cap, Cost]](m)\n    for i in 0..<m:\n      result[i]\
    \ = self.get_edge(i)\n\n  proc slope*[Cap, Cost](self: var mcf_graph[Cap, Cost],\
    \ s, t:int, flow_limit:Cap):seq[(Cap, Cost)] =\n    assert s in 0..<self.n\n \
    \   assert t in 0..<self.n\n    assert s != t\n    # variants (C = maxcost):\n\
    \    # -(n-1)C <= dual[s] <= dual[i] <= dual[t] = 0\n    # reduced cost (= e.cost\
    \ + dual[e.src] - dual[e.to]) >= 0 for all edge\n    var\n      dual = newSeqWith(self.n,\
    \ Cost(0))\n      dist = newSeq[Cost](self.n)\n      pv, pe = newSeq[int](self.n)\n\
    \      vis = newSeq[bool](self.n)\n    proc dual_ref(self:var mcf_graph[Cap, Cost]):bool\
    \ =\n      dist.fill(Cost.high)\n      pv.fill(-1)\n      pe.fill(-1)\n      vis.fill(false)\n\
    \      type Q = tuple[key:Cost, dst:int]\n      proc `<`(l,r:Q):bool = l.key <\
    \ r.key\n\n      var que = initHeapQueue[Q]()\n      dist[s] = 0\n      que.push((Cost(0),\
    \ s))\n      while que.len > 0:\n        let v = que.pop().dst\n        if vis[v]:\
    \ continue\n        vis[v] = true\n        if v == t: break\n        # dist[v]\
    \ = shortest(s, v) + dual[s] - dual[v]\n        # dist[v] >= 0 (all reduced cost\
    \ are positive)\n        # dist[v] <= (n-1)C\n        for i in 0..<self.g[v].len:\n\
    \          let e = self.g[v][i]\n          if vis[e.dst] or e.cap == 0: continue\n\
    \          # |-dual[e.dst] + dual[v]| <= (n-1)C\n          # cost <= C - -(n-1)C\
    \ + 0 = nC\n          let cost = e.cost - dual[e.dst] + dual[v]\n          if\
    \ dist[e.dst] - dist[v] > cost:\n            dist[e.dst] = dist[v] + cost\n  \
    \          pv[e.dst] = v\n            pe[e.dst] = i\n            que.push((dist[e.dst],\
    \ e.dst))\n      if not vis[t]:\n        return false\n\n      for v in 0..<self.n:\n\
    \        if not vis[v]: continue\n        # dual[v] = dual[v] - dist[t] + dist[v]\n\
    \        #     = dual[v] - (shortest(s, t) + dual[s] - dual[t]) + (shortest(s,\
    \ v) + dual[s] - dual[v])\n        #     = - shortest(s, t) + dual[t] + shortest(s,\
    \ v)\n        #     = shortest(s, v) - shortest(s, t) >= 0 - (n-1)C\n        dual[v]\
    \ -= dist[t] - dist[v]\n      return true\n    var\n      flow = Cap(0)\n    \
    \  cost = Cost(0)\n      prev_cost = -1\n    result = newSeq[(Cap, Cost)]()\n\
    \    result.add((flow, cost))\n    while flow < flow_limit:\n      if not self.dual_ref():\
    \ break\n      var c = flow_limit - flow\n      var v = t\n      while v != s:\n\
    \        c = min(c, self.g[pv[v]][pe[v]].cap)\n        v = pv[v]\n      v = t\n\
    \      while v != s:\n        var e = self.g[pv[v]][pe[v]].addr\n        e[].cap\
    \ -= c\n        self.g[v][e[].rev].cap += c\n        v = pv[v]\n      let d =\
    \ -dual[s]\n      flow += c\n      cost += c * d\n      if prev_cost == d:\n \
    \       discard result.pop()\n      result.add((flow, cost))\n      prev_cost\
    \ = cost\n  proc flow*[Cap, Cost](self: var mcf_graph[Cap, Cost], s,t:int):(Cap,\
    \ Cost) =\n    self.flow(s, t, Cap.high)\n  proc flow*[Cap, Cost](self: var mcf_graph[Cap,\
    \ Cost], s,t:int, flow_limit:Cap):(Cap, Cost) =\n    self.slope(s, t, flow_limit)[^1]\n\
    \  proc slope*[Cap, Cost](self: var mcf_graph[Cap, Cost], s,t:int):seq[(Cap, Cost)]\
    \ =\n    self.slope(s, t, Cap.high)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/mincostflow.nim
  requiredBy:
  - test/example/mincostflow_practice.nim
  - test/example/mincostflow_practice.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/mincostflow.nim
layout: document
redirect_from:
- /library/atcoder/mincostflow.nim
- /library/atcoder/mincostflow.nim.html
title: atcoder/mincostflow.nim
---
