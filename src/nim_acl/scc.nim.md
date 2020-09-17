---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_scc.nim
    title: src/nim_acl/internal_scc.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_scc.nim
    title: src/nim_acl/internal_scc.nim
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
    \ src/nim_acl/internal_scc\n\n  type scc_graph = object\n    internal: internal_scc_graph\n\
    \n  proc initSccGraph*(n:int):auto = init_internal_scc_graph(n)\n  \n  proc add_edge*(self:var\
    \ scc_graph, src, dst:int) =\n    let n = self.internal.num_vertices()\n    assert\
    \ 0 <= src and dst < n\n    assert 0 <= dst and dst < n\n    self.internal.add_edge(src,\
    \ dst)\n\n  proc scc*(self:scc_graph):auto = self.internal.scc()\n"
  dependsOn:
  - src/nim_acl/internal_scc.nim
  - src/nim_acl/internal_scc.nim
  isVerificationFile: false
  path: src/nim_acl/scc.nim
  requiredBy: []
  timestamp: '2020-09-16 23:07:19+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/scc_test.nim
  - verify/scc_test.nim
documentation_of: src/nim_acl/scc.nim
layout: document
redirect_from:
- /library/src/nim_acl/scc.nim
- /library/src/nim_acl/scc.nim.html
title: src/nim_acl/scc.nim
---
