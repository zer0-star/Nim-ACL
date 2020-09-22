# OrderedSet[K], OrderedMultiSet[K], OrderedMap[K], OrderedMultiMap[K] {{{
when not declared ATCODER_SET_MAP_HPP:
  const ATCODER_SET_MAP_HPP* = 1
  import atcoder/extra/structure/randomized_binary_search_tree
  type OrderedMultiSet*[K] = object
    rbst: RandomizedBinarySearchTree[K,void,void,void]
    root: Node[K, void, void]
  type OrderedSet*[K] = object
    rbst: RandomizedBinarySearchTree[K,void,void,void]
    root: Node[K, void, void]
  type OrderedMultiMap*[K, T] = object
    rbst: RandomizedBinarySearchTree[T,void,void,void]
    root: Node[T, void, void]
  type OrderedMap*[K, T] = object
    rbst: RandomizedBinarySearchTree[T,void,void,void]
    root: Node[T, void, void]
  
  proc initOrderedMultiSet*[K]():OrderedMultiSet[K] =
    result.rbst = initRandomizedBinarySearchTree[K]()
    result.root = nil
  proc initOrderedSet*[K]():OrderedSet[K] =
    result.rbst = initRandomizedBinarySearchTree[K]()
    result.root = nil
  proc initOrderedMultiMap*[K, V]():OrderedMultiMap[K, tuple[K:K, V:V]] =
    result.rbst = initRandomizedBinarySearchTree[(K, V)]()
    result.root = nil
  proc initOrderedMap*[K, V]():OrderedMap[K, tuple[K:K, V:V]] =
    result.rbst = initRandomizedBinarySearchTree[(K, V)]()
    result.root = nil
  
  #RBST(sz, [&](T x, T y) { return x; }, T()) {}
  
  type anySet = concept x
    x is OrderedMultiSet or x is OrderedSet
  type anyMap = concept x
    x is OrderedMultiMap or x is OrderedMap
  
  type SetOrMap = OrderedMultiSet or OrderedSet or OrderedMultiMap or OrderedMap

  template getKey*(self: SetOrMap, t:Node):auto =
    when self.type is anySet: t.key
    else: t.key[0]
  
  proc lower_bound*[T:SetOrMap](self: var T, t:var Node, x:T.K):int {.inline.}=
    if t == nil: return 0
    if x <= self.getKey(t): return self.lower_bound(t.l, x)
    return self.lower_bound(t.r, x) + self.rbst.count(t.l) + 1
  
  proc lower_bound*[T:SetOrMap](self:var T, x:T.K):int {.inline.} =
    self.lower_bound(self.root, x)

  proc upper_bound*[T:SetOrMap](self: var T, t:var Node, x:T.K):int {.inline.} =
    if t == nil: return 0
    if x < self.getKey(t): return self.upper_bound(t.l, x)
    return self.upper_bound(t.r, x) + self.rbst.count(t.l) + 1
  
  proc find*[T:SetOrMap](self: var T, t:var Node, x:T.K):Node {.inline.}=
    if t == nil: return nil
    if x < self.getKey(t): return self.find(t.l, x)
    elif x > self.getKey(t): return self.find(t.r, x)
    else: return t
  proc find*[T:SetOrMap](self:var T, x:T.K):auto {.inline.} =
    self.find(self.root, x)
  
  proc contains*[T:SetOrMap](self: var T, x:T.K):bool {.inline.} =
    self.find(x) != nil
  
  proc upper_bound*[T:SetOrMap](self: var T, x:T.K):int {.inline.} =
    self.upper_bound(self.root, x)
  
  proc kth_element*[T:SetOrmap](self: var T, t:Node, k:int):T.T {.inline.} =
    let p = self.rbst.count(t.l)
    if k < p: return self.kth_element(t.l, k)
    elif k == self.rbst.count(t.l): return t.key
    return self.kth_element(t.r, k - self.rbst.count(t.l) - 1)
  
  proc kth_element*[T:SetOrMap](self: var T, k:int):T.T {.inline.} =
    self.kth_element(self.root, k)
  
  proc insert*[K](self: var OrderedMultiSet[K], x:K) {.inline.} =
    self.rbst.insert(self.root, self.lower_bound(x), x)
  proc insert*[K, V](self: var OrderedMultiMap[K, tuple[K:K, V:V]], x:(K, V)) =
    self.rbst.insert(self.root, self.lower_bound(x[0]), x)
  
  proc count*[T:SetOrMap](self: var T, x:T.K):int {.inline.} =
    return self.upper_bound(x) - self.lower_bound(x)
  
  proc erase_key*[T:SetOrMap](self: var T, x:T.K) {.inline.} =
    if self.count(x) == 0: return
    self.rbst.erase(self.root, self.lower_bound(x))
  
  proc insert*[K](self: var OrderedSet[K], x:K) {.inline.} =
    var t = self.find(x)
    if t != nil: return
    self.rbst.insert(self.root, self.lower_bound(x), x)
  proc insert*[K, V](self: var OrderedMap[K, tuple[K:K, V:V]], x:(K, V)) {.inline.} =
    var t = self.find(x[0])
    if t != nil: t.key = x
    else: self.rbst.insert(self.root, self.lower_bound(x[0]), x)
  proc `[]`*[K, V](self: var OrderedMap[K, tuple[K:K, V:V]], x:K):auto {.inline.} =
    var t = self.find(x)
    if t != nil: return t.key[1]
    result = V.default
    self.insert((x, result))
  proc `[]=`*[K, V](self: var OrderedMap[K, tuple[K:K, V:V]], x:K, v:V) {.inline.} =
    var t = self.find(x)
    if t != nil:
      t.key[1] = v
      return
    self.insert((x, v))
  
  proc len*(self:var SetOrMap):int {.inline.} = self.rbst.len(self.root)
  proc empty*(self:var SetOrMap):bool {.inline.} = self.rbst.empty(self.root)
  # }}}
