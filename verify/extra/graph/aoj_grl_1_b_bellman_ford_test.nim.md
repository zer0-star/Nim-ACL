---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/bellman_ford.nim
    title: atcoder/extra/graph/bellman_ford.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/bellman_ford.nim
    title: atcoder/extra/graph/bellman_ford.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_B
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_B
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_B\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/bellman_ford\n\
    \nproc main() =\n  var\n    V, E, R = nextInt()\n  var g = initGraph(V)\n  for\
    \ i in 0..<E:\n    var a, b, c = nextInt()\n    g.addEdge(a,b,c)\n  let bf = bellman_ford(g,\
    \ R);\n  if bf.negative_cycle: echo \"NEGATIVE CYCLE\"\n  else:\n    for u in\
    \ 0..<V:\n      if bf[u] == int.inf: echo \"INF\"\n      else: echo bf[u]\n\n\
    main()\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/bellman_ford.nim
  - atcoder/header.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/bellman_ford.nim
  - atcoder/extra/other/inf.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
- /verify/verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim.html
title: verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
---
