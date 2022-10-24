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
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
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
    PROBLEM: https://judge.yosupo.jp/problem/directedmst
    links:
    - https://judge.yosupo.jp/problem/directedmst
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/directedmst\n\n\
    import atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/chu_liu_edmonds\n\
    import std/options, std/sequtils, std/strutils\n\nproc main() =\n  var\n    N,\
    \ M, S = nextInt()\n    edges = newSeq[Edge[int, int]]()\n  for i in 0..<M:\n\
    \    let a, b, c = nextInt()\n    edges.add(initEdge(a,b,c))\n  let (s, parent)\
    \ = minimumSpanningTreeArborescence[int](edges, N, S).get\n  echo s\n  echo parent.mapIt($it).join(\"\
    \ \")\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/extra/structure/skew_heap.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/dsu.nim
  - atcoder/extra/structure/skew_heap.nim
  - atcoder/dsu.nim
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/graph/yosupo_directedmst_test.nim
  requiredBy: []
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/yosupo_directedmst_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/yosupo_directedmst_test.nim
- /verify/verify/extra/graph/yosupo_directedmst_test.nim.html
title: verify/extra/graph/yosupo_directedmst_test.nim
---
