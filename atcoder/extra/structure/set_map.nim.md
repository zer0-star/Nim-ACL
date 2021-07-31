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
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
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
    \  const USE_RED_BLACK_TREE = true\n  {.push discardable inline.}\n  include atcoder/extra/structure/binary_tree_utils\n\
    \  type MULTI_TRUE = int32\n  type MULTI_FALSE = void\n  type SortedTree*[Tree,\
    \ Node, multi, K, V; p:static[tuple]] = object of Tree\n#    comp*: proc(a, b:K):bool\n\
    \    End*: Node\n\n  when USE_RED_BLACK_TREE:\n    include atcoder/extra/structure/red_black_tree\n\
    \    type\n      SortedSetType*[K, Countable; p:static[tuple]] = SortedTree[RedBlackTree[K,\
    \ Countable], RedBlackTreeNode[K, Countable], MULTI_FALSE, K, void, p]\n     \
    \ SortedMultiSetType*[K, Countable; p:static[tuple]] = SortedTree[RedBlackTree[K,\
    \ Countable], RedBlackTreeNode[K, Countable], MULTI_TRUE, K, void, p]\n      SortedMapType*[K;\
    \ V:not void; Countable; p:static[tuple]] = SortedTree[RedBlackTree[(K, V), Countable],\
    \ RedBlackTreeNode[(K, V), Countable], MULTI_FALSE, K, V, p]\n      SortedMultiMapType*[K;\
    \ V:not void; Countable; p:static[tuple]] = SortedTree[RedBlackTree[(K, V), Countable],\
    \ RedBlackTreeNode[(K, V), Countable], MULTI_TRUE, K, V, p]\n\n#      SortedSet*[K]\
    \ = SortedSetType[K, void]\n#      SortedMultiSet*[K] = SortedMultiSetType[K,\
    \ void]\n#      SortedMap*[K; V:not void] = SortedMapType[K, V, void]\n#     \
    \ SortedMultiMap*[K; V:not void] = SortedMultiMapType[K, V, void]\n#      CountableSortedSet*[K]\
    \ = SortedSetType[K, int]\n#      CountableSortedMultiSet*[K] = SortedMultiSetType[K,\
    \ int]\n#      CountableSortedMap*[K; V:not void] = SortedMapType[K, V, int]\n\
    #      CountableSortedMultiMap*[K; V:not void] = SortedMultiMapType[K, V, int]\n\
    \n#    type SetOrMap = SortedMultiSet or SortedSet or SortedMultiMap or SortedMap\
    \ or CountableSortedMultiSet or CountableSortedSet or CountableSortedMultiMap\
    \ or CountableSortedMap or SortedTree\n    type SetOrMap = SortedMultiSetType\
    \ or SortedSetType or SortedMultiMapType or SortedMapType\n    proc init*[Tree:SetOrMap](self:\
    \ var Tree) =\n      when Tree.V is void:\n        type T = Tree.K\n      else:\n\
    \        type T = (Tree.K, Tree.V)\n      type Countable = Tree.Tree.Countable\n\
    \      var End = RedBlackTreeNode[T, Countable](color: Color.black, id: -2)\n\
    \      var leaf = RedBlackTreeNode[T, Countable](color: Color.black, id: -1)\n\
    \      leaf.l = leaf; leaf.r = leaf\n      End.p = nil\n      End.l = leaf; End.r\
    \ = leaf\n      when Tree.Tree.Countable isnot void:\n        leaf.cnt = 0\n \
    \     self.root = End\n      self.End = End\n      self.leaf = leaf\n      self.next_id\
    \ = 0\n\n    proc `$`*[T:SetOrMap](self: T): string =\n      result = \"{\"\n\
    \      var node = self.root\n      var stack: seq[T.Node] = @[]\n      while stack.len()\
    \ != 0 or not node.isLeaf:\n        if not node.isLeaf:\n          if node !=\
    \ self.End:\n            stack.add(node)\n          node = node.l\n        else:\n\
    \          node = stack.pop()\n          when T.V is void:\n            result\
    \ &= $(node.key) & \" \"\n          else:\n            result &= $(node.key[0])\
    \ & \":\" & $(node.key[1])\n          result &= \",\"\n          node = node.r\n\
    \      result &= \"}\"\n\n  else:\n    include atcoder/extra/structure/randomized_binary_search_tree_with_parent\n\
    \ \n    type SortedSetType*[K, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[K],\
    \ RBSTNode[K, void, void], MULTI_FALSE, K, void, p]\n    type SortedMultiSetType*[K,\
    \ Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[K], RBSTNode[K,\
    \ void, void], MULTI_TRUE, K, void, p]\n    type SortedMapType*[K, V, Countable;\
    \ p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K,\
    \ V), void, void], MULTI_FALSE, K, V, p]\n    type SortedMultiMapType*[K, V, Countable;\
    \ p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K,\
    \ V), void, void], MULTI_TRUE, K, V, p]\n  \n    type SetOrMap = SortedMultiSetType\
    \ or SortedSetType or SortedMultiMapType or SortedMapType\n  \n    proc init*[Tree:SetOrMap](self:\
    \ var Tree) =\n      when Tree.V is void:\n        type T = Tree.K\n      else:\n\
    \        type T = (Tree.K, Tree.V)\n      Tree.Tree(self).setRBST()\n      var\
    \ end_node = RBSTNode[T, void, void](cnt: 1, p:nil, id: -1)\n      end_node.l\
    \ = self.leaf; end_node.r = self.leaf;\n      self.End = end_node\n      self.root\
    \ = self.End\n  \n#    proc initSortedMultiSet*[K](comp:static[proc(a, b:T.K):bool]\
    \ = nil):SortedMultiSet[K] =\n#      result.init(comp)\n#    proc initSortedSet*[K](comp:proc(a,\
    \ b:T.K):bool = nil):SortedSet[K] =\n#      result.init(comp)\n#    proc initSortedMultiMap*[K,\
    \ V](comp:proc(a, b:T.K):bool = nil):SortedMultiMap[K, V] =\n#      result.init(comp)\n\
    #    proc initSortedMap*[K, V](comp:proc(a, b:T.K):bool = nil):SortedMap[K, V]\
    \ =\n#      result.init(comp)\n  \n  #  RBST(sz, [&](T x, T y) { return x; },\
    \ T()) {}\n    \n    proc `*`*[Node:RBSTNode](it:Node):auto = it.key\n  \n   \
    \ proc len*[Tree:SetOrMap](self:Tree):int = Tree.Tree(self).len() - 1\n    proc\
    \ empty*[Tree:SetOrMap](self:Tree):bool = self.len() == 0\n    proc check_tree*(self:SetOrMap)\
    \ =\n      doAssert self.len + 1 == self.check_tree()\n  \n    proc `$`*(self:\
    \ SetOrMap):string = self.Tree(self).to_string(self.root)\n  {.pop.}\n\n\n  template\
    \ SortedSet*(K:typedesc, f:static[proc(a, b:K):bool] = nil):typedesc = SortedSetType[K,\
    \ void, (f,)]\n  template SortedMultiSet*(K:typedesc, f:static[proc(a, b:K):bool]\
    \ = nil):typedesc = SortedMultiSetType[K, void, (f,)]\n  template SortedMap*(K:typedesc;\
    \ V:typedesc[not void], f:static[proc(a, b:K):bool] = nil):typedesc = SortedMapType[K,\
    \ V, void, (f,)]\n  template SortedMultiMap*(K:typedesc; V:typedesc[not void],\
    \ f:static[proc(a, b:K):bool] = nil):typedesc = SortedMultiMapType[K, V, void,\
    \ (f,)]\n  template CountableSortedSet*(K:typedesc, f:static[proc(a, b:K):bool]\
    \ = nil):typedesc = SortedSetType[K, int, (f,)]\n  template CountableSortedMultiSet*(K:typedesc,\
    \ f:static[proc(a, b:K):bool] = nil):typedesc = SortedMultiSetType[K, int, (f,)]\n\
    \  template CountableSortedMap*(K:typedesc; V:typedesc[not void], f:static[proc(a,\
    \ b:K):bool] = nil):typedesc = SortedMapType[K, V, int, (f,)]\n  template CountableSortedMultiMap*(K:typedesc;\
    \ V:typedesc[not void], f:static[proc(a, b:K):bool] = nil):typedesc = SortedMultiMapType[K,\
    \ V, int, (f,)]\n\n  proc default*[T:SetOrMap](self:typedesc[T]):T =\n    result.init()\n\
    \  proc initSortedSet*(K:typedesc, isCountable:static[bool] = false, comp:static[proc(a,\
    \ b:K):bool] = nil):auto =\n    var r: SortedSetType[K, when isCountable: int\
    \ else: void, (comp,)]\n    r.init()\n    return r\n  proc initSortedMultiSet*(K:typedesc,\
    \ isCountable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto\
    \ =\n    var r: SortedMultiSetType[K, when isCountable: int else: void, (comp,)]\n\
    \    r.init()\n    return r\n  proc initSortedMap*(K:typedesc, V:typedesc[not\
    \ void], isCountable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto\
    \ =\n    var r: SortedMapType[K, V, when isCountable: int else: void, (comp,)]\n\
    \    r.init()\n    return r\n  proc initSortedMultiMap*(K:typedesc, V:typedesc[not\
    \ void], isCountable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto\
    \ =\n    var r: SortedMultiMapType[K, V, when isCountable: int else: void, (comp,)]\n\
    \    r.init()\n    return r\n"
  dependsOn:
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
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
