---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  _extendedRequiredBy:
  - icon: ':x:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':x:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
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
  code: "when not declared ATCODER_RED_BLACK_TREE_HPP:\n  const ATCODER_RED_BLACK_TREE_HPP*\
    \ = 1\n  import std/sugar\n#  {.experimental: \"codeReordering\".}\n  {.push inline.}\n\
    \  type\n    Color* = enum red, black\n    RedBlackTreeNode*[K; Countable] = ref\
    \ object\n      p*, l*, r*: RedBlackTreeNode[K, Countable]\n      key*: K\n  \
    \    color*: Color\n      id*: int\n      when Countable isnot void:\n       \
    \ cnt*: int\n    RedBlackTreeType*[K, Node; Countable] = object of RootObj\n \
    \     root*, leaf*: Node\n      size*: int\n      next_id*: int\n    RedBlackTree*[K;\
    \ Countable] = RedBlackTreeType[K, RedBlackTreeNode[K, Countable], Countable]\n\
    \n  proc newNode[T:RedBlackTree](self: var T, parent: T.Node): T.Node =\n    result\
    \ = T.Node(p:parent, l:self.leaf, r: self.leaf, color: Color.red, id: self.next_id)\n\
    \    when T.Countable isnot void:\n      result.cnt = 1\n\n  proc newNode[T:RedBlackTree](self:\
    \ var T, parent: T.Node, key: T.K): T.Node =\n    result = self.newNode(parent)\n\
    \    result.key = key\n    self.next_id += 1\n\n  proc initRedBlackTree*[K](root:RedBlackTreeNode[K,\
    \ false] = nil): RedBlackTree[K, false] =\n    var leaf = RedBlackTreeNode[K](color:\
    \ Color.black, id: -1)\n    leaf.l = leaf;leaf.r = leaf\n    result = RedBlackTree[K](root:\
    \ root, next_id: 0, leaf:leaf)\n  proc initCountableRedBlackTree*[K](root:RedBlackTreeNode[K,\
    \ true] = nil): RedBlackTree[K, true] =\n    result = initRedBlackTree[K](root)\n\
    \    result.cnt = 1\n\n#  proc isLeaf*[Node:RedBlackTreeNode](self: Node):bool\
    \ =\n#    assert self != nil\n    #### type1\n  #  result = self.l == self\n \
    \ #  if result: assert(self.r == self)\n    #### type 2\n#    return self.id ==\
    \ -1\n\n\n  include atcoder/extra/structure/binary_tree_node_utils\n\n  proc `*`*[T:RedBlackTreeNode](node:T):auto\
    \ = node.key\n  template update*[T:RedBlackTree](self:T, node: T.Node) =\n   \
    \ when T.Countable isnot void:\n      if node == self.leaf or node == nil: return\n\
    \      node.cnt = node.l.cnt + node.r.cnt\n      node.cnt.inc\n    discard\n\n\
    \  proc rotateLeft[T:RedBlackTree](self: var T, parent: T.Node) =\n    if parent\
    \ == nil: return\n    var right = parent.r\n    parent.r = right.l\n    if right.l\
    \ != self.leaf: right.l.p = parent\n    right.p = parent.p\n    if parent.p ==\
    \ nil: self.root = right\n    elif parent.p.l == parent: parent.p.l = right\n\
    \    else: parent.p.r = right\n    right.l = parent\n    parent.p = right\n  \
    \  self.update(parent)\n    self.update(right)\n#    self.update(right.p)\n  proc\
    \ rotateRight[T:RedBlackTree](self: var T, parent: T.Node) =\n    if parent ==\
    \ nil: return\n    var left = parent.l\n    parent.l = left.r\n    if left.r !=\
    \ self.leaf : left.r.p = parent\n    left.p = parent.p\n    if parent.p == nil:\
    \ self.root = left\n    elif parent.p.r == parent: parent.p.r = left\n    else:\
    \ parent.p.l = left\n    left.r = parent\n    parent.p = left\n    self.update(parent)\n\
    \    self.update(left)\n#    self.update(left.p)\n\n  # insert {{{\n  proc fixInsert[T:RedBlackTree](self:\
    \ var T, node: T.Node) =\n    ## Rebalances a tree after an insertion\n    if\
    \ T.Countable isnot void:\n      var curr = node\n      while curr != nil:\n \
    \       self.update(curr)\n        curr = curr.p\n\n    var curr = node\n    while\
    \ curr != self.root and curr.p.color == Color.red:\n      if curr.p.p != nil and\
    \ curr.p == curr.p.p.l:\n        var uncle = curr.p.p.r\n        if uncle.color\
    \ == Color.red:\n          curr.p.color = Color.black\n          uncle.color =\
    \ Color.black\n          curr.p.p.color = Color.red\n          curr = curr.p.p\n\
    \        else:\n          if curr == curr.p.r:\n            curr = curr.p\n  \
    \          self.rotateLeft(curr)\n          curr.p.color = Color.black\n     \
    \     if curr.p.p != nil:\n            curr.p.p.color = Color.red\n          \
    \  self.rotateRight(curr.p.p)\n      elif curr.p.p != nil:\n        var uncle\
    \ = curr.p.p.l\n        if uncle.color == Color.red:\n          curr.p.color =\
    \ Color.black\n          uncle.color = Color.black\n          curr.p.p.color =\
    \ Color.red\n          curr = curr.p.p\n        else:\n          if curr == curr.p.l:\n\
    \            curr = curr.p\n            self.rotateRight(curr)\n          curr.p.color\
    \ = Color.black\n          if curr.p.p != nil:\n            curr.p.p.color = Color.red\n\
    \            self.rotateLeft(curr.p.p)\n    self.root.color = Color.black\n\n\n\
    \  proc insert*[T:RedBlackTree](self: var T, node:T.Node, next:T.Node): T.Node\
    \ {.discardable.} =\n    self.size += 1\n    if next.l == self.leaf:\n      #\
    \ insert at next.l\n      next.l = node\n      node.p = next\n    else:\n    \
    \  var curr = next.l.rightMost\n      # insert at curr.r\n      curr.r = node\n\
    \      node.p = curr\n    self.fixInsert(node)\n    return node\n\n  proc insert*[T:RedBlackTree](self:\
    \ var T, next:T.Node, x:T.K): T.Node {.discardable.} =\n    var node = self.newNode(T.Node(nil),\
    \ x)\n    return self.insert(node, next)\n  # }}}\n\n  # erase {{{\n  proc fixErase*[T:RedBlackTree](self:\
    \ var T, node: T.Node, parent: T.Node) =\n\n    var\n      child = node\n    \
    \  parent = parent\n    while child != self.root and child.color == Color.black:\n\
    \      if parent == nil: break # add!!!!!!!!\n      if child == parent.l:\n  \
    \      var sib = parent.r\n        if sib.color == Color.red:\n          sib.color\
    \ = Color.black\n          parent.color = Color.red\n          self.rotateLeft(parent)\n\
    \          sib = parent.r\n  \n        if sib.l.color == Color.black and sib.r.color\
    \ == Color.black:\n          sib.color = Color.red\n          child = parent\n\
    \          parent = child.p\n        else:\n          if sib.r.color == Color.black:\n\
    \            sib.l.color = Color.black\n            sib.color = Color.red\n  \
    \          self.rotateRight(sib)\n            sib = parent.r\n          sib.color\
    \ = parent.color\n          parent.color = Color.black\n          sib.r.color\
    \ = Color.black\n          self.rotateLeft(parent)\n          child = self.root\n\
    \          parent = child.p\n      else:\n        var sib = parent.l\n       \
    \ if sib.color == Color.red:\n          sib.color = Color.black\n          parent.color\
    \ = Color.red\n          self.rotateRight(parent)\n          sib = parent.l\n\n\
    \        if sib.r.color == Color.black and sib.l.color == Color.black:\n     \
    \     sib.color = Color.red\n          child = parent\n          parent = child.p\n\
    \        else:\n          if sib.l.color == Color.black:\n            sib.r.color\
    \ = Color.black\n            sib.color = Color.red\n            self.rotateLeft(sib)\n\
    \            sib = parent.l\n          sib.color = parent.color\n          parent.color\
    \ = Color.black\n          sib.l.color = Color.black\n          self.rotateRight(parent)\n\
    \          child = self.root\n          parent = child.p\n    child.color = Color.black\n\
    \n\n  \n  proc write*[T:RedBlackTree](rbt: T, self: T.Node, h = 0) =\n    for\
    \ i in 0..<h: stderr.write \" | \"\n    if self == rbt.leaf:\n      stderr.write\
    \ \"*\\n\"\n    else:\n      stderr.write \"id: \",self.id, \" key: \", self.key,\
    \ \" color: \", self.color, \" cnt: \", self.cnt, \" \"\n  #    if self.key ==\
    \ T.K.inf: stderr.write \"inf\"\n      if self.p != nil: stderr.write \" parent:\
    \ \", self.p.id\n      else: stderr.write \" parent: nil\"\n      stderr.write\
    \ \"\\n\"\n      if h >= 200:\n        stderr.write \"too deep!!!\\n\"\n     \
    \   assert false\n        return\n      rbt.write(self.l, h + 1)\n      rbt.write(self.r,\
    \ h + 1)\n  \n  proc write*[T:RedBlackTree](self: T) =\n    stderr.write \"=======\
    \ RB-TREE =============\\n\"\n    self.write(self.root, 0)\n    stderr.write \"\
    ======= END ==========\\n\"\n  \n  proc erase*[T:RedBlackTree](self: var T, node:\
    \ T.Node) =\n    # TODO\n#    if node == nil:\n#      echo \"warning: erase nil\"\
    \n#    if node == self.End or node == nil or node.isLeaf: return\n    var node\
    \ = node\n  \n    self.size.dec\n  \n    if node.l != self.leaf and node.r !=\
    \ self.leaf:\n      let pred = node.pred\n      swap(node.color, pred.color)\n\
    \      when T.Countable isnot void:\n        swap(node.cnt, pred.cnt)\n      #\
    \ swap node and pred\n      if node.l == pred:\n        let tmp = pred.r\n   \
    \     pred.r = node.r\n        if node.l != self.leaf:\n          node.l.p = pred\n\
    \        if node.r != self.leaf:\n          node.r.p = pred\n        node.l =\
    \ pred.l\n        node.r = tmp\n        pred.l = node\n        pred.p = node.p\n\
    \        node.p = pred\n        if pred.p != nil:\n          if pred.p.l == node:\n\
    \            pred.p.l = pred\n          if pred.p.r == node:\n            pred.p.r\
    \ = pred\n      else:\n        swap(node.p, pred.p)\n        swap(node.l, pred.l)\n\
    \        swap(node.r, pred.r)\n        if node.p != nil:\n          if node.p.l\
    \ == pred:\n            node.p.l = node\n          if node.p.r == pred:\n    \
    \        node.p.r = node\n        if node.l != self.leaf:\n          node.l.p\
    \ = node\n        if node.r != self.leaf:\n          node.r.p = node\n       \
    \ if pred.p != nil:\n          if pred.p.l == node:\n            pred.p.l = pred\n\
    \          if pred.p.r == node:\n            pred.p.r = pred\n        if pred.l\
    \ != self.leaf:\n          pred.l.p = pred\n        if pred.r != self.leaf:\n\
    \          pred.r.p = pred\n      if self.root == node:\n        self.root = pred\n\
    \  #    self.write()\n  #    node.key = pred.key\n  #    node.value = pred.value\n\
    \  #    node = pred\n    when T.Countable isnot void:\n      proc update_parents(self:T,\
    \ node:T.Node) =\n        var curr = node\n        while curr != nil:\n      \
    \    self.update(curr)\n          curr = curr.p\n\n    let child = if node.l !=\
    \ self.leaf: node.l else: node.r\n    if child != self.leaf:\n      child.p =\
    \ node.p\n      if node.p == nil:\n        self.root = child\n      elif node\
    \ == node.p.l:\n        node.p.l = child\n      else:\n        node.p.r = child\n\
    \      when T.Countable isnot void:\n        self.update_parents(node.p)\n   \
    \   if node.color == Color.black:\n        self.fixErase(child, node.p)\n    else:\n\
    \      if node.p == nil:\n        self.root = self.leaf\n      elif node == node.p.l:\n\
    \        node.p.l = self.leaf\n      else:\n        assert node == node.p.r\n\
    \        node.p.r = self.leaf\n      when T.Countable isnot void:\n        self.update_parents(node.p)\n\
    \      if node.color == Color.black:\n        self.fixErase(self.leaf, node.p)\n\
    \  # }}}\n  \n  proc len*[T:RedBlackTree](self: T): int =\n    return self.size\n\
    \  proc empty*[T:RedBlackTree](self: T): bool =\n    return self.len == 0\n  \n\
    \  iterator iterOrder*[T:RedBlackTree](self: T): auto =\n    var node = self.root\n\
    \    var stack: seq[T.Node] = @[]\n    while stack.len() != 0 or node != self.leaf:\n\
    \      if node != self.leaf:\n        stack.add(node)\n        node = node.l\n\
    \      else:\n        node = stack.pop()\n        if node == self.End: break\n\
    \        yield node.key\n        node = node.r\n  {.pop.}\n"
  dependsOn:
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  isVerificationFile: false
  path: atcoder/extra/structure/red_black_tree.nim
  requiredBy:
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - tests/test_extra_set_map.nim
  - tests/test_extra_set_map.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/map_test.nim
  - verify/map_test.nim
documentation_of: atcoder/extra/structure/red_black_tree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/red_black_tree.nim
- /library/atcoder/extra/structure/red_black_tree.nim.html
title: atcoder/extra/structure/red_black_tree.nim
---
