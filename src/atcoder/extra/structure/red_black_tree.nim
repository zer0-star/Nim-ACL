when not declared ATCODER_RED_BLACK_TREE_HPP:
  const ATCODER_RED_BLACK_TREE_HPP* = 1
  #import std/sugar
#  {.experimental: "codeReordering".}
  {.push inline, discardable.}
  type
    Color* = enum red, black
    RedBlackTreeNode*[K] = ref object
      p*, l*, r*: RedBlackTreeNode[K]
      key*: K
      color*: Color
      id*, cnt*: int32
      level*: int8
    RedBlackTreeType*[K, Node] = object of RootObj
      root*, leaf*: Node
      next_id*: int32
    RedBlackTree*[K] = RedBlackTreeType[K, RedBlackTreeNode[K]]
  proc getleaf*[K](self: RedBlackTree[K]):RedBlackTreeNode[K] =
    var leaf_node {.global.} :RedBlackTreeNode[K]
    once:
      leaf_node = nil
    if leaf_node == nil:
      leaf_node = self.Node(color: Color.black, id: -1)
      (leaf_node.l, leaf_node.r) = (leaf_node, leaf_node)
      leaf_node.level = 0
      leaf_node.cnt = 0
    return leaf_node

  proc newNode*[T:RedBlackTree](self: var T, parent: T.Node): T.Node =
    type Node_T = T.Node
    #result = T.Node(p:parent) # なぜかこうしないといけない。。。
    #result = new T.Node
    result = Node_T(p:parent, l:self.leaf, r: self.leaf, color: Color.red, id: self.next_id, cnt: 1)

  proc newNode*[T:RedBlackTree](self: var T, parent: T.Node, key: T.K): T.Node =
    result = self.newNode(parent)
    result.key = key
    self.next_id += 1
  proc init*[T:RedBlackTree](self:var T, root: var T.Node = nil) =
    self.leaf = self.getLeaf()
    if root != nil:
      self.root = root
      (self.root.l, self.root.r) = (self.leaf, self.leaf)
      root.id = -2
      self.root.p = nil
      self.root.color = Color.black
      self.update(root)
    #self.next_id = 0
    self.next_id = 100

  include atcoder/extra/structure/binary_tree_node_utils

  # checker, write
  proc write*[T:RedBlackTree](rbt: T, self: T.Node, h = 0) =
    for i in 0..<h: stderr.write " | "
    if self == nil:
      stderr.write "nil node?????\n"
      return
    if self.id == -1:
      stderr.write "*\n"
    else:
      stderr.write "id: ",self.id, " key: ", self.key, " color: ", self.color
      stderr.write " cnt: ", self.cnt, " ", " level: ", self.level
  #    if self.key == T.K.inf: stderr.write "inf"
      if self.p != nil: stderr.write " parent: ", self.p.id
      else: stderr.write " parent: nil"
      stderr.write "\n"
      if h >= 20:
        stderr.write "too deep!!!\n"
        assert false
        return
      rbt.write(self.l, h + 1)
      rbt.write(self.r, h + 1)
  
  proc write*[T:RedBlackTree](self: T) =
    stderr.write "======= RB-TREE =============\n"
    doAssert self.root != T.Node(nil)
    self.write(self.root, 0)
    stderr.write "======= END ==========\n"
  import sets
  proc checkTree*[T:RedBlackTree](self: T, node: T.Node = nil) =
    var node = node
    if node == nil:
      node = self.root
    #doAssert self.root.color == Color.black
    var black_ct_s = initHashSet[int]()
    proc checkTreeSub(node:T.Node, black_ct:int) =
      var black_ct = black_ct
      if node.color == Color.black: black_ct.inc
      if node.id == -1:
        black_ct_s.incl(black_ct)
        return
      if node.color == Color.red:
        doAssert node.l.color == Color.black and node.r.color == Color.black
      let d = if node.id >= 0: 1 else: 0
      doAssert node.cnt == node.l.cnt + node.r.cnt + d
      let
        lev_l = node.l.level + (if node.l.color == Color.black: 1 else: 0)
        lev_r = node.r.level + (if node.r.color == Color.black: 1 else: 0)
      if node.level != lev_l  or node.level != lev_r:
        echo "found!!"
        echo "node: ", node.id
        echo "node.level, lev_l, lev_r: ", node.level, " ", lev_l, " ", lev_r
        self.write(node)
      doAssert node.level == node.l.level + (if node.l.color == Color.black: 1 else: 0)
      doAssert node.level == node.r.level + (if node.r.color == Color.black: 1 else: 0)
      checkTreeSub(node.l, black_ct)
      checkTreeSub(node.r, black_ct)
    checkTreeSub(node, 0)
    doAssert black_ct_s.len == 1




  template update*[T:RedBlackTree](self:T, node: T.Node) =
    if node == self.leaf or node == nil: return
    node.cnt = node.l.cnt + node.r.cnt
    if node.id >= 0: node.cnt.inc
    node.level = node.l.level + (if node.l.color == Color.black: 1 else: 0)

  proc rotateLeft*[T:RedBlackTree](self: var T, parent: T.Node):T.Node {.discardable.} =
    if parent == nil: return
    var right = parent.r
    parent.r = right.l
    if right.l != self.leaf: right.l.p = parent
    right.p = parent.p
    if parent == self.root:
      self.root = right
    if parent.p == nil:
      discard
    elif parent.p.l == parent: parent.p.l = right
    else: parent.p.r = right
    right.l = parent
    parent.p = right
    self.update(parent)
    self.update(right)
    return right

  proc rotateRight*[T:RedBlackTree](self: var T, parent: T.Node):T.Node {.discardable.} =
    if parent == nil: return
    var left = parent.l
    parent.l = left.r
    if left.r != self.leaf: left.r.p = parent
    left.p = parent.p
    if parent == self.root:
      self.root = left
    if parent.p == nil:
      discard
    elif parent.p.r == parent: parent.p.r = left
    else: parent.p.l = left
    left.r = parent
    parent.p = left
    self.update(parent)
    self.update(left)
    return left

  proc insert*[T:RedBlackTree](self: var T, node:T.Node, next:T.Node): T.Node {.discardable.} =

    proc fixInsert(self: var T, node: T.Node) =
      var curr = node
      #while curr != self.root and curr.p.color == Color.red:
      while curr.p != nil and curr.p.color == Color.red:
        if curr.p.p != nil and curr.p == curr.p.p.l:
          var uncle = curr.p.p.r
          if uncle.color == Color.red:
            curr.p.color = Color.black
            uncle.color = Color.black
            curr.p.p.color = Color.red
            self.update(curr.p)
            self.update(curr.p.p)
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
            self.update(curr.p)
            self.update(curr.p.p)
            curr = curr.p.p
          else:
            if curr == curr.p.l:
              curr = curr.p
              self.rotateRight(curr)
            curr.p.color = Color.black
            if curr.p.p != nil:
              curr.p.p.color = Color.red
              self.rotateLeft(curr.p.p)
      while curr != nil:
        self.update(curr)
        if curr.p == nil: curr.color = Color.black
        curr = curr.p

    if next.l == self.leaf:
      # insert at next.l
      next.l = node
      node.p = next
      #self.write()
    else:
      var curr = next.l.rightMost
      # insert at curr.r
      curr.r = node
      node.p = curr
    self.update(node)
    self.fixInsert(node)
    return node

  proc insert*[T:RedBlackTree](self: var T, next:T.Node, x:T.K): T.Node {.discardable.} =
    when false:
      echo "next: ", next.id, " ", next.key
      if next.p == nil: echo "nil"
      else:
        echo next.p.l.id # なぜか0になる
      self.write
    var node = self.newNode(T.Node(nil), x)
    when false:
      echo "insert ", node.id, " ", node.key
      echo "next: ", next.id, " ", next.key
      if next.p == nil: echo "nil"
      else:
        echo next.p.l.id # なぜか0になる
      self.write
    result = self.insert(node, next)





  #proc getNodeStr(self:RedBlackTreeNode):string =
  #  if self == nil: "nil"
  #  else: $self.id

  proc update_parents[T:RedBlackTree](self:var T, node:T.Node):T.Node {.discardable.} =
    var curr = node
    while curr != nil:
      self.update(curr)
      if curr.p == nil: return curr
      curr = curr.p

  proc erase*[T:RedBlackTree](self: var T, node: T.Node):T.Node =
    proc fixErase(self: var T, node: T.Node, parent: T.Node) =
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
          else:
            self.update(parent)

          if sib.l.color == Color.black and sib.r.color == Color.black:
            sib.color = Color.red
            self.update(parent)
            child = parent
            parent = child.p
            self.update(parent)
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
            self.update_parents(sib)
            child = self.root
            parent = child.p
        else:
          var sib = parent.l
          if sib.color == Color.red:
            sib.color = Color.black
            parent.color = Color.red
            self.rotateRight(parent)
            sib = parent.l
          else:
            self.update(parent)

          if sib.r.color == Color.black and sib.l.color == Color.black:
            sib.color = Color.red
            self.update(parent)
            child = parent
            parent = child.p
            self.update(parent)
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
            self.update_parents(sib)
            child = self.root
            parent = child.p

      if child != self.leaf:
        child.color = Color.black
      var curr = parent
      self.update_parents(curr)

    var node = node
    var succ = node.succ
    if node.l != self.leaf and node.r != self.leaf:
      swap(node.color, succ.color)
      swap(node.cnt, succ.cnt)
      # swap node and succ
      if node.r == succ:
        let tmp = succ.l
        succ.l = node.l
        if node.l != self.leaf: node.l.p = succ
        if node.r != self.leaf: node.r.p = succ
        node.l = tmp
        node.r = succ.r
        succ.r = node
        succ.p = node.p
        node.p = succ
        if succ.p != nil:
          if succ.p.l == node: succ.p.l = succ
          if succ.p.r == node: succ.p.r = succ
      else:
        swap(node.p, succ.p)
        swap(node.l, succ.l)
        swap(node.r, succ.r)
        if node.p != nil:
          if node.p.l == succ: node.p.l = node
          if node.p.r == succ: node.p.r = node
        if node.l != self.leaf: node.l.p = node
        if node.r != self.leaf: node.r.p = node
        if succ.p != nil:
          if succ.p.l == node: succ.p.l = succ
          if succ.p.r == node: succ.p.r = succ
        if succ.l != self.leaf: succ.l.p = succ
        if succ.r != self.leaf: succ.r.p = succ
      if self.root == node:
        self.root = succ


    let child = if node.l != self.leaf: node.l else: node.r
    if child != self.leaf:
      child.p = node.p
      if node.p == nil: self.root = child
      elif node == node.p.l: node.p.l = child
      else: node.p.r = child

      if node.color == Color.black:
        self.fixErase(child, node.p)
      else:
        self.update_parents(node.p)
    else:
      if node.p == nil:
        self.root = self.leaf
      elif node == node.p.l:
        node.p.l = self.leaf
      else:
        assert node == node.p.r
        node.p.r = self.leaf

      if node.color == Color.black:
        self.fixErase(self.leaf, node.p)
      else:
        self.update_parents(node.p)
    return succ

# split, join

  proc expose*[T:RedBlackTree](self: var T, N:T.Node):(T.Node, T.Node, T.Node) =
    if not N.l.isLeaf:
      N.l.p = nil
      N.l.color = Color.black
    if not N.r.isLeaf:
      N.r.p = nil
      N.r.color = Color.black
    N.color = Color.black
    (result[0], result[2]) = (N.l, N.r)
    (N.l, N.r) = (self.leaf, self.leaf)
    result[1] = N
  
  proc join*[T:RedBlackTree](self: var T, TL, k, TR:T.Node):T.Node =
    proc joinRightRB[T:RedBlackTree](self:var T, TL, k, TR:T.Node):T.Node =
      doAssert TL.level >= TR.level
      if TL.color == Color.black and TL.level == TR.level:
        k.color = Color.red
        (k.l, k.r) = (TL, TR)
        k.p = nil
        if not k.l.isLeaf: k.l.p = k
        if not k.r.isLeaf: k.r.p = k
        self.update(k)
        return k
      TL.r.p = nil
      TL.r = self.joinRightRB(TL.r, k, TR)
      if not TL.r.isLeaf: TL.r.p = TL
      #if TL.color == Color.black and TL.r.r.color == Color.red:
      result = TL
      if TL.color == Color.black and TL.r.r.color == Color.red and TL.r.color == Color.red:
        TL.r.r.color = Color.black
        result = self.rotateLeft(TL)
      self.update(result)
    proc joinLeftRB[T:RedBlackTree](self:var T, TL, k, TR:T.Node):T.Node =
      doAssert TL.level <= TR.level
      if TR.color == Color.black and TR.level == TL.level:
        k.color = Color.red
        (k.l, k.r) = (TL, TR)
        k.p = nil
        if not k.l.isLeaf: k.l.p = k
        if not k.r.isLeaf: k.r.p = k
        self.update(k)
        return k
      TR.l.p = nil
      TR.l = self.joinLeftRB(TL, k, TR.l)
      if not TR.l.isLeaf: TR.l.p = TR
      result = TR
      # if TR.color == Color.black and TR.l.l.color == Color.red:
      if TR.color == Color.black and TR.l.l.color == Color.red and TR.l.color == Color.red:
        TR.l.l.color = Color.black
        result = self.rotateRight(TR)
      self.update(result)
    if TL.level > TR.level:
      result = self.joinRightRB(TL, k, TR)
      if result.color == Color.red and result.r.color == Color.red:
        result.color = Color.black
    elif TL.level < TR.level:
      result = self.joinLeftRB(TL, k, TR)
      if result.color == Color.red and result.l.color == Color.red:
        result.color = Color.black
    else:
      (k.l, k.r) = (TL, TR)
      if not k.l.isLeaf: k.l.p = k
      if not k.r.isLeaf: k.r.p = k
      if TL.color == Color.black and TR.color == Color.black:
        k.color = Color.red
      else:
        k.color = Color.black
      result = k
      self.update(result)
    result.color = Color.black
    result.p = nil
  
  proc join*[T:RedBlackTree](self: var T, L, R: T.Node):T.Node =
    proc splitLast(self: var T, k:T.Node):(T.Node, T.Node) = 
      var (L, k, R) = self.expose(k)
      if R.isLeaf:
        return (L, k)
      else:
        var (N, k2) = self.splitLast(R)
        return (self.join(L, k, N), k2)
  
    if L.isLeaf:
      R.color = Color.black
      return R
    else:
      var (L2, k) = self.splitLast(L)
      L2.color = Color.black
      return self.join(L2, k, R)
  
  proc split3*(self:var RedBlackTree, N:self.Node):auto =
    # Nを中心に左右に分ける
    if N.isLeaf:
      doAssert false
      #return (self.leaf, false, self.leaf) # !!!
    var path:seq[(self.Node, int)]
    block:
      var N = N
      while N.p != nil:
        var P = N.p
        if P.l == N:
          path.add (P, 0)
        elif P.r == N:
          path.add (P, 1)
        else:
          doAssert false
        N = P
    var (L, _, R) = self.expose(N)
    for (P, d) in path:
      if d == 0:
        P.r.p = nil
        P.r.color = Color.black
        R = self.join(R, P, P.r)
      else:
        P.l.p = nil
        P.l.color = Color.black
        L = self.join(P.l, P, L)
    return (L, R)
  
  proc split*(self:var RedBlackTree, N:self.Node):auto =
    var prev = self.newNode(self.Node(nil))
    self.insert(prev, N)
    return self.split3(prev)
  
  proc insert_by_join*[T:RedBlackTree](self: var T, node, next:T.Node):T.Node = # nextの前にnodeを入れる
    result = node
    var
      parent:T.Node
      d:int # left: 0, right: 1
    if next.l == self.leaf:
      # insert at next.l
      parent = next
      d = 0
    else:
      var curr = next.l.rightMost
      # insert at curr.r
      parent = curr
      d = 1
    var node = self.join(self.leaf, node, self.leaf)
    while parent != nil:
      var
        grand_parent = parent.p
        d2:int
      if grand_parent != nil:
        if grand_parent.l == parent:
          d2 = 0
        else:
          d2 = 1
      #var (L, p, R) = self.expose(parent)
      if d == 0:
        if parent.r != self.leaf:
          parent.r.p = nil
          parent.r.color = Color.black
        parent.l = self.leaf
        parent = self.join(node, parent, parent.r)
      else:
        if parent.l != self.leaf:
          parent.l.p = nil
          parent.l.color = Color.black
        parent.r = self.leaf
        parent = self.join(parent.l, parent, node)

      node = parent
      parent = grand_parent
      d = d2
    self.root = node
  proc insert_by_join*[T:RedBlackTree](self: var T, next:T.Node, key:T.K):T.Node = # nextの前にnodeを入れる
    self.insert_by_join(self.newNode(T.Node(nil), key), next)


  proc len*[T:RedBlackTree](self: T): int =
    return self.root.cnt
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
        #if node == self.End: break
        yield node.key
        node = node.r
  {.pop.}
