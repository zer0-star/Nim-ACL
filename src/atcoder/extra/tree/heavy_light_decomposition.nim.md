---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
    title: verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
    title: verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_HEAVY_LIGHT_DECOMPOSITION_HPP:\n  import std/sugar\n\
    \  import atcoder/extra/graph/graph_template\n  type HeavyLightDecomposition[T]\
    \ = object\n    sz*, in_a, out_a, head, rev, par, dep*:seq[int]\n  proc initHeavyLightDecomposition*[G:Graph](g:G,\
    \ s = 0):HeavyLightDecomposition[G.T] =\n    type T = G.T\n    var\n      g =\
    \ g\n      sz, in_a, out_a, head, rev, par, dep = newSeq[int](g.len)\n    head[s]\
    \ = s\n    proc dfsSz(idx, p, d:int) =\n      dep[idx] = d\n      par[idx] = p\n\
    \      sz[idx] = 1\n      if g[idx].len > 0 and g[idx][0].dst == p: swap(g[idx][0].dst,\
    \ g[idx][^1].dst)\n      for e in g[idx].mitems:\n        if e.dst == p: continue\n\
    \        dfsSz(e.dst, idx, d + 1)\n        sz[idx] += sz[e.dst];\n        if sz[g[idx][0].dst]\
    \ < sz[e.dst]:\n          swap(g[idx][0].dst, e.dst)\n\n    proc dfsHld(idx, par:int,\
    \ times:var int) =\n      in_a[idx] = times\n      times += 1\n      rev[in_a[idx]]\
    \ = idx;\n      for e in g[idx]:\n        if e.dst == par: continue\n        head[e.dst]\
    \ = if g[idx][0].dst == e.dst: head[idx] else: e.dst\n        dfsHld(e.dst, idx,\
    \ times)\n      out_a[idx] = times\n\n    dfsSz(s, -1, 0)\n    var t = 0\n   \
    \ dfs_hld(s, -1, t)\n    result = HeavyLightDecomposition[T](sz:sz, in_a:in_a,\
    \ out_a:out_a, head:head, rev:rev, par:par, dep:dep)\n  \n  proc la*[T](self:HeavyLightDecomposition[T];\
    \ v, k:int):int =\n    var (v, k) = (v, k)\n    while true:\n      let u = self.head[v]\n\
    \      if self.in_a[v] - k >= self.in_a[u]: return self.rev[self.in_a[v] - k]\n\
    \      k -= self.in_a[v] - self.in_a[u] + 1\n      v = self.par[u]\n\n  proc lca*[T](self:HeavyLightDecomposition[T];\
    \ u, v:int):int =\n    var (u,v) = (u,v)\n    while true:\n      if self.in_a[u]\
    \ > self.in_a[v]: swap(u, v)\n      if self.head[u] == self.head[v]: return u\n\
    \      v = self.par[self.head[v]]\n  proc dist*[T](self: HeavyLightDecomposition[T],\
    \ u, v:int):int =\n    return self.dep[u] + self.dep[v] - 2 * self.dep[self.lca(u,\
    \ v)]\n\n  proc query*[T,U](self: HeavyLightDecomposition[T]; u, v:int, ti:U,\
    \ q:(int, int)->U, f, s:(U,U)->U, edge = false):U =\n    var\n      (l,r) = (ti,ti)\n\
    \      (u,v) = (u,v)\n    while true:\n      if self.in_a[u] > self.in_a[v]: swap(u,\
    \ v); swap(l, r)\n      if self.head[u] == self.head[v]: break\n      l = f(q(self.in_a[self.head[v]],\
    \ self.in_a[v] + 1), l)\n      v = self.par[self.head[v]]\n    return s(f(q(self.in_a[u]\
    \ + edge.int, self.in_a[v] + 1), l), r)\n  proc query*[T,U](self: HeavyLightDecomposition[T];\
    \ u, v:int, ti:U, q:(int, int)->U, f:(U,U)->U, edge = false):U = self.query(u,\
    \ v, ti, q, f, f, edge)\n\n  proc add*[T](self: HeavyLightDecomposition[T]; u,\
    \ v:int, q:(int,int)->void, edge = false) =\n    var (u,v) = (u,v)\n    while\
    \ true:\n      if self.in_a[u] > self.in_a[v]: swap(u, v)\n      if self.head[u]\
    \ == self.head[v]: break\n      q(self.in_a[self.head[v]], self.in_a[v] + 1)\n\
    \      v = self.par[self.head[v]]\n    q(self.in_a[u] + edge.int, self.in_a[v]\
    \ + 1)\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/tree/heavy_light_decomposition.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
  - verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
documentation_of: atcoder/extra/tree/heavy_light_decomposition.nim
layout: document
redirect_from:
- /library/atcoder/extra/tree/heavy_light_decomposition.nim
- /library/atcoder/extra/tree/heavy_light_decomposition.nim.html
title: atcoder/extra/tree/heavy_light_decomposition.nim
---
