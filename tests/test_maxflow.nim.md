---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':warning:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':warning:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  - icon: ':warning:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links:
    - https://github.com/atcoder/ac-library/issues/1
    - https://github.com/atcoder/ac-library/issues/5
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import std/unittest\n\nimport atcoder/maxflow\n\nimport \"../test/utils/random.nim\"\
    \n\ntype ll = int\ntype ull = uint\n\ntest \"MaxflowTest, Zero\":\n  var g1: MFGraph[int]\n\
    \  var g2 = init_mf_graph[int](0)\n\ntest \"MaxflowTest, Assign\":\n  var g: MFGraph[int]\n\
    \  g = init_mf_graph[int](10)\n\ntemplate edge_eq[edge](expect, actual: edge)\
    \ =\n  check expect.src == actual.src\n  check expect.dst == actual.dst\n  check\
    \ expect.cap == actual.cap\n  check expect.flow == actual.flow\n\ntest \"MaxflowTest,\
    \ Simple\":\n  var g = init_mf_graph[int](4)\n  check 0 == g.add_edge(0, 1, 1)\n\
    \  check 1 == g.add_edge(0, 2, 1)\n  check 2 == g.add_edge(1, 3, 1)\n  check 3\
    \ == g.add_edge(2, 3, 1)\n  check 4 == g.add_edge(1, 2, 1)\n  check 2 == g.flow(0,\
    \ 3)\n\n  var e:MFEdge[int]\n  e = MFEdge[int](src:0, dst:1, cap:1, flow:1)\n\
    \  edge_eq(e, g.get_edge(0))\n  e = MFEdge[int](src:0, dst:2, cap:1, flow:1)\n\
    \  edge_eq(e, g.get_edge(1))\n  e = MFEdge[int](src:1, dst:3, cap:1, flow:1)\n\
    \  edge_eq(e, g.get_edge(2))\n  e = MFEdge[int](src:2, dst:3, cap:1, flow:1)\n\
    \  edge_eq(e, g.get_edge(3))\n  e = MFEdge[int](src:1, dst:2, cap:1, flow:0)\n\
    \  edge_eq(e, g.get_edge(4))\n\n  check @[true, false, false, false] == g.min_cut(0)\n\
    \ntest \"MaxflowTest, NotSimple\":\n  var g = init_mf_graph[int](2)\n  check 0\
    \ == g.add_edge(0, 1, 1)\n  check 1 == g.add_edge(0, 1, 2)\n  check 2 == g.add_edge(0,\
    \ 1, 3)\n  check 3 == g.add_edge(0, 1, 4)\n  check 4 == g.add_edge(0, 1, 5)\n\
    \  check 5 == g.add_edge(0, 0, 6)\n  check 6 == g.add_edge(1, 1, 7)\n  check 15\
    \ == g.flow(0, 1)\n\n  var e: MFEdge[int]\n  e = MFEdge[int](src:0, dst:1, cap:1,\
    \ flow:1)\n  edge_eq(e, g.get_edge(0))\n  e = MFEdge[int](src:0, dst:1, cap:2,\
    \ flow:2)\n  edge_eq(e, g.get_edge(1))\n  e = MFEdge[int](src:0, dst:1, cap:3,\
    \ flow:3)\n  edge_eq(e, g.get_edge(2))\n  e = MFEdge[int](src:0, dst:1, cap:4,\
    \ flow:4)\n  edge_eq(e, g.get_edge(3))\n  e = MFEdge[int](src:0, dst:1, cap:5,\
    \ flow:5)\n  edge_eq(e, g.get_edge(4))\n\n  check @[true, false] == g.min_cut(0)\n\
    \ntest \"MaxflowTest, Cut\":\n  var g = init_mf_graph[int](3)\n  check 0 == g.add_edge(0,\
    \ 1, 2)\n  check 1 == g.add_edge(1, 2, 1)\n  check 1 == g.flow(0, 2)\n\n  var\
    \ e:MFEdge[int]\n  e = MFEdge[int](src:0, dst:1, cap:2, flow:1)\n  edge_eq(e,\
    \ g.get_edge(0))\n  e = MFEdge[int](src:1, dst:2, cap:1, flow:1)\n  edge_eq(e,\
    \ g.get_edge(1))\n\n  check @[true, true, false] == g.min_cut(0)\n\ntest \"MaxflowTest,\
    \ Twice\":\n  var e:MFEdge[int]\n  \n  var g = init_mf_graph[int](3)\n  check\
    \ 0 == g.add_edge(0, 1, 1)\n  check 1 == g.add_edge(0, 2, 1)\n  check 2 == g.add_edge(1,\
    \ 2, 1)\n  \n  check 2 == g.flow(0, 2)\n\n  e = MFEdge[int](src:0, dst:1, cap:1,\
    \ flow:1)\n  edge_eq(e, g.get_edge(0))\n  e = MFEdge[int](src:0, dst:2, cap:1,\
    \ flow:1)\n  edge_eq(e, g.get_edge(1))\n  e = MFEdge[int](src:1, dst:2, cap:1,\
    \ flow:1)\n  edge_eq(e, g.get_edge(2))\n\n  g.change_edge(0, 100, 10)\n  e = MFEdge[int](src:0,\
    \ dst:1, cap:100, flow:10)\n  edge_eq(e, g.get_edge(0))\n\n  check 0 == g.flow(0,\
    \ 2)\n  check 90 == g.flow(0, 1)\n\n  e = MFEdge[int](src:0, dst:1, cap:100, flow:100)\n\
    \  edge_eq(e, g.get_edge(0))\n  e = MFEdge[int](src:0, dst:2, cap:1, flow:1)\n\
    \  edge_eq(e, g.get_edge(1))\n  e = MFEdge[int](src:1, dst:2, cap:1, flow:1)\n\
    \  edge_eq(e, g.get_edge(2))\n\n  check 2 == g.flow(2, 0)\n\n  e = MFEdge[int](src:0,\
    \ dst:1, cap:100, flow:99)\n  edge_eq(e, g.get_edge(0))\n  e = MFEdge[int](src:0,\
    \ dst:2, cap:1, flow:0)\n  edge_eq(e, g.get_edge(1))\n  e = MFEdge[int](src:1,\
    \ dst:2, cap:1, flow:0)\n  edge_eq(e, g.get_edge(2))\n\ntest \"MaxflowTest, Bound\"\
    :\n  var e:MFEdge[int32]\n\n  const INF = int32.high\n  var g = init_mf_graph[int32](3)\n\
    \  check 0 == g.add_edge(0, 1, INF)\n  check 1 == g.add_edge(1, 0, INF)\n  check\
    \ 2 == g.add_edge(0, 2, INF)\n\n  check INF == g.flow(0, 2)\n\n  e = MFEdge[int32](src:0,\
    \ dst:1, cap:INF, flow:0.int32)\n  edge_eq(e, g.get_edge(0))\n  e = MFEdge[int32](src:1,\
    \ dst:0, cap:INF, flow:0.int32)\n  edge_eq(e, g.get_edge(1))\n  e = MFEdge[int32](src:0,\
    \ dst:2, cap:INF, flow:INF)\n  edge_eq(e, g.get_edge(2))\n\ntest \"MaxflowTest,\
    \ BoundUint\":\n  var e:MFEdge[uint32]\n\n  const INF = uint32.high\n  var g =\
    \ init_mf_graph[uint32](3)\n  check 0 == g.add_edge(0, 1, INF)\n  check 1 == g.add_edge(1,\
    \ 0, INF)\n  check 2 == g.add_edge(0, 2, INF)\n\n  check INF == g.flow(0, 2)\n\
    \n  e = MFEdge[uint32](src:0, dst:1, cap:INF, flow:0.uint32)\n  edge_eq(e, g.get_edge(0))\n\
    \  e = MFEdge[uint32](src:1, dst:0, cap:INF, flow:0.uint32)\n  edge_eq(e, g.get_edge(1))\n\
    \  e = MFEdge[uint32](src:0, dst:2, cap:INF, flow:INF)\n  edge_eq(e, g.get_edge(2))\n\
    \n# https://github.com/atcoder/ac-library/issues/1\ntest \"MaxflowTest, SelfLoop\"\
    :\n  var g = init_mf_graph[int](3)\n  check 0 == g.add_edge(0, 0, 100)\n\n  let\
    \ e = MFEdge[int](src:0, dst:0, cap:100, flow:0)\n  edge_eq(e, g.get_edge(0))\n\
    \ntest \"MaxflowTest, Invalid\":\n  var g = init_mf_graph[int](2)\n  # https://github.com/atcoder/ac-library/issues/5\n\
    \  expect AssertionError:\n    discard g.flow(0, 0)\n    discard g.flow(0, 0,\
    \ 0)\n\ntest \"MaxflowTest, Stress\":\n  for phase in 0..<10000:\n    let n =\
    \ randint(2, 20);\n    let m = randint(1, 100);\n\n    var (s, t) = randpair(0,\
    \ n - 1)\n    if randbool(): swap(s, t)\n\n    var g = init_mf_graph[int](n)\n\
    \    for i in 0..<m:\n      let\n        u = randint(0, n - 1)\n        v = randint(0,\
    \ n - 1)\n        c = randint(0, 10000)\n      g.add_edge(u, v, c)\n    let flow\
    \ = g.flow(s, t)\n    var dual = 0\n    let cut = g.min_cut(s)\n    var v_flow\
    \ = newSeq[int](n)\n    for e in g.edges:\n      v_flow[e.src] -= e.flow\n   \
    \   v_flow[e.dst] += e.flow\n      if cut[e.src] and not cut[e.dst]: dual += e.cap\n\
    \    check flow == dual\n    check -flow == v_flow[s]\n    check flow == v_flow[t]\n\
    \    for i in 0..<n:\n      if i == s or i == t: continue\n      check 0 == v_flow[i]\n"
  dependsOn:
  - atcoder/maxflow.nim
  - atcoder/internal_queue.nim
  - atcoder/internal_queue.nim
  - atcoder/maxflow.nim
  isVerificationFile: false
  path: tests/test_maxflow.nim
  requiredBy: []
  timestamp: '2021-08-18 01:50:54+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_maxflow.nim
layout: document
redirect_from:
- /library/tests/test_maxflow.nim
- /library/tests/test_maxflow.nim.html
title: tests/test_maxflow.nim
---
