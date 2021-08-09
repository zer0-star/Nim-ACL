when not declared ATCODER_SET_MAP_HPP:
  const ATCODER_SET_MAP_HPP* = 1
  const USE_RED_BLACK_TREE = true
  {.push discardable inline.}
  import std/strutils
  include atcoder/extra/structure/binary_tree_utils
  type MULTI_TRUE = int32
  type MULTI_FALSE = void
  type SortedTree*[Tree, Node, multi, K, V; p:static[tuple]] = object of Tree
    End*: Node

  when USE_RED_BLACK_TREE:
    include atcoder/extra/structure/red_black_tree
    type
      SortedSetType*[K, Countable; p:static[tuple]] = SortedTree[RedBlackTree[K, Countable], RedBlackTreeNode[K, Countable], MULTI_FALSE, K, void, p]
      SortedMultiSetType*[K, Countable; p:static[tuple]] = SortedTree[RedBlackTree[K, Countable], RedBlackTreeNode[K, Countable], MULTI_TRUE, K, void, p]
      SortedMapType*[K; V:not void; Countable; p:static[tuple]] = SortedTree[RedBlackTree[(K, V), Countable], RedBlackTreeNode[(K, V), Countable], MULTI_FALSE, K, V, p]
      SortedMultiMapType*[K; V:not void; Countable; p:static[tuple]] = SortedTree[RedBlackTree[(K, V), Countable], RedBlackTreeNode[(K, V), Countable], MULTI_TRUE, K, V, p]

    type SetOrMap = SortedMultiSetType or SortedSetType or SortedMultiMapType or SortedMapType
    proc init*[Tree:SetOrMap](self: var Tree) =
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

  else:
    include atcoder/extra/structure/randomized_binary_search_tree_with_parent
 
    type SortedSetType*[K, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[K], RBSTNode[K, void, void], MULTI_FALSE, K, void, p]
    type SortedMultiSetType*[K, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[K], RBSTNode[K, void, void], MULTI_TRUE, K, void, p]
    type SortedMapType*[K, V, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K, V), void, void], MULTI_FALSE, K, V, p]
    type SortedMultiMapType*[K, V, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K, V), void, void], MULTI_TRUE, K, V, p]
  
    type SetOrMap = SortedMultiSetType or SortedSetType or SortedMultiMapType or SortedMapType
  
    proc init*[Tree:SetOrMap](self: var Tree) =
      when Tree.V is void:
        type T = Tree.K
      else:
        type T = (Tree.K, Tree.V)
      Tree.Tree(self).setRBST()
      var end_node = RBSTNode[T, void, void](cnt: 1, p:nil, id: -1)
      end_node.l = self.leaf; end_node.r = self.leaf;
      self.End = end_node
      self.root = self.End
  
  #  RBST(sz, [&](T x, T y) { return x; }, T()) {}
    
    proc `*`*[Node:RBSTNode](it:Node):auto = it.key
  
    proc len*[Tree:SetOrMap](self:Tree):int = Tree.Tree(self).len() - 1
    proc empty*[Tree:SetOrMap](self:Tree):bool = self.len() == 0
    proc check_tree*(self:SetOrMap) =
      doAssert self.len + 1 == self.check_tree()
  
#    proc `$`*(self: SetOrMap):string = self.Tree(self).to_string(self.root)
  {.pop.}

  template SortedSet*(K:typedesc, countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc =
    SortedSetType[K, when countable: int else: void, (comp,)]
  template SortedMultiSet*(K:typedesc, countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc =
    SortedMultiSetType[K, when countable: int else: void, (comp,)]
  template SortedMap*(K:typedesc; V:typedesc[not void], countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc =
    SortedMapType[K, V, when countable: int else: void, (comp,)]
  template SortedMultiMap*(K:typedesc; V:typedesc[not void], countable: static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc =
    SortedMultiMapType[K, V, when countable: static[bool] = false, (comp,)]

  proc default*[T:SetOrMap](self:typedesc[T]):T =
    result.init()
  proc initSortedSet*(K:typedesc, countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    var r: SortedSetType[K, when countable: int else: void, (comp,)]
    r.init()
    return r
  proc initSortedMultiSet*(K:typedesc, countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    var r: SortedMultiSetType[K, when countable: int else: void, (comp,)]
    r.init()
    return r
  proc initSortedMap*(K:typedesc, V:typedesc[not void], countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    var r: SortedMapType[K, V, when countable: int else: void, (comp,)]
    r.init()
    return r
  proc initSortedMultiMap*(K:typedesc, V:typedesc[not void], countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    var r: SortedMultiMapType[K, V, when countable: int else: void, (comp,)]
    r.init()
    return r

  proc `$`*(self: SetOrMap): string =
    var a = newSeq[string]()
    var node = self.root
    var stack: seq[self.Node] = @[]
    while stack.len() != 0 or not node.isLeaf:
      if not node.isLeaf:
        if node != self.End:
          stack.add(node)
        node = node.l
      else:
        node = stack.pop()
        when self.V is void:
          var k = ""
          k.addQuoted(node.key)
          a &= k
        else:
          var k, v = ""
          k.addQuoted(node.key[0])
          v.addQuoted(node.key[1])
          a &= k & ": " & v
        node = node.r
    return "{" & a.join(", ") & "}"
