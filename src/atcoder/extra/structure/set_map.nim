when not declared ATCODER_SET_MAP_HPP:
  const ATCODER_SET_MAP_HPP* = 1
  #type BinaryTreeType = enum
  #  RedBlack, 
  #  Splay, 
  #  Randomized
  #const SetMapType = BinaryTreeType.RedBlack
# red black
  const USE_RED_BLACK_TREE = true
  const USE_SPLAY_TREE = false
# splay
#  const USE_RED_BLACK_TREE = false
#  const USE_SPLAY_TREE = true
# RBST
#  const USE_RED_BLACK_TREE = false
#  const USE_SPLAY_TREE = false

  {.push discardable inline.}
  import std/strutils
  include atcoder/extra/structure/binary_tree_utils
  type MULTI_TRUE = int32
  type MULTI_FALSE = void
  type SortedTree*[Tree, Node, multi, K, V; p:static[tuple]] = object
    tree*: Tree
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
      type Node = Tree.Node
      var End = Node(id: -2)
      when Tree.Tree.Countable isnot void:
        End.cnt = 1
      self.End = End
      self.tree.init(End)
    proc empty*[Tree:SetOrMap](self:Tree):bool = self.tree.empty()
    proc len*[Tree:SetOrMap](self:Tree):int = self.tree.len()
  elif USE_SPLAY_TREE:
    include atcoder/extra/structure/splay_tree
    type
      SortedSetType*[K, Countable; p:static[tuple]] = SortedTree[SplayTree[K], SplayTreeNode[K, void, void, void], MULTI_FALSE, K, void, p]
      SortedMultiSetType*[K, Countable; p:static[tuple]] = SortedTree[SplayTree[K], SplayTreeNode[K, void, void, void], MULTI_TRUE, K, void, p]
      SortedMapType*[K; V:not void; Countable; p:static[tuple]] = SortedTree[SplayTree[(K, V)], SplayTreeNode[(K, V), void, void, void], MULTI_FALSE, K, V, p]
      SortedMultiMapType*[K; V:not void; Countable; p:static[tuple]] = SortedTree[SplayTree[(K, V)], SplayTreeNode[(K, V), void, void, void], MULTI_TRUE, K, V, p]

    type SetOrMap = SortedMultiSetType or SortedSetType or SortedMultiMapType or SortedMapType
    proc init*[Tree:SetOrMap](self: var Tree) =
      when Tree.V is void:
        type T = Tree.K
      else:
        type T = (Tree.K, Tree.V)
      var End = Tree.Node(id: -2)
      End.cnt = 1 # be carefull!!!!!!!!!!!!!!!
      self.End = End
      self.tree.init(End)
    proc len*[Tree:SetOrMap](self:Tree):int = self.tree.root.cnt - 1
    proc empty*[Tree:SetOrMap](self:Tree):bool = self.len == 0

  else:
    include atcoder/extra/structure/randomized_binary_search_tree_with_parent
 
    type
      SortedSetType*[K, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[K], RandomizedBinarySearchTree[K].Node, MULTI_FALSE, K, void, p]
      SortedMultiSetType*[K, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[K], RBSTNode[K, void, void], MULTI_TRUE, K, void, p]
      SortedMapType*[K, V, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K, V), void, void], MULTI_FALSE, K, V, p]
      SortedMultiMapType*[K, V, Countable; p:static[tuple]] = SortedTree[RandomizedBinarySearchTree[(K, V)], RBSTNode[(K, V), void, void], MULTI_TRUE, K, V, p]
  
    type SetOrMap = SortedMultiSetType or SortedSetType or SortedMultiMapType or SortedMapType
  
    proc init*[Tree:SetOrMap](self: var Tree) =
      when Tree.V is void:
        type T = Tree.K
      else:
        type T = (Tree.K, Tree.V)
      var End = Tree.Node(id: -2)
      End.cnt = 1 # be carefull!!!!!!!!!!!!!!!
      self.End = End
      self.tree.init(End)
#      end_node.l = self.leaf; end_node.r = self.leaf;
  
  #  RBST(sz, [&](T x, T y) { return x; }, T()) {}
    
    proc len*[Tree:SetOrMap](self:Tree):int = self.tree.len() - 1
    proc empty*[Tree:SetOrMap](self:Tree):bool = self.len() == 0
#      doAssert self.len + 1 == self.tree.check_tree()
  
#    proc `$`*(self: SetOrMap):string = self.Tree(self).to_string(self.root)
  {.pop.}
  proc check_tree*(self:SetOrMap) = self.tree.check_tree

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
  template initSortedSet*[K](countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    block:
      var r: SortedSetType[K, when countable: int else: void, (comp,)]
      r.init()
      r
  template initSortedMultiSet*[K](countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    block:
      var r: SortedMultiSetType[K, when countable: int else: void, (comp,)]
      r.init()
      r
  template initSortedMap*[K; V:not void](countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    block:
      var r: SortedMapType[K, V, when countable: int else: void, (comp,)]
      r.init()
      r
  template initSortedMultiMap*[K; V:not void](countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    block:
      var r: SortedMultiMapType[K, V, when countable: int else: void, (comp,)]
      r.init()
      r

  proc `$`*(self: SetOrMap): string =
    var a = newSeq[string]()
    var node = self.tree.root
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
