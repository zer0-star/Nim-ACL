---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/structure/generalized_slope_trick.nim
    title: atcoder/extra/structure/generalized_slope_trick.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/generalized_slope_trick.nim
    title: atcoder/extra/structure/generalized_slope_trick.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/generalized_slope_trick.nim
    title: atcoder/extra/structure/generalized_slope_trick.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/generalized_slope_trick.nim
    title: atcoder/extra/structure/generalized_slope_trick.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/link_cut_tree.nim
    title: atcoder/extra/structure/link_cut_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/link_cut_tree.nim
    title: atcoder/extra/structure/link_cut_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/link_cut_tree.nim
    title: atcoder/extra/structure/link_cut_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/link_cut_tree.nim
    title: atcoder/extra/structure/link_cut_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/aoj_1508_splay_tree_test.nim
    title: verify/extra/structure/aoj_1508_splay_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/aoj_1508_splay_tree_test.nim
    title: verify/extra/structure/aoj_1508_splay_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
    title: verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
    title: verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
    title: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
    title: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
    title: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
    title: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_predecessor_problem_test.nim
    title: verify/extra/structure/yosupo_predecessor_problem_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_predecessor_problem_test.nim
    title: verify/extra/structure/yosupo_predecessor_problem_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
    title: verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
    title: verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SPLAY_TREE_HPP:\n  {.push inline.}\n  const ATCODER_SPLAY_TREE_HPP*\
    \ = 1\n\n  import atcoder/rangeutils\n\n  type useRev = int\n  type useSum = int\n\
    \n  template hasLazy(self:typedesc):bool = self.L isnot void\n\n  type SplayTreeNode*[D,\
    \ L, hasRev, hasSum] = ref object\n    cnt*:int\n    l*, r*, p*: SplayTreeNode[D,\
    \ L, hasRev, hasSum]\n    key*:D\n    id*:int\n    when hasSum isnot void:\n \
    \     sum*:D\n    when hasRev isnot void:\n      rev*:bool\n    when L isnot void:\n\
    \      lazy*:L\n\n  type SplayTreeType*[D, L, Node, hasRev, hasSum; p:static[tuple]]\
    \ = object of RootObj\n    root*, leaf*:Node\n    id_max*:int\n    M1:D\n    when\
    \ L isnot void:\n      OM0:L\n  type SplayTree*[D] = SplayTreeType[D, void, SplayTreeNode[D,\
    \ void, void, void], void, void, ()]\n  type SomeSplayTree* = SplayTreeType or\
    \ SplayTree\n\n  template calc_op[ST:SomeSplayTree](self:typedesc[ST], a, b:ST.D):auto\
    \ =\n    block:\n      let op = ST.p.op\n      op(a, b)\n  template calc_mapping[ST:SomeSplayTree](self:typedesc[ST],\
    \ a:ST.L, b:ST.D, c:untyped):auto =\n    block:\n      let mapping = ST.p.mapping\n\
    \      when ST.p.p == nil:\n        mapping(a, b)\n      else:\n        let p\
    \ = ST.p.p\n        mapping(p(a, c), b)\n  template calc_composition[ST:SomeSplayTree](self:typedesc[ST],\
    \ a, b:ST.L):auto =\n    block:\n      let composition = ST.p.composition\n  \
    \    composition(a, b)\n  template calc_s[ST:SomeSplayTree](self:typedesc[ST],\
    \ a:ST.D):auto =\n    block:\n      let s = ST.p.s\n      s(a)\n\n\n  proc initNode*[ST:SomeSplayTree](self:var\
    \ ST, key:ST.D):auto =\n    type \n      D = ST.D\n      L = ST.L\n      hasRev\
    \ = ST.hasRev\n      hasSum = ST.hasSum\n    result = SplayTreeNode[D, L, hasRev,\
    \ hasSum](key:key, l:self.leaf,r:self.leaf,p:nil,cnt:1,id:self.id_max)\n    self.id_max.inc\n\
    \    when hasRev isnot void: result.rev = false\n    when hasSum isnot void: result.sum\
    \ = key\n    when L isnot void: result.lazy = self.OM0\n  proc initNode*[ST:SomeSplayTree](self:var\
    \ ST):auto = ST.initNode(ST.D(0))\n\n  proc init*[ST:SomeSplayTree](self: var\
    \ ST, root: ST.Node = nil, leaf:ST.Node = nil) =\n    var leaf = leaf\n    if\
    \ leaf == nil:\n      # leaf\n      leaf = ST.Node(cnt:0, p:nil, id: -1)\n   \
    \   leaf.l = leaf;leaf.r = leaf\n      when ST.hasSum isnot void:\n        leaf.sum\
    \ = self.M1\n      when ST.hasLazy:\n        leaf.lazy = self.OM0\n    self.leaf\
    \ = leaf\n    if root == nil:\n      self.root = self.leaf\n    else:\n      self.root\
    \ = root\n      self.root.l = self.leaf\n      self.root.r = self.leaf\n    self.root.p\
    \ = nil\n    self.id_max = 0\n\n  proc init*[ST:SomeSplayTree](self: typedesc[ST],\
    \ root: ST.Node = nil):ST =\n    result = ST()\n    result.init(root)\n\n  template\
    \ getSplayTreeType*(D, L, hasRev, hasSum; p:static[tuple]):typedesc =\n    type\
    \ Node = SplayTreeNode[D, L, hasRev, hasSum]\n    SplayTreeType[D, L, Node, hasRev,\
    \ hasSum, p]\n\n  proc initSplayTree*[D]():auto =\n    getSplayTreeType(D, void,\
    \ void, void, ()).init()\n  proc initSplayTree*[D](f:static[proc(a, b:D):D], M1:D):auto\
    \ =\n    result = getSplayTreeType(D, void, void, useSum, (op:f)).init()\n   \
    \ result.M1 = M1\n  proc initReversibleSplayTree*[D](f:static[proc(a, b:D):D],\
    \ s:static[proc(a:D):D], M1:D):auto =\n    result = getSplayTreeType(D, void,\
    \ useRev, useSum, (op:f, s:s)).init()\n    result.M1 = M1\n  proc initReversibleSplayTree*[D](f:static[proc(a,\
    \ b:D):D], M1:D):auto =\n    proc s(a:D):D = a\n    return initReversibleSplayTree[D](f,\
    \ s, M1)\n  proc initLazyReversibleSplayTree*[D, L](f:static[proc(a, b:D):D],\
    \ g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], s:static[proc(a:D):D],\
    \ M1:D, OM0:L):auto =\n    result = getSplayTreeType(D, L, useRev, useSum, (op:f,\
    \ mapping:g, composition:h, s:s)).init()\n    result.M1 = M1\n    result.OM0 =\
    \ OM0\n  proc initLazyReversibleSplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L,\
    \ a:D):D], h:static[proc(a, b:L):L], M1:D, OM0:L):auto =\n    proc s(a:D):D =\
    \ a\n    return initLazyReversibleSplayTree(f, g, h, s, M1, OM0)\n  proc initLazySplayTree*[D,\
    \ L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L],\
    \ pp:static[proc(a:L, c:int):L], M1:D, OM0:L):auto =\n    result = getSplayTreeType(D,\
    \ L, void, useSum, (op:f, mapping:g, composition:h, p:pp)).init()\n    result.M1\
    \ = M1\n    result.OM0 = OM0\n  proc initLazySplayTree*[D, L](f:static[proc(a,\
    \ b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], M1:D, OM0:L):auto\
    \ =\n    initLazySplayTree[D, L](f, g, h, nil, M1, OM0)\n\n  proc is_root*[T:SomeSplayTree](self:T,\
    \ t:T.Node):bool =\n    return t.p == nil or (t.p.l != t and t.p.r != t)\n  \n\
    #  proc count*[T:SomeSplayTree](self:T, t:T.Node):int = return if t != nil: t.len\
    \ else: 0\n  proc count*[T:SomeSplayTree](self:T, t:T.Node):int = t.cnt\n\n  proc\
    \ update*[T:SomeSplayTree](self:T, t:T.Node):auto {.discardable.} =\n    t.cnt\
    \ = 1\n    when T.hasSum isnot void:\n      t.sum = t.key\n    if t.l != self.leaf:\n\
    \      t.cnt += t.l.cnt\n      when T.hasSum isnot void: t.sum = T.calc_op(t.l.sum,\
    \ t.sum)\n    if t.r != self.leaf:\n      t.cnt += t.r.cnt\n      when T.hasSum\
    \ isnot void: t.sum = T.calc_op(t.sum, t.r.sum)\n    return t\n\n  proc propagate*[T:SomeSplayTree](self:T,\
    \ t:T.Node, x:T.L) =\n    static: assert T.L isnot void\n    t.key = T.calc_mapping(x,\
    \ t.key, 1)\n    when T.hasSum isnot void: t.sum = T.calc_mapping(x, t.sum, self.count(t))\n\
    \    t.lazy = T.calc_composition(x, t.lazy)\n\n  proc toggle*[T:SomeSplayTree](self:T,\
    \ t:T.Node) =\n    static: assert T.hasRev isnot void\n    swap(t.l, t.r)\n  \
    \  when T.hasSum isnot void: t.sum = T.calc_s(t.sum)\n    t.rev = not t.rev\n\n\
    \  proc push*[T:SomeSplayTree](self:T, t:T.Node) =\n    when T.hasLazy:\n    \
    \  if t.lazy != self.OM0:\n        if t.l != self.leaf: self.propagate(t.l, t.lazy)\n\
    \        if t.r != self.leaf: self.propagate(t.r, t.lazy)\n        t.lazy = self.OM0\n\
    \    when T.hasRev isnot void:\n      if t.rev:\n        if t.l != self.leaf:\
    \ self.toggle(t.l)\n        if t.r != self.leaf: self.toggle(t.r)\n        t.rev\
    \ = false\n\n  proc rotr*[T:SomeSplayTree](self:T, t:T.Node) =\n    var\n    \
    \  x = t.p\n      y = x.p\n      t = t\n    x.l = t.r\n    if x.l != self.leaf:\
    \ t.r.p = x\n    t.r = x; x.p = t\n    self.update(x); self.update(t)\n    t.p\
    \ = y\n    if t.p != nil:\n      if y.l == x: y.l = t\n      if y.r == x: y.r\
    \ = t\n      self.update(y)\n\n  proc rotl*[T:SomeSplayTree](self:T, t:T.Node)\
    \ =\n    var\n      x = t.p\n      y = x.p\n      t = t\n    x.r = t.l\n    if\
    \ x.r != self.leaf: t.l.p = x\n    t.l = x; x.p = t;\n    self.update(x);self.update(t)\n\
    \    t.p = y\n    if t.p != nil:\n      if y.l == x: y.l = t\n      if y.r ==\
    \ x: y.r = t\n      self.update(y)\n\n  proc splay*[T:SomeSplayTree](self:T, t:T.Node)\
    \ =\n    self.push(t)\n    while not self.is_root(t):\n      var q = t.p\n   \
    \   if self.is_root(q):\n        self.push(q); self.push(t)\n        if q.l ==\
    \ t: self.rotr(t)\n        else: self.rotl(t)\n      else:\n        var r = q.p\n\
    \        self.push(r); self.push(q); self.push(t)\n        if r.l == q:\n    \
    \      if q.l == t: self.rotr(q); self.rotr(t)\n          else: self.rotl(t);\
    \ self.rotr(t)\n        else:\n          if q.r == t: self.rotl(q); self.rotl(t)\n\
    \          else: self.rotr(t); self.rotl(t)\n  \n  proc get_left*[T:SomeSplayTree](self:T,\
    \ t:T.Node):T.Node =\n    var t = t\n    while t.l != self.leaf: t = t.l\n   \
    \ return t\n  \n  proc get_right*[T:SomeSplayTree](self:T, t:T.Node):T.Node =\n\
    \    var t = t\n    while t.r != self.leaf: t = t.r\n    return t\n  \n  proc\
    \ erase*[T:SomeSplayTree](self:T, root:var T.Node, t:T.Node, return_right:static[bool]\
    \ = true):T.Node =\n    var t = t\n    self.splay(t)\n    #when return_right:\n\
    \    #  result = self.get_left(t.r)\n    #else:\n    #  result = self.get_right(t.l)\n\
    \    var (x, y) = (t.l, t.r)\n  # TODO\n  # delete t\n    if x == self.leaf:\n\
    \      t = y\n      if t != self.leaf: t.p = nil\n    elif y == self.leaf:\n \
    \     t = x\n      t.p = nil\n    else:\n      x.p = nil\n      t = self.get_right(x)\n\
    \      self.splay(t)\n      t.r = y\n      y.p = t\n      self.update(t)\n   \
    \ swap(root, t)\n    return root\n\n  proc sub_get_node*[T:SomeSplayTree](self:T,\
    \ t:var T.Node, k:int):T.Node {.discardable.} =\n    self.push(t)\n    if k <\
    \ self.count(t.l):\n      return self.sub_get_node(t.l, k)\n    elif k == self.count(t.l):\n\
    #      self.splay(t)\n      return t\n    else:\n      return self.sub_get_node(t.r,\
    \ k - self.count(t.l) - 1)\n\n  proc get_node*[T:SomeSplayTree](self:T, t:var\
    \ T.Node, k:int):T.Node =\n    self.splay(t)\n#    doAssert 0 <= k and k < self.count(t)\n\
    \    result = self.sub_get_node(t, k)\n    self.splay(result)\n#    self.update(result)\n\
    \n# original\n#  proc split*[T:SomeSplayTree](self: T, t:T.Node, k:int):(T.Node,\
    \ T.Node) =\n#    if t == nil: return (nil, nil)\n#    self.push(t)\n#    if k\
    \ <= self.count(t.l):\n#      var x = self.split(t.l, k)\n#      t.l = x[1]\n\
    #      t.p = nil\n#      if x[1] != nil: x[1].p = t\n#      return (x[0], self.update(t))\n\
    #    else:\n#      var x = self.split(t.r, k - self.count(t.l) - 1);\n#      t.r\
    \ = x[0]\n#      t.p = nil\n#      if x[0] != nil: x[0].p = t\n#      return (self.update(t),\
    \ x[1])\n\n\n#   get_node-based\n\n  proc split*[T:SomeSplayTree](self: T, t:T.Node):(T.Node,\
    \ T.Node) =\n    if t == self.leaf: return (self.leaf, self.leaf)\n    var t =\
    \ t\n    self.splay(t)\n    var p = t.l\n    if t.l != self.leaf:\n      t.l.p\
    \ = nil\n      t.l = self.leaf\n#    if p != self.leaf: self.update(p)\n    if\
    \ t != self.leaf: self.update(t)\n    return (p, t)\n\n  proc split_index*[T:SomeSplayTree](self:\
    \ T, t:T.Node, k:int):(T.Node, T.Node) =\n    if t == self.leaf: return (self.leaf,\
    \ self.leaf)\n    if k < 0:\n      return (self.leaf, t)\n    elif self.count(t)\
    \ <= k:\n      return (t, self.leaf)\n    var t = t\n    t = self.get_node(t,\
    \ k)\n    return self.split(t)\n\n    ##    assert u != self.leaf\n    #    self.splay(t)\n\
    \    #    var p = t.l\n    #    if t.l != self.leaf:\n    #      t.l.p = nil\n\
    \    #      t.l = self.leaf\n    ##    if p != self.leaf: self.update(p)\n   \
    \ #    if t != self.leaf: self.update(t)\n    #    return (p, t)\n\n  proc merge*[T:SomeSplayTree](self:T,\
    \ rest:varargs[T.Node]):T.Node =\n    var l = rest[0]\n    if rest.len == 1: return\
    \ l\n    var r = self.merge(rest[1 .. ^1])\n    if l == self.leaf and r == self.leaf:\
    \ return self.leaf\n    if l == self.leaf: self.splay(r); return r\n    if r ==\
    \ self.leaf: self.splay(l); return l\n    self.splay(l); self.splay(r)\n    l\
    \ = self.get_right(l)\n    self.splay(l)\n    l.r = r\n    r.p = l\n    self.update(l)\n\
    \    return l\n  \n  proc split_index3*[T:SomeSplayTree](self: T, t:T.Node, a,\
    \ b:int):(T.Node, T.Node, T.Node) =\n    self.splay(t)\n    var\n      x = self.split_index(t,\
    \ a)\n      y = self.split_index(x[1], b - a)\n    return (x[0], y[0], y[1])\n\
    \  \n  proc build_node*[T:SomeSplayTree](self: T, l, r:int, v:seq[T.Node]):T.Node\
    \ =\n    if l + 1 >= r: return v[l]\n    return self.merge(self.build_node(l,\
    \ (l + r) shr 1, v), self.build_node((l + r) shr 1, r, v))\n  \n  proc build_node*[T:SomeSplayTree](self:\
    \ T, v:seq[T.Node]):T.Node =\n    return self.build_node(0, v.len, v)\n  \n  proc\
    \ push_front_node*[T:SomeSplayTree](self: T, t:var T.Node, z:T.Node) =\n    if\
    \ t != self.leaf:\n      self.splay(t)\n      var cur = self.get_left(t)\n   \
    \   self.splay(cur)\n      z.p = cur\n      cur.l = z\n      self.splay(z)\n \
    \   t = z\n\n  proc push_back_node*[T:SomeSplayTree](self: T, t:var T.Node, z:T.Node)\
    \ =\n    if t != self.leaf:\n      self.splay(t)\n      var cur = self.get_right(t)\n\
    \      self.splay(cur)\n      z.p = cur\n      cur.r = z\n      self.splay(z)\n\
    \    t = z\n\n  proc insert_node_index*[T:SomeSplayTree](self: T, t:var T.Node,\
    \ k:int, v:T.Node) =\n    self.splay(t)\n    var x = self.split_index(t, k)\n\
    \    t = self.merge(self.merge(x[0], v), x[1])\n\n  proc insert*[T:SomeSplayTree](self:\
    \ var T, t:var T.Node, next:T.Node, v:T.D):T.Node =\n    result = self.initNode(v)\n\
    #    self.splay(t)\n    var x = self.split(next)\n    t = self.merge(self.merge(x[0],\
    \ result), x[1])\n\n\n  proc erase_index*[T:SomeSplayTree](self: T, t:var T.Node,\
    \ k:int) =\n    self.splay(t)\n    var\n      x = self.split_index(t, k)\n   \
    \   y = self.split_index(x[1], 1)\n    # TODO\n  #  delete y[0]\n    t = self.merge(x[0],\
    \ y[1])\n\n  proc sum*[T:SomeSplayTree](self:T, t:T.Node):auto =\n    static:\
    \ assert T.hasSum isnot void\n#    return if t != self.leaf: t.sum else: self.M1\n\
    \    return t.sum\n#    return if t != self.leaf: t.sum else: self.M1\n  proc\
    \ alloc*[T:SomeSplayTree](self:var T, x:T.D):auto =\n    return self.initNode(x)\n\
    \  \n  proc prod*[T:SomeSplayTree](self:T, t:var T.Node, s:Slice[int]):T.D =\n\
    \    let (a, b) = self.halfOpenEndpoints(s)\n    self.splay(t)\n    var x = self.split_index(t,\
    \ a)\n    var y = self.split_index(x[1], b - a)\n    var ret = self.sum(y[0])\n\
    \    t = self.merge(x[0], y[0], y[1])\n    return ret\n  \n  proc build*[T:SomeSplayTree](self:var\
    \ T, t:var T.Node, v:seq[T.D]) =\n    var vs = newSeq[T.Node](v.len)\n    for\
    \ i in 0..<v.len: vs[i] = self.initNode(v[i])\n    t = self.build_node(vs)\n\n\
    \  proc set*[T:SomeSplayTree](self:T, t:var T.Node, k:int, x:T.D) =\n    self.splay(t)\n\
    \    self.setImpl(t, k, x)\n\n  proc push_front*[T:SomeSplayTree](self:T, t:var\
    \ T.Node, x:T.D) =\n    self.push_front_node(t, self.initNode(x))\n  \n  proc\
    \ push_back*[T:SomeSplayTree](self:T, t:var T.Node, x:T.D) =\n    self.push_back_node(t,\
    \ self.initNode(x))\n  \n  proc insert_index*[T:SomeSplayTree](self:T, t:var T.Node,\
    \ k:int, x:T.D) =\n    self.insert_node_index(t, k, self.initNode(x))\n\n  proc\
    \ apply_all*[T:SomeSplayTree](self:T, t:var T.Node, pp:T.L) =\n    static: assert\
    \ T.L isnot void\n    self.splay(t)\n    self.propagate(t, pp)\n    self.push(t)\n\
    \n  proc apply*[T:SomeSplayTree](self:T, t:var T.Node, s:Slice[int], pp:T.L) =\n\
    \    static: assert T.L isnot void\n    let (a, b) = self.halfOpenEndpoints(s)\n\
    \    self.splay(t)\n    var\n      x = self.split_index(t, a)\n      y = self.split_index(x[1],\
    \ b - a)\n    self.apply_all(y[0], pp)\n    t = self.merge(x[0], y[0], y[1])\n\
    \n  proc write_tree*[T:SomeSplayTree](self:T, t:T.Node, h = 0) =\n    if h > 5:\n\
    \      echo \"too deep!!!!!!!!!!!!!!\"\n      return\n    for i in 0..<h:\n  \
    \    stdout.write(\"  \")\n    if t == self.leaf:\n      echo \"*\"\n    else:\n\
    #      assert t.id != -1\n      echo t.key, \" \", t.id\n      self.write_tree(t.l,\
    \ h + 1)\n      self.write_tree(t.r, h + 1)\n  proc write_tree*[T:SomeSplayTree](self:T)\
    \ =\n    echo \"==== tree ===== \"\n    self.write_tree(self.root)\n\n  proc setImpl*[T:SomeSplayTree](self:T,\
    \ t:var T.Node, k:int, x:T.D):T.Node {.discardable.} =\n    self.push(t)\n   \
    \ if k < self.count(t.l):\n      return self.setImpl(t.l, k, x)\n    elif k ==\
    \ self.count(t.l):\n      t.key = x\n      self.splay(t)\n      return t\n   \
    \ else:\n      return self.setImpl(t.r, k - self.count(t.l) - 1, x)\n\n  proc\
    \ check_tree*[T:SomeSplayTree](self:T):void = discard\n\n  proc erase_index*[T:SomeSplayTree](self:var\
    \ T, t:T.Node) = self.erase_index(self.root, t)\n  proc erase_index*[T:SomeSplayTree](self:\
    \ var T, k:int) = self.erase_index(self.root, k)\n  proc erase*[T:SomeSplayTree](self:var\
    \ T, t:T.Node, return_right:static[bool] = true):T.Node =\n    self.erase(self.root,\
    \ t, return_right)\n  proc get_node*[T:SomeSplayTree](self:var T, k:int):T.Node\
    \ = self.get_node(self.root, k)\n  proc get*[T:SomeSplayTree](self:var T, k:int):T.D\
    \ = self.get_node(k).D\n  proc `[]`*[T:SomeSplayTree](self:var T, k:int):T.D =\
    \ self.get_node(k).D\n  proc set*[T:SomeSplayTree](self:var T, k:int, x:T.D) =\
    \ self.set(self.root, k, x)\n  proc `[]=`*[T:SomeSplayTree](self:var T, k:int,\
    \ x:T.D) = self.set(self.root, k, x)\n  proc push_front*[T:SomeSplayTree](self:\
    \ var T, z:T.D) = self.push_front(self.root, z)\n  proc push_back*[T:SomeSplayTree](self:\
    \ var T, z:T.D) = self.push_back(self.root, z)\n  proc insert_index*[T:SomeSplayTree](self:var\
    \ T, k:int, x:T.D) = self.insert_index(self.root, k, x)\n  proc insert*[T:SomeSplayTree](self:\
    \ var T, next:T.Node, v:T.D):T.Node = self.insert(self.root, next, v)\n  proc\
    \ build*[T:SomeSplayTree](self:var T, v:seq[T.D]) = self.build(self.root, v)\n\
    \  proc apply_all*[T:SomeSplayTree](self:var T, pp:T.L) = self.apply_all(self.root,\
    \ pp)\n  proc apply*[T:SomeSplayTree](self:var T, s:Slice[int], pp:T.L) = self.apply(self.root,\
    \ s, pp)\n  proc prod*[T:SomeSplayTree](self:var T, s:Slice[int]):T.D = self.prod(self.root,\
    \ s)\n  proc `[]`*[T:SomeSplayTree](self:var T, s:Slice[int]):T.D = self.prod(self.root,\
    \ s)\n  {.pop.}\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  isVerificationFile: false
  path: atcoder/extra/structure/splay_tree.nim
  requiredBy:
  - atcoder/extra/structure/generalized_slope_trick.nim
  - atcoder/extra/structure/generalized_slope_trick.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/link_cut_tree.nim
  - atcoder/extra/structure/link_cut_tree.nim
  - atcoder/extra/structure/generalized_slope_trick.nim
  - atcoder/extra/structure/generalized_slope_trick.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/link_cut_tree.nim
  - atcoder/extra/structure/link_cut_tree.nim
  timestamp: '2021-11-18 02:47:29+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/map_test.nim
  - verify/map_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/extra/structure/yosupo_predecessor_problem_test.nim
  - verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
  - verify/extra/structure/yosupo_range_affine_range_sum_splay_tree_test.nim
  - verify/extra/structure/aoj_1508_splay_tree_test.nim
  - verify/extra/structure/aoj_1508_splay_tree_test.nim
  - verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
documentation_of: atcoder/extra/structure/splay_tree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/splay_tree.nim
- /library/atcoder/extra/structure/splay_tree.nim.html
title: atcoder/extra/structure/splay_tree.nim
---
