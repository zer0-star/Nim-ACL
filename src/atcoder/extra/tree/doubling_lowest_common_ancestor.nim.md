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
  - icon: ':x:'
    path: verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
    title: verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
  - icon: ':x:'
    path: verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
    title: verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
  - icon: ':x:'
    path: verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
    title: verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
  - icon: ':x:'
    path: verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
    title: verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LOWEST_COMMON_ANCESTOR_DOUBLING:\n  const ATCODER_LOWEST_COMMON_ANCESTOR_DOUBLING*\
    \ = 1\n  import std/sequtils\n  import atcoder/extra/graph/graph_template\n  type\
    \ DoublingLowestCommonAncestor*[T] = object\n    LOG:int\n    dep*:seq[int]\n\
    \    table:seq[seq[int]]\n  \n  proc initDoublingLowestCommonAncestor*[G:Graph](g:G,\
    \ r = 0):DoublingLowestCommonAncestor[G.T] =\n    type T = G.T\n    var (LOG,\
    \ t) = (0, 1)\n    while t <= g.len: t *= 2;LOG+=1\n    var\n      dep = newSeqWith(g.len,\
    \ 0)\n      table = newSeqWith(LOG, newSeqWith(g.len, -1))\n    proc dfs(idx,\
    \ par, d:int) =\n      table[0][idx] = par\n      dep[idx] = d\n      for e in\
    \ g[idx]:\n        if e.dst != par: dfs(e.dst, idx, d + 1)\n    dfs(r, -1, 0)\n\
    \    for k in 0..<LOG-1:\n      for i in 0..<table[k].len:\n        if table[k][i]\
    \ == -1: table[k + 1][i] = -1\n        else: table[k + 1][i] = table[k][table[k][i]]\n\
    \    return DoublingLowestCommonAncestor[T](LOG:LOG, dep:dep, table:table)\n\n\
    \  proc ancestor*[T](self: DoublingLowestCommonAncestor[T], u:int, h:int):int\
    \ =\n    assert self.dep[u] >= h\n    var u = u\n    for i in countdown(self.LOG-1,\
    \ 0):\n      if (((self.dep[u] - h) shr i) and 1) > 0: u = self.table[i][u]\n\
    \    return u\n\n  proc lca*[T](self: DoublingLowestCommonAncestor[T], u, v:int):int\
    \ =\n    var (u,v) = (u,v)\n    if self.dep[u] > self.dep[v]: swap(u,v)\n    for\
    \ i in countdown(self.LOG-1, 0):\n      if (((self.dep[v] - self.dep[u]) shr i)\
    \ and 1) > 0: v = self.table[i][v]\n    if u == v: return u\n    for i in countdown(self.LOG-1,\
    \ 0):\n      if self.table[i][u] != self.table[i][v]:\n        u = self.table[i][u]\n\
    \        v = self.table[i][v]\n    return self.table[0][u]\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/tree/doubling_lowest_common_ancestor.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
  - verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
  - verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
  - verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
documentation_of: atcoder/extra/tree/doubling_lowest_common_ancestor.nim
layout: document
redirect_from:
- /library/atcoder/extra/tree/doubling_lowest_common_ancestor.nim
- /library/atcoder/extra/tree/doubling_lowest_common_ancestor.nim.html
title: atcoder/extra/tree/doubling_lowest_common_ancestor.nim
---
