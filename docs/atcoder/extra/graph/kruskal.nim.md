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
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
    title: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
    title: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_KRUSKAL_HPP:\n  const ATCODER_KRUSKAL_HPP* = 1\n\
    \  import atcoder/extra/graph/graph_template\n  import atcoder/dsu\n  proc kruskal*[G:Graph](g:G):(G.T,\
    \ seq[Edge[G.T, G.U]]) =\n    var es = newSeq[Edge[G.T, G.U]]()\n    for u in\
    \ 0..<g.len:\n      for e in g[u]:\n        es.add(e)\n    es.sort()\n    var\n\
    \      ret = newSeq[Edge[G.T, G.U]]()\n      uf = initDSU(g.len)\n      total\
    \ = G.T(0)\n    for e in es:\n      if not uf.same(e.src, e.dst):\n        uf.merge(e.src,\
    \ e.dst)\n        total += e.weight\n        ret.add(e)\n    return (total, ret)\n"
  dependsOn:
  - atcoder/dsu.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/dsu.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/dsu.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/dsu.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/kruskal.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
  - verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
documentation_of: atcoder/extra/graph/kruskal.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/kruskal.nim
- /library/atcoder/extra/graph/kruskal.nim.html
title: atcoder/extra/graph/kruskal.nim
---
