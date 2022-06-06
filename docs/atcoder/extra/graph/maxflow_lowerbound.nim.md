---
data:
  _extendedDependsOn:
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
  - icon: ':x:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  - icon: ':x:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  - icon: ':x:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  - icon: ':x:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MAXFLOW_LOWERBOUND_HPP:\n  const ATCODER_MAXFLOW_LOWERBOUND_HPP*\
    \ = 1\n  import atcoder/maxflow\n  import std/options\n  \n  type MaxFlowLowerBound*[Cap]\
    \ = object\n    flow: MFGraph[Cap]\n    in_cap, up_cap: seq[Cap]\n    #typename\
    \ F< flow_t >::edge *latte, *malta;\n    #latte, malta:int\n    X, Y, V: int\n\
    \    sum: Cap\n  \n  proc initMaxFlowLowerBound*[Cap](V:int):MaxFlowLowerBound[Cap]\
    \ =\n    MaxFlowLowerBound[Cap](V:V, flow:initMFGraph[Cap](V + 2), X:V, Y:V +\
    \ 1, sum:Cap(0), in_cap:newSeq[Cap](V))\n  \n  proc add_edge*[Cap](self: var MaxFlowLowerBound[Cap],\
    \ src, dst:int, low, high: Cap) =\n    doAssert src != dst\n    self.flow.add_edge(src,\
    \ dst, high - low)\n    self.in_cap[src] -= low\n    self.in_cap[dst] += low\n\
    \    self.up_cap.add(high)\n  \n  proc build*[Cap](self: var MaxFlowLowerBound[Cap])\
    \ =\n    for i in 0..<self.V:\n      if self.in_cap[i] > 0:\n        self.flow.add_edge(self.X,\
    \ i, self.in_cap[i]) # TODO: cost\u76F4\u3059\n        self.sum += self.in_cap[i]\n\
    \      elif self.in_cap[i] < 0:\n        self.flow.add_edge(i, self.Y, -self.in_cap[i])\n\
    \  \n  proc can_flow*[Cap](self: var MaxFlowLowerBound[Cap]):bool =\n    self.build()\n\
    \    var ret = self.flow.flow(self.X, self.Y)\n    #echo \"base: \", ret\n   \
    \ return ret >= self.sum\n  \n  proc can_flow*[Cap](self: var MaxFlowLowerBound[Cap],\
    \ s, t:int):bool =\n    assert s != t\n    self.flow.add_edge(t, s, Cap.high div\
    \ 10)\n    #self.latte = &flow.graph[t].back()\n    #self.malta = &flow.graph[s].back()\n\
    \    return self.can_flow()\n  \n  proc max_flow*[Cap](self: var MaxFlowLowerBound[Cap],\
    \ s, t:int):Option[Cap] =\n    if self.can_flow(s, t):\n#      self.flow.reset\n\
    \      return self.flow.flow(s, t).some\n    else:\n      return result.T.none\n\
    \  \n  #proc slope*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):Option[seq[Cap]]\
    \ =\n  #  if self.can_flow(s, t):\n# #     self.flow.reset\n  ##    return self.flow.slope(s,\
    \ t).some\n  #    return self.flow.slope(s, t).some\n  #  else:\n  #    return\
    \ result.T.none\n  \n  \n  #flow_t min_flow(int s, int t) {\n  #  if(can_flow(s,\
    \ t)) {\n  #    auto ret = flow.INF - latte->cap;\n  #    latte->cap = malta->cap\
    \ = 0;\n  #    return ret - flow.max_flow(t, s);\n  #  } else {\n  #    return\
    \ -1;\n  #  }\n  #}\n  #\n  #void output(int M) {\n  #  vector< flow_t > ans(M);\n\
    \  #  for(int i = 0; i < flow.graph.size(); i++) {\n  #    for(auto &e : flow.graph[i])\
    \ {\n  #      if(!e.isrev && ~e.idx) ans[e.idx] = up[e.idx] - e.cap;\n  #    }\n\
    \  #  }\n  #  for(auto &p : ans) cout << p << endl;\n  #}\n  \n#var g = initMaxFlowLowerBound[int](3)\n\
    #g.addEdge(0, 1, 1, 2)\n#g.addEdge(1, 2, 2, 3)\n#echo g.max_flow(0, 2)\n\n"
  dependsOn:
  - atcoder/maxflow.nim
  - atcoder/internal_queue.nim
  - atcoder/maxflow.nim
  - atcoder/internal_queue.nim
  - atcoder/maxflow.nim
  - atcoder/internal_queue.nim
  - atcoder/maxflow.nim
  - atcoder/internal_queue.nim
  isVerificationFile: false
  path: atcoder/extra/graph/maxflow_lowerbound.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/maxflow_lowerbound.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/maxflow_lowerbound.nim
- /library/atcoder/extra/graph/maxflow_lowerbound.nim.html
title: atcoder/extra/graph/maxflow_lowerbound.nim
---
