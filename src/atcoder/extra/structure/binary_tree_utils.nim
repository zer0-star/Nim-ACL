when not declared ATCODER_BINARY_TREE_UTILS_HPP:
  const ATCODER_BINARY_TREE_UTILS_HPP* = 1
  include atcoder/extra/structure/binary_tree_node_utils
  {.push discardable inline.}
  type SomeSortedTree* = concept x, type T
    T.Tree is BinaryTree
    T.K is typedesc
    T.V is typedesc
    T.Node is typedesc
    T.multi is typedesc
    T.p
    x.End
  type SomeSortedSet* = concept x, type T
    T is SomeSortedTree
    T.V is void
    T.multi is void
  type SomeSortedMap* = concept x, type T
    T is SomeSortedTree
    T.V isnot void
    T.multi is void
  type SomeSortedMultiSet* = concept x, type T
    T is SomeSortedTree
    T.V is void
    T.multi isnot void
  type SomeSortedMultiMap* = concept x, type T
    T is SomeSortedTree
    T.V isnot void
    T.multi isnot void
  type hasSplay* = concept x, type T
    var t:T.Node
    x.tree.splay(t)
  proc begin*[T:SomeSortedTree](self: T):T.Node = self.tree.begin()

  proc getKey*[T:SomeSortedTree](self: T, t:T.Node):auto =
    when T.V is void: t.key
    else: t.key[0]

  template calc_comp*[T:SomeSortedTree](self:T, x, y:T.K):bool =
    when T.p[0] is typeof(nil):
      x < y
    else:
      let comp = T.p[0]
      comp(x, y)

  proc lower_bound*[T:SomeSortedTree](self: var T, t:var T.Node, x:T.K):T.Node =
    if t.isLeaf:
      return t
    if t != self.End and self.calc_comp(self.getKey(t), x):
      return self.lower_bound(t.r, x)
    else:
      var t2 = self.lower_bound(t.l, x)
      if t2.isLeaf: return t
      else: return t2

  proc lower_bound*[T:SomeSortedTree](self:var T, x:T.K):T.Node =
    assert self.tree.root != nil
    result = self.lower_bound(self.tree.root, x)
    when T is hasSplay:
      self.tree.splay(result)
      self.tree.root = result

  proc upper_bound*[T:SomeSortedTree](self: var T, t:var T.Node, x:T.K):T.Node =
    if t.isLeaf: return t
    if t == self.End or self.calc_comp(x, self.getKey(t)):
      var t2 = self.upper_bound(t.l, x)
      if t2.isLeaf: return t
      else: return t2
    else:
      return self.upper_bound(t.r, x)

  proc upper_bound*[T:SomeSortedTree](self: var T, x:T.K):T.Node =
    assert self.tree.root != nil
    result = self.upper_bound(self.tree.root, x)
    when T is hasSplay:
      self.tree.splay(result)
      self.tree.root = result

#  proc find*[T:SomeSortedTree](self: var T, t:var T.Node, x:T.K):T.Node =
#    echo "find:  ", t.key
#    if t == self.End or t.isLeaf: return self.End
#    if self.calc_comp(x, self.getKey(t)): return self.find(t.l, x)
#    elif self.calc_comp(self.getKey(t), x): return self.find(t.r, x)
#    else: return t
  proc find*[T:SomeSortedTree](self:var T, x:T.K):T.Node =
    var t = self.lower_bound(x)
    if t != self.End and self.getKey(t) == x: return t
    else: return self.End
#    result = self.find(self.root, x)
  proc contains*[T:SomeSortedTree](self: var T, x:T.K):bool =
    self.find(x) != self.End

  proc insert*[T:SomeSortedMultiSet](self: var T, x:T.K):T.Node =
    self.tree.insert(self.upper_bound(x), x)
  proc insert*[T:SomeSortedMultiMap](self: var T, x:(T.K, T.V)):T.Node =
    self.tree.insert(self.upper_bound(x[0]), x)

  proc insert*[T:SomeSortedSet](self: var T, x:T.K):T.Node =
    var t = self.lower_bound(x)
    if t != self.End and t.key == x: return t
    else: return self.tree.insert(t, x)
  proc insert*[T:SomeSortedMap](self: var T, x:(T.K, T.V)):T.Node =
    var it = self.lower_bound(x[0])
    if it != self.End and it.key[0] == x[0]: it.key[1] = x[1]; return it
    else: return self.tree.insert(it, x)
  proc incl*[T:SomeSortedSet | SomeSortedMultiSet](self:var T, x:T.K):T.Node =
    self.insert(x)
  proc incl*[T:SomeSortedMap | SomeSortedMultiMap](self:var T, x:(T.K, T.V)):T.Node =
    self.insert(x)

  template getAddr*[T:SomeSortedMap](self:var T, x:T.K):auto =
    var t = self.lower_bound(x)
    if t == self.End or t.key[0] != x:
      var v: T.V
      when v is SomeSortedTree:
        v.init()
      t = self.tree.insert(t, (x, v))
    t.key[1].addr

  template `[]`*[T:SomeSortedMap](self: var T, x:T.K):auto =
    var t = self.getAddr(x)
    t[]
  proc `[]=`*[T:SomeSortedMap](self: var T, x:T.K, v:T.V) =
    var t = self.getAddr(x)
    t[] = v

  proc erase*[T:SomeSortedSet or SomeSortedMap](self: var T, x:T.K):T.Node =
    mixin erase
    var t = self.lower_bound(x)
    if t == self.End or self.getKey(t) != x: return self.End
    else: return self.tree.erase(t)
  proc erase*[T:SomeSortedMultiSet or SomeSortedMultiMap](self: var T, lb, ub:T.Node):T.Node =
    if lb != ub:
      var
        (L, R) = self.tree.split(lb)
        (RL, RR) = self.tree.split(ub)
      self.tree.root = self.tree.join(L, RR)
    return ub

  proc erase*[T:SomeSortedMultiSet or SomeSortedMultiMap](self: var T, x:T.K):T.Node =
    #doAssert T.Tree.Countable isnot void
    mixin erase
    return self.erase(self.lower_bound(x), self.upper_bound(x))

  proc erase*[T:SomeSortedTree](self: var T, t:T.Node):T.Node = self.tree.erase(t)
  proc excl*[T:SomeSortedTree](self: var T, x:T.K):T.Node = self.erase(x)
  proc excl*[T:SomeSortedTree](self: var T, t:T.Node):T.Node = self.erase(t)

  proc kth_element*[T:SomeSortedTree](self: var T, t:T.Node, k:int):T.Node =
#    static:
#      assert T.Tree.Countable isnot void
    let p = t.l.cnt
    if k < p: return self.kth_element(t.l, k)
    elif k > p: return self.kth_element(t.r, k - p - 1)
    else: return t
  
  proc kth_element*[T:SomeSortedTree](self: var T, k:int):T.Node =
    return self.kth_element(self.tree.root, k)
  proc `{}`*[T:SomeSortedTree](self: var T, k:int):T.Node =
    return self.kth_element(k)

  proc index*[T:SomeSortedTree](self:T, t:T.Node):int =
#    static:
#      assert T.Tree.Countable isnot void
    return index(t)
  proc distance*[T:SomeSortedTree](self:T, t1, t2:T.Node):int =
#    static:
#      assert T.Tree.Countable isnot void
    return index(t2) - index(t1)

  iterator items*[T:SomeSortedSet or SomeSortedMultiSet](self:T):T.K =
    var it = self.begin
    while it != self.End:
      yield it.key
      it.inc
  iterator pairs*[T:SomeSortedMap or SomeSortedMultiMap](self:T):(T.K, T.V) =
    var it = self.begin
    while it != self.End:
      yield it.key
      it.inc
  proc `end`*[Tree:SomeSortedTree](self:Tree):Tree.Node = self.End
  {.pop.}
