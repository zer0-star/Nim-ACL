---
data:
  _extendedDependsOn:
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
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import std/unittest\n\nimport atcoder/scc\n\ntest \"SCCTest, Empty\":\n \
    \ var graph0:SCCGraph\n  check newSeq[seq[int]]() == graph0.scc()\n  var graph1\
    \ = initSCCGraph(0)\n  check newSeq[seq[int]]() == graph1.scc()\n\ntest \"SCCTest,\
    \ Assign\":\n  var graph:SCCGraph\n  graph = initSCCGraph(10)\n\ntest \"SCCTest,\
    \ Simple\":\n  var graph = initSCCGraph(2)\n  graph.add_edge(0, 1)\n  graph.add_edge(1,\
    \ 0)\n  let scc = graph.scc()\n  check 1 == scc.len\n\ntest \"SCCTest, SelfLoop\"\
    :\n  var graph = initSCCGraph(2)\n  graph.add_edge(0, 0)\n  graph.add_edge(0,\
    \ 0)\n  graph.add_edge(1, 1)\n  let scc = graph.scc()\n  check 2 == scc.len\n\n\
    test \"SCCTest, Invalid\":\n  var graph = initSCCGraph(2)\n  expect AssertionError:\n\
    \    graph.add_edge(0, 10)\n"
  dependsOn:
  - atcoder/internal_scc.nim
  - atcoder/scc.nim
  - atcoder/internal_scc.nim
  - atcoder/scc.nim
  isVerificationFile: false
  path: tests/test_scc.nim
  requiredBy: []
  timestamp: '2020-09-25 20:51:01+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_scc.nim
layout: document
redirect_from:
- /library/tests/test_scc.nim
- /library/tests/test_scc.nim.html
title: tests/test_scc.nim
---
