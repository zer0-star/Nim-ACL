when not declared ATCODER_SET_MAP_HPP:
  const ATCODER_SET_MAP_HPP* = 1
  import atcoder/extra/structure/randomized_binary_search_tree
  type SortedMultiSet*[K, T] = object
    rbst: RandomizedBinarySearchTree[K,void,RBSTNode[K, void, void], false, void, ()]
  type SortedSet*[K, T] = object
    rbst: RandomizedBinarySearchTree[K,void,RBSTNode[K, void, void], false, void, ()]
  type SortedMultiMap*[K, T] = object
    rbst: RandomizedBinarySearchTree[T,void,RBSTNode[T, void, void], false, void, ()]
  type SortedMap*[K, T] = object
    rbst: RandomizedBinarySearchTree[T,void,RBSTNode[T, void, void], false, void, ()]

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
    result.rbst.root = nil

  proc initSortedMultiSet*[K]():auto = SortedMultiSet.getType(K).init()
  proc initSortedSet*[K]():auto = SortedSet.getType(K).init()
  proc initSortedMultiMap*[K, V]():auto = SortedMultiMap.getType(K, V).init()
  proc initSortedMap*[K, V]():auto = SortedMap.getType(K, V).init()

  #RBST(sz, [&](T x, T y) { return x; }, T()) {}
  
  proc getKey*[T:SetOrMap; Node:RBSTNode](self: T, t:Node):auto =
    when self.type is anySet: t.key
    else: t.key[0]
  
  proc lower_bound*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):int {.inline.}=
    if t == nil: return 0
    if x <= self.getKey(t): return self.lower_bound(t.l, x)
    return self.lower_bound(t.r, x) + self.rbst.count(t.l) + 1
  
  proc lower_bound*[T:SetOrMap](self:var T, x:T.K):int {.inline.} =
    self.lower_bound(self.rbst.root, x)

  proc upper_bound*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):int {.inline.} =
    if t == nil: return 0
    if x < self.getKey(t): return self.upper_bound(t.l, x)
    return self.upper_bound(t.r, x) + self.rbst.count(t.l) + 1
  
  proc findNode*[T:SetOrMap, Node:RBSTNode](self: var T, t:var Node, x:T.K):auto {.inline.}=
#    if t == nil: return nil
    if t == nil: return t
    if x < self.getKey(t): return self.findNode(t.l, x)
    elif x > self.getKey(t): return self.findNode(t.r, x)
    else: return t
  proc findNode*[T:SetOrMap](self:var T, x:T.K):auto {.inline.} =
    self.findNode(self.rbst.root, x)
  proc contains*[T:SetOrMap](self: var T, x:T.K):bool {.inline.} =
    self.findNode(x) != nil
  
  proc upper_bound*[T:SetOrMap](self: var T, x:T.K):int {.inline.} =
    self.upper_bound(self.rbst.root, x)
  
  proc kth_element*[T:SetOrMap; Node:RBSTNode](self: var T, t:Node, k:int):T.T {.inline.} =
    let p = self.rbst.count(t.l)
    if k < p: return self.kth_element(t.l, k)
    elif k > p: return self.kth_element(t.r, k - self.rbst.count(t.l) - 1)
    else: return t.key

  proc kth_element*[T:SetOrMap](self: var T, k:int):T.T {.inline.} =
    return self.kth_element(self.rbst.root, k)
  proc `{}`*[T:SetOrMap](self: var T, k:int):T.T {.inline.} =
    return self.kth_element(k)

  proc insert*[T:SortedMultiSet](self: var T, x:T.K) {.inline.} =
    self.rbst.insert(self.upper_bound(x), x)
  proc insert*[T:SortedMultiMap](self: var T, x:T.T) =
    self.rbst.insert(self.upper_bound(x[0]), x)

  proc count*[T:SetOrMap](self: var T, x:T.K):int {.inline.} =
    return self.upper_bound(x) - self.lower_bound(x)
  
  proc erase*[T:SetOrMap](self: var T, x:T.K) {.inline.} =
    if self.count(x) == 0: return
    self.rbst.erase(self.lower_bound(x))
  proc find*[T:SetOrMap](self:var T, x:T.K):int {.inline.} =
    if self.count(x) == 0: return -1
    else: return self.lower_bound(x)

  proc insert*[T:SortedSet](self: var T, x:T.K) {.inline.} =
    var t = self.findNode(x)
    if t != nil: return
    self.rbst.insert(self.upper_bound(x), x)
  proc insert*[T:SortedMap](self: var T, x:T.T) {.inline.} =
    var t = self.findNode(x[0])
    if t != nil: t.key = x
    else: self.rbst.insert(self.upper_bound(x[0]), x)
  proc `[]`*[K, V](self: var SortedMap[K, tuple[K:K, V:V]], x:K):auto {.inline.} =
    var t = self.findNode(x)
    if t != nil: return t.key[1]
    result = V.default
    self.insert((x, result))
  proc `[]=`*[K, V](self: var SortedMap[K, tuple[K:K, V:V]], x:K, v:V) {.inline.} =
    var t = self.findNode(x)
    if t != nil:
      t.key[1] = v
      return
    self.insert((x, v))
  
  proc len*(self:var SetOrMap):int {.inline.} = self.rbst.len()
  proc empty*(self:var SetOrMap):bool {.inline.} = self.rbst.empty()

