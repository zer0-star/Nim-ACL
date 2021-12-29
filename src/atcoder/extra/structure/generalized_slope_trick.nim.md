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
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_GENERALIZED_SLOPE_TRICK:\n  const ATCODER_GENERALIZED_SLOPE_TRICK*\
    \ = 1\n  import atcoder/extra/structure/splay_tree\n\n  proc split_lower_bound*[T:SomeSplayTree](self:T,\
    \ t:T.Node, key:T.D):(T.Node, T.Node) =\n    if t == self.leaf: return (self.leaf,\
    \ self.leaf)\n    self.push(t)\n    if key <= t.key:\n      var x = self.split_lower_bound(t.l,\
    \ key)\n      t.l = x[1]\n      t.p = nil\n      if x[1] != self.leaf: x[1].p\
    \ = t\n      return (x[0], self.update(t))\n    else:\n      var x = self.split_lower_bound(t.r,\
    \ key)\n      t.r = x[0]\n      t.p = nil\n      if x[0] != self.leaf: x[0].p\
    \ = t\n      return (self.update(t), x[1])\n\n  proc merge_wuh*[T:SomeSplayTree](self:\
    \ T, t1, t2:T.Node):T.Node =\n    if t1 == self.leaf and t2 == self.leaf: return\
    \ self.leaf\n    if t1 == self.leaf: self.splay(t2); return t2\n    if t2 == self.leaf:\
    \ self.splay(t1); return t1\n    self.splay(t1); self.splay(t2)\n    var (t1,\
    \ t2) = (t1, t2)\n    if self.count(t1) < self.count(t2): swap(t1, t2)\n    let\
    \ ct2 = self.count(t2) div 2\n    var (t2l, v, t2r) = self.split_index3(t2, ct2,\
    \ ct2 + 1)\n    var (t1l, t1r) = self.split_lower_bound(t1, v.key)\n    return\
    \ self.merge(self.merge_wuh(t1l, t2l), v, self.merge_wuh(t1r, t2r))\n\n  proc\
    \ insert_lower_bound*[T:SomeSplayTree](self: var T, t:T.Node, v:T.D):T.Node =\n\
    \    if t != self.leaf:\n      self.splay(t)\n      var x = self.split_lower_bound(t,\
    \ v)\n      return self.merge(self.merge(x[0], self.alloc(v)), x[1])\n    else:\n\
    \      return self.alloc(v)\n\n  type GeneralizedSlopeTrick*[T, ST] = object\n\
    \    inf*:int\n    min_f*:T\n    st*: ST\n    L*, R*: SplayTreeNode[T, T, void,\
    \ int]\n\n  proc initGeneralizedSlopeTrick*[T]:auto =\n    proc f(a, b:T):T =\
    \ a + b\n    proc g(a:T, b:int):T = a * b\n    var st = initLazySplayTree(f, f,\
    \ f, g, 0, 0)\n    result = GeneralizedSlopeTrick[T, st.type](st:st, inf:T.high\
    \ div 3, min_f: T(0))\n    result.st.init()\n    result.L = result.st.leaf\n \
    \   result.R = result.st.leaf\n  proc like*[T, ST](self: GeneralizedSlopeTrick[T,\
    \ ST]):auto =\n    result = GeneralizedSlopeTrick[T, ST](inf:T.high div 3, min_f:\
    \ T(0))\n    result.st.init(leaf = self.st.leaf)\n    result.L = result.st.leaf\n\
    \    result.R = result.st.leaf\n\n\n  proc push_R*[T](self:var GeneralizedSlopeTrick,\
    \ a: T) =\n    self.R = self.st.insert_lower_bound(self.R, a)\n\n  proc top_R*[ST:GeneralizedSlopeTrick](self:\
    \ var ST):ST.T =\n    if self.R != self.st.leaf:\n      self.R = self.st.get_left(self.R)\n\
    \      self.st.splay(self.R)\n      return self.R.key\n    else:\n      return\
    \ self.inf\n\n  proc pop_R*[ST:GeneralizedSlopeTrick](self:var ST):ST.T =\n  \
    \  result = self.top_R()\n    if self.R != self.st.leaf: self.R = self.st.erase(self.R,\
    \ false)\n\n  proc push_L*[T](self: var GeneralizedSlopeTrick, a:T) =\n    self.L\
    \ = self.st.insert_lower_bound(self.L, a)\n\n  proc top_L*[ST:GeneralizedSlopeTrick](self:\
    \ var ST):ST.T =\n    if self.L != self.st.leaf:\n      self.L = self.st.get_right(self.L)\n\
    \      self.st.splay(self.L)\n      return self.L.key\n    else:\n      return\
    \ -self.inf\n\n  proc pop_L*[ST:GeneralizedSlopeTrick](self: var ST):ST.T =\n\
    \    result = self.top_L()\n    if self.L != self.st.leaf: self.L = self.st.erase(self.L,\
    \ false)\n\n  proc len*[T](self:GeneralizedSlopeTrick):int =\n    self.st.count(self.L)\
    \ + self.st.count(self.R)\n\n  type Query*[T] = object\n    lx*, rx*, min_f*:\
    \ T\n\n  # return min f(x)\n  proc query*[ST:GeneralizedSlopeTrick](self:var ST):Query[ST.T]\
    \ =\n    return Query[ST.T](lx:self.top_L(), rx:self.top_R(), min_f:self.min_f)\n\
    \n  # f(x) += a\n  proc add_all*[ST:GeneralizedSlopeTrick](self:var ST, a:ST.T)\
    \ =\n    self.min_f += a\n\n  # add \\_\n  # f(x) += max(a - x, 0)\n  proc add_a_minus_x*[ST:GeneralizedSlopeTrick](self:\
    \ var ST, a:ST.T) =\n    self.min_f += max(ST.T(0), a - self.top_R())\n    self.push_R(a)\n\
    \    self.push_L(self.pop_R())\n\n  # add _/\n  # f(x) += max(x - a, 0)\n  proc\
    \ add_x_minus_a*[ST:GeneralizedSlopeTrick](self: var ST, a:ST.T) =\n    self.min_f\
    \ += max(ST.T(0), self.top_L() - a)\n    self.push_L(a)\n    self.push_R(self.pop_L())\n\
    \n  # add \\/\n  # f(x) += abs(x - a)\n  proc add_abs*[ST:GeneralizedSlopeTrick](self:\
    \ var ST, a:ST.T) =\n    self.add_a_minus_x(a)\n    self.add_x_minus_a(a)\n\n\
    \  # \\/ -> \\_\n  # f_{new} (x) = min f(y) (y <= x)\n  proc clear_right*[ST:GeneralizedSlopeTrick](self:\
    \ var ST) =\n    self.R = self.st.leaf\n\n  # \\/ -> _/\n  # f_{new} (x) = min\
    \ f(y) (y >= x)\n  proc clear_left*[ST:GeneralizedSlopeTrick](self: var ST) =\n\
    \    self.L = self.st.leaf\n\n  # \\/ -> \\_/\n  # f_{new} (x) = min f(y) (x-b\
    \ <= y <= x-a)\n  proc shift*[ST:GeneralizedSlopeTrick](self: var ST, a, b:ST.T)\
    \ =\n    assert a <= b\n    if self.L != self.st.leaf: self.st.apply_all(self.L,\
    \ a)\n    if self.R != self.st.leaf: self.st.apply_all(self.R, b)\n\n  # \\/.\
    \ -> .\\/\n  # f_{new} (x) = f(x - a)\n  proc shift*[ST:GeneralizedSlopeTrick](self:\
    \ var ST, a:ST.T) =\n    self.shift(a, a)\n\n  # return f(x) L, R \u3092\u7834\
    \u58CA\u3059\u308B\n  proc get*[ST:GeneralizedSlopeTrick](self: var ST, x:ST.T):ST.T\
    \ =\n    type T = ST.T\n    result = self.min_f\n    block:\n      var (l, r)\
    \ = self.st.split_lower_bound(self.L, x)\n      if r != self.st.leaf:\n      \
    \  result += r.sum\n        result -= x * T(self.st.count(r))\n      self.L =\
    \ self.st.merge(l, r)\n    block:\n      var (l, r) = self.st.split_lower_bound(self.R,\
    \ x);\n      if l != self.st.leaf:\n        result += x * T(self.st.count(l))\n\
    \        result -= l.sum\n      self.R = self.st.merge(l, r)\n\n  # f(x) += g(x)\n\
    \  proc merge*[ST:GeneralizedSlopeTrick](self: var ST, g:var ST) =\n    self.L\
    \ = self.st.merge_wuh(self.L, g.L)\n    self.R = self.st.merge_wuh(self.R, g.R)\n\
    \    self.min_f += g.min_f;\n"
  dependsOn:
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  isVerificationFile: false
  path: atcoder/extra/structure/generalized_slope_trick.nim
  requiredBy: []
  timestamp: '2021-11-18 02:51:01+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/generalized_slope_trick.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/generalized_slope_trick.nim
- /library/atcoder/extra/structure/generalized_slope_trick.nim.html
title: atcoder/extra/structure/generalized_slope_trick.nim
---
