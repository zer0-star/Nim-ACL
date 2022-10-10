---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_generalized.nim
    title: atcoder/extra/graph/mincostflow_generalized.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_generalized.nim
    title: atcoder/extra/graph/mincostflow_generalized.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_generalized.nim
    title: atcoder/extra/graph/mincostflow_generalized.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_generalized.nim
    title: atcoder/extra/graph/mincostflow_generalized.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_lowerbound.nim
    title: atcoder/extra/graph/mincostflow_lowerbound.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_lowerbound.nim
    title: atcoder/extra/graph/mincostflow_lowerbound.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_lowerbound.nim
    title: atcoder/extra/graph/mincostflow_lowerbound.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/mincostflow_lowerbound.nim
    title: atcoder/extra/graph/mincostflow_lowerbound.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
    title: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
    title: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_SCC_HPP:\n  const ATCODER_INTERNAL_SCC_HPP*\
    \ = 1\n  \n  import std/sequtils\n  import atcoder/internal_csr\n\n  \n  type\
    \ edge* = object\n    dst:int\n  # Reference:\n  # R. Tarjan,\n  # Depth-First\
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
  dependsOn:
  - atcoder/internal_csr.nim
  - atcoder/internal_csr.nim
  isVerificationFile: false
  path: atcoder/internal_scc.nim
  requiredBy:
  - atcoder/extra/graph/mincostflow_lowerbound.nim
  - atcoder/extra/graph/mincostflow_lowerbound.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/scc.nim
  - atcoder/scc.nim
  - atcoder/extra/graph/mincostflow_lowerbound.nim
  - atcoder/extra/graph/mincostflow_lowerbound.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/extra/graph/mincostflow_generalized.nim
  - atcoder/twosat.nim
  - atcoder/twosat.nim
  timestamp: '2021-08-18 01:50:54+09:00'
  verificationStatus: LIBRARY_ALL_AC
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
