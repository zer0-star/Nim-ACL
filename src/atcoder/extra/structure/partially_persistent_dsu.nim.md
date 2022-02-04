---
data:
  _extendedDependsOn: []
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
  code: "when not declared ATCODER_PARTIALLY_PERSISTENT_DSU_HPP:\n  const ATCODER_PARTIALLY_PERSISTENT_DSU_HPP*\
    \ = 1\n  import std/sequtils, std/math, std/algorithm\n  \n  type PartiallyPersistentDSU*\
    \ = object\n    data, last: seq[int]\n    add: seq[seq[(int,int)]]\n  \n  proc\
    \ initPartiallyPersistentDSU*(sz:int):auto =\n    return PartiallyPersistentDSU(\n\
    \      data:newSeqWith(sz, -1), \n      last:newSeqWith(sz, 10^9), \n      add:newSeqWith(sz,\
    \ @[(-1, -1)])\n    )\n  \n  proc leader*(self: PartiallyPersistentDSU, t, x:int):int\
    \ =\n    if t < self.last[x]: return x\n    return self.leader(t, self.data[x])\n\
    \  \n  proc merge*(self: var PartiallyPersistentDSU, t, x, y:int):bool =\n   \
    \ var\n      x = self.leader(t, x)\n      y = self.leader(t, y)\n    if x == y:\
    \ return false\n    if self.data[x] > self.data[y]: swap(x, y)\n    self.data[x]\
    \ += self.data[y]\n    self.add[x].add((t, self.data[x]))\n    self.data[y] =\
    \ x\n    self.last[y] = t\n    return true\n  \n  proc size*(self: PartiallyPersistentDSU,\
    \ t, x:int):int =\n    let x = self.leader(t, x)\n    let i = self.add[x].lower_bound((t,\
    \ 0))\n    return -self.add[x][i - 1][1]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/partially_persistent_dsu.nim
  requiredBy: []
  timestamp: '2020-12-31 00:02:41+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/partially_persistent_dsu.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/partially_persistent_dsu.nim
- /library/atcoder/extra/structure/partially_persistent_dsu.nim.html
title: atcoder/extra/structure/partially_persistent_dsu.nim
---
