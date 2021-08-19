---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':question:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':warning:'
    path: atcoder/internal_heap.nim
    title: atcoder/internal_heap.nim
  - icon: ':warning:'
    path: atcoder/internal_heap.nim
    title: atcoder/internal_heap.nim
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
  code: "import std/unittest\nimport atcoder/mincostflow, atcoder/maxflow\nimport\
    \ \"../test/utils/random.nim\"\n\ntype ll = int\ntype ull = uint\n\ntest \"MincostflowTest,\
    \ Zero\":\n  var g1:MCFGraph[int,int]\n  var g2 = initMCFGraph[int,int](0)\n\n\
    template edge_eq[edge](expect, actual:edge) =\n  check expect.src == actual.src\n\
    \  check expect.dst == actual.dst\n  check expect.cap == actual.cap\n  check expect.flow\
    \ == actual.flow\n  check expect.cost == actual.cost\n\nproc make_edge_info[Cap,\
    \ Cost](src, dst:int, cap, flow:Cap, cost:Cost):auto =\n  MCFEdge[Cap, Cost](src:src,\
    \ dst:dst, cap:cap, flow:flow, cost:cost)\n\ntest \"MincostflowTest, Simple\"\
    :\n  var g = initMCFGraph[int,int](4)\n  g.add_edge(0, 1, 1, 1)\n  g.add_edge(0,\
    \ 2, 1, 1)\n  g.add_edge(1, 3, 1, 1)\n  g.add_edge(2, 3, 1, 1)\n  g.add_edge(1,\
    \ 2, 1, 1)\n  let expect = @[(0, 0), (2, 4)]\n  check expect == g.slope(0, 3,\
    \ 10)\n  var e = MCFEdge[int,int]()\n\n  e = make_edge_info(0, 1, 1, 1, 1)\n \
    \ edge_eq(e, g.get_edge(0))\n  e = make_edge_info(0, 2, 1, 1, 1)\n  edge_eq(e,\
    \ g.get_edge(1))\n  e = make_edge_info(1, 3, 1, 1, 1)\n  edge_eq(e, g.get_edge(2))\n\
    \  e = make_edge_info(2, 3, 1, 1, 1)\n  edge_eq(e, g.get_edge(3))\n  e = make_edge_info(1,\
    \ 2, 1, 0, 1)\n  edge_eq(e, g.get_edge(4))\n\ntest \"MincostflowTest, Usage\"\
    :\n  block:\n    var g = initMCFGraph[int,int](2)\n    g.add_edge(0, 1, 1, 2)\n\
    \    check (1, 2) == g.flow(0, 1)\n  block:\n    var g = initMCFGraph[int,int](2)\n\
    \    g.add_edge(0, 1, 1, 2);\n    let expect = @[(0, 0), (1, 2)]\n    check expect\
    \ == g.slope(0, 1)\n\ntest \"MincostflowTest, Assign\":\n  var g:MCFGraph[int,int]\n\
    \  g = initMCFGraph[int,int](10)\n\ntest \"MincostflowTest, OutOfRange\":\n  var\
    \ g = initMCFGraph[int,int](10)\n  \n  expect AssertionError: discard g.slope(-1,\
    \ 3)\n  expect AssertionError: discard g.slope(3, 3)\n\n# https://github.com/atcoder/ac-library/issues/1\n\
    test \"MincostflowTest, SelfLoop\":\n  var g = initMCFGraph[int,int](3)\n  check\
    \ 0 == g.add_edge(0, 0, 100, 123)\n  \n  var e = make_edge_info(0, 0, 100, 0,\
    \ 123)\n  edge_eq(e, g.get_edge(0))\n\ntest \"MincostflowTest, SameCostPaths\"\
    :\n  var g = initMCFGraph[int,int](3)\n  check 0 == g.add_edge(0, 1, 1, 1)\n \
    \ check 1 == g.add_edge(1, 2, 1, 0)\n  check 2 == g.add_edge(0, 2, 2, 1)\n  let\
    \ expected = @[(0, 0), (3, 3)]\n  check expected == g.slope(0, 2)\n\ntest \"MincostflowTest,\
    \ Invalid\":\n  var g = initMCFGraph[int,int](2)\n  # https://github.com/atcoder/ac-library/issues/51\n\
    \  expect AssertionError: discard g.add_edge(0, 0, -1, 0)\n  expect AssertionError:\
    \ discard g.add_edge(0, 0, 0, -1)\n\n\n\ntest \"MincostflowTest, Stress\":\n \
    \ for phase in 0..<1000:\n    let n = randint(2, 20)\n    let m = randint(1, 100)\n\
    \    var (s, t) = randpair(0, n - 1)\n    if randbool(): swap(s, t)\n\n    var\
    \ g_mf = initMFGraph[int](n)\n    var g = initMCFGraph[int, int](n)\n    for i\
    \ in 0..<m:\n      let u = randint(0, n - 1)\n      let v = randint(0, n - 1)\n\
    \      let cap = randint(0, 10)\n      let cost = randint(0, 10000)\n      g.add_edge(u,\
    \ v, cap, cost)\n      g_mf.add_edge(u, v, cap)\n    var (flow, cost) = g.flow(s,\
    \ t)\n    check g_mf.flow(s, t) == flow\n\n    var cost2 = 0\n    var v_cap =\
    \ newSeq[int](n)\n    for e in g.edges():\n      v_cap[e.src] -= e.flow\n    \
    \  v_cap[e.dst] += e.flow\n      cost2 += e.flow * e.cost\n    check cost == cost2\n\
    \n    for i in 0..<n:\n      if i == s:\n        check -flow == v_cap[i]\n   \
    \   elif i == t:\n        check flow == v_cap[i]\n      else:\n        check 0\
    \ == v_cap[i]\n\n    # check: there is no negative-cycle\n    var dist = newSeq[int](n)\n\
    \    while true:\n      var update = false\n      for e in g.edges():\n      \
    \  if e.flow < e.cap:\n          let ndist = dist[e.src] + e.cost\n          if\
    \ ndist < dist[e.dst]:\n            update = true\n            dist[e.dst] = ndist\n\
    \        if e.flow != 0:\n          let ndist = dist[e.dst] - e.cost\n       \
    \   if ndist < dist[e.src]:\n            update = true\n            dist[e.src]\
    \ = ndist\n      if not update: break\n\n"
  dependsOn:
  - atcoder/maxflow.nim
  - atcoder/mincostflow.nim
  - atcoder/mincostflow.nim
  - atcoder/internal_heap.nim
  - atcoder/internal_heap.nim
  - atcoder/internal_csr.nim
  - atcoder/internal_csr.nim
  - atcoder/internal_queue.nim
  - atcoder/internal_queue.nim
  - atcoder/maxflow.nim
  isVerificationFile: false
  path: tests/test_mincostflow.nim
  requiredBy: []
  timestamp: '2021-08-18 01:50:54+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_mincostflow.nim
layout: document
redirect_from:
- /library/tests/test_mincostflow.nim
- /library/tests/test_mincostflow.nim.html
title: tests/test_mincostflow.nim
---
