when not declared ATCODER_SET_MAP_HPP:
  const ATCODER_SET_MAP_HPP* = 1
  const USE_RED_BLACK_TREE = true
  {.push discardable inline.}
  include atcoder/extra/structure/binary_tree_utils
  type MULTI_TRUE = int32
  type MULTI_FALSE = void
  type SortedTree*[Tree, Node, multi, K, V; p:static[tuple]] = object of Tree
#    comp*: proc(a, b:K):bool
    End*: Node

  when USE_RED_BLACK_TREE:
    import atcoder/extra/structure/red_black_tree
    type
      SortedSetType*[K, Countable; p:static[tuple]] = SortedTree[RedBlackTree[K, Countable], RedBlackTreeNode[K, Countable], MULTI_FALSE, K, void, p]
      SortedMultiSetType*[K, Countable; p:static[tuple]] = SortedTree[RedBlackTree[K, Countable], RedBlackTreeNode[K, Countable], MULTI_TRUE, K, void, p]
      SortedMapType*[K; V:not void; Countable; p:static[tuple]] = SortedTree[RedBlackTree[(K, V), Countable], RedBlackTreeNode[(K, V), Countable], MULTI_FALSE, K, V, p]
      SortedMultiMapType*[K; V:not void; Countable; p:static[tuple]] = SortedTree[RedBlackTree[(K, V), Countable], RedBlackTreeNode[(K, V), Countable], MULTI_TRUE, K, V, p]

#      SortedSet*[K] = SortedSetType[K, void]
#      SortedMultiSet*[K] = SortedMultiSetType[K, void]
#      SortedMap*[K; V:not void] = SortedMapType[K, V, void]
#      SortedMultiMap*[K; V:not void] = SortedMultiMapType[K, V, void]
#      CountableSortedSet*[K] = SortedSetType[K, int]
#      CountableSortedMultiSet*[K] = SortedMultiSetType[K, int]
#      CountableSortedMap*[K; V:not void] = SortedMapType[K, V, int]
#      CountableSortedMultiMap*[K; V:not void] = SortedMultiMapType[K, V, int]

#    type SetOrMap = SortedMultiSet or SortedSet or SortedMultiMap or SortedMap or CountableSortedMultiSet or CountableSortedSet or CountableSortedMultiMap or CountableSortedMap or SortedTree
    type SetOrMap = SortedMultiSetType or SortedSetType or SortedMultiMapType or SortedMapType
    proc init[Tree:SetOrMap](self: var Tree) =
      when Tree.V is void:
        type T = Tree.K
      else:
        type T = (Tree.K, Tree.V)
      type Countable = Tree.Tree.Countable
      var End = RedBlackTreeNode[T, Countable](color: Color.black, id: -2)
      var leaf = RedBlackTreeNode[T, Countable](color: Color.black, id: -1)
      leaf.l = leaf; leaf.r = leaf
      End.p = nil
      End.l = leaf; End.r = leaf
      when Tree.Tree.Countable isnot void:
        leaf.cnt = 0
      self.root = End
      self.End = End
      self.leaf = leaf
      self.next_id = 0

    proc `$`*[T:SetOrMap](self: T): string =
      result = "{"
      var node = self.root
      var stack: seq[T.Node] = @[]
      while stack.len() != 0 or not node.isLeaf:
        if not node.isLeaf:
          if node != self.End:
            stack.add(node)
          node = node.l
        else:
          node = stack.pop()
          when T.V is void:
            result &= $(node.key) & " "
          else:
            result &= $(node.key[0]) & ":" & $(node.key[1])
          result &= ","
          node = node.r
      result &= "}"

  else:
    import atcoder/extra/structure/randomized_binary_search_tree_with_parent
 
    type SortedSetType*[K, Countable, comp] = SortedTree[RandomizedBinarySearchTree[K], RBSTNode[K, void, MULTI_FALSE], MULTI_FALSE, K, void, comp]
    type SortedMultiSetType*[K, Countable, comp] = SortedTree[RandomizedBinarySearchTree[K], RBSTNode[K, void, MULTI_FALSE], MULTI_TRUE, K, void, comp]
    type SortedMapType*[K, V, Countable, comp] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K, V), void, MULTI_FALSE], MULTI_FALSE, K, V, comp]
    type SortedMultiMapType*[K, V, Countable, comp] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K, V), void, MULTI_FALSE], MULTI_TRUE, K, V, comp]
  
    type SetOrMap = SortedMultiSetType or SortedSetType or SortedMultiMapType or SortedMapType
  
    proc init*[T:SetOrMap](self: var T, comp: proc(a, b:T.K):bool = nil) =
      T.Tree(self).setRBST()
      var end_node = T.Tree(self).Node(cnt: 1, p:nil, id: -1)
      end_node.l = self.leaf; end_node.r = self.leaf;
      self.End = end_node
      self.root = self.End
  
#    proc initSortedMultiSet*[K](comp:static[proc(a, b:T.K):bool] = nil):SortedMultiSet[K] =
#      result.init(comp)
#    proc initSortedSet*[K](comp:proc(a, b:T.K):bool = nil):SortedSet[K] =
#      result.init(comp)
#    proc initSortedMultiMap*[K, V](comp:proc(a, b:T.K):bool = nil):SortedMultiMap[K, V] =
#      result.init(comp)
#    proc initSortedMap*[K, V](comp:proc(a, b:T.K):bool = nil):SortedMap[K, V] =
#      result.init(comp)
  
  #  RBST(sz, [&](T x, T y) { return x; }, T()) {}
    
    proc `*`*[Node:RBSTNode](it:Node):auto = it.key
  
    proc len*(self:SetOrMap):int = self.len()
    proc empty*(self:var SetOrMap):bool = self.empty()
    proc check_tree*(self:SetOrMap) =
      doAssert self.len + 1 == self.check_tree()
  
    proc `$`*(self: SetOrMap):string = self.Tree(self).to_string(self.root)
  {.pop.}


  template SortedSet*(K:typedesc, f:static[proc(a, b:K):bool] = nil):typedesc = SortedSetType[K, void, (f,)]
  template SortedMultiSet*(K:typedesc, f:static[proc(a, b:K):bool] = nil):typedesc = SortedMultiSetType[K, void, (f,)]
  template SortedMap*(K:typedesc; V:typedesc[not void], f:static[proc(a, b:K):bool] = nil):typedesc = SortedMapType[K, V, void, (f,)]
  template SortedMultiMap*(K:typedesc; V:typedesc[not void], f:static[proc(a, b:K):bool] = nil):typedesc = SortedMultiMapType[K, V, void, (f,)]
  template CountableSortedSet*(K:typedesc, f:static[proc(a, b:K):bool] = nil):typedesc = SortedSetType[K, int, (f,)]
  template CountableSortedMultiSet*(K:typedesc, f:static[proc(a, b:K):bool] = nil):typedesc = SortedMultiSetType[K, int, (f,)]
  template CountableSortedMap*(K:typedesc; V:typedesc[not void], f:static[proc(a, b:K):bool] = nil):typedesc = SortedMapType[K, V, int, (f,)]
  template CountableSortedMultiMap*(K:typedesc; V:typedesc[not void], f:static[proc(a, b:K):bool] = nil):typedesc = SortedMultiMapType[K, V, int, (f,)]

  proc default*[T:SetOrMap](self:typedesc[T]):T =
    result.init()
  proc initSortedSet*(K:typedesc, isCountable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    var r: SortedSetType[K, when isCountable: int else: void, (comp,)]
    r.init()
    return r
  proc initSortedMultiSet*(K:typedesc, isCountable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    var r: SortedMultiSetType[K, when isCountable: int else: void, (comp,)]
    r.init()
    return r
  proc initSortedMap*(K:typedesc, V:typedesc[not void], isCountable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    var r: SortedMapType[K, V, when isCOuntable: int else: void, (comp,)]
    r.init()
    return r
  proc initSortedMultiMap*(K:typedesc, V:typedesc[not void], isCountable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    var r: SortedMultiMapType[K, V, when isCountable: int else: void, (comp,)]
    r.init()
    return r
