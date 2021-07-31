---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_utils.nim
    title: atcoder/extra/structure/binary_tree_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_utils.nim
    title: atcoder/extra/structure/binary_tree_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SET_MAP_HPP:\n  const ATCODER_SET_MAP_HPP* = 1\n\
    \  {.push discardable inline.}\n#  import atcoder/extra/structure/randomized_binary_search_tree\n\
    \  import atcoder/extra/structure/randomized_binary_search_tree_with_parent\n\
    \  type SortedMultiSet*[K, T] = object\n    rbst*: RandomizedBinarySearchTree[K,void,RBSTNode[K,\
    \ void, void], false, void, ()]\n    End*: RBSTNode[K, void, void]\n  type SortedSet*[K,\
    \ T] = object\n    rbst*: RandomizedBinarySearchTree[K,void,RBSTNode[K, void,\
    \ void], false, void, ()]\n    End*: RBSTNode[K, void, void]\n  type SortedMultiMap*[K,\
    \ T] = object\n    rbst*: RandomizedBinarySearchTree[T,void,RBSTNode[T, void,\
    \ void], false, void, ()]\n    End*: RBSTNode[T, void, void]\n  type SortedMap*[K,\
    \ T] = object\n    rbst*: RandomizedBinarySearchTree[T,void,RBSTNode[T, void,\
    \ void], false, void, ()]\n    End*: RBSTNode[T, void, void]\n\n  type anySet\
    \ = SortedSet or SortedMultiSet\n  type anyMap = SortedMap or SortedMultiMap\n\
    \n  type SetOrMap = SortedMultiSet or SortedSet or SortedMultiMap or SortedMap\n\
    \n  template getType*(T:typedesc[anySet], K):typedesc =\n    T[K, K]\n  template\
    \ getType*(T:typedesc[anyMap], K, V):typedesc =\n    T[K, (K, V)]\n\n  proc init*(T:typedesc[SetOrMap]):T\
    \ =\n    result.rbst = initRandomizedBinarySearchTree[T.T]()\n#    result.rbst\
    \ = initRandomizedBinarySearchTree[T.T](proc(a, b:T.T):T.T = (0, 0), (0, 0))\n\
    \    result.End = result.rbst.alloc(T.T.default, 0)\n    result.rbst.root = result.End\n\
    \  proc Begin*[T:SetOrMap](self: T):auto =\n    self.rbst.root.leftMost\n\n  proc\
    \ initSortedMultiSet*[K]():auto = SortedMultiSet.getType(K).init()\n  proc initSortedSet*[K]():auto\
    \ = SortedSet.getType(K).init()\n  proc initSortedMultiMap*[K, V]():auto = SortedMultiMap.getType(K,\
    \ V).init()\n  proc initSortedMap*[K, V]():auto = SortedMap.getType(K, V).init()\n\
    \  \n\n  #RBST(sz, [&](T x, T y) { return x; }, T()) {}\n  \n  proc getKey*[T:SetOrMap;\
    \ Node:RBSTNode](self: T, t:Node):auto =\n    when self.type is anySet: t.key\n\
    \    else: t.key[0]\n\n  proc `*`*[Node:RBSTNode](it:Node):auto = it.key\n\n \
    \ proc lower_bound_index*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node,\
    \ x:T.K):int {.inline.}=\n    if t == nil or t == self.End: return 0\n    if x\
    \ <= self.getKey(t): return self.lower_bound_index(t.l, x)\n    return self.lower_bound_index(t.r,\
    \ x) + self.rbst.count(t.l) + 1\n  \n  proc lower_bound_index*[T:SetOrMap](self:var\
    \ T, x:T.K):int =\n    self.lower_bound_index(self.rbst.root, x)\n\n  proc upper_bound_index*[T:SetOrMap;\
    \ Node:RBSTNode](self: var T, t:var Node, x:T.K):int =\n    if t == nil or t ==\
    \ self.End: return 0\n    if x < self.getKey(t): return self.upper_bound_index(t.l,\
    \ x)\n    return self.upper_bound_index(t.r, x) + self.rbst.count(t.l) + 1\n\n\
    \  proc upper_bound_index*[T:SetOrMap](self: var T, x:T.K):int =\n    self.upper_bound_index(self.rbst.root,\
    \ x)\n\n  proc lower_bound*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node,\
    \ x:T.K):Node {.inline.}=\n    if t == self.End: return t\n    elif t != nil:\n\
    \      if x <= self.getKey(t):\n        var t2 = self.lower_bound(t.l, x)\n  \
    \      if t2 == nil: return t\n        else: return t2\n      else:\n        return\
    \ self.lower_bound(t.r, x)\n    else: return t\n\n  proc lower_bound*[T:SetOrMap](self:var\
    \ T, x:T.K):auto =\n    self.lower_bound(self.rbst.root, x)\n\n  proc upper_bound*[T:SetOrMap;\
    \ Node:RBSTNode](self: var T, t:var Node, x:T.K):Node =\n    if t == self.End:\
    \ return t\n    elif t != nil:\n      if x < self.getKey(t):\n        var t2 =\
    \ self.upper_bound(t.l, x)\n        if t2 == nil: return t\n        else: return\
    \ t2\n      else:\n        return self.upper_bound(t.r, x)\n    else:\n      return\
    \ t\n\n  proc upper_bound*[T:SetOrMap](self: var T, x:T.K):auto =\n    assert\
    \ self.rbst.root != nil\n    self.upper_bound(self.rbst.root, x)\n\n  proc findNode*[T:SetOrMap,\
    \ Node:RBSTNode](self: var T, t:var Node, x:T.K):auto {.inline.}=\n#    if t ==\
    \ nil: return nil\n    if t == nil: return t\n    if x < self.getKey(t): return\
    \ self.findNode(t.l, x)\n    elif x > self.getKey(t): return self.findNode(t.r,\
    \ x)\n    else: return t\n  proc findNode*[T:SetOrMap](self:var T, x:T.K):auto\
    \ =\n    self.findNode(self.rbst.root, x)\n  proc contains*[T:SetOrMap](self:\
    \ var T, x:T.K):bool =\n    self.findNode(x) != nil\n  \n \n  proc kth_element*[T:SetOrMap;\
    \ Node:RBSTNode](self: var T, t:Node, k:int):T.T =\n    let p = self.rbst.count(t.l)\n\
    \    if k < p: return self.kth_element(t.l, k)\n    elif k > p: return self.kth_element(t.r,\
    \ k - self.rbst.count(t.l) - 1)\n    else: return t.key\n\n  proc kth_element*[T:SetOrMap](self:\
    \ var T, k:int):T.T =\n    return self.kth_element(self.rbst.root, k)\n  proc\
    \ `{}`*[T:SetOrMap](self: var T, k:int):T.T =\n    return self.kth_element(k)\n\
    \n  proc insert*[T:SortedMultiSet](self: var T, x:T.K) =\n    self.rbst.insert(self.upper_bound(x),\
    \ x)\n  proc insert*[T:SortedMultiMap](self: var T, x:T.T) =\n    self.rbst.insert(self.upper_bound(x[0]),\
    \ x)\n\n  proc count*[T:SetOrMap](self: var T, x:T.K):int =\n    return self.upper_bound_index(x)\
    \ - self.lower_bound_index(x)\n  \n  proc erase*[T:SetOrMap](self: var T, x:T.K)\
    \ =\n    if self.count(x) == 0: return\n    var t = self.lower_bound(x)\n    self.rbst.erase(t)\n\
    \n  proc erase*[T:SetOrMap](self: var T, t:RBSTNode) =\n    self.rbst.erase(t)\n\
    \n  proc find*[T:SetOrMap](self:var T, x:T.K):int =\n    if self.count(x) == 0:\
    \ return -1\n    else: return self.lower_bound_index(x)\n\n  proc insert*[T:SortedSet](self:\
    \ var T, x:T.K) =\n    var t = self.findNode(x)\n    if t != nil: return\n   \
    \ var it = self.upper_bound(x)\n    self.rbst.insert(it, x)\n  proc insert*[T:SortedMap](self:\
    \ var T, x:T.T) =\n    var t = self.findNode(x[0])\n    if t != nil: t.key = x\n\
    \    else:\n      var it = self.upper_bound(x[0])\n      self.rbst.insert(it,\
    \ x)\n  proc `[]`*[K, V](self: var SortedMap[K, tuple[K:K, V:V]], x:K):auto =\n\
    \    var t = self.findNode(x)\n    if t != nil: return t.key[1]\n    result =\
    \ V.default\n    self.insert((x, result))\n  proc `[]=`*[K, V](self: var SortedMap[K,\
    \ tuple[K:K, V:V]], x:K, v:V) =\n    var t = self.findNode(x)\n    if t != nil:\n\
    \      t.key[1] = v\n      return\n    self.insert((x, v))\n  \n  proc len*(self:SetOrMap):int\
    \ = self.rbst.len()\n  proc empty*(self:var SetOrMap):bool = self.rbst.empty()\n\
    \  proc check_tree*(self:SetOrMap) =\n    doAssert self.len + 1 == self.rbst.check_tree()\n\
    \  proc `$`*(self: SetOrMap):string = self.rbst.to_string(self.rbst.root)\n  {.pop.}\n"
  dependsOn:
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  isVerificationFile: false
  path: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
- /library/atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim.html
title: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
---
