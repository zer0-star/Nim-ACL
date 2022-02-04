---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
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
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_A
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_A
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_A\n\
    \ninclude atcoder/header\ninclude atcoder/maxflow\n\nblock:\n  let V, E = nextInt()\n\
    \  var mf = initMaxFlow[int](V)\n  for i in 0..<E:\n    let a, b, c = nextInt()\n\
    \    mf.addEdge(a, b, c)\n  echo mf.flow(0, V - 1)\n"
  dependsOn:
  - atcoder/internal_queue.nim
  - atcoder/maxflow.nim
  - atcoder/header.nim
  - atcoder/maxflow.nim
  - atcoder/internal_queue.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/max_flow_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/max_flow_test.nim
layout: document
redirect_from:
- /verify/verify/max_flow_test.nim
- /verify/verify/max_flow_test.nim.html
title: verify/max_flow_test.nim
---