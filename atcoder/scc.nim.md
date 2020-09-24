---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SCC_HPP:\n  const ATCODER_SCC_HPP* = 1\n\n  import\
    \ atcoder/internal_scc\n\n  type scc_graph = object\n    internal: internal_scc_graph\n\
    \n  proc initSccGraph*(n:int):auto =\n    scc_graph(internal:init_internal_scc_graph(n))\n\
    \  \n  proc add_edge*(self:var scc_graph, src, dst:int) =\n    let n = self.internal.num_vertices()\n\
    \    assert 0 <= src and dst < n\n    assert 0 <= dst and dst < n\n    self.internal.add_edge(src,\
    \ dst)\n\n  proc scc*(self:scc_graph):auto = self.internal.scc()\n"
  dependsOn:
  - atcoder/internal_scc.nim
  - atcoder/internal_scc.nim
  isVerificationFile: false
  path: atcoder/scc.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/scc_test.nim
  - verify/scc_test.nim
documentation_of: atcoder/scc.nim
layout: document
redirect_from:
- /library/atcoder/scc.nim
- /library/atcoder/scc.nim.html
title: atcoder/scc.nim
---
