when not declared ATCODER_SET_MAP_HPP:
  const ATCODER_SET_MAP_HPP* = 1
  {.push discardable inline.}
#  import atcoder/extra/structure/randomized_binary_search_tree
  import atcoder/extra/structure/randomized_binary_search_tree_with_parent
  type SortedMultiSet*[K, T] = object
    rbst*: RandomizedBinarySearchTree[K,void,RBSTNode[K, void, void], false, void, ()]
    End*: RBSTNode[K, void, void]
  type SortedSet*[K, T] = object
    rbst*: RandomizedBinarySearchTree[K,void,RBSTNode[K, void, void], false, void, ()]
    End*: RBSTNode[K, void, void]
  type SortedMultiMap*[K, T] = object
    rbst*: RandomizedBinarySearchTree[T,void,RBSTNode[T, void, void], false, void, ()]
    End*: RBSTNode[T, void, void]
  type SortedMap*[K, T] = object
    rbst*: RandomizedBinarySearchTree[T,void,RBSTNode[T, void, void], false, void, ()]
    End*: RBSTNode[T, void, void]

  type anySet = SortedSet or SortedMultiSet
  type anyMap = SortedMap or SortedMultiMap

  type SetOrMap = SortedMultiSet or SortedSet or SortedMultiMap or SortedMap

  template getType*(T:typedesc[anySet], K):typedesc =
    T[K, K]
  template getType*(T:typedesc[anyMap], K, V):typedesc =
    T[K, (K, V)]

  proc init*(T:typedesc[SetOrMap]):T =
    result.rbst = initRandomizedBinarySearchTree[T.T]()
#    result.rbst = initRandomizedBinarySearchTree[T.T](proc(a, b:T.T):T.T = (0, 0), (0, 0))
    result.End = result.rbst.alloc(T.T.default, 0)
    result.rbst.root = result.End
  proc Begin*[T:SetOrMap](self: T):auto =
    self.rbst.root.leftMost

  proc initSortedMultiSet*[K]():auto = SortedMultiSet.getType(K).init()
  proc initSortedSet*[K]():auto = SortedSet.getType(K).init()
  proc initSortedMultiMap*[K, V]():auto = SortedMultiMap.getType(K, V).init()
  proc initSortedMap*[K, V]():auto = SortedMap.getType(K, V).init()
  

  #RBST(sz, [&](T x, T y) { return x; }, T()) {}
  
  proc getKey*[T:SetOrMap; Node:RBSTNode](self: T, t:Node):auto =
    when self.type is anySet: t.key
    else: t.key[0]

  proc `*`*[Node:RBSTNode](it:Node):auto = it.key

  proc lower_bound_index*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):int {.inline.}=
    if t == nil or t == self.End: return 0
    if x <= self.getKey(t): return self.lower_bound_index(t.l, x)
    return self.lower_bound_index(t.r, x) + self.rbst.count(t.l) + 1
  
  proc lower_bound_index*[T:SetOrMap](self:var T, x:T.K):int =
    self.lower_bound_index(self.rbst.root, x)

  proc upper_bound_index*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):int =
    if t == nil or t == self.End: return 0
    if x < self.getKey(t): return self.upper_bound_index(t.l, x)
    return self.upper_bound_index(t.r, x) + self.rbst.count(t.l) + 1

  proc upper_bound_index*[T:SetOrMap](self: var T, x:T.K):int =
    self.upper_bound_index(self.rbst.root, x)

  proc lower_bound*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):Node {.inline.}=
    if t == self.End: return t
    elif t != nil:
      if x <= self.getKey(t):
        var t2 = self.lower_bound(t.l, x)
        if t2 == nil: return t
        else: return t2
      else:
        return self.lower_bound(t.r, x)
    else: return t

  proc lower_bound*[T:SetOrMap](self:var T, x:T.K):auto =
    self.lower_bound(self.rbst.root, x)

  proc upper_bound*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):Node =
    if t == self.End: return t
    elif t != nil:
      if x < self.getKey(t):
        var t2 = self.upper_bound(t.l, x)
        if t2 == nil: return t
        else: return t2
      else:
        return self.upper_bound(t.r, x)
    else:
      return t

  proc upper_bound*[T:SetOrMap](self: var T, x:T.K):auto =
    assert self.rbst.root != nil
    self.upper_bound(self.rbst.root, x)

  proc findNode*[T:SetOrMap, Node:RBSTNode](self: var T, t:var Node, x:T.K):auto {.inline.}=
#    if t == nil: return nil
    if t == nil: return t
    if x < self.getKey(t): return self.findNode(t.l, x)
    elif x > self.getKey(t): return self.findNode(t.r, x)
    else: return t
  proc findNode*[T:SetOrMap](self:var T, x:T.K):auto =
    self.findNode(self.rbst.root, x)
  proc contains*[T:SetOrMap](self: var T, x:T.K):bool =
    self.findNode(x) != nil
  
 
  proc kth_element*[T:SetOrMap; Node:RBSTNode](self: var T, t:Node, k:int):T.T =
    let p = self.rbst.count(t.l)
    if k < p: return self.kth_element(t.l, k)
    elif k > p: return self.kth_element(t.r, k - self.rbst.count(t.l) - 1)
    else: return t.key

  proc kth_element*[T:SetOrMap](self: var T, k:int):T.T =
    return self.kth_element(self.rbst.root, k)
  proc `{}`*[T:SetOrMap](self: var T, k:int):T.T =
    return self.kth_element(k)

  proc insert*[T:SortedMultiSet](self: var T, x:T.K) =
    self.rbst.insert(self.upper_bound(x), x)
  proc insert*[T:SortedMultiMap](self: var T, x:T.T) =
    self.rbst.insert(self.upper_bound(x[0]), x)

  proc count*[T:SetOrMap](self: var T, x:T.K):int =
    return self.upper_bound_index(x) - self.lower_bound_index(x)
  
  proc erase*[T:SetOrMap](self: var T, x:T.K) =
    if self.count(x) == 0: return
    var t = self.lower_bound(x)
    self.rbst.erase(t)

  proc erase*[T:SetOrMap](self: var T, t:RBSTNode) =
    self.rbst.erase(t)

  proc find*[T:SetOrMap](self:var T, x:T.K):int =
    if self.count(x) == 0: return -1
    else: return self.lower_bound_index(x)

  proc insert*[T:SortedSet](self: var T, x:T.K) =
    var t = self.findNode(x)
    if t != nil: return
    var it = self.upper_bound(x)
    self.rbst.insert(it, x)
  proc insert*[T:SortedMap](self: var T, x:T.T) =
    var t = self.findNode(x[0])
    if t != nil: t.key = x
    else:
      var it = self.upper_bound(x[0])
      self.rbst.insert(it, x)
  proc `[]`*[K, V](self: var SortedMap[K, tuple[K:K, V:V]], x:K):auto =
    var t = self.findNode(x)
    if t != nil: return t.key[1]
    result = V.default
    self.insert((x, result))
  proc `[]=`*[K, V](self: var SortedMap[K, tuple[K:K, V:V]], x:K, v:V) =
    var t = self.findNode(x)
    if t != nil:
      t.key[1] = v
      return
    self.insert((x, v))
  
  proc len*(self:SetOrMap):int = self.rbst.len()
  proc empty*(self:var SetOrMap):bool = self.rbst.empty()
  proc check_tree*(self:SetOrMap) =
    doAssert self.len + 1 == self.rbst.check_tree()
  proc `$`*(self: SetOrMap):string = self.rbst.to_string(self.rbst.root)
  {.pop.}
