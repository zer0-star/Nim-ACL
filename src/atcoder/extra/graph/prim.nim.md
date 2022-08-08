---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_minimum_spanning_tree_prim_test.nim
    title: verify/extra/graph/aoj_grl_2_a_minimum_spanning_tree_prim_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_minimum_spanning_tree_prim_test.nim
    title: verify/extra/graph/aoj_grl_2_a_minimum_spanning_tree_prim_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_PRIM_HPP:\n  const ATCODER_PRIM_HPP* = 1\n  import\
    \ atcoder/extra/graph/graph_template\n  import std/heapqueue, std/sequtils\n \
    \ \n  proc prim*[G:Graph](g:G, s:int = 0):(G.T, seq[Edge[G.T, G.U]]) =\n    var\n\
    \      total = G.T(0)\n      used = newSeqWith(g.len, false)\n      que = initHeapQueue[Edge[G.T,\
    \ G.U]]()\n      es = newSeq[Edge[G.T, G.U]]()\n    que.push(initEdge(-1, s, g.T(0)))\n\
    \    while que.len > 0:\n      let p = que.pop()\n      if used[p.dst]: continue\n\
    \      used[p.dst] = true;\n      if p.src != -1: es.add(p)\n      total += p.weight\n\
    \      for e in g[p.dst]: que.push(e)\n    return (total, es)\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/prim.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_2_a_minimum_spanning_tree_prim_test.nim
  - verify/extra/graph/aoj_grl_2_a_minimum_spanning_tree_prim_test.nim
documentation_of: atcoder/extra/graph/prim.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/prim.nim
- /library/atcoder/extra/graph/prim.nim.html
title: atcoder/extra/graph/prim.nim
---
