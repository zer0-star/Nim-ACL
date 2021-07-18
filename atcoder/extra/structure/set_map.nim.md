---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree.nim
    title: atcoder/extra/structure/randomized_binary_search_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree.nim
    title: atcoder/extra/structure/randomized_binary_search_tree.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: tests/test_extra_set_map.nim
    title: tests/test_extra_set_map.nim
  - icon: ':warning:'
    path: tests/test_extra_set_map.nim
    title: tests/test_extra_set_map.nim
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  - icon: ':x:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SET_MAP_HPP:\n  const ATCODER_SET_MAP_HPP* = 1\n\
    \  import atcoder/extra/structure/randomized_binary_search_tree\n  type SortedMultiSet*[K,\
    \ T] = object\n    rbst: RandomizedBinarySearchTree[K,void,RBSTNode[K, void, void],\
    \ false, void, ()]\n  type SortedSet*[K, T] = object\n    rbst: RandomizedBinarySearchTree[K,void,RBSTNode[K,\
    \ void, void], false, void, ()]\n  type SortedMultiMap*[K, T] = object\n    rbst:\
    \ RandomizedBinarySearchTree[T,void,RBSTNode[T, void, void], false, void, ()]\n\
    \  type SortedMap*[K, T] = object\n    rbst: RandomizedBinarySearchTree[T,void,RBSTNode[T,\
    \ void, void], false, void, ()]\n\n  type anySet = SortedSet or SortedMultiSet\n\
    \  type anyMap = SortedMap or SortedMultiMap\n\n  type SetOrMap = SortedMultiSet\
    \ or SortedSet or SortedMultiMap or SortedMap\n\n  template getType*(T:typedesc[anySet],\
    \ K):typedesc =\n    T[K, K]\n  template getType*(T:typedesc[anyMap], K, V):typedesc\
    \ =\n    T[K, (K, V)]\n\n  proc init*(T:typedesc[SetOrMap]):T =\n    result.rbst\
    \ = initRandomizedBinarySearchTree[T.T]()\n#    result.rbst = initRandomizedBinarySearchTree[T.T](proc(a,\
    \ b:T.T):T.T = (0, 0), (0, 0))\n    result.rbst.root = nil\n\n  proc initSortedMultiSet*[K]():auto\
    \ = SortedMultiSet.getType(K).init()\n  proc initSortedSet*[K]():auto = SortedSet.getType(K).init()\n\
    \  proc initSortedMultiMap*[K, V]():auto = SortedMultiMap.getType(K, V).init()\n\
    \  proc initSortedMap*[K, V]():auto = SortedMap.getType(K, V).init()\n\n  #RBST(sz,\
    \ [&](T x, T y) { return x; }, T()) {}\n  \n  proc getKey*[T:SetOrMap; Node:RBSTNode](self:\
    \ T, t:Node):auto =\n    when self.type is anySet: t.key\n    else: t.key[0]\n\
    \  \n  proc lower_bound*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):int\
    \ {.inline.}=\n    if t == nil: return 0\n    if x <= self.getKey(t): return self.lower_bound(t.l,\
    \ x)\n    return self.lower_bound(t.r, x) + self.rbst.count(t.l) + 1\n  \n  proc\
    \ lower_bound*[T:SetOrMap](self:var T, x:T.K):int {.inline.} =\n    self.lower_bound(self.rbst.root,\
    \ x)\n\n  proc upper_bound*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node,\
    \ x:T.K):int {.inline.} =\n    if t == nil: return 0\n    if x < self.getKey(t):\
    \ return self.upper_bound(t.l, x)\n    return self.upper_bound(t.r, x) + self.rbst.count(t.l)\
    \ + 1\n  \n  proc findNode*[T:SetOrMap, Node:RBSTNode](self: var T, t:var Node,\
    \ x:T.K):auto {.inline.}=\n#    if t == nil: return nil\n    if t == nil: return\
    \ t\n    if x < self.getKey(t): return self.findNode(t.l, x)\n    elif x > self.getKey(t):\
    \ return self.findNode(t.r, x)\n    else: return t\n  proc findNode*[T:SetOrMap](self:var\
    \ T, x:T.K):auto {.inline.} =\n    self.findNode(self.rbst.root, x)\n  proc contains*[T:SetOrMap](self:\
    \ var T, x:T.K):bool {.inline.} =\n    self.findNode(x) != nil\n  \n  proc upper_bound*[T:SetOrMap](self:\
    \ var T, x:T.K):int {.inline.} =\n    self.upper_bound(self.rbst.root, x)\n  \n\
    \  proc kth_element*[T:SetOrMap; Node:RBSTNode](self: var T, t:Node, k:int):T.T\
    \ {.inline.} =\n    let p = self.rbst.count(t.l)\n    if k < p: return self.kth_element(t.l,\
    \ k)\n    elif k > p: return self.kth_element(t.r, k - self.rbst.count(t.l) -\
    \ 1)\n    else: return t.key\n\n  proc kth_element*[T:SetOrMap](self: var T, k:int):T.T\
    \ {.inline.} =\n    return self.kth_element(self.rbst.root, k)\n  proc `{}`*[T:SetOrMap](self:\
    \ var T, k:int):T.T {.inline.} =\n    return self.kth_element(k)\n\n  proc insert*[T:SortedMultiSet](self:\
    \ var T, x:T.K) {.inline.} =\n    self.rbst.insert(self.upper_bound(x), x)\n \
    \ proc insert*[T:SortedMultiMap](self: var T, x:T.T) =\n    self.rbst.insert(self.upper_bound(x[0]),\
    \ x)\n\n  proc count*[T:SetOrMap](self: var T, x:T.K):int {.inline.} =\n    return\
    \ self.upper_bound(x) - self.lower_bound(x)\n  \n  proc erase*[T:SetOrMap](self:\
    \ var T, x:T.K) {.inline.} =\n    if self.count(x) == 0: return\n    self.rbst.erase(self.lower_bound(x))\n\
    \  proc find*[T:SetOrMap](self:var T, x:T.K):int {.inline.} =\n    if self.count(x)\
    \ == 0: return -1\n    else: return self.lower_bound(x)\n\n  proc insert*[T:SortedSet](self:\
    \ var T, x:T.K) {.inline.} =\n    var t = self.findNode(x)\n    if t != nil: return\n\
    \    self.rbst.insert(self.upper_bound(x), x)\n  proc insert*[T:SortedMap](self:\
    \ var T, x:T.T) {.inline.} =\n    var t = self.findNode(x[0])\n    if t != nil:\
    \ t.key = x\n    else: self.rbst.insert(self.upper_bound(x[0]), x)\n  proc `[]`*[K,\
    \ V](self: var SortedMap[K, tuple[K:K, V:V]], x:K):auto {.inline.} =\n    var\
    \ t = self.findNode(x)\n    if t != nil: return t.key[1]\n    result = V.default\n\
    \    self.insert((x, result))\n  proc `[]=`*[K, V](self: var SortedMap[K, tuple[K:K,\
    \ V:V]], x:K, v:V) {.inline.} =\n    var t = self.findNode(x)\n    if t != nil:\n\
    \      t.key[1] = v\n      return\n    self.insert((x, v))\n  \n  proc len*(self:var\
    \ SetOrMap):int {.inline.} = self.rbst.len()\n  proc empty*(self:var SetOrMap):bool\
    \ {.inline.} = self.rbst.empty()\n\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/randomized_binary_search_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/randomized_binary_search_tree.nim
  isVerificationFile: false
  path: atcoder/extra/structure/set_map.nim
  requiredBy:
  - tests/test_extra_set_map.nim
  - tests/test_extra_set_map.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/map_test.nim
  - verify/map_test.nim
documentation_of: atcoder/extra/structure/set_map.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/set_map.nim
- /library/atcoder/extra/structure/set_map.nim.html
title: atcoder/extra/structure/set_map.nim
---
