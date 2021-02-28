when not declared ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP:
  const ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP* = 1
  {.push inline.}
  import std/sugar, std/random, atcoder/rangeutils
  type RBSTNode*[D, L, useSum] = ref object
    cnt*:int
    l*,r*:RBSTNode[D, L, useSum]
    key*:D
    when useSum isnot void:
      sum*:D
    when L isnot void:
      lazy*:L
    id:int

  type RandomizedBinarySearchTree*[D,L,Node;useP:static[bool], useSum;p:static[tuple]] = object of RootObj
    root*: Node
    when D isnot void:
      D0:D
    when L isnot void:
      L0:L
    r:Rand
    id_max:int

  template calc_op[ST:RandomizedBinarySearchTree](self:typedesc[ST], a, b:ST.D):auto =
    block:
      let op = ST.p.op
      op(a, b)
  template calc_mapping[ST:RandomizedBinarySearchTree](self:typedesc[ST], a:ST.L, b:ST.D):auto =
    block:
      let mapping = ST.p.mapping
      mapping(a, b)
  template calc_composition[ST:RandomizedBinarySearchTree](self:typedesc[ST], a, b:ST.L):auto =
    block:
      let composition = ST.p.composition
      composition(a, b)
  template calc_p[ST:RandomizedBinarySearchTree](self:typedesc[ST], a:ST.L, b:Slice[int]):auto =
    block:
      let s = ST.p.p
      s(a, b)

  proc hasSum*(t:typedesc[RandomizedBinarySearchTree] or typedesc[RBSTNode]):bool {.compileTime.} = t.useSum isnot void
  #proc hasData*(t:typedesc):bool {.compileTime.} = t.D isnot void
  proc hasLazy*(t:typedesc):bool {.compileTime.} = t.L isnot void
#  proc hasP*(t:typedesc):bool {.compileTime.} = t.useP isnot void
  #proc isPersistent*(t:typedesc):bool {.compileTime.} = t.Persistent isnot void


  proc initNode*[RBST:RandomizedBinarySearchTree](self:RBST, k:RBST.D, p:RBST.L, id:int):auto =
    result = RBSTNode[RBST.D, RBST.L, RBST.useSum](cnt:1, key:k, lazy:p, l:nil, r:nil, id:id)
    when RBST.hasSum: result.sum = k
  proc initNode*[RBST:RandomizedBinarySearchTree](self:RBST, k:RBST.D, id:int):auto =
    result = RBSTNode[RBST.D, RBST.L, RBST.useSum](cnt:1, key:k, l:nil, r:nil, id:id)
    when RBST.hasSum: result.sum = k
  
  proc initRandomizedBinarySearchTree*[D](seed = 2019):auto =
    type Node = RBSTNode[D, void, void]
    RandomizedBinarySearchTree[D,void,Node,false,void,()](root:nil, r:initRand(seed), id_max:0)
  proc initRandomizedBinarySearchTree*[D](f:static[(D,D)->D], D0:D, seed = 2019):auto =
    type Node = RBSTNode[D, void, int]
    RandomizedBinarySearchTree[D,void,Node,false,int,(op:f)](root:nil, D0:D0, r:initRand(seed), id_max: 0)
  proc initRandomizedBinarySearchTree*[D, L](f:static[(D,D)->D], g:static[(L,D)->D], h:static[(L,L)->L], D0:D, L0:L, seed = 2019):auto =
    type Node = RBSTNode[D, L, int]
    RandomizedBinarySearchTree[D,L,Node,false,int,(op:f,mapping:g,composition:h)](root:nil, D0:D0, L0:L0, r:initRand(seed), id_max: 0)
  proc initRandomizedBinarySearchTree*[D, L](f:static[(D,D)->D], g:static[(L,D)->D], h:static[(L,L)->L], p:static[(L,Slice[int])->L],D0:D,L0:L,seed = 2019):auto =
    type Node = RBSTNode[D, L, int]
    RandomizedBinarySearchTree[D,L,Node,true,int,(op:f,mapping:g,composition:h,p:p)](root:nil, D0:D0, L0:L0, r:initRand(seed), id_max: 0)
  
  proc alloc*[RBST](self: var RBST, key:RBST.D):auto =
    when RBST.hasLazy:
      result = self.initNode(key, self.L0, self.id_max)
    else:
      result = self.initNode(key, self.id_max)
    self.id_max.inc
  #  return &(pool[ptr++] = Node(key, self.L0));
  
  template clone*[D,L,useSum](t:RBSTNode[D, L, useSum]):auto = t
  proc test*[RBST:RandomizedBinarySearchTree](self: var RBST, n, s:int):bool = 
    const randMax = 18_446_744_073_709_551_615u64
    let
      q = randMax div n.uint64
      qn = q * n.uint64
    while true:
      let x = self.r.next()
      if x < qn: return x < s.uint64 * q
  
  proc count*[RBST:RandomizedBinarySearchTree](self: RBST, t:RBST.Node):auto = (if t != nil: t.cnt else: 0)
  proc sum*[RBST:RandomizedBinarySearchTree](self: RBST, t:RBST.Node):auto = (if t != nil: t.sum else: self.D0)
  
  proc update*[RBST:RandomizedBinarySearchTree](self: RBST, t:var RBST.Node):RBST.Node {.inline.} =
    t.cnt = self.count(t.l) + self.count(t.r) + 1
    when RBST.hasSum:
      t.sum = RBST.calc_op(RBST.calc_op(self.sum(t.l), t.key), self.sum(t.r))
    t
  
  proc propagate*[RBST:RandomizedBinarySearchTree](self: var RBST, t:RBST.Node):auto =
    when RBST.hasLazy:
      var t = clone(t)
      if t.lazy != self.L0:
        when RBST.useP:
          var
            li = 0
            ri = 0
        if t.l != nil:
          t.l = clone(t.l)
          t.l.lazy = RBST.calc_composition(t.lazy, t.l.lazy)
          when RBST.useP: ri = li + self.count(t.l)
          t.l.sum = RBST.calc_mapping(when RBST.useP: RBST.calc_p(t.lazy, li..<ri) else: t.lazy, t.l.sum)
        when RBST.useP: li = ri
        t.key = RBST.calc_mapping(when RBST.useP: RBST.calc_p(t.lazy, li..<li+1) else: t.lazy, t.key)
        when RBST.useP: li.inc
        if t.r != nil:
          t.r = clone(t.r)
          t.r.lazy = RBST.calc_composition(t.lazy, t.r.lazy)
          when RBST.useP: ri = li + self.count(t.r)
          t.r.sum = RBST.calc_mapping(when RBST.useP: RBST.calc_p(t.lazy, li..<ri) else: t.lazy, t.r.sum)
        t.lazy = self.L0
      self.update(t)
    else:
      t
  
  proc merge*[RBST:RandomizedBinarySearchTree](self: var RBST, l, r:RBST.Node):auto =
    if l == nil: return r
    elif r == nil: return l
  #  when RBST.hasLazy:
    var (l, r) = (l, r)
#    if self.r.rand(l.cnt + r.cnt - 1) < l.cnt:
    if self.test(l.cnt + r.cnt, l.cnt):
      when RBST.hasLazy:
        l = self.propagate(l)
      l.r = self.merge(l.r, r)
      return self.update(l)
    else:
      when RBST.hasLazy:
        r = self.propagate(r)
      r.l = self.merge(l, r.l)
      return self.update(r)
  
  proc split*[RBST:RandomizedBinarySearchTree](self:var RBST, t:RBST.Node, k:int):(RBST.Node, RBST.Node) =
    if t == nil: return (t, t)
    var t = t
    when RBST.hasLazy:
      t = self.propagate(t)
    if k <= self.count(t.l):
      var s = self.split(t.l, k)
      t.l = s[1]
      return (s[0], self.update(t))
    else:
      var s = self.split(t.r, k - self.count(t.l) - 1)
      t.r = s[0]
      return (self.update(t), s[1])
  
  proc build*[RBST:RandomizedBinarySearchTree](self: var RBST, s:Slice[int], v:seq[RBST.D]):auto =
    let (l, r) = (s.a, s.b + 1)
    if l + 1 >= r: return self.alloc(v[l])
    var (x, y) = (self.build(l..<(l + r) shr 1, v), self.build((l + r) shr 1..<r, v))
    return self.merge(x, y)
  
  proc build*[RBST:RandomizedBinarySearchTree](self: var RBST, v:seq[RBST.D]) =
    self.root = self.build(0..<v.len, v)
  #  ptr = 0;
  #  return build(0, (int) v.size(), v);
  
  proc to_vec*[RBST:RandomizedBinarySearchTree](self: var RBST, r:RBST.Node, v:var seq[RBST.D], i:var int) =
    if r == nil: return
    when RBST.hasLazy:
      var r = r
      r = self.propagate(r)
    self.to_vec(r.l, v, i)
    v[i] = r.key
    i.inc
  #  *it = r.key;
    self.to_vec(r.r, v, i);
  
  proc to_vec*[RBST:RandomizedBinarySearchTree](self: var RBST, r:RBST.Node):auto =
    result = newSeq[RBST.D](self.count(r))
    var i = 0
    self.to_vec(r, result, i)
  
  proc to_string*[RBST:RandomizedBinarySearchTree](self: var RBST, r:RBST.Node):string =
    return self.to_vec(r).join(", ")
  
  proc write_tree*[RBST:RandomizedBinarySearchTree](self: var RBST, r:RBST.Node, h = 0) =
    if h == 0: echo "========== tree ======="
    if r == nil: return
    when RBST.hasLazy:
      var r = r
      r = self.propagate(r)
    for i in 0..<h: stdout.write "  "
    stdout.write r.id, ": ", r.key, ", ", r.sum
    when RBST.hasLazy:
      stdout.write ", ", r.lazy
    echo ""
    self.write_tree(r.l, h+1)
    self.write_tree(r.r, h+1)
    if h == 0: echo "========== end ======="
  
  proc insert*[RBST:RandomizedBinarySearchTree](self: var RBST, t:var RBST.Node, k:int, v:RBST.D) =
    var x = self.split(t, k)
    t = self.merge(self.merge(x[0], self.alloc(v)), x[1]);
  
  proc erase*[RBST:RandomizedBinarySearchTree](self: var RBST, t:var RBST.Node, k:int) =
    var x = self.split(t, k)
    t = self.merge(x[0], self.split(x[1], 1)[1])
  
  proc prod*[RBST:RandomizedBinarySearchTree](self: var RBST, t:var RBST.Node, p:Slice[int]):auto =
    let (a, b) = p.halfOpenEndpoints
    var
      x = self.split(t, a)
      y = self.split(x[1], b - a)
    result = self.sum(y[0])
    var m = self.merge(y[0], y[1])
    t = self.merge(x[0], m)
  
  proc apply*[RBST:RandomizedBinarySearchTree](self:var RBST, t:var RBST.Node, s:Slice[int], p:RBST.L) =
    static: assert RBST.hasLazy
    let (a, b) = s.halfOpenEndpoints
    var
      x = self.split(t, a)
      y = self.split(x[1], b - a)
    y[0].lazy = RBST.calc_composition(p, y[0].lazy)
    var m = self.merge(self.propagate(y[0]), y[1])
    t = self.merge(x[0], m)
  
  proc set*[RBST:RandomizedBinarySearchTree](self: var RBST, t:var RBST.Node, k:int, x:RBST.D) =
    when RBST.hasLazy:
      t = self.propagate(t)
    if k < self.count(t.l): self.set(t.l, k, x)
    elif k == self.count(t.l):
      t.key = x
      t.sum = x
    else: self.set(t.r, k - self.count(t.l) - 1, x)
    t = self.update(t)
  
  proc len*[RBST:RandomizedBinarySearchTree](self: var RBST, t:RBST.Node):auto = self.count(t)
  proc empty*[RBST:RandomizedBinarySearchTree](self: var RBST, t:RBST.Node):bool = return t == nil
  proc makeset*[RBST:RandomizedBinarySearchTree](self: var RBST):RBST.Node = nil 


  proc insert*[RBST:RandomizedBinarySearchTree](self: var RBST, k:int, v:RBST.D) = self.insert(self.root, k, v)
  proc erase*[RBST:RandomizedBinarySearchTree](self: var RBST, k:int) = self.erase(self.root, k)
  proc prod*[RBST:RandomizedBinarySearchTree](self: var RBST, p:Slice[int]):auto = self.prod(self.root, p)
  proc `[]`*[RBST:RandomizedBinarySearchTree](self: var RBST, p:Slice[int]):auto = self.prod(self.root, p)
  proc apply*[RBST:RandomizedBinarySearchTree](self:var RBST, s:Slice[int], p:RBST.L) = self.apply(self.root, s, p)
  proc set*[RBST:RandomizedBinarySearchTree](self: var RBST, k:int, x:RBST.D) = self.set(self.root, k, x)
  proc `[]=`*[RBST:RandomizedBinarySearchTree](self: var RBST, k:int, x:RBST.D) = self.set(self.root, k, x)
  proc len*[RBST:RandomizedBinarySearchTree](self: var RBST):auto = self.len(self.root)
  proc empty*[RBST:RandomizedBinarySearchTree](self: var RBST):bool = self.empty(self.root)
  {.pop.}




