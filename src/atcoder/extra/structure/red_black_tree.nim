when not declared ATCODER_RED_BLACK_TREE_HPP:
  const ATCODER_RED_BLACK_TREE_HPP* = 1
  import std/sugar
#  {.experimental: "codeReordering".}
  {.push inline.}
  type
    Color* = enum red, black
    RedBlackTreeNode*[K; Countable] = ref object
      p*, l*, r*: RedBlackTreeNode[K, Countable]
      key*: K
      color*: Color
      id*: int
      when Countable isnot void:
        cnt*: int
    RedBlackTreeType*[K, Node; Countable] = object of RootObj
      root*, leaf*: Node
      size*: int
      next_id*: int
    RedBlackTree*[K; Countable] = RedBlackTreeType[K, RedBlackTreeNode[K, Countable], Countable]

  proc newNode[T:RedBlackTree](self: var T, parent: T.Node): T.Node =
    result = T.Node(p:parent, l:self.leaf, r: self.leaf, color: Color.red, id: self.next_id)
    when T.Countable isnot void:
      result.cnt = 1

  proc newNode[T:RedBlackTree](self: var T, parent: T.Node, key: T.K): T.Node =
    result = self.newNode(parent)
    result.key = key
    self.next_id += 1

  proc initRedBlackTree*[K](root:RedBlackTreeNode[K, false] = nil): RedBlackTree[K, false] =
    var leaf = RedBlackTreeNode[K](color: Color.black, id: -1)
    leaf.l = leaf;leaf.r = leaf
    result = RedBlackTree[K](root: root, next_id: 0, leaf:leaf)
  proc initCountableRedBlackTree*[K](root:RedBlackTreeNode[K, true] = nil): RedBlackTree[K, true] =
    result = initRedBlackTree[K](root)
    result.cnt = 1

#  proc isLeaf*[Node:RedBlackTreeNode](self: Node):bool =
#    assert self != nil
    #### type1
  #  result = self.l == self
  #  if result: assert(self.r == self)
    #### type 2
#    return self.id == -1


  include atcoder/extra/structure/binary_tree_node_utils

  proc `*`*[T:RedBlackTreeNode](node:T):auto = node.key
  template update*[T:RedBlackTree](self:T, node: T.Node) =
    when T.Countable isnot void:
      if node == self.leaf or node == nil: return
      node.cnt = node.l.cnt + node.r.cnt
      node.cnt.inc
    discard

  proc rotateLeft[T:RedBlackTree](self: var T, parent: T.Node) =
    if parent == nil: return
    var right = parent.r
    parent.r = right.l
    if right.l != self.leaf: right.l.p = parent
    right.p = parent.p
    if parent.p == nil: self.root = right
    elif parent.p.l == parent: parent.p.l = right
    else: parent.p.r = right
    right.l = parent
    parent.p = right
    self.update(parent)
    self.update(right)
#    self.update(right.p)
  proc rotateRight[T:RedBlackTree](self: var T, parent: T.Node) =
    if parent == nil: return
    var left = parent.l
    parent.l = left.r
    if left.r != self.leaf : left.r.p = parent
    left.p = parent.p
    if parent.p == nil: self.root = left
    elif parent.p.r == parent: parent.p.r = left
    else: parent.p.l = left
    left.r = parent
    parent.p = left
    self.update(parent)
    self.update(left)
#    self.update(left.p)

  # insert {{{
  proc fixInsert[T:RedBlackTree](self: var T, node: T.Node) =
    ## Rebalances a tree after an insertion
    if T.Countable isnot void:
      var curr = node
      while curr != nil:
        self.update(curr)
        curr = curr.p

    var curr = node
    while curr != self.root and curr.p.color == Color.red:
      if curr.p.p != nil and curr.p == curr.p.p.l:
        var uncle = curr.p.p.r
        if uncle.color == Color.red:
          curr.p.color = Color.black
          uncle.color = Color.black
          curr.p.p.color = Color.red
          curr = curr.p.p
        else:
          if curr == curr.p.r:
            curr = curr.p
            self.rotateLeft(curr)
          curr.p.color = Color.black
          if curr.p.p != nil:
            curr.p.p.color = Color.red
            self.rotateRight(curr.p.p)
      elif curr.p.p != nil:
        var uncle = curr.p.p.l
        if uncle.color == Color.red:
          curr.p.color = Color.black
          uncle.color = Color.black
          curr.p.p.color = Color.red
          curr = curr.p.p
        else:
          if curr == curr.p.l:
            curr = curr.p
            self.rotateRight(curr)
          curr.p.color = Color.black
          if curr.p.p != nil:
            curr.p.p.color = Color.red
            self.rotateLeft(curr.p.p)
    self.root.color = Color.black


  proc insert*[T:RedBlackTree](self: var T, node:T.Node, next:T.Node): T.Node {.discardable.} =
    self.size += 1
    if next.l == self.leaf:
      # insert at next.l
      next.l = node
      node.p = next
    else:
      var curr = next.l.rightMost
      # insert at curr.r
      curr.r = node
      node.p = curr
    self.fixInsert(node)
    return node

  proc insert*[T:RedBlackTree](self: var T, next:T.Node, x:T.K): T.Node {.discardable.} =
    var node = self.newNode(T.Node(nil), x)
    return self.insert(node, next)
  # }}}

  # erase {{{
  proc fixErase*[T:RedBlackTree](self: var T, node: T.Node, parent: T.Node) =

    var
      child = node
      parent = parent
    while child != self.root and child.color == Color.black:
      if parent == nil: break # add!!!!!!!!
      if child == parent.l:
        var sib = parent.r
        if sib.color == Color.red:
          sib.color = Color.black
          parent.color = Color.red
          self.rotateLeft(parent)
          sib = parent.r
  
        if sib.l.color == Color.black and sib.r.color == Color.black:
          sib.color = Color.red
          child = parent
          parent = child.p
        else:
          if sib.r.color == Color.black:
            sib.l.color = Color.black
            sib.color = Color.red
            self.rotateRight(sib)
            sib = parent.r
          sib.color = parent.color
          parent.color = Color.black
          sib.r.color = Color.black
          self.rotateLeft(parent)
          child = self.root
          parent = child.p
      else:
        var sib = parent.l
        if sib.color == Color.red:
          sib.color = Color.black
          parent.color = Color.red
          self.rotateRight(parent)
          sib = parent.l

        if sib.r.color == Color.black and sib.l.color == Color.black:
          sib.color = Color.red
          child = parent
          parent = child.p
        else:
          if sib.l.color == Color.black:
            sib.r.color = Color.black
            sib.color = Color.red
            self.rotateLeft(sib)
            sib = parent.l
          sib.color = parent.color
          parent.color = Color.black
          sib.l.color = Color.black
          self.rotateRight(parent)
          child = self.root
          parent = child.p
    child.color = Color.black


  
  proc write*[T:RedBlackTree](rbt: T, self: T.Node, h = 0) =
    for i in 0..<h: stderr.write " | "
    if self == rbt.leaf:
      stderr.write "*\n"
    else:
      stderr.write "id: ",self.id, " key: ", self.key, " color: ", self.color, " cnt: ", self.cnt, " "
  #    if self.key == T.K.inf: stderr.write "inf"
      if self.p != nil: stderr.write " parent: ", self.p.id
      else: stderr.write " parent: nil"
      stderr.write "\n"
      if h >= 200:
        stderr.write "too deep!!!\n"
        assert false
        return
      rbt.write(self.l, h + 1)
      rbt.write(self.r, h + 1)
  
  proc write*[T:RedBlackTree](self: T) =
    stderr.write "======= RB-TREE =============\n"
    self.write(self.root, 0)
    stderr.write "======= END ==========\n"
  
  proc erase*[T:RedBlackTree](self: var T, node: T.Node) =
    # TODO
#    if node == nil:
#      echo "warning: erase nil"
#    if node == self.End or node == nil or node.isLeaf: return
    var node = node
  
    self.size.dec
  
    if node.l != self.leaf and node.r != self.leaf:
      let pred = node.pred
      swap(node.color, pred.color)
      when T.Countable isnot void:
        swap(node.cnt, pred.cnt)
      # swap node and pred
      if node.l == pred:
        let tmp = pred.r
        pred.r = node.r
        if node.l != self.leaf:
          node.l.p = pred
        if node.r != self.leaf:
          node.r.p = pred
        node.l = pred.l
        node.r = tmp
        pred.l = node
        pred.p = node.p
        node.p = pred
        if pred.p != nil:
          if pred.p.l == node:
            pred.p.l = pred
          if pred.p.r == node:
            pred.p.r = pred
      else:
        swap(node.p, pred.p)
        swap(node.l, pred.l)
        swap(node.r, pred.r)
        if node.p != nil:
          if node.p.l == pred:
            node.p.l = node
          if node.p.r == pred:
            node.p.r = node
        if node.l != self.leaf:
          node.l.p = node
        if node.r != self.leaf:
          node.r.p = node
        if pred.p != nil:
          if pred.p.l == node:
            pred.p.l = pred
          if pred.p.r == node:
            pred.p.r = pred
        if pred.l != self.leaf:
          pred.l.p = pred
        if pred.r != self.leaf:
          pred.r.p = pred
      if self.root == node:
        self.root = pred
  #    self.write()
  #    node.key = pred.key
  #    node.value = pred.value
  #    node = pred
    when T.Countable isnot void:
      proc update_parents(self:T, node:T.Node) =
        var curr = node
        while curr != nil:
          self.update(curr)
          curr = curr.p

    let child = if node.l != self.leaf: node.l else: node.r
    if child != self.leaf:
      child.p = node.p
      if node.p == nil:
        self.root = child
      elif node == node.p.l:
        node.p.l = child
      else:
        node.p.r = child
      when T.Countable isnot void:
        self.update_parents(node.p)
      if node.color == Color.black:
        self.fixErase(child, node.p)
    else:
      if node.p == nil:
        self.root = self.leaf
      elif node == node.p.l:
        node.p.l = self.leaf
      else:
        assert node == node.p.r
        node.p.r = self.leaf
      when T.Countable isnot void:
        self.update_parents(node.p)
      if node.color == Color.black:
        self.fixErase(self.leaf, node.p)
  # }}}
  
  proc len*[T:RedBlackTree](self: T): int =
    return self.size
  proc empty*[T:RedBlackTree](self: T): bool =
    return self.len == 0
  
  iterator iterOrder*[T:RedBlackTree](self: T): auto =
    var node = self.root
    var stack: seq[T.Node] = @[]
    while stack.len() != 0 or node != self.leaf:
      if node != self.leaf:
        stack.add(node)
        node = node.l
      else:
        node = stack.pop()
        if node == self.End: break
        yield node.key
        node = node.r
  {.pop.}
