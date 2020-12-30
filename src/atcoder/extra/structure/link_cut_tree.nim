when not declared ATCODER_LINK_CUT_TREE_HPP:
  const ATCODER_LINK_CUT_TREE_HPP* = 1
  import atcoder/extra/structure/splay_tree

  type LinkCutTree*[ST:SplayTree] = object
    splay_tree*:ST

  proc expose*[ST](self:LinkCutTree[ST], t:ST.Node):auto {.discardable.} =
    var
      rp:ST.Node = nil
      cur = t
    while cur != nil:
      self.splay_tree.splay(cur)
      cur.r = rp
      self.splay_tree.update(cur)
      rp = cur
      cur = cur.p
    self.splay_tree.splay(t)
    return rp

  proc link*[ST](self:LinkCutTree[ST], child, parent:ST.Node) =
    self.expose(child)
    self.expose(parent)
    child.p = parent
    parent.r = child
    self.splay_tree.update(parent)
  
  proc cut*[ST](self:LinkCutTree[ST], child:ST.Node) =
    self.expose(child)
    var parent = child.l
    child.l = nil
    parent.p = nil
    self.splay_tree.update(child)
  
  proc evert*[ST](self:LinkCutTree[ST], t:ST.Node) =
    self.expose(t)
    self.splay_tree.toggle(t)
    self.splay_tree.push(t)
  
  proc lca*[ST](self:LinkCutTree[ST], u, v:ST.Node):auto =
    if self.splay_tree.get_root(u) != self.splay_tree.get_root(v): return nil
    self.expose(u)
    return self.expose(v)

  proc get_kth*[ST](self:LinkCutTree[ST], x:ST.Node, k:int):auto =
    self.expose(x)
    while x != nil:
      self.push(x)
      if x.r != nil and x.r.sz > k:
        x = x.r;
      else:
        if x.r != nil: k -= x.r.sz
        if k == 0: return x
        k -= 1
        x = x.l
    return nil

  proc get_root*[ST](self:LinkCutTree[ST], x:ST.Node):auto =
    self.expose(x)
    while x.l != nil:
      self.splay_tree.push(x)
      x = x.l
    return x
  proc initLinkCutTree*[T](f:static[proc(a, b:T):T], s:static[proc(a:T):T], M1:T):auto =
    var st = initReversibleSplayTree(f, s, M1)
    return LinkCutTree[st.type](splay_tree:st)
  proc initLinkCutTree*[T](f:static[proc(a, b:T):T], M1:T):auto =
    proc s(a:T):T = a
    return initLinkCutTree[T](f, s, M1)

  proc alloc*[ST](self:LinkCutTree[ST], x:ST.D):ST.Node =
    return initNode(self.splay_tree, x)
