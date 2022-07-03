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
  _extendedRequiredBy:
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_RED_BLACK_TREE_HPP:\n  const ATCODER_RED_BLACK_TREE_HPP*\
    \ = 1\n  import std/sugar\n#  {.experimental: \"codeReordering\".}\n  {.push inline,\
    \ discardable.}\n  type\n    Color* = enum red, black\n    RedBlackTreeNode*[K]\
    \ = ref object\n      p*, l*, r*: RedBlackTreeNode[K]\n      key*: K\n      color*:\
    \ Color\n      id*, cnt*: int32\n      level*: int8\n    RedBlackTreeType*[K,\
    \ Node] = object of RootObj\n      root*, leaf*: Node\n      next_id*: int32\n\
    \    RedBlackTree*[K] = RedBlackTreeType[K, RedBlackTreeNode[K]]\n  proc getleaf*[K](self:\
    \ RedBlackTree[K]):RedBlackTreeNode[K] =\n    var leaf_node {.global.} :RedBlackTreeNode[K]\
    \ = nil\n    if leaf_node == nil:\n      leaf_node = self.Node(color: Color.black,\
    \ id: -1)\n      (leaf_node.l, leaf_node.r) = (leaf_node, leaf_node)\n      leaf_node.level\
    \ = 0\n      leaf_node.cnt = 0\n    return leaf_node\n\n  proc newNode*[T:RedBlackTree](self:\
    \ var T, parent: T.Node): T.Node =\n    result = T.Node(p:parent, l:self.leaf,\
    \ r: self.leaf, color: Color.red, id: self.next_id)\n    result.cnt = 1\n\n  proc\
    \ newNode*[T:RedBlackTree](self: var T, parent: T.Node, key: T.K): T.Node =\n\
    \    result = self.newNode(parent)\n    result.key = key\n    self.next_id +=\
    \ 1\n  proc init*[T:RedBlackTree](self:var T, root: var T.Node = nil) =\n    self.leaf\
    \ = self.getLeaf()\n    if root != nil:\n      self.root = root\n      (self.root.l,\
    \ self.root.r) = (self.leaf, self.leaf)\n      root.id = -2\n      self.root.p\
    \ = nil\n      self.root.color = Color.black\n      self.update(root)\n    self.next_id\
    \ = 0\n\n  include atcoder/extra/structure/binary_tree_node_utils\n\n  # checker,\
    \ write\n  proc write*[T:RedBlackTree](rbt: T, self: T.Node, h = 0) =\n    for\
    \ i in 0..<h: stderr.write \" | \"\n    if self.id == -1:\n      stderr.write\
    \ \"*\\n\"\n    else:\n      stderr.write \"id: \",self.id, \" key: \", self.key,\
    \ \" color: \", self.color\n      stderr.write \" cnt: \", self.cnt, \" \", \"\
    \ level: \", self.level\n  #    if self.key == T.K.inf: stderr.write \"inf\"\n\
    \      if self.p != nil: stderr.write \" parent: \", self.p.id\n      else: stderr.write\
    \ \" parent: nil\"\n      stderr.write \"\\n\"\n      if h >= 20:\n        stderr.write\
    \ \"too deep!!!\\n\"\n        assert false\n        return\n      rbt.write(self.l,\
    \ h + 1)\n      rbt.write(self.r, h + 1)\n  \n  proc write*[T:RedBlackTree](self:\
    \ T) =\n    stderr.write \"======= RB-TREE =============\\n\"\n    doAssert self.root\
    \ != T.Node(nil)\n    self.write(self.root, 0)\n    stderr.write \"======= END\
    \ ==========\\n\"\n  import sets\n  proc checkTree*[T:RedBlackTree](self: T, node:\
    \ T.Node = nil) =\n    var node = node\n    if node == nil:\n      node = self.root\n\
    \    #doAssert self.root.color == Color.black\n    var black_ct_s = initHashSet[int]()\n\
    \    proc checkTreeSub(node:T.Node, black_ct:int) =\n      var black_ct = black_ct\n\
    \      if node.color == Color.black: black_ct.inc\n      if node.id == -1:\n \
    \       black_ct_s.incl(black_ct)\n        return\n      if node.color == Color.red:\n\
    \        doAssert node.l.color == Color.black and node.r.color == Color.black\n\
    \      let d = if node.id >= 0: 1 else: 0\n      doAssert node.cnt == node.l.cnt\
    \ + node.r.cnt + d\n      if node.level != node.l.level + (if node.l.color ==\
    \ Color.black: 1 else: 0) or node.level != node.r.level + (if node.r.color ==\
    \ Color.black: 1 else: 0):\n        echo \"found!!\"\n        echo \"node: \"\
    , node.id\n        self.write(node)\n      doAssert node.level == node.l.level\
    \ + (if node.l.color == Color.black: 1 else: 0)\n      doAssert node.level ==\
    \ node.r.level + (if node.r.color == Color.black: 1 else: 0)\n      checkTreeSub(node.l,\
    \ black_ct)\n      checkTreeSub(node.r, black_ct)\n    checkTreeSub(node, 0)\n\
    \    doAssert black_ct_s.len == 1\n\n\n\n\n  template update*[T:RedBlackTree](self:T,\
    \ node: T.Node) =\n    if node == self.leaf or node == nil: return\n    node.cnt\
    \ = node.l.cnt + node.r.cnt\n    if node.id >= 0: node.cnt.inc\n    node.level\
    \ = node.l.level + (if node.l.color == Color.black: 1 else: 0)\n\n  proc rotateLeft*[T:RedBlackTree](self:\
    \ var T, parent: T.Node):T.Node {.discardable.} =\n    if parent == nil: return\n\
    \    var right = parent.r\n    parent.r = right.l\n    if right.l != self.leaf:\
    \ right.l.p = parent\n    right.p = parent.p\n    if parent == self.root:\n  \
    \    self.root = right\n    if parent.p == nil:\n      discard\n    elif parent.p.l\
    \ == parent: parent.p.l = right\n    else: parent.p.r = right\n    right.l = parent\n\
    \    parent.p = right\n    self.update(parent)\n    self.update(right)\n    return\
    \ right\n\n  proc rotateRight*[T:RedBlackTree](self: var T, parent: T.Node):T.Node\
    \ {.discardable.} =\n    if parent == nil: return\n    var left = parent.l\n \
    \   parent.l = left.r\n    if left.r != self.leaf: left.r.p = parent\n    left.p\
    \ = parent.p\n    if parent == self.root:\n      self.root = left\n    if parent.p\
    \ == nil:\n      discard\n    elif parent.p.r == parent: parent.p.r = left\n \
    \   else: parent.p.l = left\n    left.r = parent\n    parent.p = left\n    self.update(parent)\n\
    \    self.update(left)\n    return left\n\n  proc insert*[T:RedBlackTree](self:\
    \ var T, node:T.Node, next:T.Node): T.Node {.discardable.} =\n    proc fixInsert(self:\
    \ var T, node: T.Node) =\n      var curr = node\n      #while curr != self.root\
    \ and curr.p.color == Color.red:\n      while curr.p != nil and curr.p.color ==\
    \ Color.red:\n        if curr.p.p != nil and curr.p == curr.p.p.l:\n         \
    \ var uncle = curr.p.p.r\n          if uncle.color == Color.red:\n           \
    \ curr.p.color = Color.black\n            uncle.color = Color.black\n        \
    \    curr.p.p.color = Color.red\n            self.update(curr.p)\n           \
    \ self.update(curr.p.p)\n            curr = curr.p.p\n          else:\n      \
    \      if curr == curr.p.r:\n              curr = curr.p\n              self.rotateLeft(curr)\n\
    \            curr.p.color = Color.black\n            if curr.p.p != nil:\n   \
    \           curr.p.p.color = Color.red\n              self.rotateRight(curr.p.p)\n\
    \        elif curr.p.p != nil:\n          var uncle = curr.p.p.l\n          if\
    \ uncle.color == Color.red:\n            curr.p.color = Color.black\n        \
    \    uncle.color = Color.black\n            curr.p.p.color = Color.red\n     \
    \       self.update(curr.p)\n            self.update(curr.p.p)\n            curr\
    \ = curr.p.p\n          else:\n            if curr == curr.p.l:\n            \
    \  curr = curr.p\n              self.rotateRight(curr)\n            curr.p.color\
    \ = Color.black\n            if curr.p.p != nil:\n              curr.p.p.color\
    \ = Color.red\n              self.rotateLeft(curr.p.p)\n      while curr != nil:\n\
    \        self.update(curr)\n        if curr.p == nil: curr.color = Color.black\n\
    \        curr = curr.p\n\n    if next.l == self.leaf:\n      # insert at next.l\n\
    \      next.l = node\n      node.p = next\n    else:\n      var curr = next.l.rightMost\n\
    \      # insert at curr.r\n      curr.r = node\n      node.p = curr\n    self.update(node)\n\
    \    self.fixInsert(node)\n    return node\n\n  proc insert*[T:RedBlackTree](self:\
    \ var T, next:T.Node, x:T.K): T.Node {.discardable.} =\n    var node = self.newNode(T.Node(nil),\
    \ x)\n    return self.insert(node, next)\n\n\n  #proc getNodeStr(self:RedBlackTreeNode):string\
    \ =\n  #  if self == nil: \"nil\"\n  #  else: $self.id\n\n  proc update_parents[T:RedBlackTree](self:var\
    \ T, node:T.Node):T.Node {.discardable.} =\n    var curr = node\n    while curr\
    \ != nil:\n      self.update(curr)\n      if curr.p == nil: return curr\n    \
    \  curr = curr.p\n\n  proc erase*[T:RedBlackTree](self: var T, node: T.Node):T.Node\
    \ =\n    proc fixErase(self: var T, node: T.Node, parent: T.Node) =\n      var\n\
    \        child = node\n        parent = parent\n      while child != self.root\
    \ and child.color == Color.black:\n        if parent == nil: break # add!!!!!!!!\n\
    \        if child == parent.l:\n          var sib = parent.r\n          if sib.color\
    \ == Color.red:\n            sib.color = Color.black\n            parent.color\
    \ = Color.red\n            self.rotateLeft(parent)\n            sib = parent.r\n\
    \          else:\n            self.update(parent)\n\n          if sib.l.color\
    \ == Color.black and sib.r.color == Color.black:\n            sib.color = Color.red\n\
    \            self.update(parent)\n            child = parent\n            parent\
    \ = child.p\n            self.update(parent)\n          else:\n            if\
    \ sib.r.color == Color.black:\n              sib.l.color = Color.black\n     \
    \         sib.color = Color.red\n              self.rotateRight(sib)\n       \
    \       sib = parent.r\n            sib.color = parent.color\n            parent.color\
    \ = Color.black\n            sib.r.color = Color.black\n            self.rotateLeft(parent)\n\
    \            self.update_parents(sib)\n            child = self.root\n       \
    \     parent = child.p\n        else:\n          var sib = parent.l\n        \
    \  if sib.color == Color.red:\n            sib.color = Color.black\n         \
    \   parent.color = Color.red\n            self.rotateRight(parent)\n         \
    \   sib = parent.l\n          else:\n            self.update(parent)\n\n     \
    \     if sib.r.color == Color.black and sib.l.color == Color.black:\n        \
    \    sib.color = Color.red\n            self.update(parent)\n            child\
    \ = parent\n            parent = child.p\n            self.update(parent)\n  \
    \        else:\n            if sib.l.color == Color.black:\n              sib.r.color\
    \ = Color.black\n              sib.color = Color.red\n              self.rotateLeft(sib)\n\
    \              sib = parent.l\n            sib.color = parent.color\n        \
    \    parent.color = Color.black\n            sib.l.color = Color.black\n     \
    \       self.rotateRight(parent)\n            self.update_parents(sib)\n     \
    \       child = self.root\n            parent = child.p\n\n      if child != self.leaf:\n\
    \        child.color = Color.black\n      var curr = parent\n      self.update_parents(curr)\n\
    \n    var node = node\n    var succ = node.succ\n    if node.l != self.leaf and\
    \ node.r != self.leaf:\n      swap(node.color, succ.color)\n      swap(node.cnt,\
    \ succ.cnt)\n      # swap node and succ\n      if node.r == succ:\n        let\
    \ tmp = succ.l\n        succ.l = node.l\n        if node.l != self.leaf: node.l.p\
    \ = succ\n        if node.r != self.leaf: node.r.p = succ\n        node.l = tmp\n\
    \        node.r = succ.r\n        succ.r = node\n        succ.p = node.p\n   \
    \     node.p = succ\n        if succ.p != nil:\n          if succ.p.l == node:\
    \ succ.p.l = succ\n          if succ.p.r == node: succ.p.r = succ\n      else:\n\
    \        swap(node.p, succ.p)\n        swap(node.l, succ.l)\n        swap(node.r,\
    \ succ.r)\n        if node.p != nil:\n          if node.p.l == succ: node.p.l\
    \ = node\n          if node.p.r == succ: node.p.r = node\n        if node.l !=\
    \ self.leaf: node.l.p = node\n        if node.r != self.leaf: node.r.p = node\n\
    \        if succ.p != nil:\n          if succ.p.l == node: succ.p.l = succ\n \
    \         if succ.p.r == node: succ.p.r = succ\n        if succ.l != self.leaf:\
    \ succ.l.p = succ\n        if succ.r != self.leaf: succ.r.p = succ\n      if self.root\
    \ == node:\n        self.root = succ\n\n\n    let child = if node.l != self.leaf:\
    \ node.l else: node.r\n    if child != self.leaf:\n      child.p = node.p\n  \
    \    if node.p == nil: self.root = child\n      elif node == node.p.l: node.p.l\
    \ = child\n      else: node.p.r = child\n\n      if node.color == Color.black:\n\
    \        self.fixErase(child, node.p)\n      else:\n        self.update_parents(node.p)\n\
    \    else:\n      if node.p == nil:\n        self.root = self.leaf\n      elif\
    \ node == node.p.l:\n        node.p.l = self.leaf\n      else:\n        assert\
    \ node == node.p.r\n        node.p.r = self.leaf\n\n      if node.color == Color.black:\n\
    \        self.fixErase(self.leaf, node.p)\n      else:\n        self.update_parents(node.p)\n\
    \    return succ\n\n# split, join\n\n  proc expose*[T:RedBlackTree](self: var\
    \ T, N:T.Node):(T.Node, T.Node, T.Node) =\n    if not N.l.isLeaf:\n      N.l.p\
    \ = nil\n      N.l.color = Color.black\n    if not N.r.isLeaf:\n      N.r.p =\
    \ nil\n      N.r.color = Color.black\n    N.color = Color.black\n    (result[0],\
    \ result[2]) = (N.l, N.r)\n    (N.l, N.r) = (self.leaf, self.leaf)\n    result[1]\
    \ = N\n  \n  proc join*[T:RedBlackTree](self: var T, TL, k, TR:T.Node):T.Node\
    \ =\n    proc joinRightRB[T:RedBlackTree](self:var T, TL, k, TR:T.Node):T.Node\
    \ =\n      doAssert TL.level >= TR.level\n      if TL.color == Color.black and\
    \ TL.level == TR.level:\n        k.color = Color.red\n        (k.l, k.r) = (TL,\
    \ TR)\n        k.p = nil\n        if not k.l.isLeaf: k.l.p = k\n        if not\
    \ k.r.isLeaf: k.r.p = k\n        self.update(k)\n        return k\n      TL.r.p\
    \ = nil\n      TL.r = self.joinRightRB(TL.r, k, TR)\n      if not TL.r.isLeaf:\
    \ TL.r.p = TL\n      #if TL.color == Color.black and TL.r.r.color == Color.red:\n\
    \      result = TL\n      if TL.color == Color.black and TL.r.r.color == Color.red\
    \ and TL.r.color == Color.red:\n        TL.r.r.color = Color.black\n        result\
    \ = self.rotateLeft(TL)\n      self.update(result)\n    proc joinLeftRB[T:RedBlackTree](self:var\
    \ T, TL, k, TR:T.Node):T.Node =\n      doAssert TL.level <= TR.level\n      if\
    \ TR.color == Color.black and TR.level == TL.level:\n        k.color = Color.red\n\
    \        (k.l, k.r) = (TL, TR)\n        k.p = nil\n        if not k.l.isLeaf:\
    \ k.l.p = k\n        if not k.r.isLeaf: k.r.p = k\n        self.update(k)\n  \
    \      return k\n      TR.l.p = nil\n      TR.l = self.joinLeftRB(TL, k, TR.l)\n\
    \      if not TR.l.isLeaf: TR.l.p = TR\n      result = TR\n      # if TR.color\
    \ == Color.black and TR.l.l.color == Color.red:\n      if TR.color == Color.black\
    \ and TR.l.l.color == Color.red and TR.l.color == Color.red:\n        TR.l.l.color\
    \ = Color.black\n        result = self.rotateRight(TR)\n      self.update(result)\n\
    \    if TL.level > TR.level:\n      result = self.joinRightRB(TL, k, TR)\n   \
    \   if result.color == Color.red and result.r.color == Color.red:\n        result.color\
    \ = Color.black\n    elif TL.level < TR.level:\n      result = self.joinLeftRB(TL,\
    \ k, TR)\n      if result.color == Color.red and result.l.color == Color.red:\n\
    \        result.color = Color.black\n    else:\n      (k.l, k.r) = (TL, TR)\n\
    \      if not k.l.isLeaf: k.l.p = k\n      if not k.r.isLeaf: k.r.p = k\n    \
    \  if TL.color == Color.black and TR.color == Color.black:\n        k.color =\
    \ Color.red\n      else:\n        k.color = Color.black\n      result = k\n  \
    \    self.update(result)\n    result.color = Color.black\n    result.p = nil\n\
    \  \n  proc join*[T:RedBlackTree](self: var T, L, R: T.Node):T.Node =\n    proc\
    \ splitLast(self: var T, k:T.Node):(T.Node, T.Node) = \n      var (L, k, R) =\
    \ self.expose(k)\n      if R.isLeaf:\n        return (L, k)\n      else:\n   \
    \     var (N, k2) = self.splitLast(R)\n        return (self.join(L, k, N), k2)\n\
    \  \n    if L.isLeaf:\n      R.color = Color.black\n      return R\n    else:\n\
    \      var (L2, k) = self.splitLast(L)\n      L2.color = Color.black\n      return\
    \ self.join(L2, k, R)\n  \n  proc split3*(self:var RedBlackTree, N:self.Node):auto\
    \ =\n    # N\u3092\u4E2D\u5FC3\u306B\u5DE6\u53F3\u306B\u5206\u3051\u308B\n   \
    \ if N.isLeaf:\n      doAssert false\n      #return (self.leaf, false, self.leaf)\
    \ # !!!\n    var path:seq[(self.Node, int)]\n    block:\n      var N = N\n   \
    \   while N.p != nil:\n        var P = N.p\n        if P.l == N:\n          path.add\
    \ (P, 0)\n        elif P.r == N:\n          path.add (P, 1)\n        else:\n \
    \         doAssert false\n        N = P\n    var (L, N, R) = self.expose(N)\n\
    \    for (P, d) in path:\n      if d == 0:\n        P.r.p = nil\n        P.r.color\
    \ = Color.black\n        R = self.join(R, P, P.r)\n      else:\n        P.l.p\
    \ = nil\n        P.l.color = Color.black\n        L = self.join(P.l, P, L)\n \
    \   return (L, R)\n  \n  proc split*(self:var RedBlackTree, N:self.Node):auto\
    \ =\n    var prev = self.newNode(self.Node(nil))\n    self.insert(prev, N)\n \
    \   return self.split3(prev)\n  \n  proc insert_by_join*[T:RedBlackTree](self:\
    \ var T, node, next:T.Node):T.Node = # next\u306E\u524D\u306Bnode\u3092\u5165\u308C\
    \u308B\n    result = node\n    var\n      parent:T.Node\n      d:int # left: 0,\
    \ right: 1\n    if next.l == self.leaf:\n      # insert at next.l\n      parent\
    \ = next\n      d = 0\n    else:\n      var curr = next.l.rightMost\n      # insert\
    \ at curr.r\n      parent = curr\n      d = 1\n    var node = self.join(self.leaf,\
    \ node, self.leaf)\n    while parent != nil:\n      var\n        grand_parent\
    \ = parent.p\n        d2:int\n      if grand_parent != nil:\n        if grand_parent.l\
    \ == parent:\n          d2 = 0\n        else:\n          d2 = 1\n      #var (L,\
    \ p, R) = self.expose(parent)\n      if d == 0:\n        if parent.r != self.leaf:\n\
    \          parent.r.p = nil\n          parent.r.color = Color.black\n        parent.l\
    \ = self.leaf\n        parent = self.join(node, parent, parent.r)\n      else:\n\
    \        if parent.l != self.leaf:\n          parent.l.p = nil\n          parent.l.color\
    \ = Color.black\n        parent.r = self.leaf\n        parent = self.join(parent.l,\
    \ parent, node)\n\n      node = parent\n      parent = grand_parent\n      d =\
    \ d2\n    self.root = node\n  proc insert_by_join*[T:RedBlackTree](self: var T,\
    \ next:T.Node, key:T.K):T.Node = # next\u306E\u524D\u306Bnode\u3092\u5165\u308C\
    \u308B\n    self.insert_by_join(self.newNode(T.Node(nil), key), next)\n\n\n  proc\
    \ len*[T:RedBlackTree](self: T): int =\n    return self.root.cnt\n  proc empty*[T:RedBlackTree](self:\
    \ T): bool =\n    return self.len == 0\n  \n  iterator iterOrder*[T:RedBlackTree](self:\
    \ T): auto =\n    var node = self.root\n    var stack: seq[T.Node] = @[]\n   \
    \ while stack.len() != 0 or node != self.leaf:\n      if node != self.leaf:\n\
    \        stack.add(node)\n        node = node.l\n      else:\n        node = stack.pop()\n\
    \        #if node == self.End: break\n        yield node.key\n        node = node.r\n\
    \  {.pop.}\n"
  dependsOn:
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  isVerificationFile: false
  path: atcoder/extra/structure/red_black_tree.nim
  requiredBy:
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  timestamp: '2022-07-03 22:20:00+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/map_test.nim
  - verify/map_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
documentation_of: atcoder/extra/structure/red_black_tree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/red_black_tree.nim
- /library/atcoder/extra/structure/red_black_tree.nim.html
title: atcoder/extra/structure/red_black_tree.nim
---
