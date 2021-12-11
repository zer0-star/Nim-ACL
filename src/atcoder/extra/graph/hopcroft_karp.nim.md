---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_bipartite_matching_test.nim
    title: verify/extra/graph/yosupo_bipartite_matching_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_bipartite_matching_test.nim
    title: verify/extra/graph/yosupo_bipartite_matching_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_EXTRA_HOPCROFT_KARP:\n  const ATCODER_EXTRA_HOPCROFT_KARP*\
    \ = 1\n  import std/sequtils, std/deques\n  import options\n\n  type HopcroftKarp*\
    \ = object\n    n, m:int\n    graph: seq[seq[int]]\n    dist, match: seq[int]\n\
    \    used, vv:seq[bool]\n    maximum_matching_result: Option[seq[(int, int)]]\n\
    \    minimum_vertex_cover_result, maximum_stable_set_result: Option[(seq[int],\
    \ seq[int])]\n\n  proc initHopcroftKarp*(n, m:int): HopcroftKarp =\n    HopcroftKarp(n:n,\
    \ m:m, graph:newSeq[seq[int]](n), match:newSeqWith(m, -1), used: newSeq[bool](n))\n\
    \n  proc add_edge*(self: var HopcroftKarp, u, v:int) = self.graph[u].add(v)\n\n\
    \  proc maximum_matching*(self: var HopcroftKarp):seq[(int,int)] =\n    if self.maximum_matching_result.isSome:\
    \ return self.maximum_matching_result.get\n    proc bfs(self: var HopcroftKarp)\
    \ =\n      self.dist = newSeqWith(self.n, -1)\n      var que = initDeque[int]()\n\
    \      for i in 0..<self.n:\n        if not self.used[i]:\n          que.addLast(i)\n\
    \          self.dist[i] = 0\n\n      while que.len != 0:\n        let a = que.popFirst()\n\
    \        for b in self.graph[a]:\n          let c = self.match[b]\n          if\
    \ c >= 0 and self.dist[c] == -1:\n            self.dist[c] = self.dist[a] + 1\n\
    \            que.addLast(c)\n\n    proc dfs(self: var HopcroftKarp, a:int):bool\
    \ =\n      self.vv[a] = true\n      for b in self.graph[a]:\n        let c = self.match[b]\n\
    \        if c < 0 or (not self.vv[c] and self.dist[c] == self.dist[a] + 1 and\
    \ self.dfs(c)):\n          self.match[b] = a\n          self.used[a] = true\n\
    \          return true\n      return false\n\n    while true:\n      self.bfs()\n\
    \      self.vv = newSeqWith(self.n, false)\n      var flow = 0\n      for i in\
    \ 0..<self.n:\n        if not self.used[i] and self.dfs(i): flow.inc\n      if\
    \ flow == 0: break\n\n    for i in 0..<self.match.len:\n      if self.match[i]\
    \ != -1:\n        result.add((self.match[i], i))\n    self.maximum_matching_result\
    \ = result.some\n\n  proc minimum_vertex_cover*(self: var HopcroftKarp):(seq[int],\
    \ seq[int]) =\n    if self.minimum_vertex_cover_result.isSome(): return self.minimum_vertex_cover_result.get\n\
    \    if not self.maximum_matching_result.isSome(): discard self.maximum_matching()\n\
    \    var colorL = newSeqWith(self.n, 0)\n    var colorR = newSeqWith(self.m, 0)\n\
    \    var matched = newSeqWith(self.n, false)\n    proc dfs(self: HopcroftKarp,\
    \ u:int) =\n      if colorL[u] == 1: return\n      colorL[u] = 1\n      for v\
    \ in self.graph[u]:\n        if self.match[v] != -1 and self.match[v] == u: continue\n\
    \        colorR[v] = 1\n        if self.match[v] != -1:\n          self.dfs(self.match[v])\n\
    \    for (l,r) in self.maximum_matching_result.get():\n      matched[l] = true\n\
    \    for u in 0..<self.n:\n      if not matched[u]:\n        self.dfs(u)\n   \
    \ for u in 0..<self.n:\n      if colorL[u] == 0: result[0].add u\n    for u in\
    \ 0..<self.m:\n      if colorR[u] == 1: result[1].add u\n    self.minimum_vertex_cover_result\
    \ = result.some\n\n  proc maximum_stable_set*(self: var HopcroftKarp):(seq[int],\
    \ seq[int]) =\n    if self.maximum_stable_set_result.isSome: return self.maximum_stable_set_result.get\n\
    \    if not self.minimum_vertex_cover_result.isSome(): discard self.minimum_vertex_cover()\n\
    \    block:\n      var s = self.minimum_vertex_cover_result.get[0]\n      for\
    \ u in 0..<self.n:\n        if u notin s: result[0].add u\n    block:\n      var\
    \ s = self.minimum_vertex_cover_result.get[1]\n      for u in 0..<self.m:\n  \
    \      if u notin s: result[1].add u\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/hopcroft_karp.nim
  requiredBy: []
  timestamp: '2021-07-15 21:51:07+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/yosupo_bipartite_matching_test.nim
  - verify/extra/graph/yosupo_bipartite_matching_test.nim
documentation_of: atcoder/extra/graph/hopcroft_karp.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/hopcroft_karp.nim
- /library/atcoder/extra/graph/hopcroft_karp.nim.html
title: atcoder/extra/graph/hopcroft_karp.nim
---
