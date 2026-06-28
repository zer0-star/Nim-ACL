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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_REROOTING_HPP:\n  const ATCODER_REROOTING_HPP*\
    \ = 1\n  #import atcoder/extra/other/debug\n\n  type ReRooting*[T, Weight] = object\n\
    \    V:int\n    f: proc(a:T, v:int, w:Weight):T\n    g: proc(a:T, v:int):T\n \
    \   merge: proc(a, b:T):T\n    G:seq[seq[tuple[dst:int, weight:Weight]]]\n   \
    \ dp:seq[seq[T]]\n  # dp_v = g(merge(f(dp_c1,c1), f(dp_c2,c2), ..., f(dp_ck,ck)),\
    \ v)\n    mi:T # identity of merge\n\n  proc initReRootingImpl*[T, Weight](V:int,\
    \ f:proc(a:T, v:int, w:Weight):T, merge:proc(a, b:T):T, mi:T, g:proc(a:T, v:int):T):ReRooting[T,\
    \ Weight] =\n    ReRooting[T, Weight](V:V, f:f, merge:merge, mi:mi, g:g, G:newSeq[seq[tuple[dst:int,\
    \ weight:Weight]]](V), dp:newSeq[seq[T]](V))\n  proc initReRooting*[T, Weight](V:int,\
    \ f:proc(a:T, v:int, w:Weight):T, merge:proc(a, b:T):T, mi:T, g:proc(a:T, v:int):T):ReRooting[T,\
    \ Weight] =\n    initReRootingImpl[T, Weight](V, f, merge, mi, g)\n  proc initReRooting*[T](V:int,\
    \ f:proc(a:T, v:int):T, merge:proc(a, b:T):T, mi:T, g:proc(a:T, v:int):T):ReRooting[T,\
    \ int] =\n    proc f0(a:T, v:int, w:int):T = f(a, v)\n    initReRootingImpl[T,\
    \ int](V, f0, merge, mi, g)\n  proc initReRooting*[T, Weight](V:int, f:proc(a:T,\
    \ v:int, w:Weight):T, merge:proc(a, b:T):T, mi:T):ReRooting[T, Weight] =\n   \
    \ proc g(a:T, v:int):T = a\n    initReRooting[T, Weight](V, f, merge, mi, g)\n\
    \n  #void read(int idx = 1) {\n  #  int a, b;\n  #  for (int i = 0; i < V - 1;\
    \ ++i) {\n  #    cin >> a >> b;\n  #    a -= idx, b -= idx;\n  #    G[a].emplace_back(b);\n\
    \  #    G[b].emplace_back(a);\n  #  }\n  #}\n\n  proc add_edge*[T, Weight](self:\
    \ var ReRooting[T, Weight], a, b:int) =\n    self.G[a].add((b, Weight.default))\n\
    \    self.G[b].add((a, Weight.default))\n  proc add_bi_edge*[T, Weight](self:\
    \ var ReRooting[T, Weight], a, b:int, w:Weight) =\n    self.G[a].add((b, w))\n\
    \    self.G[b].add((a, w))\n  proc add_bi_edge*[T, Weight](self: var ReRooting[T,\
    \ Weight], a, b:int, w1, w2:Weight) =\n    self.G[a].add((b, w1))\n    self.G[b].add((a,\
    \ w2))\n\n  proc dfs1*[T, Weight](self:var ReRooting[T, Weight], p, v:int):T =\n\
    \    var res = self.mi\n    for i in 0 ..< self.G[v].len:\n      let e = self.G[v][i]\n\
    \      if e.dst == p: continue\n      self.dp[v][i] = self.dfs1(v, e.dst)\n  \
    \    res = self.merge(res, self.f(self.dp[v][i], e.dst, e.weight))\n    return\
    \ self.g(res, v)\n\n  proc dfs2*[T, Weight](self:var ReRooting[T, Weight], p,\
    \ v:int, from_par:T) =\n    for i in 0 ..< self.G[v].len:\n      if self.G[v][i].dst\
    \ == p:\n        self.dp[v][i] = from_par\n        break\n    var pR = newSeq[T,\
    \ Weight](self.G[v].len + 1)\n    pR[self.G[v].len] = self.mi\n    for i in countdown(self.G[v].len,\
    \ 1):\n      let e = self.G[v][i - 1]\n      pR[i - 1] = self.merge(pR[i], self.f(self.dp[v][i\
    \ - 1], e.dst, e.weight))\n    var pL = self.mi\n    for i in 0 ..< self.G[v].len:\n\
    \      let e = self.G[v][i]\n      if e.dst != p:\n        let val = self.merge(pL,\
    \ pR[i + 1])\n        self.dfs2(v, e.dst, self.g(val, v))\n      pL = self.merge(pL,\
    \ self.f(self.dp[v][i], e.dst, e.weight))\n\n  proc solve*[T, Weight](self: var\
    \ ReRooting[T, Weight], root = 0) =\n    for i in 0 ..< self.V:\n      self.dp[i].setLen(self.G[i].len)\n\
    \    discard self.dfs1(-1, root)\n    self.dfs2(-1, root, self.mi)\n\n  proc `[]`*[T,\
    \ Weight](self: ReRooting[T, Weight], v:int):T =\n    var ans = self.mi\n    for\
    \ i in 0 ..< self.G[v].len:\n      let e = self.G[v][i]\n      ans = self.merge(ans,\
    \ self.f(self.dp[v][i], e.dst, e.weight))\n    return self.g(ans, v)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/tree/rerooting.nim
  requiredBy: []
  timestamp: '2022-10-24 18:34:10+09:00'
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
