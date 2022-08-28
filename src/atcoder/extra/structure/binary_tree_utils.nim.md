---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
    title: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
    title: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
    title: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
    title: atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_predecessor_problem_test.nim
    title: verify/extra/structure/yosupo_predecessor_problem_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_predecessor_problem_test.nim
    title: verify/extra/structure/yosupo_predecessor_problem_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
    title: verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
    title: verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_BINARY_TREE_UTILS_HPP:\n  const ATCODER_BINARY_TREE_UTILS_HPP*\
    \ = 1\n  include atcoder/extra/structure/binary_tree_node_utils\n  {.push discardable\
    \ inline.}\n  type SomeSortedTree* = concept x, type T\n    T.Tree is BinaryTree\n\
    \    T.K is typedesc\n    T.V is typedesc\n    T.Node is typedesc\n    T.multi\
    \ is typedesc\n    T.p\n    x.End\n  type SomeSortedSet* = concept x, type T\n\
    \    T is SomeSortedTree\n    T.V is void\n    T.multi is void\n  type SomeSortedMap*\
    \ = concept x, type T\n    T is SomeSortedTree\n    T.V isnot void\n    T.multi\
    \ is void\n  type SomeSortedMultiSet* = concept x, type T\n    T is SomeSortedTree\n\
    \    T.V is void\n    T.multi isnot void\n  type SomeSortedMultiMap* = concept\
    \ x, type T\n    T is SomeSortedTree\n    T.V isnot void\n    T.multi isnot void\n\
    \  type hasSplay* = concept x, type T\n    var t:T.Node\n    x.tree.splay(t)\n\
    \  proc begin*[T:SomeSortedTree](self: T):T.Node = self.tree.begin()\n\n  proc\
    \ getKey*[T:SomeSortedTree](self: T, t:T.Node):auto =\n    when T.V is void: t.key\n\
    \    else: t.key[0]\n\n  template calc_comp*[T:SomeSortedTree](self:T, x, y:T.K):bool\
    \ =\n    when T.p[0] is typeof(nil):\n      x < y\n    else:\n      let comp =\
    \ T.p[0]\n      comp(x, y)\n\n  proc lower_bound*[T:SomeSortedTree](self: var\
    \ T, t:var T.Node, x:T.K):T.Node =\n    if t.isLeaf:\n      return t\n    if t\
    \ != self.End and self.calc_comp(self.getKey(t), x):\n      return self.lower_bound(t.r,\
    \ x)\n    else:\n      var t2 = self.lower_bound(t.l, x)\n      if t2.isLeaf:\
    \ return t\n      else: return t2\n\n  proc lower_bound*[T:SomeSortedTree](self:var\
    \ T, x:T.K):T.Node =\n    assert self.tree.root != nil\n    result = self.lower_bound(self.tree.root,\
    \ x)\n    when T is hasSplay:\n      self.tree.splay(result)\n      self.tree.root\
    \ = result\n\n  proc upper_bound*[T:SomeSortedTree](self: var T, t:var T.Node,\
    \ x:T.K):T.Node =\n    if t.isLeaf: return t\n    if t == self.End or self.calc_comp(x,\
    \ self.getKey(t)):\n      var t2 = self.upper_bound(t.l, x)\n      if t2.isLeaf:\
    \ return t\n      else: return t2\n    else:\n      return self.upper_bound(t.r,\
    \ x)\n\n  proc upper_bound*[T:SomeSortedTree](self: var T, x:T.K):T.Node =\n \
    \   assert self.tree.root != nil\n    result = self.upper_bound(self.tree.root,\
    \ x)\n    when T is hasSplay:\n      self.tree.splay(result)\n      self.tree.root\
    \ = result\n\n#  proc find*[T:SomeSortedTree](self: var T, t:var T.Node, x:T.K):T.Node\
    \ =\n#    echo \"find:  \", t.key\n#    if t == self.End or t.isLeaf: return self.End\n\
    #    if self.calc_comp(x, self.getKey(t)): return self.find(t.l, x)\n#    elif\
    \ self.calc_comp(self.getKey(t), x): return self.find(t.r, x)\n#    else: return\
    \ t\n  proc find*[T:SomeSortedTree](self:var T, x:T.K):T.Node =\n    var t = self.lower_bound(x)\n\
    \    if t != self.End and self.getKey(t) == x: return t\n    else: return self.End\n\
    #    result = self.find(self.root, x)\n  proc contains*[T:SomeSortedTree](self:\
    \ var T, x:T.K):bool =\n    self.find(x) != self.End\n\n  proc insert*[T:SomeSortedMultiSet](self:\
    \ var T, x:T.K):T.Node =\n    self.tree.insert(self.upper_bound(x), x)\n  proc\
    \ insert*[T:SomeSortedMultiMap](self: var T, x:(T.K, T.V)):T.Node =\n    self.tree.insert(self.upper_bound(x[0]),\
    \ x)\n\n  proc insert*[T:SomeSortedSet](self: var T, x:T.K):T.Node =\n    var\
    \ t = self.lower_bound(x)\n    if t != self.End and t.key == x: return t\n   \
    \ else: return self.tree.insert(t, x)\n  proc insert*[T:SomeSortedMap](self: var\
    \ T, x:(T.K, T.V)):T.Node =\n    var it = self.lower_bound(x[0])\n    if it !=\
    \ self.End and it.key[0] == x[0]: it.key[1] = x[1]; return it\n    else: return\
    \ self.tree.insert(it, x)\n  proc incl*[T:SomeSortedSet | SomeSortedMultiSet](self:var\
    \ T, x:T.K):T.Node =\n    self.insert(x)\n  proc incl*[T:SomeSortedMap | SomeSortedMultiMap](self:var\
    \ T, x:(T.K, T.V)):T.Node =\n    self.insert(x)\n\n  template getAddr*[T:SomeSortedMap](self:var\
    \ T, x:T.K):auto =\n    var t = self.lower_bound(x)\n    if t == self.End or t.key[0]\
    \ != x:\n      var v: T.V\n      when v is SomeSortedTree:\n        v.init()\n\
    \      t = self.tree.insert(t, (x, v))\n    t.key[1].addr\n\n  template `[]`*[T:SomeSortedMap](self:\
    \ var T, x:T.K):auto =\n    var t = self.getAddr(x)\n    t[]\n  proc `[]=`*[T:SomeSortedMap](self:\
    \ var T, x:T.K, v:T.V) =\n    var t = self.getAddr(x)\n    t[] = v\n\n  proc erase*[T:SomeSortedSet\
    \ or SomeSortedMap](self: var T, x:T.K):T.Node =\n    mixin erase\n    var t =\
    \ self.lower_bound(x)\n    if t == self.End or self.getKey(t) != x: return self.End\n\
    \    else: return self.tree.erase(t)\n  proc erase*[T:SomeSortedMultiSet or SomeSortedMultiMap](self:\
    \ var T, lb, ub:T.Node):T.Node =\n    if lb != ub:\n      var\n        (L, R)\
    \ = self.tree.split(lb)\n        (RL, RR) = self.tree.split(ub)\n      self.tree.root\
    \ = self.tree.join(L, RR)\n    return ub\n\n  proc erase*[T:SomeSortedMultiSet\
    \ or SomeSortedMultiMap](self: var T, x:T.K):T.Node =\n    #doAssert T.Tree.Countable\
    \ isnot void\n    mixin erase\n    return self.erase(self.lower_bound(x), self.upper_bound(x))\n\
    \n  proc erase*[T:SomeSortedTree](self: var T, t:T.Node):T.Node = self.tree.erase(t)\n\
    \  proc excl*[T:SomeSortedTree](self: var T, x:T.K):T.Node = self.erase(x)\n \
    \ proc excl*[T:SomeSortedTree](self: var T, t:T.Node):T.Node = self.erase(t)\n\
    \n  proc kth_element*[T:SomeSortedTree](self: var T, t:T.Node, k:int):T.Node =\n\
    #    static:\n#      assert T.Tree.Countable isnot void\n    let p = t.l.cnt\n\
    \    if k < p: return self.kth_element(t.l, k)\n    elif k > p: return self.kth_element(t.r,\
    \ k - p - 1)\n    else: return t\n  \n  proc kth_element*[T:SomeSortedTree](self:\
    \ var T, k:int):T.Node =\n    return self.kth_element(self.tree.root, k)\n  proc\
    \ `{}`*[T:SomeSortedTree](self: var T, k:int):T.Node =\n    return self.kth_element(k)\n\
    \n  proc index*[T:SomeSortedTree](self:T, t:T.Node):int =\n#    static:\n#   \
    \   assert T.Tree.Countable isnot void\n    return index(t)\n  proc distance*[T:SomeSortedTree](self:T,\
    \ t1, t2:T.Node):int =\n#    static:\n#      assert T.Tree.Countable isnot void\n\
    \    return index(t2) - index(t1)\n\n  iterator items*[T:SomeSortedSet or SomeSortedMultiSet](self:T):T.K\
    \ =\n    var it = self.begin\n    while it != self.End:\n      yield it.key\n\
    \      it.inc\n  iterator pairs*[T:SomeSortedMap or SomeSortedMultiMap](self:T):(T.K,\
    \ T.V) =\n    var it = self.begin\n    while it != self.End:\n      yield it.key\n\
    \      it.inc\n  proc `end`*[Tree:SomeSortedTree](self:Tree):Tree.Node = self.End\n\
    \  {.pop.}\n"
  dependsOn:
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  isVerificationFile: false
  path: atcoder/extra/structure/binary_tree_utils.nim
  requiredBy:
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  timestamp: '2022-07-03 22:20:00+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
  - verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/map_test.nim
  - verify/map_test.nim
documentation_of: atcoder/extra/structure/binary_tree_utils.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/binary_tree_utils.nim
- /library/atcoder/extra/structure/binary_tree_utils.nim.html
title: atcoder/extra/structure/binary_tree_utils.nim
---
