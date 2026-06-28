when not declared ATCODER_BINARY_TREE_NODE_UTILS_HPP:
  const ATCODER_BINARY_TREE_NODE_UTILS_HPP* = 1
  type BinaryTreeNode* = concept x, type T
    x.l is T
    x.r is T
    x.p is T
#    T.Countable
  type BinaryTree* = concept x, type T
    T.Node is BinaryTreeNode
    x.root is T.Node

  proc greater_func*[K](a,b:K):bool = a < b

  proc isLeaf*[Node:BinaryTreeNode](self:Node):bool =
    return self.l == self

  proc leftMost*[Node:BinaryTreeNode](self: Node):Node =
    if self.l.isLeaf: return self
    else: return self.l.leftMost
  proc rightMost*[Node:BinaryTreeNode](self: Node): Node =
    if self.r.isLeaf: return self
    else: return self.r.rightMost
  proc parentLeft*[Node:BinaryTreeNode](node: Node): Node =
    var node = node
    while true:
      if node.p == nil: return nil
      elif node.p.l == node: return node.p
      node = node.p
  proc parentRight*[Node:BinaryTreeNode](node: Node): Node =
    var node = node
    while true:
      if node.p == nil: return nil
      elif node.p.r == node: return node.p
      node = node.p
  proc front*[Tree:BinaryTree](self: Tree): Tree.Node = self.root.leftMost
  proc tail*[Tree:BinaryTree](self: Tree): Tree.Node =  self.root.rightMost
  proc begin*[Tree:BinaryTree](self:Tree):Tree.Node = self.root.leftMost

  proc succ*[Node:BinaryTreeNode](node: Node): Node =
    if not node.r.isLeaf: return node.r.leftMost
    else: return node.parentLeft
  proc pred*[Node:BinaryTreeNode](node: Node): Node =
    if not node.l.isLeaf: return node.l.rightMost
    else: return node.parentRight
  proc inc*[Node:BinaryTreeNode](node: var Node) =
    var node2 = node.succ
    swap node, node2
  proc dec*[Node:BinaryTreeNode](node: var Node) =
    var node2 = node.pred
    swap node, node2
  proc `+=`*[Node:BinaryTreeNode](node: var Node, n:int) =
    if n < 0: node -= (-n)
    for i in 0..<n: node.inc
  proc `-=`*[Node:BinaryTreeNode](node: var Node, n:int) =
    if n < 0: node += (-n)
    for i in 0..<n: node.dec

  proc index*[Node:BinaryTreeNode](t:Node):int =
#    static:
#      assert Node.Countable isnot void
    result = t.l.cnt
    var (t, p) = (t, t.p)
    while p != nil:
      if p.r == t: result += p.l.cnt + 1
      t = t.p
      p = p.p
  proc distance*[Node:BinaryTreeNode](t1, t2:Node):int =
#    static:
#      assert Node.Countable isnot void
    return t2.index - t1.index
  proc `*`*[Node:BinaryTreeNode](node:Node):auto = node.key
  iterator items*[Node:BinaryTreeNode](s:Slice[Node]):Node =
    var it = s.a
    while true:
      yield it
      if it == s.b: break
      it.inc
