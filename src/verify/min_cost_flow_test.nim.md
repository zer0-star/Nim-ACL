---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
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
  - icon: ':heavy_check_mark:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_B
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_B
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_B\n\
    \ninclude atcoder/header\ninclude atcoder/mincostflow\n\nblock:\n  let V, E, F\
    \ = nextInt()\n  var mcf = initMinCostFlow[int, int](V)\n  for i in 0..<E:\n \
    \   let a, b, c, d = nextInt()\n    mcf.addEdge(a, b, c, d)\n  var f = mcf.flow(0,\
    \ V - 1, F)\n  if f.cap < F:\n    echo -1\n  else:\n    echo f.cost\n"
  dependsOn:
  - atcoder/internal_csr.nim
  - atcoder/mincostflow.nim
  - atcoder/internal_queue.nim
  - atcoder/mincostflow.nim
  - atcoder/internal_queue.nim
  - atcoder/internal_csr.nim
  - atcoder/header.nim
  - atcoder/internal_heap.nim
  - atcoder/internal_heap.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/min_cost_flow_test.nim
  requiredBy: []
  timestamp: '2021-12-21 01:39:48+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/min_cost_flow_test.nim
layout: document
redirect_from:
- /verify/verify/min_cost_flow_test.nim
- /verify/verify/min_cost_flow_test.nim.html
title: verify/min_cost_flow_test.nim
---
