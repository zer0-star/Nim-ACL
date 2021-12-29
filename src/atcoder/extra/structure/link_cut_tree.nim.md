---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
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
  _extendedRequiredBy: []
  _extendedVerifiedWith:
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
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LINK_CUT_TREE_HPP:\n  const ATCODER_LINK_CUT_TREE_HPP*\
    \ = 1\n  import atcoder/extra/structure/splay_tree\n\n  type LinkCutTree*[ST:SplayTreeType]\
    \ = object\n    splay_tree*:ST\n  template leaf[ST:LinkCutTree](self:ST):auto\
    \ = self.splay_tree.leaf\n\n  proc expose*[ST](self:LinkCutTree[ST], t:ST.Node):auto\
    \ {.discardable.} =\n    var\n      rp:ST.Node = self.leaf\n      cur = t\n  \
    \  while cur != nil:\n      self.splay_tree.splay(cur)\n      cur.r = rp\n   \
    \   self.splay_tree.update(cur)\n      rp = cur\n      cur = cur.p\n    self.splay_tree.splay(t)\n\
    \    return rp\n\n  proc link*[ST](self:LinkCutTree[ST], child, parent:ST.Node)\
    \ =\n    self.expose(child)\n    self.expose(parent)\n    child.p = parent\n \
    \   parent.r = child\n    self.splay_tree.update(parent)\n  \n  proc cut*[ST](self:LinkCutTree[ST],\
    \ child:ST.Node) =\n    self.expose(child)\n    var parent = child.l\n    child.l\
    \ = self.leaf\n    parent.p = nil\n    self.splay_tree.update(child)\n  \n  proc\
    \ evert*[ST](self:LinkCutTree[ST], t:ST.Node) =\n    self.expose(t)\n    self.splay_tree.toggle(t)\n\
    \    self.splay_tree.push(t)\n  \n  proc lca*[ST](self:LinkCutTree[ST], u, v:ST.Node):auto\
    \ =\n    if self.splay_tree.get_root(u) != self.splay_tree.get_root(v): return\
    \ nil\n    self.expose(u)\n    return self.expose(v)\n\n  proc get_kth*[ST](self:LinkCutTree[ST],\
    \ x:ST.Node, k:int):auto =\n    self.expose(x)\n    while x != self.leaf:\n  \
    \    self.push(x)\n      if x.r != self.leaf and x.r.sz > k:\n        x = x.r;\n\
    \      else:\n        if x.r != self.leaf: k -= x.r.sz\n        if k == 0: return\
    \ x\n        k -= 1\n        x = x.l\n    return nil\n\n  proc get_root*[ST](self:LinkCutTree[ST],\
    \ x:ST.Node):auto =\n    self.expose(x)\n    while x.l != self.leaf:\n      self.splay_tree.push(x)\n\
    \      x = x.l\n    return x\n  proc initLinkCutTree*[T](f:static[proc(a, b:T):T],\
    \ s:static[proc(a:T):T], M1:T):auto =\n    var st = initReversibleSplayTree(f,\
    \ s, M1)\n    return LinkCutTree[st.type](splay_tree:st)\n  proc initLinkCutTree*[T](f:static[proc(a,\
    \ b:T):T], M1:T):auto =\n    proc s(a:T):T = a\n    return initLinkCutTree[T](f,\
    \ s, M1)\n\n  proc alloc*[ST](self:var LinkCutTree[ST], x:ST.D):ST.Node =\n  \
    \  return initNode(self.splay_tree, x)\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  isVerificationFile: false
  path: atcoder/extra/structure/link_cut_tree.nim
  requiredBy: []
  timestamp: '2021-11-18 02:47:29+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
documentation_of: atcoder/extra/structure/link_cut_tree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/link_cut_tree.nim
- /library/atcoder/extra/structure/link_cut_tree.nim.html
title: atcoder/extra/structure/link_cut_tree.nim
---
