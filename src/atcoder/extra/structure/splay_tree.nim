when not declared ATCODER_SPLAY_TREE_HPP:
  {.push inline.}
  const ATCODER_SPLAY_TREE_HPP* = 1

  import atcoder/rangeutils

  template hasLazy(self:typedesc):bool = self.L isnot void

  type SplayTreeNode*[D, L; hasRev, hasSum:static[bool]] = ref object
    sz*:int
    l*, r*, p*: SplayTreeNode[D, L, hasRev, hasSum]
    key*:D
    when hasSum:
      sum*:D
    when hasRev:
      rev*:bool
    when L isnot void:
      lazy*:L

  type SplayTree*[D, L, Node; hasRev, hasSum:static[bool]; p:static[tuple]] = object of RootObj
    root*:Node
    M1:D
    when L isnot void:
      OM0:L

  template calc_op[ST:SplayTree](self:typedesc[ST], a, b:ST.D):auto =
    block:
      let op = ST.p.op
      op(a, b)
  template calc_mapping[ST:SplayTree](self:typedesc[ST], a:ST.L, b:ST.D):auto =
    block:
      let mapping = ST.p.mapping
      mapping(a, b)
  template calc_composition[ST:SplayTree](self:typedesc[ST], a, b:ST.L):auto =
    block:
      let composition = ST.p.composition
      composition(a, b)
  template calc_s[ST:SplayTree](self:typedesc[ST], a:ST.D):auto =
    block:
      let s = ST.p.s
      s(a)

  proc initNode*[ST:SplayTree](self:ST, key:ST.D):auto =
    type 
      D = ST.D
      L = ST.L
    const
      hasRev = ST.hasRev
      hasSum = ST.hasSum
    result = SplayTreeNode[D, L, hasRev, hasSum](key:key, l:nil,r:nil,p:nil,sz:1)
    when hasRev: result.rev = false
    when hasSum: result.sum = key
    when L isnot void: result.lazy = self.OM0
  proc initNode*[ST:SplayTree](self:ST):auto = ST.initNode(ST.D(0))

  template getSplayTreeType(D, L:typedesc, hasRev, hasSum:static[bool]; p:static[tuple]):typedesc =
    type Node = SplayTreeNode[D, L, hasRev, hasSum]
    SplayTree[D, L, Node, hasRev, hasSum, p]

  proc initSplayTree*[D]():auto =
    getSplayTreeType(D, void, false, false, ())(root:nil)
  proc initSplayTree*[D](f:static[proc(a, b:D):D], M1:D):auto =
    getSplayTreeType(D, void, false, true, (op:f))(root:nil, M1:M1)
  proc initReversibleSplayTree*[D](f:static[proc(a, b:D):D], s:static[proc(a:D):D], M1:D):auto =
    getSplayTreeType(D, void, true, true, (op:f, s:s))(root:nil, M1:M1)
  proc initReversibleSplayTree*[D](f:static[proc(a, b:D):D], M1:D):auto =
    proc s(a:D):D = a
    return initReversibleSplayTree[D](f, s, M1)
  proc initLazyReversibleSplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], s:static[proc(a:D):D], M1:D, OM0:L):auto =
    getSplayTreeType(D, L, true, true, (op:f, mapping:g, composition:h, s:s))(root:nil, M1:M1, OM0:OM0)
  proc initLazyReversibleSplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], M1:D, OM0:L):auto =
    proc s(a:D):D = a
    return initLazyReversibleSplayTree(f, g, h, s, M1, OM0)
  proc initLazySplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], M1:D, OM0:L):auto =
    getSplayTreeType(D, L, false, true, (op:f, mapping:g, composition:h))(root:nil, M1:M1, OM0:OM0)

  proc is_root*[T:SplayTree](self:T, t:T.Node):bool =
    return t.p == nil or (t.p.l != t and t.p.r != t)
  
  proc count*[T:SplayTree](self:T, t:T.Node):int = return if t != nil: t.sz else: 0

  proc update*[T:SplayTree](self:T, t:T.Node):auto {.discardable.} =
    t.sz = 1
    when T.hasSum:
      t.sum = t.key
      if t.l != nil: t.sz += t.l.sz; t.sum = T.calc_op(t.l.sum, t.sum)
      if t.r != nil: t.sz += t.r.sz; t.sum = T.calc_op(t.sum, t.r.sum)
    return t

  proc propagate*[T:SplayTree](self:T, t:T.Node, x:T.L) =
    static: assert T.L isnot void
    t.key = T.calc_mapping(x, t.key)
    when T.hasSum: t.sum = T.calc_mapping(x, t.sum)
    t.lazy = T.calc_composition(x, t.lazy)

  proc toggle*[T:SplayTree](self:T, t:T.Node) =
    static: assert T.hasRev
    swap(t.l, t.r)
    when T.hasSum: t.sum = T.calc_s(t.sum)
    t.rev = not t.rev

  proc push*[T:SplayTree](self:T, t:T.Node) =
    when T.hasLazy:
      if t.lazy != self.OM0:
        if t.l != nil: self.propagate(t.l, t.lazy)
        if t.r != nil: self.propagate(t.r, t.lazy)
        t.lazy = self.OM0
    when T.hasRev:
      if t.rev:
        if t.l != nil: self.toggle(t.l)
        if t.r != nil: self.toggle(t.r)
        t.rev = false

  proc rotr*[T:SplayTree](self:T, t:T.Node) =
    var
      x = t.p
      y = x.p
      t = t
    x.l = t.r
    if x.l != nil: t.r.p = x
    t.r = x; x.p = t
    self.update(x); self.update(t)
    t.p = y
    if t.p != nil:
      if y.l == x: y.l = t
      if y.r == x: y.r = t
      self.update(y)

  proc rotl*[T:SplayTree](self:T, t:T.Node) =
    var
      x = t.p
      y = x.p
      t = t
    x.r = t.l
    if x.r != nil: t.l.p = x
    t.l = x; x.p = t;
    self.update(x);self.update(t)
    t.p = y
    if t.p != nil:
      if y.l == x: y.l = t
      if y.r == x: y.r = t
      self.update(y)

  proc splay*[T:SplayTree](self:T, t:T.Node) =
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
  
  proc get_left*[T:SplayTree](self:T, t:T.Node):T.Node =
    var t = t
    while t.l != nil: t = t.l
    return t
  
  proc get_right*[T:SplayTree](self:T, t:T.Node):T.Node =
    var t = t
    while t.r != nil: t = t.r
    return t
  
  proc erase*[T:SplayTree](self:T, root:var T.Node, t:T.Node) =
    var t = t
    self.splay(t)
    var (x, y) = (t.l, t.r)
  # TODO
  # delete t
    if x == nil:
      t = y
      if t != nil: t.p = nil
    elif y == nil:
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

  proc get_node*[T:SplayTree](self:T, t:var T.Node, k:int):T.Node =
    self.splay(t)
#    doAssert 0 <= k and k < self.count(t)
    result = self.sub_get_node(t, k)
    self.splay(result)
#    self.update(result)

# original
#  proc split*[T:SplayTree](self: T, t:T.Node, k:int):(T.Node, T.Node) =
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
  proc split*[T:SplayTree](self: T, t:T.Node, k:int):(T.Node, T.Node) =
    if t == nil: return (nil, nil)
    if k < 0:
      return (nil, t)
    elif self.count(t) <= k:
      return (t, nil)
    var t = t
    t = self.get_node(t, k)
#    assert u != nil
    self.splay(t)
    var p = t.l
    if t.l != nil:
      t.l.p = nil
      t.l = nil
#    if p != nil: self.update(p)
    if t != nil: self.update(t)
    return (p, t)

  proc merge*[T:SplayTree](self:T, rest:varargs[T.Node]):T.Node =
    var l = rest[0]
    if rest.len == 1: return l
    var r = self.merge(rest[1 .. ^1])
    if l == nil and r == nil: return nil
    if l == nil: self.splay(r); return r
    if r == nil: self.splay(l); return l
    self.splay(l); self.splay(r)
    l = self.get_right(l)
    self.splay(l)
    l.r = r
    r.p = l
    self.update(l)
    return l
  
  proc split3*[T:SplayTree](self: T, t:T.Node, a, b:int):(T.Node, T.Node, T.Node) =
    self.splay(t)
    var
      x = self.split(t, a)
      y = self.split(x[1], b - a)
    return (x[0], y[0], y[1])
  
  proc build_node*[T:SplayTree](self: T, l, r:int, v:seq[T.Node]):T.Node =
    if l + 1 >= r: return v[l]
    return self.merge(self.build_node(l, (l + r) shr 1, v), self.build_node((l + r) shr 1, r, v))
  
  proc build_node*[T:SplayTree](self: T, v:seq[T.Node]):T.Node =
    return self.build_node(0, v.len, v)
  
  proc push_front_node*[T:SplayTree](self: T, t:var T.Node, z:T.Node) =
    if t != nil:
      self.splay(t)
      var cur = self.get_left(t)
      self.splay(cur)
      z.p = cur
      cur.l = z
      self.splay(z)
    t = z

  proc push_back_node*[T:SplayTree](self: T, t:var T.Node, z:T.Node) =
    if t != nil:
      self.splay(t)
      var cur = self.get_right(t)
      self.splay(cur)
      z.p = cur
      cur.r = z
      self.splay(z)
    t = z

  proc insert_node*[T:SplayTree](self: T, t:var T.Node, k:int, v:T.Node) =
    self.splay(t)
    var x = self.split(t, k)
    t = self.merge(self.merge(x[0], v), x[1])
  
  proc erase*[T:SplayTree](self: T, t:var T.Node, k:int) =
    self.splay(t)
    var
      x = self.split(t, k)
      y = self.split(x[1], 1)
    # TODO
  #  delete y[0]
    t = self.merge(x[0], y[1])

  proc sum*[T:SplayTree](self:T, t:T.Node):auto =
    static: assert T.hasSum
    return if t != nil: t.sum else: self.M1
  proc alloc*[T:SplayTree](self:T, x:T.D):auto =
    return self.initNode(x)
  
  proc prod*[T:SplayTree](self:T, t:var T.Node, s:Slice[int]):T.D =
    let (a, b) = s.halfOpenEndpoints
    self.splay(t)
    var x = self.split(t, a)
    var y = self.split(x[1], b - a)
    var ret = self.sum(y[0])
    t = self.merge(x[0], y[0], y[1])
    return ret
  
  proc build*[T:SplayTree](self:T, t:var T.Node, v:seq[T.D]) =
    var vs = newSeq[T.Node](v.len)
    for i in 0..<v.len: vs[i] = self.initNode(v[i])
    t = self.build_node(vs)

  proc set*[T:SplayTree](self:T, t:var T.Node, k:int, x:T.D) =
    self.splay(t)
    self.setImpl(t, k, x)

  proc push_front*[T:SplayTree](self:T, t:var T.Node, x:T.D) =
    self.push_front_node(t, self.initNode(x))
  
  proc push_back*[T:SplayTree](self:T, t:var T.Node, x:T.D) =
    self.push_back_node(t, self.initNode(x))
  
  proc insert*[T:SplayTree](self:T, t:var T.Node, k:int, x:T.D) =
    self.insert_node(t, k, self.initNode(x))

  proc apply_all*[T:SplayTree](self:T, t:var T.Node, pp:T.L) =
    static: assert T.L isnot void
    self.splay(t)
    self.propagate(t, pp)
    self.push(t)

  proc apply*[T:SplayTree](self:T, t:var T.Node, s:Slice[int], pp:T.L) =
    static: assert T.L isnot void
    let (a, b) = s.halfOpenEndpoints
    self.splay(t)
    var
      x = self.split(t, a)
      y = self.split(x[1], b - a)
    self.apply_all(y[0], pp)
    t = self.merge(x[0], y[0], y[1])

  proc write_tree*[T:SplayTree](self:T, t:T.Node, h = 0) =
    if h > 10:return
    for i in 0..<h:
      stdout.write("  ")
    if t == nil:
      echo "*"
    else:
      echo t.key
      self.write_tree(t.l, h + 1)
      self.write_tree(t.r, h + 1)

  proc setImpl*[T:SplayTree](self:T, t:var T.Node, k:int, x:T.D):T.Node {.discardable.} =
    self.push(t)
    if k < self.count(t.l):
      return self.setImpl(t.l, k, x)
    elif k == self.count(t.l):
      t.key = x
      self.splay(t)
      return t
    else:
      return self.setImpl(t.r, k - self.count(t.l) - 1, x)

  proc sub_get_node*[T:SplayTree](self:T, t:var T.Node, k:int):T.Node {.discardable.} =
    self.push(t)
    if k < self.count(t.l):
      return self.sub_get_node(t.l, k)
    elif k == self.count(t.l):
#      self.splay(t)
      return t
    else:
      return self.sub_get_node(t.r, k - self.count(t.l) - 1)


  proc erase*[T:SplayTree](self:var T, t:T.Node) = self.erase(self.root, t)
  proc erase*[T:SplayTree](self: var T, k:int) = self.erase(self.root, k)
  proc get_node*[T:SplayTree](self:var T, k:int):T.Node = self.get_node(self.root, k)
  proc get*[T:SplayTree](self:var T, k:int):T.D = self.get_node(k).D
  proc `[]`*[T:SplayTree](self:var T, k:int):T.D = self.get_node(k).D
  proc set*[T:SplayTree](self:var T, k:int, x:T.D) = self.set(self.root, k, x)
  proc `[]=`*[T:SplayTree](self:var T, k:int, x:T.D) = self.set(self.root, k, x)
  proc push_front*[T:SplayTree](self: var T, z:T.D) = self.push_front(self.root, z)
  proc push_back*[T:SplayTree](self: var T, z:T.D) = self.push_back(self.root, z)
  proc insert*[T:SplayTree](self:var T, k:int, x:T.D) = self.insert(self.root, k, x)
  proc build*[T:SplayTree](self:var T, v:seq[T.D]) = self.build(self.root, v)
  proc apply_all*[T:SplayTree](self:var T, pp:T.L) = self.apply_all(self.root, pp)
  proc apply*[T:SplayTree](self:var T, s:Slice[int], pp:T.L) = self.apply(self.root, s, pp)
  proc prod*[T:SplayTree](self:var T, s:Slice[int]):T.D = self.prod(self.root, s)
  proc `[]`*[T:SplayTree](self:var T, s:Slice[int]):T.D = self.prod(self.root, s)
  {.pop.}
