---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/skew_heap.nim
    title: atcoder/extra/structure/skew_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/skew_heap.nim
    title: atcoder/extra/structure/skew_heap.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_B
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_B
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_B\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/chu_liu_edmonds\n\
    import std/options\n\nproc main() =\n  var\n    V, E, R = nextInt()\n    edges\
    \ = newSeq[Edge[int, int]]()\n  for i in 0..<E:\n    let a, b, c = nextInt()\n\
    \    edges.add(initEdge(a,b,c))\n  var t = minimumSpanningTreeArborescence[int](edges,\
    \ V, R)\n  echo t.get[0]\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/dsu.nim
  - atcoder/extra/structure/skew_heap.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/header.nim
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/dsu.nim
  - atcoder/extra/structure/skew_heap.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
- /verify/verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim.html
title: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
---
