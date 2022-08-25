---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_generalized.nim
    title: atcoder/extra/graph/mincostflow_generalized.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_generalized.nim
    title: atcoder/extra/graph/mincostflow_generalized.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_generalized.nim
    title: atcoder/extra/graph/mincostflow_generalized.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_generalized.nim
    title: atcoder/extra/graph/mincostflow_generalized.nim
  - icon: ':question:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':question:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':question:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':question:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':x:'
    path: atcoder/internal_heap.nim
    title: atcoder/internal_heap.nim
  - icon: ':x:'
    path: atcoder/internal_heap.nim
    title: atcoder/internal_heap.nim
  - icon: ':x:'
    path: atcoder/internal_heap.nim
    title: atcoder/internal_heap.nim
  - icon: ':x:'
    path: atcoder/internal_heap.nim
    title: atcoder/internal_heap.nim
  - icon: ':x:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':x:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':x:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':x:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':question:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':question:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':question:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MINCOSTFLOW_LOWERBOUND_HPP:\n  const ATCODER_MINCOSTFLOW_LOWERBOUND_HPP*\
    \ = 1\n  import lib/graph/mincostflow_generalized\n  import std/options\n  \n\
    \  type MinCostFlowLowerBound*[Cap, Cost] = object\n    flow: MCFGraph[Cap, Cost,\
    \ GRAPHTYPE_POSITIVEEDGE]\n    in_cap, up_cap: seq[Cap]\n    #typename F< flow_t\
    \ >::edge *latte, *malta;\n    #latte, malta:int\n    X, Y, V:int\n    sum:Cap\n\
    \  \n  proc initMinCostFlowLowerBound*[Cap, Cost, GraphType](V:int):MinCostFlowLowerBound[Cap,\
    \ Cost] =\n    MinCostFlowLowerBound[Cap, Cost](V:V, flow:initMCFGraph[Cap, Cost,\
    \ GraphType](V + 2), X:V, Y:V + 1, sum:Cap(0), in_cap:newSeq[Cap](V))\n  \n  proc\
    \ add_edge*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], src, dst:int,\
    \ low, high: Cap, cost:Cost) =\n    doAssert src != dst\n    self.flow.add_edge(src,\
    \ dst, high - low, cost)\n    self.in_cap[src] -= low\n    self.in_cap[dst] +=\
    \ low\n    self.up_cap.add(high)\n  \n  proc build*[Cap, Cost](self: var MinCostFlowLowerBound[Cap,\
    \ Cost]) =\n    for i in 0..<self.V:\n      if self.in_cap[i] > 0:\n        self.flow.add_edge(self.X,\
    \ i, self.in_cap[i], Cost(0)) # TODO: cost\u76F4\u3059\n        self.sum += self.in_cap[i]\n\
    \      elif self.in_cap[i] < 0:\n        self.flow.add_edge(i, self.Y, -self.in_cap[i],\
    \ Cost(0))\n  \n  proc can_flow*[Cap, Cost](self: var MinCostFlowLowerBound[Cap,\
    \ Cost]):bool =\n    self.build()\n    var ret = self.flow.flow(self.X, self.Y)\n\
    \    echo \"base: \", ret\n    return ret.cap >= self.sum\n  \n  proc can_flow*[Cap,\
    \ Cost](self: var MinCostFlowLowerBound[Cap, Cost], s, t:int):bool =\n    assert\
    \ s != t\n    self.flow.add_edge(t, s, Cap.inf div 10, 0)\n    #self.latte = &flow.graph[t].back()\n\
    \    #self.malta = &flow.graph[s].back()\n    return self.can_flow()\n  \n  proc\
    \ max_flow*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], s, t:int):Option[(Cap,\
    \ Cost)] =\n    if self.can_flow(s, t):\n#      self.flow.reset\n      return\
    \ self.flow.flow(s, t).some\n    else:\n      return result.T.none\n  \n  proc\
    \ slope*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], s, t:int):Option[seq[(Cap,\
    \ Cost)]] =\n    if self.can_flow(s, t):\n#      self.flow.reset\n  #    return\
    \ self.flow.slope(s, t).some\n      return self.flow.slope(s, t).some\n    else:\n\
    \      return result.T.none\n  \n  \n  #flow_t min_flow(int s, int t) {\n  # \
    \ if(can_flow(s, t)) {\n  #    auto ret = flow.INF - latte->cap;\n  #    latte->cap\
    \ = malta->cap = 0;\n  #    return ret - flow.max_flow(t, s);\n  #  } else {\n\
    \  #    return -1;\n  #  }\n  #}\n  #\n  #void output(int M) {\n  #  vector< flow_t\
    \ > ans(M);\n  #  for(int i = 0; i < flow.graph.size(); i++) {\n  #    for(auto\
    \ &e : flow.graph[i]) {\n  #      if(!e.isrev && ~e.idx) ans[e.idx] = up[e.idx]\
    \ - e.cap;\n  #    }\n  #  }\n  #  for(auto &p : ans) cout << p << endl;\n  #}\n\
    \  \n  \n  \n"
  dependsOn:
  - atcoder/internal_queue.nim
  - atcoder/internal_scc.nim
  - atcoder/internal_csr.nim
  - atcoder/scc.nim
  - atcoder/internal_heap.nim
  - atcoder/internal_queue.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/internal_heap.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/internal_scc.nim
  - atcoder/scc.nim
  - atcoder/internal_csr.nim
  - atcoder/internal_queue.nim
  - atcoder/internal_scc.nim
  - atcoder/internal_csr.nim
  - atcoder/scc.nim
  - atcoder/internal_heap.nim
  - atcoder/internal_queue.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/internal_heap.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/internal_scc.nim
  - atcoder/scc.nim
  - atcoder/internal_csr.nim
  isVerificationFile: false
  path: atcoder/extra/graph/mincostflow_lowerbound.nim
  requiredBy: []
  timestamp: '2021-12-29 18:50:03+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/mincostflow_lowerbound.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/mincostflow_lowerbound.nim
- /library/atcoder/extra/graph/mincostflow_lowerbound.nim.html
title: atcoder/extra/graph/mincostflow_lowerbound.nim
---
