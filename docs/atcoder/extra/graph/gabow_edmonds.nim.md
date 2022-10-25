---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_matching_on_general_graph_test.nim
    title: verify/extra/graph/yosupo_matching_on_general_graph_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_matching_on_general_graph_test.nim
    title: verify/extra/graph/yosupo_matching_on_general_graph_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_GABOW_EDMONS_HPP:\n  const ATCODER_GABOW_EDMONS_HPP*\
    \ = 1\n  import deques, sequtils\n  \n  type edge = object\n    to, idx:int\n\
    \  \n  type GabowEdmonds = object\n    g:seq[seq[edge]]\n    edges:seq[(int,int)]\n\
    \    mate, label, first: seq[int]\n    que:Deque[int]\n  \n  proc initGabowEdmonds*(n:int):GabowEdmonds\
    \ =\n    return GabowEdmonds(g:newSeq[seq[edge]](n + 1), mate: newSeq[int](n +\
    \ 1), label: newSeqWith(n + 1, -1), first: newSeq[int](n + 1), que:initDeque[int]())\n\
    \  \n  proc add_edge*(self: var GabowEdmonds; u, v:int) =\n    var\n      u =\
    \ u + 1\n      v = v + 1\n    self.g[u].add(edge(to:v, idx:self.edges.len + self.g.len))\n\
    \    self.g[v].add(edge(to:u, idx:self.edges.len + self.g.len))\n    self.edges.add((u,\
    \ v))\n  \n  proc find(self: var GabowEdmonds, x:int):int =\n    if self.label[self.first[x]]\
    \ < 0: return self.first[x]\n    self.first[x] = self.find(self.first[x])\n  \
    \  return self.first[x]\n  \n  proc rematch(self: var GabowEdmonds, v,w:int) =\n\
    \    let t = self.mate[v]\n    self.mate[v] = w\n    if self.mate[t] != v: return\n\
    \    if self.label[v] < self.g.len:\n      self.mate[t] = self.label[v]\n    \
    \  self.rematch(self.label[v], t)\n    else:\n      let\n        p = self.edges[self.label[v]\
    \ - self.g.len]\n        (x, y) = p\n      self.rematch(x, y)\n      self.rematch(y,\
    \ x)\n  \n  proc assignLabel(self: var GabowEdmonds, x,y,num:int) =\n    var r\
    \ = self.find(x)\n    var s = self.find(y)\n    var join = 0;\n    if r == s:\
    \ return\n    self.label[r] = -num\n    self.label[s] = -num\n    while true:\n\
    \      if s != 0: swap(r, s)\n      r = self.find(self.label[self.mate[r]])\n\
    \      if self.label[r] == -num:\n        join = r\n        break\n      self.label[r]\
    \ = -num\n    var v = self.first[x]\n    while v != join:\n      self.que.addLast(v)\n\
    \      self.label[v] = num\n      self.first[v] = join\n      v = self.first[self.label[self.mate[v]]]\n\
    \    v = self.first[y]\n    while v != join:\n      self.que.addLast(v)\n    \
    \  self.label[v] = num\n      self.first[v] = join\n      v = self.first[self.label[self.mate[v]]]\n\
    \  \n  proc augmentCheck(self: var GabowEdmonds, u:int):bool =\n    self.que =\
    \ initDeque[int]()\n    self.first[u] = 0\n    self.label[u] = 0\n    self.que.addLast(u)\n\
    \    while self.que.len > 0:\n      let x = self.que.popFirst()\n      for e in\
    \ self.g[x]:\n        let y = e.to\n        if self.mate[y] == 0 and y != u:\n\
    \          self.mate[y] = x\n          self.rematch(x, y)\n          return true\n\
    \        elif self.label[y] >= 0:\n          self.assignLabel(x, y, e.idx)\n \
    \       elif self.label[self.mate[y]] < 0:\n          self.label[self.mate[y]]\
    \ = x\n          self.first[self.mate[y]] = y\n          self.que.addLast(self.mate[y])\n\
    \    return false\n  \n  proc maxMatching*(self: var GabowEdmonds):seq[(int,int)]\
    \ =\n    for i in 1..<self.g.len:\n      if self.mate[i] != 0: continue\n    \
    \  if self.augmentCheck(i): self.label = newSeqWith(self.g.len, -1)\n    result\
    \ = newSeq[(int,int)]()\n    for i in 1..<self.g.len:\n      if i < self.mate[i]:\
    \ result.add((i - 1, self.mate[i] - 1))\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/gabow_edmonds.nim
  requiredBy: []
  timestamp: '2020-12-19 22:31:09+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/yosupo_matching_on_general_graph_test.nim
  - verify/extra/graph/yosupo_matching_on_general_graph_test.nim
documentation_of: atcoder/extra/graph/gabow_edmonds.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/gabow_edmonds.nim
- /library/atcoder/extra/graph/gabow_edmonds.nim.html
title: atcoder/extra/graph/gabow_edmonds.nim
---
