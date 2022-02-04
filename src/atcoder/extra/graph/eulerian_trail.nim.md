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
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_EULERIAN_TRAIL_HPP:\n  const ATCODER_EULERIAN_TRAIL_HPP*\
    \ = 1\n  import std/sequtils, std/algorithm\n  import atcoder/dsu\n  type EulerianTrail*[directed:static[bool]]\
    \ = object\n    g:seq[seq[(int,int)]]\n    es:seq[(int,int)]\n    M:int\n    used_vertex,\
    \ used_edge:seq[bool]\n    deg:seq[int]\n\n  proc initEulerianTrail*(V:int, directed:static[bool]):auto\
    \ =\n    result = EulerianTrail[directed](\n      g:newSeq[seq[(int,int)]](V),\
    \ \n      M:0, deg:newSeq[int](V), \n      used_vertex:newSeqWith(V, false)\n\
    \    )\n\n  proc add_edge*(self:var EulerianTrail, a, b:int) =\n    self.es.add((a,\
    \ b))\n    self.g[a].add((b, self.M))\n    when self.directed:\n      self.deg[a].inc\n\
    \      self.deg[b].dec\n    else:\n      self.g[b].add((a, self.M))\n      self.deg[a].inc\n\
    \      self.deg[b].inc\n    self.M.inc\n\n  proc get_edge*(self:var EulerianTrail,\
    \ idx:int):(int,int) = self.es[idx]\n\n  proc go(self:var EulerianTrail, s:int):seq[int]\
    \ =\n    var\n      st:seq[(int,int)]\n      ord:seq[int]\n    st.add((s, -1))\n\
    \    while st.len > 0:\n      let idx = st[^1][0]\n      self.used_vertex[idx]\
    \ = true\n      if self.g[idx].len == 0:\n        ord.add(st[^1][1])\n       \
    \ discard st.pop()\n      else:\n        let e = self.g[idx][^1]\n        discard\
    \ self.g[idx].pop()\n        if self.used_edge[e[1]]: continue\n        self.used_edge[e[1]]\
    \ = true\n        st.add(e)\n    discard ord.pop()\n    ord.reverse\n    return\
    \ ord\n\n  proc enumerate_eulerian_trail*(self:var EulerianTrail):seq[seq[int]]\
    \ =\n    when self.directed:\n      for p in self.deg:\n        if p != 0: return\
    \ @[]\n    else:\n      for p in self.deg:\n        if p mod 2 != 0: return @[]\n\
    \    self.used_edge = newSeqWith(self.M, false)\n    result = newSeq[seq[int]]()\n\
    \    for i in 0..<self.g.len:\n      if self.g[i].len == 0 or self.used_vertex[i]:\
    \ continue\n      result.add(self.go(i))\n\n  proc enumerate_semi_eulerian_trail*(self:var\
    \ EulerianTrail):seq[seq[int]] =\n    var uf = initDSU(self.g.len)\n    for p\
    \ in self.es: uf.merge(p[0], p[1])\n    self.used_edge = newSeqWith(self.M, false)\n\
    \    for vs in uf.groups():\n      var\n        latte = -1\n        malta = -1\n\
    \      when self.directed:\n        for p in vs:\n          if abs(self.deg[p])\
    \ > 1:\n            return @[]\n          elif self.deg[p] == 1:\n           \
    \ if latte >= 0: return @[]\n            latte = p\n      else:\n        for p\
    \ in vs:\n          if self.deg[p] mod 2 != 0:\n            if latte == -1: latte\
    \ = p\n            elif malta == -1: malta = p\n            else: return @[]\n\
    \      result.add(self.go(if latte == -1: vs[0] else: latte))\n      if result[^1].len\
    \ == 0: discard result.pop()\n"
  dependsOn:
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  isVerificationFile: false
  path: atcoder/extra/graph/eulerian_trail.nim
  requiredBy: []
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/eulerian_trail.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/eulerian_trail.nim
- /library/atcoder/extra/graph/eulerian_trail.nim.html
title: atcoder/extra/graph/eulerian_trail.nim
---
