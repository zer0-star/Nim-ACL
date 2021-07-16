---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':question:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':question:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':x:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
  - icon: ':x:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
  - icon: ':warning:'
    path: test/example/twosat_practice.nim
    title: test/example/twosat_practice.nim
  - icon: ':warning:'
    path: test/example/twosat_practice.nim
    title: test/example/twosat_practice.nim
  - icon: ':warning:'
    path: tests/test_scc.nim
    title: tests/test_scc.nim
  - icon: ':warning:'
    path: tests/test_scc.nim
    title: tests/test_scc.nim
  - icon: ':warning:'
    path: tests/test_twosat.nim
    title: tests/test_twosat.nim
  - icon: ':warning:'
    path: tests/test_twosat.nim
    title: tests/test_twosat.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
    title: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
    title: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - icon: ':x:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  - icon: ':x:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  - icon: ':x:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  - icon: ':x:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':question:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_SCC_HPP:\n  const ATCODER_INTERNAL_SCC_HPP*\
    \ = 1\n  \n  import std/sequtils\n  \n  type csr[E] = object\n    start:seq[int]\n\
    \    elist:seq[E]\n  proc initCsr*[E](n:int, edges:seq[(int,E)]):auto =\n    var\n\
    \      start = newSeq[int](n + 1)\n      elist = newSeq[E](edges.len)\n    for\
    \ e in edges:\n      start[e[0] + 1].inc\n    for i in 1..n:\n      start[i] +=\
    \ start[i - 1]\n    var counter = start\n    for e in edges:\n      elist[counter[e[0]]]\
    \ = e[1]\n      counter[e[0]].inc\n    return csr[E](start:start, elist:elist)\n\
    \  \n  type edge* = object\n    dst:int\n  # Reference:\n  # R. Tarjan,\n  # Depth-First\
    \ Search and Linear Graph Algorithms\n  type internal_scc_graph* = object\n  \
    \  n:int\n    edges:seq[(int,edge)]\n\n  proc init_internal_scc_graph*(n:int):auto\
    \ = internal_scc_graph(n:n, edges:newSeq[(int,edge)]())\n  \n  proc num_vertices*(self:\
    \ internal_scc_graph):int =  self.n\n\n  proc add_edge*(self: var internal_scc_graph,\
    \ src, dst:int) = self.edges.add((src, edge(dst:dst)))\n\n  # @return pair of\
    \ (# of scc, scc id)\n  proc scc_ids*(self: internal_scc_graph):(int,seq[int])\
    \ =\n    var g = initCsr[edge](self.n, self.edges)\n    var now_ord, group_num\
    \ = 0\n    var\n      visited = newSeqOfCap[int](self.n)\n      low = newSeq[int](self.n)\n\
    \      ord = newSeqWith(self.n, -1)\n      ids = newSeq[int](self.n)\n    proc\
    \ dfs(v:int) =\n      low[v] = now_ord\n      ord[v] = now_ord\n      now_ord.inc\n\
    \      visited.add(v)\n      for i in g.start[v] ..< g.start[v + 1]:\n       \
    \ let dst = g.elist[i].dst\n        if ord[dst] == -1:\n          dfs(dst)\n \
    \         low[v] = min(low[v], low[dst])\n        else:\n          low[v] = min(low[v],\
    \ ord[dst])\n      if low[v] == ord[v]:\n        while true:\n          let u\
    \ = visited[^1]\n          discard visited.pop()\n          ord[u] = self.n\n\
    \          ids[u] = group_num\n          if u == v: break\n        group_num.inc\n\
    \    for i in 0..<self.n:\n      if ord[i] == -1: dfs(i)\n    ids.applyIt(group_num\
    \ - 1 - it)\n    return (group_num, ids)\n\n  proc scc*(self: internal_scc_graph):auto\
    \ =\n    let\n      ids = self.scc_ids()\n      group_num = ids[0]\n    var counts\
    \ = newSeq[int](group_num)\n    for x in ids[1]: counts[x].inc\n    result = newSeq[seq[int]](ids[0])\n\
    \    for i in 0..<group_num:\n      result[i] = newSeqOfCap[int](counts[i])\n\
    \    for i in 0..<self.n:\n      result[ids[1][i]].add(i)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/internal_scc.nim
  requiredBy:
  - tests/test_twosat.nim
  - tests/test_twosat.nim
  - tests/test_scc.nim
  - tests/test_scc.nim
  - atcoder/scc.nim
  - atcoder/scc.nim
  - atcoder/twosat.nim
  - atcoder/twosat.nim
  - test/example/twosat_practice.nim
  - test/example/twosat_practice.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/scc_test.nim
  - verify/scc_test.nim
  - verify/twosat_test.nim
  - verify/twosat_test.nim
  - verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
documentation_of: atcoder/internal_scc.nim
layout: document
redirect_from:
- /library/atcoder/internal_scc.nim
- /library/atcoder/internal_scc.nim.html
title: atcoder/internal_scc.nim
---
