---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
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
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':x:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':x:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':x:'
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
  - icon: ':x:'
    path: verify/extra/structure/yosupo_predecessor_problem_test.nim
    title: verify/extra/structure/yosupo_predecessor_problem_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_predecessor_problem_test.nim
    title: verify/extra/structure/yosupo_predecessor_problem_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
    title: verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
    title: verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
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
  code: "when not declared ATCODER_BINARY_TREE_NODE_UTILS_HPP:\n  const ATCODER_BINARY_TREE_NODE_UTILS_HPP*\
    \ = 1\n  type BinaryTreeNode* = concept x, type T\n    x.l is T\n    x.r is T\n\
    \    x.p is T\n#    T.Countable\n  type BinaryTree* = concept x, type T\n    T.Node\
    \ is BinaryTreeNode\n    x.root is T.Node\n\n  proc greater_func*[K](a,b:K):bool\
    \ = a < b\n\n  proc isLeaf*[Node:BinaryTreeNode](self:Node):bool =\n    return\
    \ self.l == self\n\n  proc leftMost*[Node:BinaryTreeNode](self: Node):Node =\n\
    \    if self.l.isLeaf: return self\n    else: return self.l.leftMost\n  proc rightMost*[Node:BinaryTreeNode](self:\
    \ Node): Node =\n    if self.r.isLeaf: return self\n    else: return self.r.rightMost\n\
    \  proc parentLeft*[Node:BinaryTreeNode](node: Node): Node =\n    var node = node\n\
    \    while true:\n      if node.p == nil: return nil\n      elif node.p.l == node:\
    \ return node.p\n      node = node.p\n  proc parentRight*[Node:BinaryTreeNode](node:\
    \ Node): Node =\n    var node = node\n    while true:\n      if node.p == nil:\
    \ return nil\n      elif node.p.r == node: return node.p\n      node = node.p\n\
    \  proc front*[Tree:BinaryTree](self: Tree): Tree.Node = self.root.leftMost\n\
    \  proc tail*[Tree:BinaryTree](self: Tree): Tree.Node =  self.root.rightMost\n\
    \  proc begin*[Tree:BinaryTree](self:Tree):Tree.Node = self.root.leftMost\n\n\
    \  proc succ*[Node:BinaryTreeNode](node: Node): Node =\n    if not node.r.isLeaf:\
    \ return node.r.leftMost\n    else: return node.parentLeft\n  proc pred*[Node:BinaryTreeNode](node:\
    \ Node): Node =\n    if not node.l.isLeaf: return node.l.rightMost\n    else:\
    \ return node.parentRight\n  proc inc*[Node:BinaryTreeNode](node: var Node) =\n\
    \    var node2 = node.succ\n    swap node, node2\n  proc dec*[Node:BinaryTreeNode](node:\
    \ var Node) =\n    var node2 = node.pred\n    swap node, node2\n  proc `+=`*[Node:BinaryTreeNode](node:\
    \ var Node, n:int) =\n    if n < 0: node -= (-n)\n    for i in 0..<n: node.inc\n\
    \  proc `-=`*[Node:BinaryTreeNode](node: var Node, n:int) =\n    if n < 0: node\
    \ += (-n)\n    for i in 0..<n: node.dec\n\n  proc index*[Node:BinaryTreeNode](t:Node):int\
    \ =\n#    static:\n#      assert Node.Countable isnot void\n    result = t.l.cnt\n\
    \    var (t, p) = (t, t.p)\n    while p != nil:\n      if p.r == t: result +=\
    \ p.l.cnt + 1\n      t = t.p\n      p = p.p\n  proc distance*[Node:BinaryTreeNode](t1,\
    \ t2:Node):int =\n#    static:\n#      assert Node.Countable isnot void\n    return\
    \ t2.index - t1.index\n  proc `*`*[Node:BinaryTreeNode](node:Node):auto = node.key\n\
    \  iterator items*[Node:BinaryTreeNode](s:Slice[Node]):Node =\n    var it = s.a\n\
    \    while true:\n      yield it\n      if it == s.b: return\n      it.inc\n\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/binary_tree_node_utils.nim
  requiredBy:
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  timestamp: '2021-11-18 02:47:29+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
  - verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/map_test.nim
  - verify/map_test.nim
documentation_of: atcoder/extra/structure/binary_tree_node_utils.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/binary_tree_node_utils.nim
- /library/atcoder/extra/structure/binary_tree_node_utils.nim.html
title: atcoder/extra/structure/binary_tree_node_utils.nim
---
