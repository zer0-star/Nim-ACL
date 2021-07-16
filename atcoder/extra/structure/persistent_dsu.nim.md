---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/persistent_array.nim
    title: atcoder/extra/structure/persistent_array.nim
  - icon: ':x:'
    path: atcoder/extra/structure/persistent_array.nim
    title: atcoder/extra/structure/persistent_array.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/structure/yosupo_persistent_unionfind_test.nim
    title: verify/extra/structure/yosupo_persistent_unionfind_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_persistent_unionfind_test.nim
    title: verify/extra/structure/yosupo_persistent_unionfind_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_PERSISTENT_DSU_HPP:\n  const ATCODER_PERSISTENT_DSU_HPP*\
    \ = 1\n  import std/sequtils\n  import atcoder/extra/structure/persistent_array\n\
    \  type PersistentDSU* = object\n    data: PersistentArray[int]\n  \n  proc initPersistentDSU*(sz:int):PersistentDSU\
    \ =\n    PersistentDSU(data:initPersistentArray[int](newSeqWith(sz, -1)))\n  \n\
    \  proc leader*(self:PersistentDSU, k:int):int =\n    let p = self.data[k]\n \
    \   return if p >= 0: self.leader(p) else: k\n  \n  proc size*(self:PersistentDSU,\
    \ k:int):int = -self.data[self.leader(k)]\n  \n  proc merge*(self:PersistentDSU,\
    \ x, y:int):PersistentDSU =\n    let\n      x = self.leader(x)\n      y = self.leader(y)\n\
    \    if x == y: return self\n    var self = self\n    let\n      u = self.data[x]\n\
    \      v = self.data[y]\n    if u < v:\n      self.data[x] = u + v\n      self.data[y]\
    \ = x\n    else:\n      self.data[y] = u + v\n      self.data[x] = y\n    return\
    \ self\n"
  dependsOn:
  - atcoder/extra/structure/persistent_array.nim
  - atcoder/extra/structure/persistent_array.nim
  isVerificationFile: false
  path: atcoder/extra/structure/persistent_dsu.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/yosupo_persistent_unionfind_test.nim
  - verify/extra/structure/yosupo_persistent_unionfind_test.nim
documentation_of: atcoder/extra/structure/persistent_dsu.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/persistent_dsu.nim
- /library/atcoder/extra/structure/persistent_dsu.nim.html
title: atcoder/extra/structure/persistent_dsu.nim
---
