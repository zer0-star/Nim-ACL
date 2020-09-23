---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# OrderedSet[K], OrderedMultiSet[K], OrderedMap[K], OrderedMultiMap[K] {{{\n\
    when not declared ATCODER_SET_MAP_HPP:\n  const ATCODER_SET_MAP_HPP* = 1\n  import\
    \ atcoder/extra/structure/randomized_binary_search_tree\n  type OrderedMultiSet*[K]\
    \ = object\n    rbst: RandomizedBinarySearchTree[K,void,void,void]\n    root:\
    \ Node[K, void, void]\n  type OrderedSet*[K] = object\n    rbst: RandomizedBinarySearchTree[K,void,void,void]\n\
    \    root: Node[K, void, void]\n  type OrderedMultiMap*[K, T] = object\n    rbst:\
    \ RandomizedBinarySearchTree[T,void,void,void]\n    root: Node[T, void, void]\n\
    \  type OrderedMap*[K, T] = object\n    rbst: RandomizedBinarySearchTree[T,void,void,void]\n\
    \    root: Node[T, void, void]\n  \n  proc initOrderedMultiSet*[K]():OrderedMultiSet[K]\
    \ =\n    result.rbst = initRandomizedBinarySearchTree[K]()\n    result.root =\
    \ nil\n  proc initOrderedSet*[K]():OrderedSet[K] =\n    result.rbst = initRandomizedBinarySearchTree[K]()\n\
    \    result.root = nil\n  proc initOrderedMultiMap*[K, V]():OrderedMultiMap[K,\
    \ tuple[K:K, V:V]] =\n    result.rbst = initRandomizedBinarySearchTree[(K, V)]()\n\
    \    result.root = nil\n  proc initOrderedMap*[K, V]():OrderedMap[K, tuple[K:K,\
    \ V:V]] =\n    result.rbst = initRandomizedBinarySearchTree[(K, V)]()\n    result.root\
    \ = nil\n  \n  #RBST(sz, [&](T x, T y) { return x; }, T()) {}\n  \n  type anySet\
    \ = concept x\n    x is OrderedMultiSet or x is OrderedSet\n  type anyMap = concept\
    \ x\n    x is OrderedMultiMap or x is OrderedMap\n  \n  type SetOrMap = OrderedMultiSet\
    \ or OrderedSet or OrderedMultiMap or OrderedMap\n\n  template getKey*(self: SetOrMap,\
    \ t:Node):auto =\n    when self.type is anySet: t.key\n    else: t.key[0]\n  \n\
    \  proc lower_bound*[T:SetOrMap](self: var T, t:var Node, x:T.K):int {.inline.}=\n\
    \    if t == nil: return 0\n    if x <= self.getKey(t): return self.lower_bound(t.l,\
    \ x)\n    return self.lower_bound(t.r, x) + self.rbst.count(t.l) + 1\n  \n  proc\
    \ lower_bound*[T:SetOrMap](self:var T, x:T.K):int {.inline.} =\n    self.lower_bound(self.root,\
    \ x)\n\n  proc upper_bound*[T:SetOrMap](self: var T, t:var Node, x:T.K):int {.inline.}\
    \ =\n    if t == nil: return 0\n    if x < self.getKey(t): return self.upper_bound(t.l,\
    \ x)\n    return self.upper_bound(t.r, x) + self.rbst.count(t.l) + 1\n  \n  proc\
    \ find*[T:SetOrMap](self: var T, t:var Node, x:T.K):Node {.inline.}=\n    if t\
    \ == nil: return nil\n    if x < self.getKey(t): return self.find(t.l, x)\n  \
    \  elif x > self.getKey(t): return self.find(t.r, x)\n    else: return t\n  proc\
    \ find*[T:SetOrMap](self:var T, x:T.K):auto {.inline.} =\n    self.find(self.root,\
    \ x)\n  \n  proc contains*[T:SetOrMap](self: var T, x:T.K):bool {.inline.} =\n\
    \    self.find(x) != nil\n  \n  proc upper_bound*[T:SetOrMap](self: var T, x:T.K):int\
    \ {.inline.} =\n    self.upper_bound(self.root, x)\n  \n  proc kth_element*[T:SetOrmap](self:\
    \ var T, t:Node, k:int):T.T {.inline.} =\n    let p = self.rbst.count(t.l)\n \
    \   if k < p: return self.kth_element(t.l, k)\n    elif k == self.rbst.count(t.l):\
    \ return t.key\n    return self.kth_element(t.r, k - self.rbst.count(t.l) - 1)\n\
    \  \n  proc kth_element*[T:SetOrMap](self: var T, k:int):T.T {.inline.} =\n  \
    \  self.kth_element(self.root, k)\n  \n  proc insert*[K](self: var OrderedMultiSet[K],\
    \ x:K) {.inline.} =\n    self.rbst.insert(self.root, self.lower_bound(x), x)\n\
    \  proc insert*[K, V](self: var OrderedMultiMap[K, tuple[K:K, V:V]], x:(K, V))\
    \ =\n    self.rbst.insert(self.root, self.lower_bound(x[0]), x)\n  \n  proc count*[T:SetOrMap](self:\
    \ var T, x:T.K):int {.inline.} =\n    return self.upper_bound(x) - self.lower_bound(x)\n\
    \  \n  proc erase_key*[T:SetOrMap](self: var T, x:T.K) {.inline.} =\n    if self.count(x)\
    \ == 0: return\n    self.rbst.erase(self.root, self.lower_bound(x))\n  \n  proc\
    \ insert*[K](self: var OrderedSet[K], x:K) {.inline.} =\n    var t = self.find(x)\n\
    \    if t != nil: return\n    self.rbst.insert(self.root, self.lower_bound(x),\
    \ x)\n  proc insert*[K, V](self: var OrderedMap[K, tuple[K:K, V:V]], x:(K, V))\
    \ {.inline.} =\n    var t = self.find(x[0])\n    if t != nil: t.key = x\n    else:\
    \ self.rbst.insert(self.root, self.lower_bound(x[0]), x)\n  proc `[]`*[K, V](self:\
    \ var OrderedMap[K, tuple[K:K, V:V]], x:K):auto {.inline.} =\n    var t = self.find(x)\n\
    \    if t != nil: return t.key[1]\n    result = V.default\n    self.insert((x,\
    \ result))\n  proc `[]=`*[K, V](self: var OrderedMap[K, tuple[K:K, V:V]], x:K,\
    \ v:V) {.inline.} =\n    var t = self.find(x)\n    if t != nil:\n      t.key[1]\
    \ = v\n      return\n    self.insert((x, v))\n  \n  proc len*(self:var SetOrMap):int\
    \ {.inline.} = self.rbst.len(self.root)\n  proc empty*(self:var SetOrMap):bool\
    \ {.inline.} = self.rbst.empty(self.root)\n  # }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/extra/structure/set_map.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/extra/structure/set_map.nim
layout: document
redirect_from:
- /library/src/atcoder/extra/structure/set_map.nim
- /library/src/atcoder/extra/structure/set_map.nim.html
title: src/atcoder/extra/structure/set_map.nim
---
