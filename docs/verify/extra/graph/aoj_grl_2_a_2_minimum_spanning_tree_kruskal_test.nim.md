---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/kruskal.nim
    title: atcoder/extra/graph/kruskal.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/kruskal.nim
    title: atcoder/extra/graph/kruskal.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_A
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_A
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_A\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/graph/graph_template\nimport\
    \ atcoder/extra/graph/kruskal\n\nproc main() =\n  var\n    V, E = nextInt()\n\
    \    g = initGraph(V)\n  for i in 0..<E:\n    let a, b, c = nextInt()\n    g.addBiEdge(a,b,c)\n\
    \  echo kruskal(g)[0]\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/kruskal.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/header.nim
  - atcoder/dsu.nim
  - atcoder/extra/graph/kruskal.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/dsu.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
- /verify/verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim.html
title: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
---
