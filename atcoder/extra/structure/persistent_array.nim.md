---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':x:'
    path: atcoder/extra/structure/persistent_dsu.nim
    title: atcoder/extra/structure/persistent_dsu.nim
  - icon: ':x:'
    path: atcoder/extra/structure/persistent_dsu.nim
    title: atcoder/extra/structure/persistent_dsu.nim
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/structure/yosupo_persistent_queue_test.nim
    title: verify/extra/structure/yosupo_persistent_queue_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_persistent_queue_test.nim
    title: verify/extra/structure/yosupo_persistent_queue_test.nim
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
  code: "when not declared ATCODER_PERSISTENT_ARRAY_HPP:\n  const ATCODER_PERSISTENT_ARRAY_HPP*\
    \ = 1\n  const LOG = 3\n  \n  type\n    PersistentArrayNode*[T] = ref object\n\
    \      data:T\n      child:array[1 shl LOG, PersistentArrayNode[T]]\n    PersistentArray*[T]\
    \ = object\n      root: PersistentArrayNode[T]\n\n  proc build[T](t:var PersistentArrayNode[T],\
    \ data:T, k:int):PersistentArrayNode[T] =\n    if t == nil: t = PersistentArrayNode[T]()\n\
    \    if k == 0:\n      t.data = data\n      return t\n    let p = build(t.child[k\
    \ and ((1 shl LOG) - 1)], data, k shr LOG)\n    t.child[k and ((1 shl LOG) - 1)]\
    \ = p\n    return t\n  \n  proc build[T](self:var PersistentArray[T], v:seq[T])\
    \ =\n    self.root = nil\n    for i in 0..<v.len:\n      self.root = self.root.build(v[i],\
    \ i)\n  \n  proc initPersistentArray*[T](v:seq[T]):auto =\n    result = PersistentArray[T]()\n\
    \    result.build(v)\n  \n  proc `[]`*[T](t:PersistentArrayNode[T], k:int):auto\
    \ =\n    if k == 0: return t.data\n    return t.child[k and ((1 shl LOG) - 1)][k\
    \ shr LOG]\n  \n  proc `[]`*[T](self:PersistentArray[T], k:int):auto = return\
    \ self.root[k]\n  \n  proc `[]=`*[T](t:var PersistentArrayNode[T], k:int, val:T):PersistentArrayNode[T]\
    \ {.discardable.}=\n    t = if t != nil: PersistentArrayNode[T](data:t.data, child:t.child)\
    \ else: PersistentArrayNode[T]()\n    if k == 0:\n      t.data = val\n      return\
    \ t\n    var p = (t.child[k and ((1 shl LOG) - 1)][k shr LOG] = val)\n    t.child[k\
    \ and ((1 shl LOG) - 1)] = p\n    return t\n  \n  proc `[]=`*[T](self:var PersistentArray[T],\
    \ k:int, val:T) =\n    var ret = (self.root[k] = val)\n    self.root = ret\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/persistent_array.nim
  requiredBy:
  - atcoder/extra/structure/persistent_dsu.nim
  - atcoder/extra/structure/persistent_dsu.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/yosupo_persistent_queue_test.nim
  - verify/extra/structure/yosupo_persistent_queue_test.nim
  - verify/extra/structure/yosupo_persistent_unionfind_test.nim
  - verify/extra/structure/yosupo_persistent_unionfind_test.nim
documentation_of: atcoder/extra/structure/persistent_array.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/persistent_array.nim
- /library/atcoder/extra/structure/persistent_array.nim.html
title: atcoder/extra/structure/persistent_array.nim
---
