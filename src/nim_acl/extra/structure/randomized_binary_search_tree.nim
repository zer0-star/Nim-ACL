# {{{ RandomizedBinarySearchTree
when not declared ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP:
  const ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP* = 1
  import std/sugar, std/random
  
  type RandomizedBinarySearchTree*[D,L,useP,updateData] = object of RootObj
    when D isnot void:
      f:(D,D)->D
      D0:D
    when L isnot void:
      h:(L,L)->L
      g:(D,L)->D
      L0:L
    when useP isnot void:
      p:(L,Slice[int])->L
    r:Rand
    id_max:int
  
  type Node*[D, L, updateData] = ref object
    cnt*:int
    l*,r*:Node[D, L, updateData]
    key*:D
    when updateData isnot void:
      sum*:D
    when L isnot void:
      lazy*:L
    id:int

  proc isUpdateData*(t:typedesc[RandomizedBinarySearchTree] or typedesc[Node]):bool {.compileTime.} = t.updateData isnot void
  #proc hasData*(t:typedesc):bool {.compileTime.} = t.D isnot void
  proc hasLazy*(t:typedesc):bool {.compileTime.} = t.L isnot void
  proc hasP*(t:typedesc):bool {.compileTime.} = t.useP isnot void
  #proc isPersistent*(t:typedesc):bool {.compileTime.} = t.Persistent isnot void


  proc initNode*[RBST:RandomizedBinarySearchTree](self:RBST, k:RBST.D, p:RBST.L, id:int):auto =
    result = Node[RBST.D, RBST.L, RBST.updateData](cnt:1, key:k, lazy:p, l:nil, r:nil, id:id)
    when RBST.isUpdateData: result.sum = k
  proc initNode*[RBST:RandomizedBinarySearchTree](self:RBST, k:RBST.D, id:int):auto =
    result = Node[RBST.D, RBST.L, RBST.updateData](cnt:1, key:k, l:nil, r:nil, id:id)
    when RBST.isUpdateData: result.sum = k
  
  #vector< Node > pool;
  #int ptr;
  proc initRandomizedBinarySearchTree*[D](seed = 2019):auto =
    RandomizedBinarySearchTree[D,void,void,void](r:initRand(seed), id_max:0)
  proc initRandomizedBinarySearchTree*[D](f:(D,D)->D, D0:D, seed = 2019):auto =
    RandomizedBinarySearchTree[D,void,void,int](f:f, D0:D0, r:initRand(seed), id_max: 0)
  proc initRandomizedBinarySearchTree*[D,L](f:(D,D)->D, g:(D,L)->D, h:(L,L)->L, D0:D, L0:L, seed = 2019):auto =
    RandomizedBinarySearchTree[D,L,void,int](f:f, g:g, h:h, D0:D0, L0:L0, r:initRand(seed), id_max: 0)
  proc initRandomizedBinarySearchTree*[D, L](f:(D,D)->D, g:(D,L)->D, h:(L,L)->L, p:(L,Slice[int])->L,D0:D,L0:L,seed = 2019):auto =
    RandomizedBinarySearchTree[D,L,int,int](f:f, g:g, h:h, p:p, D0:D0, L0:L0, r:initRand(seed), id_max: 0)
  
  proc alloc*[RBST](self: var RBST, key:RBST.D):auto =
    when RBST.hasLazy:
      result = self.initNode(key, self.L0, self.id_max)
    else:
      result = self.initNode(key, self.id_max)
    self.id_max.inc
  #  return &(pool[ptr++] = Node(key, self.L0));
  
  template clone*[D,L,updateData](t:Node[D, L, updateData]):auto = t
  
  proc count*[RBST:RandomizedBinarySearchTree](self: RBST, t:Node):auto = (if t != nil: t.cnt else: 0)
  proc sum*[RBST:RandomizedBinarySearchTree](self: RBST, t:Node):auto = (if t != nil: t.sum else: self.D0)
  
  template update*[RBST:RandomizedBinarySearchTree](self: RBST, t:var Node):Node =
    t.cnt = self.count(t.l) + self.count(t.r) + 1
    when RBST.isUpdateData:
      t.sum = self.f(self.f(self.sum(t.l), t.key), self.sum(t.r))
    t
  
  template propagate*[RBST:RandomizedBinarySearchTree](self: var RBST, t:Node):auto =
    when RBST.hasLazy:
      t = clone(t)
      if t.lazy != self.L0:
        when RBST.hasP:
          var
            li = 0
            ri = 0
        if t.l != nil:
          t.l = clone(t.l)
          t.l.lazy = self.h(t.l.lazy, t.lazy)
          when RBST.hasP: ri = li + self.count(t.l)
          t.l.sum = self.g(t.l.sum, when RBST.hasP: self.p(t.lazy, li..<ri) else: t.lazy)
        when RBST.hasP: li = ri
        t.key = self.g(t.key, when RBST.hasP: self.p(t.lazy, li..<li+1) else: t.lazy)
        when RBST.hasP: li.inc
        if t.r != nil:
          t.r = clone(t.r)
          t.r.lazy = self.h(t.r.lazy, t.lazy)
          when RBST.hasP: ri = li + self.count(t.r)
          t.r.sum = self.g(t.r.sum, when RBST.hasP: self.p(t.lazy, li..<ri) else: t.lazy)
        t.lazy = self.L0
      self.update(t)
    else:
      t
  
  proc merge*[RBST:RandomizedBinarySearchTree](self: var RBST, l, r:Node):auto =
    if l == nil: return r
    elif r == nil: return l
  #  when RBST.hasLazy:
    var (l, r) = (l, r)
    if self.r.rand(l.cnt + r.cnt - 1) < l.cnt:
      when RBST.hasLazy:
        l = self.propagate(l)
      l.r = self.merge(l.r, r)
      return self.update(l)
    else:
      when RBST.hasLazy:
        r = self.propagate(r)
      r.l = self.merge(l, r.l)
      return self.update(r)
  
  proc split*[RBST:RandomizedBinarySearchTree](self:var RBST, t:Node, k:int):(Node, Node) =
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
  
  proc build*[RBST:RandomizedBinarySearchTree](self: var RBST, v:seq[RBST.D]):auto =
    return self.build(0..<v.len, v);
  #  ptr = 0;
  #  return build(0, (int) v.size(), v);
  
  proc to_vec*[RBST:RandomizedBinarySearchTree](self: var RBST, r:Node, v:var seq[RBST.D], i:var int) =
    if r == nil: return
    when RBST.hasLazy:
      var r = r
      r = self.propagate(r)
    self.to_vec(r.l, v, i)
    v[i] = r.key
    i.inc
  #  *it = r.key;
    self.to_vec(r.r, v, i);
  
  proc to_vec*[RBST:RandomizedBinarySearchTree](self: var RBST, r:Node):auto =
    result = newSeq[RBST.D](self.count(r))
    var i = 0
    self.to_vec(r, result, i)
  
  proc to_string*[RBST:RandomizedBinarySearchTree](self: var RBST, r:Node):string =
    return self.to_vec(r).join(", ")
  
  proc write_tree*[RBST:RandomizedBinarySearchTree](self: var RBST, r:Node, h = 0) =
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
  
  proc insert*[RBST:RandomizedBinarySearchTree](self: var RBST, t:var Node, k:int, v:RBST.D) =
    var x = self.split(t, k)
    t = self.merge(self.merge(x[0], self.alloc(v)), x[1]);
  
  proc erase*[RBST:RandomizedBinarySearchTree](self: var RBST, t:var Node, k:int) =
    var x = self.split(t, k)
    t = self.merge(x[0], self.split(x[1], 1)[1])
  
  proc query*[RBST:RandomizedBinarySearchTree](self: var RBST, t:var Node, p:Slice[int]):auto =
    let (a, b) = (p.a, p.b + 1)
    var
      x = self.split(t, a)
      y = self.split(x[1], b - a)
    result = self.sum(y[0])
    var m = self.merge(y[0], y[1])
    t = self.merge(x[0], m)
  
  proc set_propagate*[RBST:RandomizedBinarySearchTree](self:var RBST, t:var Node, s:Slice[int], p:RBST.L) =
    static: assert RBST.hasLazy
    let (a, b) = (s.a, s.b + 1)
    var
      x = self.split(t, a)
      y = self.split(x[1], b - a)
    y[0].lazy = self.h(y[0].lazy, p)
    var m = self.merge(self.propagate(y[0]), y[1])
    t = self.merge(x[0], m)
  
  proc set_element*[RBST:RandomizedBinarySearchTree](self: var RBST, t:var Node, k:int, x:RBST.D) =
    when RBST.hasLazy:
      t = self.propagate(t)
    if k < self.count(t.l): self.set_element(t.l, k, x)
    elif k == self.count(t.l):
      t.key = x
      t.sum = x
    else: self.set_element(t.r, k - self.count(t.l) - 1, x)
    t = self.update(t)
  
  proc len*[RBST:RandomizedBinarySearchTree](self: var RBST, t:Node):auto = self.count(t)
  proc empty*[RBST:RandomizedBinarySearchTree](self: var RBST, t:Node):bool = return t == nil
  proc makeset*[RBST:RandomizedBinarySearchTree](self: var RBST):Node[RBST.D, RBST.L, RBST.updateData] = nil 
  # }}}
