when not declared ATCODER_RED_BLACK_TREE_HPP:
  const ATCODER_RED_BLACK_TREE_HPP* = 1
  import std/sugar
#  {.experimental: "codeReordering".}
  {.push inline, discardable.}
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
  proc init*[T:RedBlackTree](self:var T, root: var T.Node) =
    self.leaf = self.Node(color: Color.black, id: -1)
    self.leaf.l = self.leaf
    self.leaf.r = self.leaf
    when T.Countable isnot void:
      self.leaf.cnt = 0
    if root != nil:
      self.root = root
      self.root.l = self.leaf
      self.root.r = self.leaf
      self.root.p = nil
      self.root.color = Color.black
    self.next_id = 0

#  proc initRedBlackTree*[K](root:RedBlackTreeNode[K, void]): RedBlackTree[K, void] = result.init()
#  proc initCountableRedBlackTree*[K](root:RedBlackTreeNode[K, int]): RedBlackTree[K, int] = result.init()

  include atcoder/extra/structure/binary_tree_node_utils

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
      stderr.write "id: ",self.id, " key: ", self.key, " color: ", self.color
      when T.Countable isnot void:
        stderr.write " cnt: ", self.cnt, " "
  #    if self.key == T.K.inf: stderr.write "inf"
      if self.p != nil: stderr.write " parent: ", self.p.id
      else: stderr.write " parent: nil"
      stderr.write "\n"
      if h >= 5:
        stderr.write "too deep!!!\n"
        assert false
        return
      rbt.write(self.l, h + 1)
      rbt.write(self.r, h + 1)
  
  proc write*[T:RedBlackTree](self: T) =
    stderr.write "======= RB-TREE =============\n"
    self.write(self.root, 0)
    stderr.write "======= END ==========\n"
  proc checkTree*[T:RedBlackTree](self: T) =
    doAssert self.root.color == Color.black
    var black_ct_s = initHashSet[int]()
    proc checkTreeSub(node:T.Node, black_ct:int) =
      var black_ct = black_ct
      if node.color == Color.black: black_ct.inc
      if node == self.leaf:
        black_ct_s.incl(black_ct)
        return
      if node.color == Color.red:
        doAssert node.l.color == Color.black and node.r.color == Color.black
      checkTreeSub(node.l, black_ct)
      checkTreeSub(node.r, black_ct)
    checkTreeSub(self.root, 0)
    doAssert black_ct_s.len == 1

  
  proc erase*[T:RedBlackTree](self: var T, node: T.Node):T.Node =
    var node = node
    self.size.dec
    var succ = node.succ
    if node.l != self.leaf and node.r != self.leaf:
      swap(node.color, succ.color)
      when T.Countable isnot void:
        swap(node.cnt, succ.cnt)
      # swap node and succ
      if node.r == succ:
        let tmp = succ.l
        succ.l = node.l
        if node.l != self.leaf:
          node.l.p = succ
        if node.r != self.leaf:
          node.r.p = succ
        node.l = tmp
        node.r = succ.r
        succ.r = node
        succ.p = node.p
        node.p = succ
        if succ.p != nil:
          if succ.p.l == node:
            succ.p.l = succ
          if succ.p.r == node:
            succ.p.r = succ
      else:
        swap(node.p, succ.p)
        swap(node.l, succ.l)
        swap(node.r, succ.r)
        if node.p != nil:
          if node.p.l == succ:
            node.p.l = node
          if node.p.r == succ:
            node.p.r = node
        if node.l != self.leaf:
          node.l.p = node
        if node.r != self.leaf:
          node.r.p = node
        if succ.p != nil:
          if succ.p.l == node:
            succ.p.l = succ
          if succ.p.r == node:
            succ.p.r = succ
        if succ.l != self.leaf:
          succ.l.p = succ
        if succ.r != self.leaf:
          succ.r.p = succ
      if self.root == node:
        self.root = succ

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
    return succ
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
