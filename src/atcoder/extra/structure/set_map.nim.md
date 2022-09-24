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
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':x:'
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/structure/yosupo_predecessor_problem_test.nim
    title: verify/extra/structure/yosupo_predecessor_problem_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_predecessor_problem_test.nim
    title: verify/extra/structure/yosupo_predecessor_problem_test.nim
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SET_MAP_HPP:\n  const ATCODER_SET_MAP_HPP* = 1\n\
    \  #type BinaryTreeType = enum\n  #  RedBlack, \n  #  Splay, \n  #  Randomized\n\
    \  #const SetMapType = BinaryTreeType.RedBlack\n# red black\n  const USE_RED_BLACK_TREE\
    \ = true\n  const USE_SPLAY_TREE = false\n# splay\n#  const USE_RED_BLACK_TREE\
    \ = false\n#  const USE_SPLAY_TREE = true\n# RBST\n#  const USE_RED_BLACK_TREE\
    \ = false\n#  const USE_SPLAY_TREE = false\n\n  {.push discardable inline.}\n\
    \  import std/strutils\n  include atcoder/extra/structure/binary_tree_utils\n\
    \  type MULTI_TRUE = int32\n  type MULTI_FALSE = void\n  type SortedTree*[Tree,\
    \ Node, multi, K, V; p:static[tuple]] = object\n    tree*: Tree\n    End*: Node\n\
    \n  when USE_RED_BLACK_TREE:\n    include atcoder/extra/structure/red_black_tree\n\
    \    type\n      SortedSetType*[K, Countable; p:static[tuple]] = SortedTree[RedBlackTree[K],\
    \ RedBlackTreeNode[K], MULTI_FALSE, K, void, p]\n      SortedMultiSetType*[K,\
    \ Countable; p:static[tuple]] = SortedTree[RedBlackTree[K], RedBlackTreeNode[K],\
    \ MULTI_TRUE, K, void, p]\n      SortedMapType*[K; V:not void; Countable; p:static[tuple]]\
    \ = SortedTree[RedBlackTree[(K, V)], RedBlackTreeNode[(K, V)], MULTI_FALSE, K,\
    \ V, p]\n      SortedMultiMapType*[K; V:not void; Countable; p:static[tuple]]\
    \ = SortedTree[RedBlackTree[(K, V)], RedBlackTreeNode[(K, V)], MULTI_TRUE, K,\
    \ V, p]\n\n    type SetOrMap = SortedMultiSetType or SortedSetType or SortedMultiMapType\
    \ or SortedMapType\n    proc init*[Tree:SetOrMap](self: var Tree) =\n      when\
    \ Tree.V is void:\n        type T = Tree.K\n      else:\n        type T = (Tree.K,\
    \ Tree.V)\n      type Node = Tree.Node\n      var End = Node(id: -2)\n      End.cnt\
    \ = 0\n      End.color = Color.black\n      self.End = End\n      self.tree.init(End)\n\
    \    proc empty*[Tree:SetOrMap](self:Tree):bool = self.tree.empty()\n    proc\
    \ len*[Tree:SetOrMap](self:Tree):int = self.tree.len()\n  elif USE_SPLAY_TREE:\n\
    \    include atcoder/extra/structure/splay_tree\n    type\n      SortedSetType*[K,\
    \ Countable; p:static[tuple]] = SortedTree[SplayTree[K], SplayTreeNode[K, void,\
    \ void, void], MULTI_FALSE, K, void, p]\n      SortedMultiSetType*[K, Countable;\
    \ p:static[tuple]] = SortedTree[SplayTree[K], SplayTreeNode[K, void, void, void],\
    \ MULTI_TRUE, K, void, p]\n      SortedMapType*[K; V:not void; Countable; p:static[tuple]]\
    \ = SortedTree[SplayTree[(K, V)], SplayTreeNode[(K, V), void, void, void], MULTI_FALSE,\
    \ K, V, p]\n      SortedMultiMapType*[K; V:not void; Countable; p:static[tuple]]\
    \ = SortedTree[SplayTree[(K, V)], SplayTreeNode[(K, V), void, void, void], MULTI_TRUE,\
    \ K, V, p]\n\n    type SetOrMap = SortedMultiSetType or SortedSetType or SortedMultiMapType\
    \ or SortedMapType\n    proc init*[Tree:SetOrMap](self: var Tree) =\n      when\
    \ Tree.V is void:\n        type T = Tree.K\n      else:\n        type T = (Tree.K,\
    \ Tree.V)\n      var End = Tree.Node(id: -2)\n      End.cnt = 1 # be carefull!!!!!!!!!!!!!!!\n\
    \      self.End = End\n      self.tree.init(End)\n    proc len*[Tree:SetOrMap](self:Tree):int\
    \ = self.tree.root.cnt - 1\n    proc empty*[Tree:SetOrMap](self:Tree):bool = self.len\
    \ == 0\n\n  else:\n    include atcoder/extra/structure/randomized_binary_search_tree_with_parent\n\
    \ \n    type\n      SortedSetType*[K, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[K],\
    \ RandomizedBinarySearchTree[K].Node, MULTI_FALSE, K, void, p]\n      SortedMultiSetType*[K,\
    \ Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[K], RBSTNode[K,\
    \ void, void], MULTI_TRUE, K, void, p]\n      SortedMapType*[K, V, Countable;\
    \ p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K,\
    \ V), void, void], MULTI_FALSE, K, V, p]\n      SortedMultiMapType*[K, V, Countable;\
    \ p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K,\
    \ V), void, void], MULTI_TRUE, K, V, p]\n  \n    type SetOrMap = SortedMultiSetType\
    \ or SortedSetType or SortedMultiMapType or SortedMapType\n  \n    proc init*[Tree:SetOrMap](self:\
    \ var Tree) =\n      when Tree.V is void:\n        type T = Tree.K\n      else:\n\
    \        type T = (Tree.K, Tree.V)\n      var End = Tree.Node(id: -2)\n      End.cnt\
    \ = 1 # be carefull!!!!!!!!!!!!!!!\n      self.End = End\n      self.tree.init(End)\n\
    #      end_node.l = self.leaf; end_node.r = self.leaf;\n  \n  #  RBST(sz, [&](T\
    \ x, T y) { return x; }, T()) {}\n    \n    proc len*[Tree:SetOrMap](self:Tree):int\
    \ = self.tree.len() - 1\n    proc empty*[Tree:SetOrMap](self:Tree):bool = self.len()\
    \ == 0\n#      doAssert self.len + 1 == self.tree.check_tree()\n  \n#    proc\
    \ `$`*(self: SetOrMap):string = self.Tree(self).to_string(self.root)\n  {.pop.}\n\
    \  proc check_tree*(self:SetOrMap) = self.tree.check_tree\n\n  template SortedSet*(K:typedesc,\
    \ countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc\
    \ =\n    SortedSetType[K, when countable: int else: void, (comp,)]\n  template\
    \ SortedMultiSet*(K:typedesc, countable:static[bool] = false, comp:static[proc(a,\
    \ b:K):bool] = nil):typedesc =\n    SortedMultiSetType[K, when countable: int\
    \ else: void, (comp,)]\n  template SortedMap*(K:typedesc; V:typedesc[not void],\
    \ countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc\
    \ =\n    SortedMapType[K, V, when countable: int else: void, (comp,)]\n  template\
    \ SortedMultiMap*(K:typedesc; V:typedesc[not void], countable: static[bool] =\
    \ false, comp:static[proc(a, b:K):bool] = nil):typedesc =\n    SortedMultiMapType[K,\
    \ V, when countable: static[bool] = false, (comp,)]\n\n  proc default*[T:SetOrMap](self:typedesc[T]):T\
    \ =\n    result.init()\n  template initSortedSet*[K](countable:static[bool] =\
    \ false, comp:static[proc(a, b:K):bool] = nil):auto =\n    block:\n      var r:\
    \ SortedSetType[K, when countable: int else: void, (comp,)]\n      r.init()\n\
    \      r\n  template initSortedSet*[K](a:openArray[K], countable:static[bool]\
    \ = false, comp:static[proc(a, b:K):bool] = nil):auto =\n    block:\n      var\
    \ s = initSortedSet[K](countable, comp)\n      for t in a: s.insert(t)\n     \
    \ s\n\n  template initSortedMultiSet*[K](countable:static[bool] = false, comp:static[proc(a,\
    \ b:K):bool] = nil):auto =\n    block:\n      var r: SortedMultiSetType[K, when\
    \ countable: int else: void, (comp,)]\n      r.init()\n      r\n  template initSortedMultiSet*[K](a:openArray[K],\
    \ countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =\n\
    \    block:\n      var s = initSortedMultiSet[K](countable, comp)\n      for t\
    \ in a: s.insert(t)\n      s\n\n  template initSortedMap*[K; V:not void](countable:static[bool]\
    \ = false, comp:static[proc(a, b:K):bool] = nil):auto =\n    block:\n      var\
    \ r: SortedMapType[K, V, when countable: int else: void, (comp,)]\n      r.init()\n\
    \      r\n  template initSortedMap*[K; V:not void](a:openArray[(K, V)], countable:static[bool]\
    \ = false, comp:static[proc(a, b:K):bool] = nil):auto =\n    block:\n      var\
    \ s = initSortedMap[K, V](countable, comp)\n      for p in a: s.insert(p)\n  \
    \    s\n\n  template initSortedMultiMap*[K; V:not void](countable:static[bool]\
    \ = false, comp:static[proc(a, b:K):bool] = nil):auto =\n    block:\n      var\
    \ r: SortedMultiMapType[K, V, when countable: int else: void, (comp,)]\n     \
    \ r.init()\n      r\n  template initSortedMultiMap*[K; V:not void](a:openArray[(K,\
    \ V)], countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto\
    \ =\n    block:\n      var s = initSortedMultiMap[K, V](countable, comp)\n   \
    \   for p in a: s.insert(p)\n      s\n\n  proc `$`*(self: SetOrMap): string =\n\
    \    var a = newSeq[string]()\n    var node = self.tree.root\n    var stack: seq[self.Node]\
    \ = @[]\n    while stack.len() != 0 or not node.isLeaf:\n      if not node.isLeaf:\n\
    \        if node != self.End:\n          stack.add(node)\n        node = node.l\n\
    \      else:\n        node = stack.pop()\n        when self.V is void:\n     \
    \     var k = \"\"\n          k.addQuoted(node.key)\n          a &= k\n      \
    \  else:\n          var k, v = \"\"\n          k.addQuoted(node.key[0])\n    \
    \      v.addQuoted(node.key[1])\n          a &= k & \": \" & v\n        node =\
    \ node.r\n    return \"{\" & a.join(\", \") & \"}\"\n"
  dependsOn:
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  isVerificationFile: false
  path: atcoder/extra/structure/set_map.nim
  requiredBy: []
  timestamp: '2022-09-24 20:04:56+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/map_test.nim
  - verify/map_test.nim
documentation_of: atcoder/extra/structure/set_map.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/set_map.nim
- /library/atcoder/extra/structure/set_map.nim.html
title: atcoder/extra/structure/set_map.nim
---
