when not declared ATCODER_SPLAY_TREE_HPP:
  {.push inline.}
  const ATCODER_SPLAY_TREE_HPP* = 1

  import atcoder/rangeutils

  type useRev = int
  type useSum = int

  template hasLazy(self:typedesc):bool = self.L isnot void

  type SplayTreeNode*[D, L, hasRev, hasSum] = ref object
    cnt*:int
    l*, r*, p*: SplayTreeNode[D, L, hasRev, hasSum]
    key*:D
    id*:int
    when hasSum isnot void:
      sum*:D
    when hasRev isnot void:
      rev*:bool
    when L isnot void:
      lazy*:L

  type SplayTreeType*[D, L, Node, hasRev, hasSum; p:static[tuple]] = object of RootObj
    root*, leaf*:Node
    id_max*:int
    M1:D
    when L isnot void:
      OM0:L
  type SplayTree*[D] = SplayTreeType[D, void, SplayTreeNode[D, void, void, void], void, void, ()]
  type SomeSplayTree* = SplayTreeType or SplayTree

  template calc_op[ST:SomeSplayTree](self:typedesc[ST], a, b:ST.D):auto =
    block:
      let op = ST.p.op
      op(a, b)
  template calc_mapping[ST:SomeSplayTree](self:typedesc[ST], a:ST.L, b:ST.D, c:untyped):auto =
    block:
      let mapping = ST.p.mapping
      when ST.p.p == nil:
        mapping(a, b)
      else:
        let p = ST.p.p
        mapping(p(a, c), b)
  template calc_composition[ST:SomeSplayTree](self:typedesc[ST], a, b:ST.L):auto =
    block:
      let composition = ST.p.composition
      composition(a, b)
  template calc_s[ST:SomeSplayTree](self:typedesc[ST], a:ST.D):auto =
    block:
      let s = ST.p.s
      s(a)

  proc initNode*[ST:SomeSplayTree](self:var ST, key:ST.D):auto =
    type 
      D = ST.D
      L = ST.L
      hasRev = ST.hasRev
      hasSum = ST.hasSum
    result = SplayTreeNode[D, L, hasRev, hasSum](key:key, l:self.leaf,r:self.leaf,p:nil,cnt:1,id:self.id_max)
    self.id_max.inc
    when hasRev isnot void: result.rev = false
    when hasSum isnot void: result.sum = key
    when L isnot void: result.lazy = self.OM0
  proc initNode*[ST:SomeSplayTree](self:var ST):auto = ST.initNode(ST.D(0))

  proc init*[ST:SomeSplayTree](self: var ST, root: ST.Node = nil, leaf:ST.Node = nil) =
    var leaf = leaf
    if leaf == nil:
      # leaf
      leaf = ST.Node(cnt:0, p:nil, id: -1)
      leaf.l = leaf;leaf.r = leaf
      when ST.hasSum isnot void:
        leaf.sum = self.M1
      when ST.hasLazy:
        leaf.lazy = self.OM0
    self.leaf = leaf
    if root == nil:
      self.root = self.leaf
    else:
      self.root = root
      self.root.l = self.leaf
      self.root.r = self.leaf
    self.root.p = nil
    self.id_max = 0

  proc init*[ST:SomeSplayTree](self: typedesc[ST], root: ST.Node = nil):ST =
    result = ST()
    result.init(root)

  template getSplayTreeType*(D, L, hasRev, hasSum; p:static[tuple]):typedesc =
    type Node = SplayTreeNode[D, L, hasRev, hasSum]
    SplayTreeType[D, L, Node, hasRev, hasSum, p]

  proc initSplayTree*[D]():auto =
    getSplayTreeType(D, void, void, void, ()).init()
  proc initSplayTree*[D](f:static[proc(a, b:D):D], M1:D):auto =
    result = getSplayTreeType(D, void, void, useSum, (op:f)).init()
    result.M1 = M1
  proc initReversibleSplayTree*[D](f:static[proc(a, b:D):D], s:static[proc(a:D):D], M1:D):auto =
    result = getSplayTreeType(D, void, useRev, useSum, (op:f, s:s)).init()
    result.M1 = M1
  proc initReversibleSplayTree*[D](f:static[proc(a, b:D):D], M1:D):auto =
    proc s(a:D):D = a
    return initReversibleSplayTree[D](f, s, M1)
  proc initLazyReversibleSplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], s:static[proc(a:D):D], M1:D, OM0:L):auto =
    result = getSplayTreeType(D, L, useRev, useSum, (op:f, mapping:g, composition:h, s:s, p:nil)).init()
    result.M1 = M1
    result.OM0 = OM0
  proc initLazyReversibleSplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], M1:D, OM0:L):auto =
    proc s(a:D):D = a
    return initLazyReversibleSplayTree(f, g, h, s, M1, OM0)
  proc initLazySplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], pp:static[proc(a:L, c:int):L], M1:D, OM0:L):auto =
    result = getSplayTreeType(D, L, void, useSum, (op:f, mapping:g, composition:h, p:pp)).init()
    result.M1 = M1
    result.OM0 = OM0
  proc initLazySplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], M1:D, OM0:L):auto =
    initLazySplayTree[D, L](f, g, h, nil, M1, OM0)

  proc is_root*[T:SomeSplayTree](self:T, t:T.Node):bool =
    return t.p == nil or (t.p.l != t and t.p.r != t)
  
#  proc count*[T:SomeSplayTree](self:T, t:T.Node):int = return if t != nil: t.len else: 0
  proc count*[T:SomeSplayTree](self:T, t:T.Node):int = t.cnt
  proc count*[T:SomeSplayTree](self:T):int = self.count(self.root)

  proc update*[T:SomeSplayTree](self:T, t:T.Node):auto {.discardable.} =
    t.cnt = 1
    when T.hasSum isnot void:
      t.sum = t.key
    if t.l != self.leaf:
      t.cnt += t.l.cnt
      when T.hasSum isnot void: t.sum = T.calc_op(t.l.sum, t.sum)
    if t.r != self.leaf:
      t.cnt += t.r.cnt
      when T.hasSum isnot void: t.sum = T.calc_op(t.sum, t.r.sum)
    return t

  proc propagate*[T:SomeSplayTree](self:T, t:T.Node, x:T.L) =
    static: assert T.L isnot void
    t.key = T.calc_mapping(x, t.key, 1)
    when T.hasSum isnot void: t.sum = T.calc_mapping(x, t.sum, self.count(t))
    t.lazy = T.calc_composition(x, t.lazy)

  proc toggle*[T:SomeSplayTree](self:T, t:T.Node) =
    static: assert T.hasRev isnot void
    swap(t.l, t.r)
    when T.hasSum isnot void: t.sum = T.calc_s(t.sum)
    t.rev = not t.rev

  proc push*[T:SomeSplayTree](self:T, t:T.Node) =
    when T.hasLazy:
      if t.lazy != self.OM0:
        if t.l != self.leaf: self.propagate(t.l, t.lazy)
        if t.r != self.leaf: self.propagate(t.r, t.lazy)
        t.lazy = self.OM0
    when T.hasRev isnot void:
      if t.rev:
        if t.l != self.leaf: self.toggle(t.l)
        if t.r != self.leaf: self.toggle(t.r)
        t.rev = false

  proc rotr*[T:SomeSplayTree](self:T, t:T.Node) =
    var
      x = t.p
      y = x.p
      t = t
    x.l = t.r
    if x.l != self.leaf: t.r.p = x
    t.r = x; x.p = t
    self.update(x); self.update(t)
    t.p = y
    if t.p != nil:
      if y.l == x: y.l = t
      if y.r == x: y.r = t
      self.update(y)

  proc rotl*[T:SomeSplayTree](self:T, t:T.Node) =
    var
      x = t.p
      y = x.p
      t = t
    x.r = t.l
    if x.r != self.leaf: t.l.p = x
    t.l = x; x.p = t;
    self.update(x);self.update(t)
    t.p = y
    if t.p != nil:
      if y.l == x: y.l = t
      if y.r == x: y.r = t
      self.update(y)

  proc splay*[T:SomeSplayTree](self:T, t:T.Node) =
    self.push(t)
    while not self.is_root(t):
      var q = t.p
      if self.is_root(q):
        self.push(q); self.push(t)
        if q.l == t: self.rotr(t)
        else: self.rotl(t)
      else:
        var r = q.p
        self.push(r); self.push(q); self.push(t)
        if r.l == q:
          if q.l == t: self.rotr(q); self.rotr(t)
          else: self.rotl(t); self.rotr(t)
        else:
          if q.r == t: self.rotl(q); self.rotl(t)
          else: self.rotr(t); self.rotl(t)

  proc get_left*[T:SomeSplayTree](self:T, t:T.Node):T.Node =
    var t = t
    while true:
      self.push(t)
      if t.l == self.leaf: break
      t = t.l
    return t
  
  proc get_right*[T:SomeSplayTree](self:T, t:T.Node):T.Node =
    var t = t
    while true:
      self.push(t)
      if t.r == self.leaf: break
      t = t.r
    return t
  
  proc erase*[T:SomeSplayTree](self:T, root:T.Node, t:T.Node, return_right:static[bool] = true):T.Node =
    var t = t
    self.splay(t)
    var (x, y) = (t.l, t.r)
  # TODO
  # delete t
    if x == self.leaf:
      t = y
      if t != self.leaf: t.p = nil
    elif y == self.leaf:
      t = x
      t.p = nil
    else:
      x.p = nil
      t = self.get_right(x)
      self.splay(t)
      t.r = y
      y.p = t
      self.update(t)
    swap(root, t)
    return root

  proc getNodeImpl*[T:SomeSplayTree](self:T, t:var T.Node, k:int):T.Node {.discardable.} =
    self.push(t)
    if k < self.count(t.l):
      return self.getNodeImpl(t.l, k)
    elif k == self.count(t.l):
#      self.splay(t)
      return t
    else:
      return self.getNodeImpl(t.r, k - self.count(t.l) - 1)

  proc get_node*[T:SomeSplayTree](self: T, t:var T.Node, k:int):T.Node =
    self.splay(t)
#    doAssert 0 <= k and k < self.count(t)
    result = self.getNodeImpl(t, k)
    self.splay(result)
#    self.update(result)

# original
#  proc split*[T:SomeSplayTree](self: T, t:T.Node, k:int):(T.Node, T.Node) =
#    if t == nil: return (nil, nil)
#    self.push(t)
#    if k <= self.count(t.l):
#      var x = self.split(t.l, k)
#      t.l = x[1]
#      t.p = nil
#      if x[1] != nil: x[1].p = t
#      return (x[0], self.update(t))
#    else:
#      var x = self.split(t.r, k - self.count(t.l) - 1);
#      t.r = x[0]
#      t.p = nil
#      if x[0] != nil: x[0].p = t
#      return (self.update(t), x[1])


#   get_node-based

  proc split*[T:SomeSplayTree](self: T, t:T.Node):(T.Node, T.Node) =
    if t == self.leaf: return (self.leaf, self.leaf)
    var t = t
    self.splay(t)
    var p = t.l
    if t.l != self.leaf:
      t.l.p = nil
      t.l = self.leaf
#    if p != self.leaf: self.update(p)
    if t != self.leaf: self.update(t)
    return (p, t)

  proc split_index*[T:SomeSplayTree](self: T, t:T.Node, k:int):(T.Node, T.Node) =
    if t == self.leaf: return (self.leaf, self.leaf)
    if k < 0:
      return (self.leaf, t)
    elif self.count(t) <= k:
      return (t, self.leaf)
    var t = t
    t = self.getNode(t, k)
    return self.split(t)

    ##    assert u != self.leaf
    #    self.splay(t)
    #    var p = t.l
    #    if t.l != self.leaf:
    #      t.l.p = nil
    #      t.l = self.leaf
    ##    if p != self.leaf: self.update(p)
    #    if t != self.leaf: self.update(t)
    #    return (p, t)

  proc merge*[T:SomeSplayTree](self:T, rest:varargs[T.Node]):T.Node =
    var l = rest[0]
    if rest.len == 1: return l
    var r = self.merge(rest[1 .. ^1])
    if l == self.leaf and r == self.leaf: return self.leaf
    if l == self.leaf: self.splay(r); return r
    if r == self.leaf: self.splay(l); return l
    self.splay(l); self.splay(r)
    l = self.get_right(l)
    self.splay(l)
    l.r = r
    r.p = l
    self.update(l)
    return l
  
  proc split_index3*[T:SomeSplayTree](self: T, t:T.Node, a, b:int):(T.Node, T.Node, T.Node) =
    self.splay(t)
    var
      x = self.split_index(t, a)
      y = self.split_index(x[1], b - a)
    return (x[0], y[0], y[1])

  proc reverse*[T:SomeSplayTree](self:var T, p: Slice[int]) =
    static: assert T.hasRev isnot void
    let
      l = p.a
      r = p.b + 1
    var (a0, a1, a2) = self.split_index3(self.root, l, r)
    self.toggle(a1)
    self.root = self.merge(self.merge(a0, a1), a2)

  proc build_node*[T:SomeSplayTree](self:var T, l, r:int, v:seq[T.Node]):T.Node =
    if l + 1 >= r: return v[l]
    return self.merge(self.build_node(l, (l + r) shr 1, v), self.build_node((l + r) shr 1, r, v))
  
  proc build_node*[T:SomeSplayTree](self:var T, v:seq[T.Node]):T.Node =
    return self.build_node(0, v.len, v)
  
  proc push_front_node*[T:SomeSplayTree](self:var T, t:var T.Node, z:T.Node) =
    if t != self.leaf:
      self.splay(t)
      var cur = self.get_left(t)
      self.splay(cur)
      z.p = cur
      cur.l = z
      self.splay(z)
    t = z

  proc push_back_node*[T:SomeSplayTree](self:var T, t:var T.Node, z:T.Node) =
    if t != self.leaf:
      self.splay(t)
      var cur = self.get_right(t)
      self.splay(cur)
      z.p = cur
      cur.r = z
      self.splay(z)
    t = z

  proc insert_node_index*[T:SomeSplayTree](self:var T, t:var T.Node, k:int, v:T.Node) =
    self.splay(t)
    var x = self.split_index(t, k)
    t = self.merge(self.merge(x[0], v), x[1])

  proc insert*[T:SomeSplayTree](self: var T, t:var T.Node, next:T.Node, v:T.D):T.Node =
    result = self.initNode(v)
#    self.splay(t)
    var x = self.split(next)
    t = self.merge(self.merge(x[0], result), x[1])


  proc erase_index*[T:SomeSplayTree](self: T, t:var T.Node, k:int) =
    self.splay(t)
    var
      x = self.split_index(t, k)
      y = self.split_index(x[1], 1)
    # TODO
  #  delete y[0]
    t = self.merge(x[0], y[1])

  proc sum*[T:SomeSplayTree](self:T, t:T.Node):auto =
    static: assert T.hasSum isnot void
    return t.sum

  proc alloc*[T:SomeSplayTree](self:var T, x:T.D):auto =
    return self.initNode(x)
  
  proc prod*[T:SomeSplayTree](self:T, t:var T.Node, s:Slice[int]):T.D =
    let (a, b) = self.halfOpenEndpoints(s)
    self.splay(t)
    var x = self.split_index(t, a)
    var y = self.split_index(x[1], b - a)
    var ret = self.sum(y[0])
    t = self.merge(x[0], y[0], y[1])
    return ret
  
  proc build*[T:SomeSplayTree](self:var T, t:var T.Node, v:seq[T.D]) =
    if v.len == 0: return
    var vs = newSeq[T.Node](v.len)
    for i in 0..<v.len: vs[i] = self.initNode(v[i])
    t = self.build_node(vs)

  proc set*[T:SomeSplayTree](self:var T, t:var T.Node, k:int, x:T.D) =
    self.splay(t)
    let r = self.setImpl(t, k, x)
    self.root = r

  proc push_front*[T:SomeSplayTree](self:var T, t:var T.Node, x:T.D) =
    self.push_front_node(t, self.initNode(x))
  
  proc push_back*[T:SomeSplayTree](self:var T, t:var T.Node, x:T.D) =
    self.push_back_node(t, self.initNode(x))
  
  proc insert_index*[T:SomeSplayTree](self:var T, t:var T.Node, k:int, x:T.D) =
    self.insert_node_index(t, k, self.initNode(x))

  proc apply_all*[T:SomeSplayTree](self:T, t:var T.Node, pp:T.L) =
    static: assert T.L isnot void
    self.splay(t)
    self.propagate(t, pp)
    self.push(t)

  proc apply*[T:SomeSplayTree](self:T, t:var T.Node, s:Slice[int], pp:T.L) =
    static: assert T.L isnot void
    let (a, b) = self.halfOpenEndpoints(s)
    self.splay(t)
    var
      x = self.split_index(t, a)
      y = self.split_index(x[1], b - a)
    self.apply_all(y[0], pp)
    t = self.merge(x[0], y[0], y[1])

  proc write_treeImpl*[T:SomeSplayTree](self:T, t:T.Node, h = 0) =
    if h > 10:
      echo "too deep!!!!!!!!!!!!!!"
      return
    for i in 0..<h:
      stdout.write("  ")
    if t == self.leaf:
      echo "*"
    else:
#      assert t.id != -1
      echo t.key, " ", t.id, " ", t.cnt
      self.write_treeImpl(t.l, h + 1)
      self.write_treeImpl(t.r, h + 1)
  proc write_tree*[T:SomeSplayTree](self:T, t:T.Node) =
    echo "==== tree ===== "
    self.write_treeImpl(t)
  proc write_tree*[T:SomeSplayTree](self:T) =
    self.write_tree(self.root)

  proc setImpl*[T:SomeSplayTree](self:T, t: T.Node, k:int, x:T.D):T.Node {.discardable.} =
    self.push(t)
    if k < self.count(t.l):
      return self.setImpl(t.l, k, x)
    elif k == self.count(t.l):
      t.key = x
      self.splay(t)
      return t
    else:
      return self.setImpl(t.r, k - self.count(t.l) - 1, x)

  proc check_tree*[T:SomeSplayTree](self:T):void = discard

  proc erase_index*[T:SomeSplayTree](self:var T, t:T.Node) = self.erase_index(self.root, t)
  proc erase_index*[T:SomeSplayTree](self: var T, k:int) = self.erase_index(self.root, k)
  proc erase*[T:SomeSplayTree](self:var T, t:T.Node, return_right:static[bool] = true):T.Node =
    self.erase(self.root, t, return_right)
  proc get_node*[T:SomeSplayTree](self:var T, k:int):T.Node =
    result = self.get_node(self.root, k)
    self.root = result
  proc get*[T:SomeSplayTree](self:var T, k:int):T.D = self.get_node(k).key
  proc `[]`*[T:SomeSplayTree](self:var T, k:int):T.D = self.get_node(k).key
  proc set*[T:SomeSplayTree](self:var T, k:int, x:T.D) = self.set(self.root, k, x)
  proc `[]=`*[T:SomeSplayTree](self:var T, k:int, x:T.D) = self.set(self.root, k, x)
  proc push_front*[T:SomeSplayTree](self: var T, z:T.D) = self.push_front(self.root, z)
  proc push_back*[T:SomeSplayTree](self: var T, z:T.D) = self.push_back(self.root, z)
  proc insert_index*[T:SomeSplayTree](self:var T, k:int, x:T.D) = self.insert_index(self.root, k, x)
  proc insert*[T:SomeSplayTree](self: var T, next:T.Node, v:T.D):T.Node = self.insert(self.root, next, v)
  proc build*[T:SomeSplayTree](self:var T, v:seq[T.D]) = self.build(self.root, v)
  proc apply_all*[T:SomeSplayTree](self:var T, pp:T.L) = self.apply_all(self.root, pp)
  proc apply*[T:SomeSplayTree](self:var T, s:Slice[int], pp:T.L) = self.apply(self.root, s, pp)
  proc prod*[T:SomeSplayTree](self:var T, s:Slice[int]):T.D = self.prod(self.root, s)
  proc `[]`*[T:SomeSplayTree](self:var T, s:Slice[int]):T.D = self.prod(self.root, s)

  # TODO: toSeqを呼ぶとcntが書き換わる -> get_nodeでsplayやるのでself.rootを書き換えないといけない
  proc toSeq*[T:SomeSplayTree](self:var T):seq[T.D] =
    let c = self.count
    result = newSeq[T.D](c)
    for i in 0 ..< c:
      when true:
        let u = self.get(i)
      else:
        var (a0, a1, a2) = self.split_index3(self.root, i, i + 1)
        let u = a1.key
        self.root = self.merge(self.merge(a0, a1), a2)
      result[i] = u
  {.pop.}
