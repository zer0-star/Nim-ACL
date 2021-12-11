---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
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
  - icon: ':x:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  - icon: ':x:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  - icon: ':x:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  - icon: ':x:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/max_flow_test.nim
    title: verify/max_flow_test.nim
  - icon: ':x:'
    path: verify/max_flow_test.nim
    title: verify/max_flow_test.nim
  - icon: ':x:'
    path: verify/min_cost_flow_test.nim
    title: verify/min_cost_flow_test.nim
  - icon: ':x:'
    path: verify/min_cost_flow_test.nim
    title: verify/min_cost_flow_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_QUEUE_HPP:\n  const ATCODER_INTERNAL_QUEUE_HPP*\
    \ = 1\n\n  type simple_queue[T] = object\n    payload:seq[T]\n    pos:int\n  proc\
    \ init_simple_queue*[T]():auto = simple_queue[T](payload:newSeq[T](), pos:0)\n\
    # TODO\n#      void reserve(int n) { payload.reserve(n); }\n  proc len*[T](self:simple_queue[T]):int\
    \ = self.payload.len - self.pos\n  proc empty*[T](self:simple_queue[T]):bool =\
    \ self.pos == self.payload.len\n  proc push*[T](self:var simple_queue[T], t:T)\
    \ = self.payload.add(t)\n  proc front*[T](self:simple_queue[T]):T = self.payload[self.pos]\n\
    \  proc clear*[T](self:var simple_queue[T]) =\n    self.payload.setLen(0)\n  \
    \  self.pos = 0;\n  proc pop*[T](self:var simple_queue[T]) = self.pos.inc\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/internal_queue.nim
  requiredBy:
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/maxflow.nim
  - atcoder/maxflow.nim
  - atcoder/mincostflow.nim
  - atcoder/mincostflow.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  timestamp: '2020-09-18 00:33:39+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/min_cost_flow_test.nim
  - verify/min_cost_flow_test.nim
  - verify/max_flow_test.nim
  - verify/max_flow_test.nim
documentation_of: atcoder/internal_queue.nim
layout: document
redirect_from:
- /library/atcoder/internal_queue.nim
- /library/atcoder/internal_queue.nim.html
title: atcoder/internal_queue.nim
---
