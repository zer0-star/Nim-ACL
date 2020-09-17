---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/randomized_binary_search_tree.nim
    title: atcoder/extra/structure/randomized_binary_search_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/randomized_binary_search_tree.nim
    title: atcoder/extra/structure/randomized_binary_search_tree.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# {{{ OrderedSet[K], OrderedMultiSet[K], OrderedMap[K], OrderedMultiMap[K]\n\
    when not declared ATCODER_SET_MAP_HPP:\n  const ATCODER_SET_MAP_HPP* = 1\n  import\
    \ atcoder/extra/structure/randomized_binary_search_tree\n  type OrderedMultiSet*[K]\
    \ = object\n    rbst: RandomizedBinarySearchTree[K,void,void,void]\n    root:\
    \ Node[K, void, void]\n  type OrderedSet*[K] = object\n    rbst: RandomizedBinarySearchTree[K,void,void,void]\n\
    \    root: Node[K, void, void]\n  type OrderedMultiMap*[K, V] = object\n    rbst:\
    \ RandomizedBinarySearchTree[(K, V),void,void,void]\n    root: Node[(K, V), void,\
    \ void]\n  type OrderedMap*[K, V] = object\n    rbst: RandomizedBinarySearchTree[(K,\
    \ V),void,void,void]\n    root: Node[(K, V), void, void]\n  \n  proc initOrderedMultiSet*[K]():OrderedMultiSet[K]\
    \ =\n    result.rbst = initRandomizedBinarySearchTree[K]()\n    result.root =\
    \ nil\n  proc initOrderedSet*[K]():OrderedSet[K] =\n    result.rbst = initRandomizedBinarySearchTree[K]()\n\
    \    result.root = nil\n  proc initOrderedMultiMap*[K, V]():OrderedMultiMap[K,\
    \ V] =\n    result.rbst = initRandomizedBinarySearchTree[(K, V)]()\n    result.root\
    \ = nil\n  proc initOrderedMap*[K, V]():OrderedMap[K, V] =\n    result.rbst =\
    \ initRandomizedBinarySearchTree[(K, V)]()\n    result.root = nil\n  \n  #RBST(sz,\
    \ [&](T x, T y) { return x; }, T()) {}\n  \n  type anySet = concept x\n    x is\
    \ OrderedMultiSet or x is OrderedSet\n  type anyMap = concept x\n    x is OrderedMultiMap\
    \ or x is OrderedMap\n  \n  type SetOrMap = concept x\n    x is OrderedMultiSet\
    \ | OrderedSet | OrderedMultiMap | OrderedMap\n  \n  template getKey*(self: SetOrMap,\
    \ t:Node):auto =\n    when self.type is anySet: t.key\n    else: t.key[0]\n  \n\
    \  proc lower_bound*[T:SetOrMap](self: var T, t:var Node, x:T.K):int =\n    if\
    \ t == nil: return 0\n    if x <= self.getKey(t): return self.lower_bound(t.l,\
    \ x)\n    return self.lower_bound(t.r, x) + self.rbst.count(t.l) + 1\n  \n  proc\
    \ lower_bound*[T:SetOrMap](self:var T, x:T.K):int =\n    self.lower_bound(self.root,\
    \ x)\n  \n  proc upper_bound*[T:SetOrMap](self: var T, t:var Node, x:T.K):int\
    \ =\n    if t == nil: return 0\n    if x < self.getKey(t): return self.upper_bound(t.l,\
    \ x)\n    return self.upper_bound(t.r, x) + self.rbst.count(t.l) + 1\n  \n  proc\
    \ find*[T:SetOrMap](self: var T, t:var Node, x:T.K):Node =\n    if t == nil: return\
    \ nil\n    if x < self.getKey(t): return self.find(t.l, x)\n    elif x > self.getKey(t):\
    \ return self.find(t.r, x)\n    else: return t\n  proc find*[T:SetOrMap](self:var\
    \ T, x:T.K):auto =\n    self.find(self.root, x)\n  \n  proc contains*[T:SetOrMap](self:\
    \ var T, x:T.K):bool =\n    self.find(x) != nil\n  \n  proc upper_bound*[T:SetOrMap](self:\
    \ var T, x:T.K):int =\n    self.upper_bound(self.root, x)\n  \n  proc kth_element*(self:\
    \ SetOrMap, t:Node, k:int):auto =\n    if k < self.rbst.count(t.l): return self.kth_element(t.l,\
    \ k)\n    if k == self.rbst.count(t.l): return t.key\n    return self.kth_element(t.r,\
    \ k - self.rbst.count(t.l) - 1)\n  \n  proc kth_element*(self: SetOrMap, k:int):auto\
    \ =\n    self.kth_element(self.root, k)\n  \n  proc insert*[K](self: var OrderedMultiSet[K],\
    \ x:K) =\n    self.rbst.insert(self.root, self.lower_bound(x), x)\n  proc insert*[K,\
    \ V](self: var OrderedMultiMap[K, V], x:(K, V)) =\n    self.rbst.insert(self.root,\
    \ self.lower_bound(x[0]), x)\n  \n  proc count*[T:SetOrMap](self: var T, x:T.K):int\
    \ =\n    return self.upper_bound(x) - self.lower_bound(x)\n  \n  proc erase_key*[T:SetOrMap](self:\
    \ var T, x:T.K) =\n    if self.count(x) == 0: return\n    self.rbst.erase(self.root,\
    \ self.lower_bound(x))\n  \n  proc insert*[K](self: var OrderedSet[K], x:K) =\n\
    \    var t = self.find(x)\n    if t != nil: return\n    self.rbst.insert(self.root,\
    \ self.lower_bound(x), x)\n  proc insert*[K, V](self: var OrderedMap[K, V], x:(K,\
    \ V)) =\n    var t = self.find(x[0])\n    if t != nil: t.key = x\n    else: self.rbst.insert(self.root,\
    \ self.lower_bound(x[0]), x)\n  proc `[]`*[K, V](self: var OrderedMap[K, V], x:K):auto\
    \ =\n    var t = self.find(x)\n    if t != nil: return t.key[1]\n    result =\
    \ V.default\n    self.insert((x, result))\n  proc `[]=`*[K, V](self: var OrderedMap[K,\
    \ V], x:K, v:V) =\n    var t = self.find(x)\n    if t != nil:\n      t.key[1]\
    \ = v\n      return\n    self.insert((x, v))\n  \n  proc len*(self:var SetOrMap):int\
    \ = self.rbst.len(self.root)\n  proc empty*(self:var SetOrMap):bool = self.rbst.empty(self.root)\n\
    \  # }}}\n"
  dependsOn:
  - atcoder/extra/structure/randomized_binary_search_tree.nim
  - atcoder/extra/structure/randomized_binary_search_tree.nim
  isVerificationFile: false
  path: atcoder/extra/structure/set_map.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
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
