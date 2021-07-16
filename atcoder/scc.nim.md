---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: tests/test_scc.nim
    title: tests/test_scc.nim
  - icon: ':warning:'
    path: tests/test_scc.nim
    title: tests/test_scc.nim
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
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':question:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SCC_HPP:\n  const ATCODER_SCC_HPP* = 1\n\n  import\
    \ atcoder/internal_scc\n\n  type SCCGraph* = object\n    internal: internal_scc_graph\n\
    \n  proc initSccGraph*(n:int):auto =\n    SCCGraph(internal:init_internal_scc_graph(n))\n\
    \  \n  proc add_edge*(self:var SCCgraph, src, dst:int) =\n    let n = self.internal.num_vertices()\n\
    \    assert 0 <= src and dst < n\n    assert 0 <= dst and dst < n\n    self.internal.add_edge(src,\
    \ dst)\n\n  proc scc*(self:SCCGraph):auto = self.internal.scc()\n"
  dependsOn:
  - atcoder/internal_scc.nim
  - atcoder/internal_scc.nim
  isVerificationFile: false
  path: atcoder/scc.nim
  requiredBy:
  - tests/test_scc.nim
  - tests/test_scc.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/scc_test.nim
  - verify/scc_test.nim
  - verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
documentation_of: atcoder/scc.nim
layout: document
redirect_from:
- /library/atcoder/scc.nim
- /library/atcoder/scc.nim.html
title: atcoder/scc.nim
---
