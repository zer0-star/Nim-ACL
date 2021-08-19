when not declared ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP:
  {.experimental: "codeReordering".}
  const ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP* = 1
  {.push inline.}
  import std/sugar, std/random, atcoder/rangeutils, std/strutils
  include atcoder/extra/structure/binary_tree_utils
  include atcoder/extra/structure/binary_tree_node_utils
  type RBST_TRUE = int32
  type RBST_FALSE = void
  type RBSTNode*[D, L, useSum] = ref object
    cnt*:int
    l*,r*:RBSTNode[D, L, useSum]
    p*:RBSTNode[D, L, useSum]
    key*:D
    when useSum isnot void:
      sum*:D
    when L isnot void:
      lazy*:L
    id*:int

  type RBSTType*[D,L,Node,useP, useSum;p:static[tuple]] = object of RootObj
    root*, leaf*: Node
    when D isnot void:
      D0:D
    when L isnot void:
      L0:L
    r:Rand
    id_max:int
  type RandomizedBinarySearchTree*[D] = RBSTType[D,void,RBSTNode[D,void,RBST_FALSE],RBST_FALSE,RBST_FALSE,()]
  type LazyRandomizedBinarySearchTree*[D,L,useP,useSum] = RBSTType[D,L,RBSTNode[D,L,useSum],useP,useSum,()]

  type SomeRBST* = RBSTType or RandomizedBinarySearchTree or LazyRandomizedBinarySearchTree

  template calc_op[ST:RBSTType](self:typedesc[ST], a, b:ST.D):auto =
    block:
      let op = ST.p.op
      op(a, b)
  template calc_mapping[ST:RBSTType](self:typedesc[ST], a:ST.L, b:ST.D):auto =
    block:
      let mapping = ST.p.mapping
      mapping(a, b)
  template calc_composition[ST:RBSTType](self:typedesc[ST], a, b:ST.L):auto =
    block:
      let composition = ST.p.composition
      composition(a, b)
  template calc_p[ST:RBSTType](self:typedesc[ST], a:ST.L, b:Slice[int]):auto =
    block:
      let s = ST.p.p
      s(a, b)

  proc hasSum*[RBST:SomeRBST](t:typedesc[RBST]):bool {.compileTime.} =
    when t isnot RandomizedBinarySearchTree:
      return false
    else:
      t.useSum isnot RBST_FALSE
  #proc hasData*(t:typedesc):bool {.compileTime.} = t.D isnot void
  proc hasLazy*[RBST:SomeRBST](t:typedesc[RBST]):bool {.compileTime.} =
    t.L isnot void
#    when t isnot RandomizedBinarySearchTree:
#      # TODO
#      return false
#    else:
#      t.L isnot void
#  proc hasP*(t:typedesc):bool {.compileTime.} = t.useP isnot void
  #proc isPersistent*(t:typedesc):bool {.compileTime.} = t.Persistent isnot void
  proc isLeaf*[Node:RBSTNode](node:Node):bool =
    return node.l == node

  proc initNode*[RBST:SomeRBST](self:RBST, k:RBST.D, p:RBST.L, id:int, cnt:int):auto =
    result = RBSTNode[RBST.D, RBST.L, RBST.useSum](cnt:cnt, key:k, lazy:p, l:self.leaf, r:self.leaf, p:nil , id:id)
    when RBST.hasSum: result.sum = k
  proc initNode*[RBST:SomeRBST](self:RBST, k:RBST.D, id:int, cnt:int):auto =
    result = RBSTNode[RBST.D, RBST.L, RBST.useSum](cnt:cnt, key:k, l:self.leaf, r:self.leaf, p:nil, id:id)
    when RBST.hasSum: result.sum = k
  proc alloc*[RBST:SomeRBST](self: var RBST, key:RBST.D, cnt = 1):RBST.Node =
    when RBST.hasLazy:
      result = self.initNode(key, self.L0, self.id_max, cnt)
    else:
      result = self.initNode(key, self.id_max, cnt)
    self.id_max.inc
  #  return &(pool[ptr++] = Node(key, self.L0));

  proc setRBST*[RBST:SomeRBST](self: var RBST, seed = 2019) =
    # leaf
    var leaf = RBST.Node(cnt:0, p:nil, id: -2)
    leaf.l = leaf;leaf.r = leaf
    self.leaf = leaf

    self.root = self.leaf
    self.r = initRand(seed)
    self.id_max = 0

  proc initRandomizedBinarySearchTree*[D](seed = 2019):auto =
    type Node = RBSTNode[D, void, void]
    result = RBSTType[D,void,Node,false,void,()]()
    result.setRBST()
  proc initRandomizedBinarySearchTree*[D](f:static[(D,D)->D], D0:D, seed = 2019):auto =
    type Node = RBSTNode[D, void, int]
    result = RBSTType[D,void,Node,false,int,(op:f)](D0:D0)
    result.setRBST()
  proc initRandomizedBinarySearchTree*[D, L](f:static[(D,D)->D], g:static[(L,D)->D], h:static[(L,L)->L], D0:D, L0:L, seed = 2019):auto =
    type Node = RBSTNode[D, L, int]
    result = RBSTType[D,L,Node,false,int,(op:f,mapping:g,composition:h)](D0:D0, L0:L0)
    result.setRBST()
  proc initRandomizedBinarySearchTree*[D, L](f:static[(D,D)->D], g:static[(L,D)->D], h:static[(L,L)->L], p:static[(L,Slice[int])->L],D0:D,L0:L,seed = 2019):auto =
    type Node = RBSTNode[D, L, int]
    result = RBSTType[D,L,Node,true,int,(op:f,mapping:g,composition:h,p:p)](D0:D0, L0:L0)
    result.setRBST()

  template clone*[D,L,useSum](t:RBSTNode[D, L, useSum]):auto = t
  proc test*[RBST:SomeRBST](self: var RBST, n, s:int):bool = 
    const randMax = 18_446_744_073_709_551_615u64
    let
      q = randMax div n.uint64
      qn = q * n.uint64
    while true:
      let x = self.r.next()
      if x < qn: return x < s.uint64 * q
  
#K  proc count*[RBST:SomeRBST](self: RBST, t:RBST.Node):int = (if t != nil: t.cnt else: 0)
#  proc count*[RBST:SomeRBST](self: RBST, t:RBST.Node):int = t.cnt
#  proc sum*[RBST:SomeRBST](self: RBST, t:RBST.Node):auto = (if t != nil: t.sum else: self.D0)
  proc sum*[RBST:SomeRBST](self: RBST, t:RBST.Node):auto = t.sum
  proc len*[RBST:SomeRBST](self: RBST, t:RBST.Node):int = t.cnt
  proc len*[RBST:SomeRBST](self: RBST):int = self.len(self.root)

  proc update*[RBST:SomeRBST](self: RBST, t:RBST.Node):RBST.Node {.inline.} =
#    t.cnt = self.count(t.l) + self.count(t.r) + 1
    t.cnt = t.l.cnt + t.r.cnt + 1
    when RBST.hasSum:
      t.sum = RBST.calc_op(RBST.calc_op(t.l.sum, t.key), t.r.sum)
    t

  proc propagate*[RBST:SomeRBST](self: var RBST, t:RBST.Node):auto =
    when RBST.hasLazy:
      var t = clone(t)
      if t.lazy != self.L0:
        when RBST.useP is RBST_TRUE:
          var (li, ri) = (0, 0)
        if t.l != self.leaf:
          t.l = clone(t.l)
          t.l.lazy = RBST.calc_composition(t.lazy, t.l.lazy)
          when RBST.useP is RBST_TRUE: ri = li + t.l.cnt
          t.l.sum = RBST.calc_mapping(when RBST.useP is RBST_TRUE: RBST.calc_p(t.lazy, li..<ri) else: t.lazy, t.l.sum)
        when RBST.useP is RBST_TRUE: li = ri
        t.key = RBST.calc_mapping(when RBST.useP is RBST_TRUE: RBST.calc_p(t.lazy, li..<li+1) else: t.lazy, t.key)
        when RBST.useP is RBST_TRUE: li.inc
        if t.r != self.leaf:
          t.r = clone(t.r)
          t.r.lazy = RBST.calc_composition(t.lazy, t.r.lazy)
          when RBST.useP is RBST_TRUE: ri = li + t.r.cnt
          t.r.sum = RBST.calc_mapping(when RBST.useP is RBST_TRUE: RBST.calc_p(t.lazy, li..<ri) else: t.lazy, t.r.sum)
        t.lazy = self.L0
      self.update(t)
    else:
      t
  
  proc merge*[RBST:SomeRBST](self: var RBST, l, r:RBST.Node):auto =
    if l == self.leaf: return r
    elif r == self.leaf: return l
    var (l, r) = (l, r)
    if self.test(l.cnt + r.cnt, l.cnt):
      when RBST.hasLazy:
        l = self.propagate(l)
      l.r = self.merge(l.r, r)
      if l.r != self.leaf: l.r.p = l
      return self.update(l)
    else:
      when RBST.hasLazy:
        r = self.propagate(r)
      r.l = self.merge(l, r.l)
      if r.l != self.leaf: r.l.p = r
      return self.update(r)
  
  proc split*[RBST:SomeRBST](self:var RBST, t:RBST.Node, k:int):(RBST.Node, RBST.Node) =
    if t == self.leaf: return (t, t)
    var t = t
    when RBST.hasLazy:
      t = self.propagate(t)
    if k <= t.l.cnt:
      var s = self.split(t.l, k)
      t.l = s[1]
      if t.l != self.leaf: t.l.p = t
      if s[0] != self.leaf: s[0].p = nil
      return (s[0], self.update(t))
    else:
      var s = self.split(t.r, k - t.l.cnt - 1)
      t.r = s[0]
      if t.r != self.leaf: t.r.p = t
      if s[1] != self.leaf: s[1].p = nil
      return (self.update(t), s[1])

  proc split*[RBST:SomeRBST](self:var RBST, t:RBST.Node, p:RBST.Node):(RBST.Node, RBST.Node) =
    if t == self.leaf: return (t, t)
    var t = t
    when RBST.hasLazy:
      proc propagate_up(self: var RBST, t:RBST.Node, p:RBST.Node) =
        if p == nil: return
        self.propagate_up(p.p)
        p = self.propagate(p)
    var p = p
    result[0] = p.l
    p.l = self.leaf
    result[1] = p
    while p != nil:
      if p == t: break
      # p is divided into (result[0], result[1])
      let q = p.p
      if q.l == p: #          result[0], (result[1], q.r)
        q.l = result[1]
        if q.l != self.leaf: q.l.p = q
        if result[0] != self.leaf: result[0].p = nil
        result = (result[0], self.update(q))
      else: # q.r == p,       (q.l, result[0]), result[1]
        q.r = result[0]
        if q.r != self.leaf: q.r.p = q
        if result[1] != self.leaf: result[1].p = nil
        result = (self.update(q), result[1])
      p = q

  proc build*[RBST:SomeRBST](self: var RBST, s:Slice[int], v:seq[RBST.D]):auto =
    let (l, r) = (s.a, s.b + 1)
    if l + 1 >= r: return self.alloc(v[l])
    var (x, y) = (self.build(l..<(l + r) shr 1, v), self.build((l + r) shr 1..<r, v))
    return self.merge(x, y)
  
  proc build*[RBST:SomeRBST](self: var RBST, v:seq[RBST.D]) =
    self.root = self.build(0..<v.len, v)
  
  proc to_vec*[RBST:SomeRBST](self: RBST, r:RBST.Node, v:var seq[RBST.D]) =
    if r == self.leaf: return
    when RBST.hasLazy:
      var r = r
      r = self.propagate(r)
    self.to_vec(r.l, v)
    v.add(r.key)
  #  *it = r.key;
    self.to_vec(r.r, v)
  
  proc to_vec*[RBST:SomeRBST](self: RBST, r:RBST.Node):auto =
    result = newSeq[RBST.D]()
    self.to_vec(r, result)
  
  proc to_string*[RBST:SomeRBST](self: RBST, r:RBST.Node):string =
    return "{" & self.to_vec(r).join(", ") & "}"
  
  proc write_tree*[RBST:SomeRBST](self: var RBST, r:RBST.Node, h = 0) =
    if h == 0: echo "========== tree ======="
    if r == self.leaf:
      for i in 0..<h: stdout.write "  "
      echo "*"
      return
    when RBST.hasLazy:
      var r = r
      r = self.propagate(r)
    for i in 0..<h: stdout.write "  "
#    stdout.write r.id, ": ", r.key, ", ", r.sum
    stdout.write r.id, ": ", r.key, " ", r.cnt
    when RBST.hasLazy:
      stdout.write ", ", r.lazy
    echo ""
    self.write_tree(r.l, h+1)
    self.write_tree(r.r, h+1)
    if h == 0: echo "========== end ======="
  proc write_tree*[RBST:SomeRBST](self: var RBST) =
    self.write_tree(self.root)
  
  proc insert_index*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, k:int, v:RBST.D) =
    var x = self.split(t, k)
    t = self.merge(self.merge(x[0], self.alloc(v)), x[1])

  proc insert*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, p:RBST.Node, v:RBST.D):RBST.Node {.discardable.} =
    var x = self.split(t, p)
    result = self.alloc(v)
    t = self.merge(self.merge(x[0], result), x[1])

  proc erase_index*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, k:int) =
    var x = self.split(t, k)
    t = self.merge(x[0], self.split(x[1], 1)[1])

  proc erase*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, p:RBST.Node):RBST.Node {.discardable.} =
    var p2 = p.succ
    var x = self.split(t, p)
    t = self.merge(x[0], self.split(x[1], p2)[1])
    return p2

  proc prod*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, p:Slice[int]):auto =
    let (a, b) = p.halfOpenEndpoints
    var
      x = self.split(t, a)
      y = self.split(x[1], b - a)
    result = self.sum(y[0])
    var m = self.merge(y[0], y[1])
    t = self.merge(x[0], m)
  
  proc apply*[RBST:SomeRBST](self:var RBST, t:var RBST.Node, s:Slice[int], p:RBST.L) =
    static: assert RBST.hasLazy
    let (a, b) = s.halfOpenEndpoints
    var
      x = self.split(t, a)
      y = self.split(x[1], b - a)
    y[0].lazy = RBST.calc_composition(p, y[0].lazy)
    var m = self.merge(self.propagate(y[0]), y[1])
    t = self.merge(x[0], m)
  
  proc set*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, k:int, x:RBST.D) =
    when RBST.hasLazy:
      t = self.propagate(t)
    if k < t.l.cnt: self.set(t.l, k, x)
    elif k == t.l.cnt:
      t.key = x
      t.sum = x
    else: self.set(t.r, k - t.l.cnt - 1, x)
    t = self.update(t)
  
  proc empty*[RBST:SomeRBST](self: var RBST, t:RBST.Node):bool = self.len == 0


  proc insert_index*[RBST:SomeRBST](self: var RBST, k:int, v:RBST.D) = self.insert_index(self.root, k, v)
  proc insert*[RBST:SomeRBST](self: var RBST, p:RBST.Node, v:RBST.D):RBST.Node {.discardable.} =
    self.insert(self.root, p, v)
  proc erase_index*[RBST:SomeRBST](self: var RBST, k:int) = self.erase_index(self.root, k)
  proc erase*[RBST:SomeRBST](self: var RBST, p:RBST.Node):RBST.Node {.discardable.} =
    self.erase(self.root, p)
  proc prod*[RBST:SomeRBST](self: var RBST, p:Slice[int]):auto = self.prod(self.root, p)
  proc `[]`*[RBST:SomeRBST](self: var RBST, p:Slice[int]):auto = self.prod(self.root, p)
  proc apply*[RBST:SomeRBST](self:var RBST, s:Slice[int], p:RBST.L) = self.apply(self.root, s, p)
  proc set*[RBST:SomeRBST](self: var RBST, k:int, x:RBST.D) = self.set(self.root, k, x)
  proc `[]=`*[RBST:RBSTType](self: var RBST, k:int, x:RBST.D) = self.set(self.root, k, x)
  proc empty*[RBST:SomeRBST](self: var RBST):bool = self.empty(self.root)
  proc check_tree*[RBST:SomeRBST](self: RBST, t:RBST.Node):int =
    if t == self.leaf: return 0
    result = 1
    if t.l != self.leaf:
      doAssert t.l.p == t
      result += self.check_tree(t.l)
    if t.r != self.leaf:
      doAssert t.r.p == t
      result += self.check_tree(t.r)
  proc check_tree*[RBST:SomeRBST](self: RBST):int {.discardable.} =
    doAssert self.root.p == nil
    self.check_tree(self.root)
  {.pop.}
