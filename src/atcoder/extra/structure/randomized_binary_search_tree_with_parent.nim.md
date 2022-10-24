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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP:\n  {.experimental:\
    \ \"codeReordering\".}\n  const ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP*\
    \ = 1\n  {.push inline.}\n  import std/sugar, std/random, atcoder/rangeutils,\
    \ std/strutils\n  include atcoder/extra/structure/binary_tree_utils\n  include\
    \ atcoder/extra/structure/binary_tree_node_utils\n  type RBST_TRUE = int32\n \
    \ type RBST_FALSE = void\n  type RBSTNode*[D, L, useSum] = ref object\n    cnt*:int\n\
    \    l*,r*:RBSTNode[D, L, useSum]\n    p*:RBSTNode[D, L, useSum]\n    key*:D\n\
    \    when useSum isnot void:\n      sum*:D\n    when L isnot void:\n      lazy*:L\n\
    \    id*:int\n\n  type RBSTType*[D,L,Node,useP, useSum;p:static[tuple]] = object\
    \ of RootObj\n    root*, leaf*: Node\n    when D isnot void:\n      D0:D\n   \
    \ when L isnot void:\n      L0:L\n    r:Rand\n    id_max:int\n  type RandomizedBinarySearchTree*[D]\
    \ = RBSTType[D,void,RBSTNode[D,void,RBST_FALSE],RBST_FALSE,RBST_FALSE,()]\n  type\
    \ LazyRandomizedBinarySearchTree*[D,L,useP,useSum] = RBSTType[D,L,RBSTNode[D,L,useSum],useP,useSum,()]\n\
    \n  type SomeRBST* = RBSTType or RandomizedBinarySearchTree or LazyRandomizedBinarySearchTree\n\
    \n  template calc_op[ST:RBSTType](self:typedesc[ST], a, b:ST.D):auto =\n    block:\n\
    \      let op = ST.p.op\n      op(a, b)\n  template calc_mapping[ST:RBSTType](self:typedesc[ST],\
    \ a:ST.L, b:ST.D):auto =\n    block:\n      let mapping = ST.p.mapping\n     \
    \ mapping(a, b)\n  template calc_composition[ST:RBSTType](self:typedesc[ST], a,\
    \ b:ST.L):auto =\n    block:\n      let composition = ST.p.composition\n     \
    \ composition(a, b)\n  template calc_p[ST:RBSTType](self:typedesc[ST], a:ST.L,\
    \ b:Slice[int]):auto =\n    block:\n      let s = ST.p.p\n      s(a, b)\n\n  proc\
    \ hasSum*[RBST:SomeRBST](t:typedesc[RBST]):bool {.compileTime.} =\n    when t\
    \ is RBSTType or t is LazyRandomizedBinarySearchTree:\n      t.useSum isnot RBST_FALSE\n\
    \    elif t is RandomizedBinarySearchTree:\n      false\n  #proc hasData*(t:typedesc):bool\
    \ {.compileTime.} = t.D isnot void\n  proc hasLazy*[RBST:SomeRBST](t:typedesc[RBST]):bool\
    \ {.compileTime.} =\n    t.L isnot void\n#    when t isnot RandomizedBinarySearchTree:\n\
    #      # TODO\n#      return false\n#    else:\n#      t.L isnot void\n#  proc\
    \ hasP*(t:typedesc):bool {.compileTime.} = t.useP isnot void\n  #proc isPersistent*(t:typedesc):bool\
    \ {.compileTime.} = t.Persistent isnot void\n#  proc isLeaf*[Node:RBSTNode](node:Node):bool\
    \ =\n#    return node.l == node\n\n  proc initNode*[RBST:SomeRBST](self:RBST,\
    \ k:RBST.D, p:RBST.L, id:int, cnt:int):auto =\n    result = RBSTNode[RBST.D, RBST.L,\
    \ RBST.useSum](cnt:cnt, key:k, lazy:p, l:self.leaf, r:self.leaf, p:nil , id:id)\n\
    \    when RBST.hasSum: result.sum = k\n  proc initNode*[RBST:SomeRBST](self:RBST,\
    \ k:RBST.D, id:int, cnt:int):auto =\n    result = RBSTNode[RBST.D, RBST.L, RBST.useSum](cnt:cnt,\
    \ key:k, l:self.leaf, r:self.leaf, p:nil, id:id)\n    when RBST.hasSum: result.sum\
    \ = k\n  proc alloc*[RBST:SomeRBST](self: var RBST, key:RBST.D, cnt = 1):RBST.Node\
    \ =\n    when RBST.hasLazy:\n      result = self.initNode(key, self.L0, self.id_max,\
    \ cnt)\n    else:\n      result = self.initNode(key, self.id_max, cnt)\n    self.id_max.inc\n\
    \  #  return &(pool[ptr++] = Node(key, self.L0));\n\n  proc init*[RBST:SomeRBST](self:\
    \ var RBST, root: RBST.Node = nil, seed = 2019) =\n    # leaf\n    var leaf =\
    \ RBST.Node(cnt:0, p:nil, id: -1)\n    leaf.l = leaf;leaf.r = leaf\n    self.leaf\
    \ = leaf\n    if root == nil:\n      self.root = self.leaf\n    else:\n      self.root\
    \ = root\n      self.root.l = self.leaf\n      self.root.r = self.leaf\n    self.root.p\
    \ = nil\n    self.r = initRand(seed)\n    self.id_max = 0\n\n  proc initRandomizedBinarySearchTree*[D](seed\
    \ = 2019):auto =\n    type Node = RBSTNode[D, void, void]\n    result = RBSTType[D,void,Node,false,void,()]()\n\
    \    result.init()\n  proc initRandomizedBinarySearchTree*[D](f:static[(D,D)->D],\
    \ D0:D, seed = 2019):auto =\n    type Node = RBSTNode[D, void, int]\n    result\
    \ = RBSTType[D,void,Node,false,int,(op:f)](D0:D0)\n    result.init()\n  proc initRandomizedBinarySearchTree*[D,\
    \ L](f:static[(D,D)->D], g:static[(L,D)->D], h:static[(L,L)->L], D0:D, L0:L, seed\
    \ = 2019):auto =\n    type Node = RBSTNode[D, L, int]\n    result = RBSTType[D,L,Node,false,int,(op:f,mapping:g,composition:h)](D0:D0,\
    \ L0:L0)\n    result.init()\n  proc initRandomizedBinarySearchTree*[D, L](f:static[(D,D)->D],\
    \ g:static[(L,D)->D], h:static[(L,L)->L], p:static[(L,Slice[int])->L],D0:D,L0:L,seed\
    \ = 2019):auto =\n    type Node = RBSTNode[D, L, int]\n    result = RBSTType[D,L,Node,true,int,(op:f,mapping:g,composition:h,p:p)](D0:D0,\
    \ L0:L0)\n    result.init()\n\n  template clone*[D,L,useSum](t:RBSTNode[D, L,\
    \ useSum]):auto = t\n  proc test*[RBST:SomeRBST](self: var RBST, n, s:int):bool\
    \ = \n    const randMax = 18_446_744_073_709_551_615u64\n    let\n      q = randMax\
    \ div n.uint64\n      qn = q * n.uint64\n    while true:\n      let x = self.r.next()\n\
    \      if x < qn: return x < s.uint64 * q\n  \n#K  proc count*[RBST:SomeRBST](self:\
    \ RBST, t:RBST.Node):int = (if t != nil: t.cnt else: 0)\n#  proc count*[RBST:SomeRBST](self:\
    \ RBST, t:RBST.Node):int = t.cnt\n#  proc sum*[RBST:SomeRBST](self: RBST, t:RBST.Node):auto\
    \ = (if t != nil: t.sum else: self.D0)\n  proc sum*[RBST:SomeRBST](self: RBST,\
    \ t:RBST.Node):auto = t.sum\n  proc len*[RBST:SomeRBST](self: RBST, t:RBST.Node):int\
    \ = t.cnt\n  proc len*[RBST:SomeRBST](self: RBST):int = self.len(self.root)\n\n\
    \  proc update*[RBST:SomeRBST](self: RBST, t:RBST.Node):RBST.Node {.inline.} =\n\
    #    t.cnt = self.count(t.l) + self.count(t.r) + 1\n    t.cnt = t.l.cnt + t.r.cnt\
    \ + 1\n    when RBST.hasSum:\n      t.sum = RBST.calc_op(RBST.calc_op(t.l.sum,\
    \ t.key), t.r.sum)\n    t\n\n  proc propagate*[RBST:SomeRBST](self: var RBST,\
    \ t:RBST.Node):auto =\n    when RBST.hasLazy:\n      var t = clone(t)\n      if\
    \ t.lazy != self.L0:\n        when RBST.useP is RBST_TRUE:\n          var (li,\
    \ ri) = (0, 0)\n        if t.l != self.leaf:\n          t.l = clone(t.l)\n   \
    \       t.l.lazy = RBST.calc_composition(t.lazy, t.l.lazy)\n          when RBST.useP\
    \ is RBST_TRUE: ri = li + t.l.cnt\n          t.l.sum = RBST.calc_mapping(when\
    \ RBST.useP is RBST_TRUE: RBST.calc_p(t.lazy, li..<ri) else: t.lazy, t.l.sum)\n\
    \        when RBST.useP is RBST_TRUE: li = ri\n        t.key = RBST.calc_mapping(when\
    \ RBST.useP is RBST_TRUE: RBST.calc_p(t.lazy, li..<li+1) else: t.lazy, t.key)\n\
    \        when RBST.useP is RBST_TRUE: li.inc\n        if t.r != self.leaf:\n \
    \         t.r = clone(t.r)\n          t.r.lazy = RBST.calc_composition(t.lazy,\
    \ t.r.lazy)\n          when RBST.useP is RBST_TRUE: ri = li + t.r.cnt\n      \
    \    t.r.sum = RBST.calc_mapping(when RBST.useP is RBST_TRUE: RBST.calc_p(t.lazy,\
    \ li..<ri) else: t.lazy, t.r.sum)\n        t.lazy = self.L0\n      self.update(t)\n\
    \    else:\n      t\n  \n  proc merge*[RBST:SomeRBST](self: var RBST, l, r:RBST.Node):auto\
    \ =\n    if l == self.leaf: return r\n    elif r == self.leaf: return l\n    var\
    \ (l, r) = (l, r)\n    if self.test(l.cnt + r.cnt, l.cnt):\n      when RBST.hasLazy:\n\
    \        l = self.propagate(l)\n      l.r = self.merge(l.r, r)\n      if l.r !=\
    \ self.leaf: l.r.p = l\n      return self.update(l)\n    else:\n      when RBST.hasLazy:\n\
    \        r = self.propagate(r)\n      r.l = self.merge(l, r.l)\n      if r.l !=\
    \ self.leaf: r.l.p = r\n      return self.update(r)\n  \n  proc split*[RBST:SomeRBST](self:var\
    \ RBST, t:RBST.Node, k:int):(RBST.Node, RBST.Node) =\n    if t == self.leaf: return\
    \ (t, t)\n    var t = t\n    when RBST.hasLazy:\n      t = self.propagate(t)\n\
    \    if k <= t.l.cnt:\n      var s = self.split(t.l, k)\n      t.l = s[1]\n  \
    \    if t.l != self.leaf: t.l.p = t\n      if s[0] != self.leaf: s[0].p = nil\n\
    \      return (s[0], self.update(t))\n    else:\n      var s = self.split(t.r,\
    \ k - t.l.cnt - 1)\n      t.r = s[0]\n      if t.r != self.leaf: t.r.p = t\n \
    \     if s[1] != self.leaf: s[1].p = nil\n      return (self.update(t), s[1])\n\
    \n  proc split*[RBST:SomeRBST](self:var RBST, t:RBST.Node, p:RBST.Node):(RBST.Node,\
    \ RBST.Node) =\n    if t == self.leaf: return (t, t)\n    var t = t\n    when\
    \ RBST.hasLazy:\n      proc propagate_up(self: var RBST, t:RBST.Node, p:RBST.Node)\
    \ =\n        if p == nil: return\n        self.propagate_up(p.p)\n        p =\
    \ self.propagate(p)\n    var p = p\n    result[0] = p.l\n    p.l = self.leaf\n\
    \    result[1] = p\n    while p != nil:\n      if p == t: break\n      # p is\
    \ divided into (result[0], result[1])\n      let q = p.p\n      if q.l == p: #\
    \          result[0], (result[1], q.r)\n        q.l = result[1]\n        if q.l\
    \ != self.leaf: q.l.p = q\n        if result[0] != self.leaf: result[0].p = nil\n\
    \        result = (result[0], self.update(q))\n      else: # q.r == p,       (q.l,\
    \ result[0]), result[1]\n        q.r = result[0]\n        if q.r != self.leaf:\
    \ q.r.p = q\n        if result[1] != self.leaf: result[1].p = nil\n        result\
    \ = (self.update(q), result[1])\n      p = q\n\n  proc build*[RBST:SomeRBST](self:\
    \ var RBST, s:Slice[int], v:seq[RBST.D]):auto =\n    let (l, r) = (s.a, s.b +\
    \ 1)\n    if l + 1 >= r: return self.alloc(v[l])\n    var (x, y) = (self.build(l..<(l\
    \ + r) shr 1, v), self.build((l + r) shr 1..<r, v))\n    return self.merge(x,\
    \ y)\n  \n  proc build*[RBST:SomeRBST](self: var RBST, v:seq[RBST.D]) =\n    self.root\
    \ = self.build(0..<v.len, v)\n  \n  proc to_vec*[RBST:SomeRBST](self: RBST, r:RBST.Node,\
    \ v:var seq[RBST.D]) =\n    if r == self.leaf: return\n    when RBST.hasLazy:\n\
    \      var r = r\n      r = self.propagate(r)\n    self.to_vec(r.l, v)\n    v.add(r.key)\n\
    \  #  *it = r.key;\n    self.to_vec(r.r, v)\n  \n  proc to_vec*[RBST:SomeRBST](self:\
    \ RBST, r:RBST.Node):auto =\n    result = newSeq[RBST.D]()\n    self.to_vec(r,\
    \ result)\n  \n  proc to_string*[RBST:SomeRBST](self: RBST, r:RBST.Node):string\
    \ =\n    return \"{\" & self.to_vec(r).join(\", \") & \"}\"\n  \n  proc write_tree*[RBST:SomeRBST](self:\
    \ var RBST, r:RBST.Node, h = 0) =\n    if h == 0: echo \"========== tree =======\"\
    \n    if r == self.leaf:\n      for i in 0..<h: stdout.write \"  \"\n      echo\
    \ \"*\"\n      return\n    when RBST.hasLazy:\n      var r = r\n      r = self.propagate(r)\n\
    \    for i in 0..<h: stdout.write \"  \"\n#    stdout.write r.id, \": \", r.key,\
    \ \", \", r.sum\n    stdout.write r.id, \": \", r.key, \" \", r.cnt\n    when\
    \ RBST.hasLazy:\n      stdout.write \", \", r.lazy\n    echo \"\"\n    self.write_tree(r.l,\
    \ h+1)\n    self.write_tree(r.r, h+1)\n    if h == 0: echo \"========== end =======\"\
    \n  proc write_tree*[RBST:SomeRBST](self: var RBST) =\n    self.write_tree(self.root)\n\
    \  \n  proc insert_index*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, k:int,\
    \ v:RBST.D) =\n    var x = self.split(t, k)\n    t = self.merge(self.merge(x[0],\
    \ self.alloc(v)), x[1])\n\n  proc insert*[RBST:SomeRBST](self: var RBST, t:var\
    \ RBST.Node, p:RBST.Node, v:RBST.D):RBST.Node {.discardable.} =\n    var x = self.split(t,\
    \ p)\n    result = self.alloc(v)\n    t = self.merge(self.merge(x[0], result),\
    \ x[1])\n\n  proc erase_index*[RBST:SomeRBST](self: var RBST, t:var RBST.Node,\
    \ k:int) =\n    var x = self.split(t, k)\n    t = self.merge(x[0], self.split(x[1],\
    \ 1)[1])\n\n  proc erase*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, p:RBST.Node):RBST.Node\
    \ {.discardable.} =\n    var p2 = p.succ\n    var x = self.split(t, p)\n    t\
    \ = self.merge(x[0], self.split(x[1], p2)[1])\n    return p2\n\n  proc prod*[RBST:SomeRBST](self:\
    \ var RBST, t:var RBST.Node, p:Slice[int]):auto =\n    let (a, b) = p.halfOpenEndpoints\n\
    \    var\n      x = self.split(t, a)\n      y = self.split(x[1], b - a)\n    result\
    \ = self.sum(y[0])\n    var m = self.merge(y[0], y[1])\n    t = self.merge(x[0],\
    \ m)\n  \n  proc apply*[RBST:SomeRBST](self:var RBST, t:var RBST.Node, s:Slice[int],\
    \ p:RBST.L) =\n    static: assert RBST.hasLazy\n    let (a, b) = s.halfOpenEndpoints\n\
    \    var\n      x = self.split(t, a)\n      y = self.split(x[1], b - a)\n    y[0].lazy\
    \ = RBST.calc_composition(p, y[0].lazy)\n    var m = self.merge(self.propagate(y[0]),\
    \ y[1])\n    t = self.merge(x[0], m)\n  \n  proc set*[RBST:SomeRBST](self: var\
    \ RBST, t:var RBST.Node, k:int, x:RBST.D) =\n    when RBST.hasLazy:\n      t =\
    \ self.propagate(t)\n    if k < t.l.cnt: self.set(t.l, k, x)\n    elif k == t.l.cnt:\n\
    \      t.key = x\n      t.sum = x\n    else: self.set(t.r, k - t.l.cnt - 1, x)\n\
    \    t = self.update(t)\n  \n  proc empty*[RBST:SomeRBST](self: var RBST, t:RBST.Node):bool\
    \ = self.len == 0\n\n  proc insert_index*[RBST:SomeRBST](self: var RBST, k:int,\
    \ v:RBST.D):RBST.Node {.discardable.} =\n    result = self.insert_index(self.root,\
    \ k, v)\n    self.root.p = nil\n  proc insert*[RBST:SomeRBST](self: var RBST,\
    \ p:RBST.Node, v:RBST.D):RBST.Node {.discardable.} =\n    result = self.insert(self.root,\
    \ p, v)\n    self.root.p = nil\n  proc erase_index*[RBST:SomeRBST](self: var RBST,\
    \ k:int):RBST.Node {.discardable.} =\n    result = self.erase_index(self.root,\
    \ k)\n    self.root.p = nil\n  proc erase*[RBST:SomeRBST](self: var RBST, p:RBST.Node):RBST.Node\
    \ {.discardable.} =\n    result = self.erase(self.root, p)\n    self.root.p =\
    \ nil\n  proc prod*[RBST:SomeRBST](self: var RBST, p:Slice[int]):auto = self.prod(self.root,\
    \ p)\n  proc `[]`*[RBST:SomeRBST](self: var RBST, p:Slice[int]):auto = self.prod(self.root,\
    \ p)\n  proc apply*[RBST:SomeRBST](self:var RBST, s:Slice[int], p:RBST.L) = self.apply(self.root,\
    \ s, p)\n  proc set*[RBST:SomeRBST](self: var RBST, k:int, x:RBST.D) = self.set(self.root,\
    \ k, x)\n  proc `[]=`*[RBST:RBSTType](self: var RBST, k:int, x:RBST.D) = self.set(self.root,\
    \ k, x)\n  proc empty*[RBST:SomeRBST](self: var RBST):bool = self.empty(self.root)\n\
    \  proc check_tree*[RBST:SomeRBST](self: RBST, t:RBST.Node):int =\n    if t ==\
    \ self.leaf: return 0\n    result = 1\n    if t.l != self.leaf:\n      doAssert\
    \ t.l.p == t\n      result += self.check_tree(t.l)\n    if t.r != self.leaf:\n\
    \      doAssert t.r.p == t\n      result += self.check_tree(t.r)\n  proc check_tree*[RBST:SomeRBST](self:\
    \ RBST):int {.discardable.} =\n    doAssert self.root.p == nil\n    self.check_tree(self.root)\n\
    \  {.pop.}\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  isVerificationFile: false
  path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  requiredBy:
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map_by_randomized_binary_search_tree.nim
  timestamp: '2022-09-24 20:04:56+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
  - verify/extra/structure/yosupo_range_affine_range_sum_RBST_test.nim
  - verify/map_test.nim
  - verify/map_test.nim
documentation_of: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
- /library/atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim.html
title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
---
