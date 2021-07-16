---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  - icon: ':warning:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links:
    - https://github.com/atcoder/ac-library/issues/1
    - https://github.com/atcoder/ac-library/issues/51
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import std/unittest\nimport atcoder/mincostflow\n\ntype ll = int\ntype ull\
    \ = uint\n\ntest \"MincostflowTest, Zero\":\n  var g1:MCFGraph[int,int]\n  var\
    \ g2 = initMCFGraph[int,int](0)\n\ntemplate edge_eq[edge](expect, actual:edge)\
    \ =\n  check expect.src == actual.src\n  check expect.dst == actual.dst\n  check\
    \ expect.cap == actual.cap\n  check expect.flow == actual.flow\n  check expect.cost\
    \ == actual.cost\n\nproc make_edge_info[Cap, Cost](src, dst:int, cap, flow:Cap,\
    \ cost:Cost):auto =\n  MCFEdgeInfo[Cap, Cost](src:src, dst:dst, cap:cap, flow:flow,\
    \ cost:cost)\n\ntest \"MincostflowTest, Simple\":\n  var g = initMCFGraph[int,int](4)\n\
    \  g.add_edge(0, 1, 1, 1)\n  g.add_edge(0, 2, 1, 1)\n  g.add_edge(1, 3, 1, 1)\n\
    \  g.add_edge(2, 3, 1, 1)\n  g.add_edge(1, 2, 1, 1)\n  let expect = @[(0, 0),\
    \ (2, 4)]\n  check expect == g.slope(0, 3, 10)\n  var e = MCFEdgeInfo[int,int]()\n\
    \n  e = make_edge_info(0, 1, 1, 1, 1)\n  edge_eq(e, g.get_edge(0))\n  e = make_edge_info(0,\
    \ 2, 1, 1, 1)\n  edge_eq(e, g.get_edge(1))\n  e = make_edge_info(1, 3, 1, 1, 1)\n\
    \  edge_eq(e, g.get_edge(2))\n  e = make_edge_info(2, 3, 1, 1, 1)\n  edge_eq(e,\
    \ g.get_edge(3))\n  e = make_edge_info(1, 2, 1, 0, 1)\n  edge_eq(e, g.get_edge(4))\n\
    \ntest \"MincostflowTest, Usage\":\n  block:\n    var g = initMCFGraph[int,int](2)\n\
    \    g.add_edge(0, 1, 1, 2)\n    check (1, 2) == g.flow(0, 1)\n  block:\n    var\
    \ g = initMCFGraph[int,int](2)\n    g.add_edge(0, 1, 1, 2);\n    let expect =\
    \ @[(0, 0), (1, 2)]\n    check expect == g.slope(0, 1)\n\ntest \"MincostflowTest,\
    \ Assign\":\n  var g:MCFGraph[int,int]\n  g = initMCFGraph[int,int](10)\n\ntest\
    \ \"MincostflowTest, OutOfRange\":\n  var g = initMCFGraph[int,int](10)\n  \n\
    \  expect AssertionError: discard g.slope(-1, 3)\n  expect AssertionError: discard\
    \ g.slope(3, 3)\n\n# https://github.com/atcoder/ac-library/issues/1\ntest \"MincostflowTest,\
    \ SelfLoop\":\n  var g = initMCFGraph[int,int](3)\n  check 0 == g.add_edge(0,\
    \ 0, 100, 123)\n  \n  var e = make_edge_info(0, 0, 100, 0, 123)\n  edge_eq(e,\
    \ g.get_edge(0))\n\ntest \"MincostflowTest, SameCostPaths\":\n  var g = initMCFGraph[int,int](3)\n\
    \  check 0 == g.add_edge(0, 1, 1, 1)\n  check 1 == g.add_edge(1, 2, 1, 0)\n  check\
    \ 2 == g.add_edge(0, 2, 2, 1)\n  let expected = @[(0, 0), (3, 3)]\n  check expected\
    \ == g.slope(0, 2)\n\ntest \"MincostflowTest, Invalid\":\n  var g = initMCFGraph[int,int](2)\n\
    \  # https://github.com/atcoder/ac-library/issues/51\n  expect AssertionError:\
    \ discard g.add_edge(0, 0, -1, 0)\n  expect AssertionError: discard g.add_edge(0,\
    \ 0, 0, -1)\n"
  dependsOn:
  - atcoder/mincostflow.nim
  - atcoder/mincostflow.nim
  isVerificationFile: false
  path: tests/test_mincostflow.nim
  requiredBy: []
  timestamp: '2021-05-19 22:57:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_mincostflow.nim
layout: document
redirect_from:
- /library/tests/test_mincostflow.nim
- /library/tests/test_mincostflow.nim.html
title: tests/test_mincostflow.nim
---
