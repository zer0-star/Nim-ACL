---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
    title: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
    title: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_directedmst_test.nim
    title: verify/extra/graph/yosupo_directedmst_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_directedmst_test.nim
    title: verify/extra/graph/yosupo_directedmst_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SKEW_HEAP_HPP:\n  const ATCODER_SKEW_HEAP_HPP*\
    \ = 1\n  type\n    Node[T, E] = ref object\n      key:T\n      lazy:E\n      l,\
    \ r:Node[T,E]\n    SkewHeap[T,E] = object\n      rev:bool\n      g:proc(a:T, b:E):T\n\
    \      h:proc(a:E, b:E):E\n   \n  proc initSkewHeap*[T,E](rev = false):SkewHeap[T,E]\
    \ =\n    return SkewHeap[T,E](rev:rev, g:proc(a:T, b:E):T = a+b, h:proc(a:E,b:E):E\
    \ = a+b)\n    \n  proc initSkewHeap*[T,E](g:proc(a:T,b:E):T, h:proc(a, b:E):E,\
    \ rev = false): SkewHeap[T,E] =\n    return SkewHeap[T,E](rev:rev, g:g, h:h)\n\
    \  \n  proc propagate*[T,E](self:SkewHeap[T,E], t:Node[T,E]):Node[T,E] {.discardable.}\
    \ =\n    if t.lazy != 0:\n      if t.l != nil: t.l.lazy = self.h(t.l.lazy, t.lazy)\n\
    \      if t.r != nil: t.r.lazy = self.h(t.r.lazy, t.lazy)\n      t.key = self.g(t.key,\
    \ t.lazy)\n      t.lazy = 0\n    return t\n  \n  proc merge*[T,E](self:SkewHeap[T,E],\
    \ x, y:Node[T,E]):Node[T,E] =\n    if x == nil: return y\n    if y == nil: return\
    \ x\n    var\n      x = x\n      y = y\n    self.propagate(x);self.propagate(y)\n\
    \    if (x.key > y.key) xor self.rev: swap(x, y)\n    x.r = self.merge(y, x.r)\n\
    \    swap(x.l, x.r)\n    return x\n  \n  proc push*[T,E](self: SkewHeap[T,E],\
    \ root: var Node[T, E], key:T) =\n    root = self.merge(root, Node[T,E](key:key,\
    \ lazy:0, l:nil, r:nil))\n  \n  proc top*[T,E](self: SkewHeap[T,E], root:Node[T,E]):T\
    \ = self.propagate(root).key\n  \n  proc pop*[T,E](self: SkewHeap[T,E], root:var\
    \ Node[T,E]):T {.discardable.}=\n    let top = self.propagate(root).key\n    var\
    \ temp = root\n    root = self.merge(root.l, root.r)\n    return top\n  \n  proc\
    \ empty*[T,E](self: SkewHeap[T,E], root:Node[T,E]):bool = (root == nil)\n  \n\
    \  proc add*[T,E](self:SkewHeap[T,E], root:Node[T,E], lazy:E) =\n    if root !=\
    \ nil:\n      root.lazy = self.h(root.lazy, lazy)\n      self.propagate(root)\n\
    \  \n  proc makeheap*[T,E](self:SkewHeap[T,E]):Node[T,E] = nil\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/skew_heap.nim
  requiredBy:
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/extra/graph/chu_liu_edmonds.nim
  timestamp: '2020-12-19 22:31:09+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - verify/extra/graph/yosupo_directedmst_test.nim
  - verify/extra/graph/yosupo_directedmst_test.nim
documentation_of: atcoder/extra/structure/skew_heap.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/skew_heap.nim
- /library/atcoder/extra/structure/skew_heap.nim.html
title: atcoder/extra/structure/skew_heap.nim
---
