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
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_lowerbound.nim
    title: atcoder/extra/graph/mincostflow_lowerbound.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_lowerbound.nim
    title: atcoder/extra/graph/mincostflow_lowerbound.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_lowerbound.nim
    title: atcoder/extra/graph/mincostflow_lowerbound.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_lowerbound.nim
    title: atcoder/extra/graph/mincostflow_lowerbound.nim
  - icon: ':x:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  - icon: ':x:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  _extendedVerifiedWith:
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_HEAP:\n  const ATCODER_INTERNAL_HEAP*\
    \ = 1\n  proc push_heap*[T](v: var openArray[T], p:Slice[int]) {.inline.} =\n\
    \    var i = p.b\n    while i > 0:\n      var p = (i - 1) shr 1\n      if v[p]\
    \ < v[i]: swap v[p], v[i]\n      else: break\n      i = p\n  proc pop_heap*[T](v:\
    \ var openArray[T], p:Slice[int]) {.inline.} =\n    swap v[0], v[p.b]\n    var\
    \ p = p\n    p.b.dec\n    var i = 0\n    while true:\n      var (c0, c1) = (i\
    \ * 2 + 1, i * 2 + 2)\n      if c1 in p:\n        if v[c1] > v[i]:\n         \
    \ if v[c0] > v[c1]:\n            swap(v[i], v[c0])\n            i = c0\n     \
    \     else:\n            swap(v[i], v[c1])\n            i = c1\n        elif v[c0]\
    \ > v[i]:\n          swap(v[i], v[c0])\n          i = c0\n        else: break\n\
    \      elif c0 in p:\n        if v[c0] > v[i]:\n          swap(v[i], v[c0])\n\
    \          i = c0\n        else: break\n      else: break\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/internal_heap.nim
  requiredBy:
  - atcoder/extra/graph/mincostflow_lowerbound.nim
  - atcoder/extra/graph/mincostflow_lowerbound.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/mincostflow.nim
  - atcoder/mincostflow.nim
  - atcoder/extra/graph/mincostflow_lowerbound.nim
  - atcoder/extra/graph/mincostflow_lowerbound.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  timestamp: '2021-08-23 19:10:29+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/min_cost_flow_test.nim
  - verify/min_cost_flow_test.nim
documentation_of: atcoder/internal_heap.nim
layout: document
redirect_from:
- /library/atcoder/internal_heap.nim
- /library/atcoder/internal_heap.nim.html
title: atcoder/internal_heap.nim
---
