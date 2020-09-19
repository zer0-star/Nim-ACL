---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# {{{ RandomizedBinarySearchTree\nwhen not declared ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP:\n\
    \  const ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP* = 1\n  import std/sugar,\
    \ std/random\n  \n  type RandomizedBinarySearchTree*[D,L,useP,updateData] = object\
    \ of RootObj\n    when D isnot void:\n      f:(D,D)->D\n      D0:D\n    when L\
    \ isnot void:\n      h:(L,L)->L\n      g:(D,L)->D\n      L0:L\n    when useP isnot\
    \ void:\n      p:(L,Slice[int])->L\n    r:Rand\n    id_max:int\n  \n  type Node*[D,\
    \ L, updateData] = ref object\n    cnt*:int\n    l*,r*:Node[D, L, updateData]\n\
    \    key*:D\n    when updateData isnot void:\n      sum*:D\n    when L isnot void:\n\
    \      lazy*:L\n    id:int\n\n  proc isUpdateData*(t:typedesc[RandomizedBinarySearchTree]\
    \ or typedesc[Node]):bool {.compileTime.} = t.updateData isnot void\n  #proc hasData*(t:typedesc):bool\
    \ {.compileTime.} = t.D isnot void\n  proc hasLazy*(t:typedesc):bool {.compileTime.}\
    \ = t.L isnot void\n  proc hasP*(t:typedesc):bool {.compileTime.} = t.useP isnot\
    \ void\n  #proc isPersistent*(t:typedesc):bool {.compileTime.} = t.Persistent\
    \ isnot void\n\n\n  proc initNode*[RBST:RandomizedBinarySearchTree](self:RBST,\
    \ k:RBST.D, p:RBST.L, id:int):auto =\n    result = Node[RBST.D, RBST.L, RBST.updateData](cnt:1,\
    \ key:k, lazy:p, l:nil, r:nil, id:id)\n    when RBST.isUpdateData: result.sum\
    \ = k\n  proc initNode*[RBST:RandomizedBinarySearchTree](self:RBST, k:RBST.D,\
    \ id:int):auto =\n    result = Node[RBST.D, RBST.L, RBST.updateData](cnt:1, key:k,\
    \ l:nil, r:nil, id:id)\n    when RBST.isUpdateData: result.sum = k\n  \n  #vector<\
    \ Node > pool;\n  #int ptr;\n  proc initRandomizedBinarySearchTree*[D](seed =\
    \ 2019):auto =\n    RandomizedBinarySearchTree[D,void,void,void](r:initRand(seed),\
    \ id_max:0)\n  proc initRandomizedBinarySearchTree*[D](f:(D,D)->D, D0:D, seed\
    \ = 2019):auto =\n    RandomizedBinarySearchTree[D,void,void,int](f:f, D0:D0,\
    \ r:initRand(seed), id_max: 0)\n  proc initRandomizedBinarySearchTree*[D,L](f:(D,D)->D,\
    \ g:(D,L)->D, h:(L,L)->L, D0:D, L0:L, seed = 2019):auto =\n    RandomizedBinarySearchTree[D,L,void,int](f:f,\
    \ g:g, h:h, D0:D0, L0:L0, r:initRand(seed), id_max: 0)\n  proc initRandomizedBinarySearchTree*[D,\
    \ L](f:(D,D)->D, g:(D,L)->D, h:(L,L)->L, p:(L,Slice[int])->L,D0:D,L0:L,seed =\
    \ 2019):auto =\n    RandomizedBinarySearchTree[D,L,int,int](f:f, g:g, h:h, p:p,\
    \ D0:D0, L0:L0, r:initRand(seed), id_max: 0)\n  \n  proc alloc*[RBST](self: var\
    \ RBST, key:RBST.D):auto =\n    when RBST.hasLazy:\n      result = self.initNode(key,\
    \ self.L0, self.id_max)\n    else:\n      result = self.initNode(key, self.id_max)\n\
    \    self.id_max.inc\n  #  return &(pool[ptr++] = Node(key, self.L0));\n  \n \
    \ template clone*[D,L,updateData](t:Node[D, L, updateData]):auto = t\n  \n  proc\
    \ count*[RBST:RandomizedBinarySearchTree](self: RBST, t:Node):auto = (if t !=\
    \ nil: t.cnt else: 0)\n  proc sum*[RBST:RandomizedBinarySearchTree](self: RBST,\
    \ t:Node):auto = (if t != nil: t.sum else: self.D0)\n  \n  proc update*[RBST:RandomizedBinarySearchTree](self:\
    \ RBST, t:var Node):Node {.inline.} =\n    t.cnt = self.count(t.l) + self.count(t.r)\
    \ + 1\n    when RBST.isUpdateData:\n      t.sum = self.f(self.f(self.sum(t.l),\
    \ t.key), self.sum(t.r))\n    t\n  \n  template propagate*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:Node):auto =\n    when RBST.hasLazy:\n      t = clone(t)\n     \
    \ if t.lazy != self.L0:\n        when RBST.hasP:\n          var\n            li\
    \ = 0\n            ri = 0\n        if t.l != nil:\n          t.l = clone(t.l)\n\
    \          t.l.lazy = self.h(t.l.lazy, t.lazy)\n          when RBST.hasP: ri =\
    \ li + self.count(t.l)\n          t.l.sum = self.g(t.l.sum, when RBST.hasP: self.p(t.lazy,\
    \ li..<ri) else: t.lazy)\n        when RBST.hasP: li = ri\n        t.key = self.g(t.key,\
    \ when RBST.hasP: self.p(t.lazy, li..<li+1) else: t.lazy)\n        when RBST.hasP:\
    \ li.inc\n        if t.r != nil:\n          t.r = clone(t.r)\n          t.r.lazy\
    \ = self.h(t.r.lazy, t.lazy)\n          when RBST.hasP: ri = li + self.count(t.r)\n\
    \          t.r.sum = self.g(t.r.sum, when RBST.hasP: self.p(t.lazy, li..<ri) else:\
    \ t.lazy)\n        t.lazy = self.L0\n      self.update(t)\n    else:\n      t\n\
    \  \n  proc merge*[RBST:RandomizedBinarySearchTree](self: var RBST, l, r:Node):auto\
    \ =\n    if l == nil: return r\n    elif r == nil: return l\n  #  when RBST.hasLazy:\n\
    \    var (l, r) = (l, r)\n    if self.r.rand(l.cnt + r.cnt - 1) < l.cnt:\n   \
    \   when RBST.hasLazy:\n        l = self.propagate(l)\n      l.r = self.merge(l.r,\
    \ r)\n      return self.update(l)\n    else:\n      when RBST.hasLazy:\n     \
    \   r = self.propagate(r)\n      r.l = self.merge(l, r.l)\n      return self.update(r)\n\
    \  \n  proc split*[RBST:RandomizedBinarySearchTree](self:var RBST, t:Node, k:int):(Node,\
    \ Node) =\n    if t == nil: return (t, t)\n    var t = t\n    when RBST.hasLazy:\n\
    \      t = self.propagate(t)\n    if k <= self.count(t.l):\n      var s = self.split(t.l,\
    \ k)\n      t.l = s[1]\n      return (s[0], self.update(t))\n    else:\n     \
    \ var s = self.split(t.r, k - self.count(t.l) - 1)\n      t.r = s[0]\n      return\
    \ (self.update(t), s[1])\n  \n  proc build*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, s:Slice[int], v:seq[RBST.D]):auto =\n    let (l, r) = (s.a, s.b +\
    \ 1)\n    if l + 1 >= r: return self.alloc(v[l])\n    var (x, y) = (self.build(l..<(l\
    \ + r) shr 1, v), self.build((l + r) shr 1..<r, v))\n    return self.merge(x,\
    \ y)\n  \n  proc build*[RBST:RandomizedBinarySearchTree](self: var RBST, v:seq[RBST.D]):auto\
    \ =\n    return self.build(0..<v.len, v);\n  #  ptr = 0;\n  #  return build(0,\
    \ (int) v.size(), v);\n  \n  proc to_vec*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, r:Node, v:var seq[RBST.D], i:var int) =\n    if r == nil: return\n\
    \    when RBST.hasLazy:\n      var r = r\n      r = self.propagate(r)\n    self.to_vec(r.l,\
    \ v, i)\n    v[i] = r.key\n    i.inc\n  #  *it = r.key;\n    self.to_vec(r.r,\
    \ v, i);\n  \n  proc to_vec*[RBST:RandomizedBinarySearchTree](self: var RBST,\
    \ r:Node):auto =\n    result = newSeq[RBST.D](self.count(r))\n    var i = 0\n\
    \    self.to_vec(r, result, i)\n  \n  proc to_string*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, r:Node):string =\n    return self.to_vec(r).join(\", \")\n  \n  proc\
    \ write_tree*[RBST:RandomizedBinarySearchTree](self: var RBST, r:Node, h = 0)\
    \ =\n    if h == 0: echo \"========== tree =======\"\n    if r == nil: return\n\
    \    when RBST.hasLazy:\n      var r = r\n      r = self.propagate(r)\n    for\
    \ i in 0..<h: stdout.write \"  \"\n    stdout.write r.id, \": \", r.key, \", \"\
    , r.sum\n    when RBST.hasLazy:\n      stdout.write \", \", r.lazy\n    echo \"\
    \"\n    self.write_tree(r.l, h+1)\n    self.write_tree(r.r, h+1)\n    if h ==\
    \ 0: echo \"========== end =======\"\n  \n  proc insert*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:var Node, k:int, v:RBST.D) =\n    var x = self.split(t, k)\n   \
    \ t = self.merge(self.merge(x[0], self.alloc(v)), x[1]);\n  \n  proc erase*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:var Node, k:int) =\n    var x = self.split(t, k)\n    t = self.merge(x[0],\
    \ self.split(x[1], 1)[1])\n  \n  proc query*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:var Node, p:Slice[int]):auto =\n    let (a, b) = (p.a, p.b + 1)\n\
    \    var\n      x = self.split(t, a)\n      y = self.split(x[1], b - a)\n    result\
    \ = self.sum(y[0])\n    var m = self.merge(y[0], y[1])\n    t = self.merge(x[0],\
    \ m)\n  \n  proc set_propagate*[RBST:RandomizedBinarySearchTree](self:var RBST,\
    \ t:var Node, s:Slice[int], p:RBST.L) =\n    static: assert RBST.hasLazy\n   \
    \ let (a, b) = (s.a, s.b + 1)\n    var\n      x = self.split(t, a)\n      y =\
    \ self.split(x[1], b - a)\n    y[0].lazy = self.h(y[0].lazy, p)\n    var m = self.merge(self.propagate(y[0]),\
    \ y[1])\n    t = self.merge(x[0], m)\n  \n  proc set_element*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:var Node, k:int, x:RBST.D) =\n    when RBST.hasLazy:\n      t =\
    \ self.propagate(t)\n    if k < self.count(t.l): self.set_element(t.l, k, x)\n\
    \    elif k == self.count(t.l):\n      t.key = x\n      t.sum = x\n    else: self.set_element(t.r,\
    \ k - self.count(t.l) - 1, x)\n    t = self.update(t)\n  \n  proc len*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:Node):auto = self.count(t)\n  proc empty*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:Node):bool = return t == nil\n  proc makeset*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST):Node[RBST.D, RBST.L, RBST.updateData] = nil \n  # }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/randomized_binary_search_tree.nim
  requiredBy:
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/set_map.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/map_test.nim
  - verify/map_test.nim
documentation_of: atcoder/extra/structure/randomized_binary_search_tree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/randomized_binary_search_tree.nim
- /library/atcoder/extra/structure/randomized_binary_search_tree.nim.html
title: atcoder/extra/structure/randomized_binary_search_tree.nim
---
