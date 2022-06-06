---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/tree/rerooting_test.nim
    title: verify/extra/tree/rerooting_test.nim
  - icon: ':x:'
    path: verify/extra/tree/rerooting_test.nim
    title: verify/extra/tree/rerooting_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_REROOTING_HPP:\n  const ATCODER_REROOTING_HPP*\
    \ = 1\n  import sequtils\n  type\n    Edge*[Weight, Data] = object\n      to:\
    \ int\n      weight: Weight\n      dp, ndp: Data\n    ReRooting*[Weight, Data]\
    \ = object\n      g:seq[seq[Edge[Weight, Data]]]\n      subdp*, dp*: seq[Data]\n\
    \      ident: Data\n      f_up: proc(d:Data,w:Weight):Data\n      f_merge: proc(d0,\
    \ d1: Data):Data\n  \n  proc initEdge*[Weight, Data](to:int, d: Weight, dp, ndp:\
    \ Data):Edge[Weight, Data] = Edge[Weight, Data](to: to, weight: d, dp: dp, ndp:\
    \ ndp)\n  proc initReRooting*[Weight, Data](n:int, f_up:proc(d:Data,w:Weight):Data,\
    \ f_merge:proc(d0, d1:Data):Data, ident:Data):ReRooting[Weight,Data] =\n    return\
    \ ReRooting[Weight,Data](\n      g:newSeqWith(n, newSeq[Edge[Weight, Data]]()),\n\
    \      subdp: newSeqWith(n, ident),\n      dp: newSeqWith(n, ident),\n      f_up:f_up,\
    \ f_merge:f_merge, ident:ident)\n  \n  proc addEdge*[Weight, Data](self: var ReRooting[Weight,\
    \ Data]; u,v:int, d:Weight) =\n    self.g[u].add(initEdge[Weight, Data](v, d,\
    \ self.ident, self.ident))\n    self.g[v].add(initEdge[Weight, Data](u, d, self.ident,\
    \ self.ident))\n  proc addBiEdge*[Weight, Data](self: var ReRooting[Weight, Data];\
    \ u,v:int, d,e:Weight) =\n    self.g[u].add(initEdge[Weight, Data](v, d, self.ident,\
    \ self.ident))\n    self.g[v].add(initEdge[Weight, Data](u, e, self.ident, self.ident))\n\
    \  proc addBiEdge*[Weight, Data](self: var ReRooting[Weight, Data]; u,v:int, d:Weight)\
    \ =\n    self.g[u].add(initEdge[Weight, Data](v, d, self.ident, self.ident))\n\
    \    self.g[v].add(initEdge[Weight, Data](u, d, self.ident, self.ident))\n\n \
    \ proc dfs_sub*[Weight, Data](self: var ReRooting[Weight, Data]; idx, par:int)\
    \ =\n    for e in self.g[idx]:\n      if e.to == par: continue\n      self.dfs_sub(e.to,\
    \ idx)\n      self.subdp[idx] = self.f_merge(self.subdp[idx], self.f_up(self.subdp[e.to],\
    \ e.weight))\n  \n  proc dfs_all*[Weight, Data](self: var ReRooting[Weight, Data];\
    \ idx, par:int, top:Data) =\n    var buff = self.ident\n    for i in 0..<self.g[idx].len:\n\
    \      var e = self.g[idx][i].addr\n      e[].ndp = buff\n      e[].dp = self.f_up(if\
    \ par == e.to: top else: self.subdp[e.to], e[].weight)\n      buff = self.f_merge(buff,\
    \ e[].dp)\n    self.dp[idx] = buff\n    buff = self.ident\n    for i in countdown(self.g[idx].len\
    \ - 1, 0):\n      var e = self.g[idx][i].addr\n      if e[].to != par:\n     \
    \   var tmp = self.f_merge(e[].ndp, buff)\n        self.dfs_all(e[].to, idx, tmp)\n\
    \      e[].ndp = self.f_merge(e[].ndp, buff)\n      buff = self.f_merge(buff,\
    \ e[].dp)\n  \n  proc solve*[Weight, Data](self: var ReRooting[Weight, Data]):seq[Data]\
    \ =\n    self.dfs_sub(0, -1)\n    self.dfs_all(0, -1, self.ident)\n    return\
    \ self.dp\n  \n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/tree/rerooting.nim
  requiredBy: []
  timestamp: '2021-11-18 02:51:01+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/tree/rerooting_test.nim
  - verify/extra/tree/rerooting_test.nim
documentation_of: atcoder/extra/tree/rerooting.nim
layout: document
redirect_from:
- /library/atcoder/extra/tree/rerooting.nim
- /library/atcoder/extra/tree/rerooting.nim.html
title: atcoder/extra/tree/rerooting.nim
---
