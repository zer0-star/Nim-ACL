---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP:\n  const\
    \ ATCODER_EXTRA_RANDOMIZED_BINARY_SEARCH_TREE_HPP* = 1\n  {.push inline.}\n  import\
    \ std/sugar, std/random, atcoder/rangeutils\n  type RBSTNode*[D, L, useSum] =\
    \ ref object\n    cnt*:int\n    l*,r*:RBSTNode[D, L, useSum]\n    key*:D\n   \
    \ when useSum isnot void:\n      sum*:D\n    when L isnot void:\n      lazy*:L\n\
    \    id:int\n\n  type RandomizedBinarySearchTree*[D,L,Node;useP:static[bool],\
    \ useSum;p:static[tuple]] = object of RootObj\n    root*: Node\n    when D isnot\
    \ void:\n      D0:D\n    when L isnot void:\n      L0:L\n    r:Rand\n    id_max:int\n\
    \n  template calc_op[ST:RandomizedBinarySearchTree](self:typedesc[ST], a, b:ST.D):auto\
    \ =\n    block:\n      let op = ST.p.op\n      op(a, b)\n  template calc_mapping[ST:RandomizedBinarySearchTree](self:typedesc[ST],\
    \ a:ST.L, b:ST.D):auto =\n    block:\n      let mapping = ST.p.mapping\n     \
    \ mapping(a, b)\n  template calc_composition[ST:RandomizedBinarySearchTree](self:typedesc[ST],\
    \ a, b:ST.L):auto =\n    block:\n      let composition = ST.p.composition\n  \
    \    composition(a, b)\n  template calc_p[ST:RandomizedBinarySearchTree](self:typedesc[ST],\
    \ a:ST.L, b:Slice[int]):auto =\n    block:\n      let s = ST.p.p\n      s(a, b)\n\
    \n  proc hasSum*(t:typedesc[RandomizedBinarySearchTree] or typedesc[RBSTNode]):bool\
    \ {.compileTime.} = t.useSum isnot void\n  #proc hasData*(t:typedesc):bool {.compileTime.}\
    \ = t.D isnot void\n  proc hasLazy*(t:typedesc):bool {.compileTime.} = t.L isnot\
    \ void\n#  proc hasP*(t:typedesc):bool {.compileTime.} = t.useP isnot void\n \
    \ #proc isPersistent*(t:typedesc):bool {.compileTime.} = t.Persistent isnot void\n\
    \n\n  proc initNode*[RBST:RandomizedBinarySearchTree](self:RBST, k:RBST.D, p:RBST.L,\
    \ id:int):auto =\n    result = RBSTNode[RBST.D, RBST.L, RBST.useSum](cnt:1, key:k,\
    \ lazy:p, l:nil, r:nil, id:id)\n    when RBST.hasSum: result.sum = k\n  proc initNode*[RBST:RandomizedBinarySearchTree](self:RBST,\
    \ k:RBST.D, id:int):auto =\n    result = RBSTNode[RBST.D, RBST.L, RBST.useSum](cnt:1,\
    \ key:k, l:nil, r:nil, id:id)\n    when RBST.hasSum: result.sum = k\n  \n  proc\
    \ initRandomizedBinarySearchTree*[D](seed = 2019):auto =\n    type Node = RBSTNode[D,\
    \ void, void]\n    RandomizedBinarySearchTree[D,void,Node,false,void,()](root:nil,\
    \ r:initRand(seed), id_max:0)\n  proc initRandomizedBinarySearchTree*[D](f:static[(D,D)->D],\
    \ D0:D, seed = 2019):auto =\n    type Node = RBSTNode[D, void, int]\n    RandomizedBinarySearchTree[D,void,Node,false,int,(op:f)](root:nil,\
    \ D0:D0, r:initRand(seed), id_max: 0)\n  proc initRandomizedBinarySearchTree*[D,\
    \ L](f:static[(D,D)->D], g:static[(L,D)->D], h:static[(L,L)->L], D0:D, L0:L, seed\
    \ = 2019):auto =\n    type Node = RBSTNode[D, L, int]\n    RandomizedBinarySearchTree[D,L,Node,false,int,(op:f,mapping:g,composition:h)](root:nil,\
    \ D0:D0, L0:L0, r:initRand(seed), id_max: 0)\n  proc initRandomizedBinarySearchTree*[D,\
    \ L](f:static[(D,D)->D], g:static[(L,D)->D], h:static[(L,L)->L], p:static[(L,Slice[int])->L],D0:D,L0:L,seed\
    \ = 2019):auto =\n    type Node = RBSTNode[D, L, int]\n    RandomizedBinarySearchTree[D,L,Node,true,int,(op:f,mapping:g,composition:h,p:p)](root:nil,\
    \ D0:D0, L0:L0, r:initRand(seed), id_max: 0)\n  \n  proc alloc*[RBST](self: var\
    \ RBST, key:RBST.D):auto =\n    when RBST.hasLazy:\n      result = self.initNode(key,\
    \ self.L0, self.id_max)\n    else:\n      result = self.initNode(key, self.id_max)\n\
    \    self.id_max.inc\n  #  return &(pool[ptr++] = Node(key, self.L0));\n  \n \
    \ template clone*[D,L,useSum](t:RBSTNode[D, L, useSum]):auto = t\n  proc test*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, n, s:int):bool = \n    const randMax = 18_446_744_073_709_551_615u64\n\
    \    let\n      q = randMax div n.uint64\n      qn = q * n.uint64\n    while true:\n\
    \      let x = self.r.next()\n      if x < qn: return x < s.uint64 * q\n  \n \
    \ proc count*[RBST:RandomizedBinarySearchTree](self: RBST, t:RBST.Node):auto =\
    \ (if t != nil: t.cnt else: 0)\n  proc sum*[RBST:RandomizedBinarySearchTree](self:\
    \ RBST, t:RBST.Node):auto = (if t != nil: t.sum else: self.D0)\n  proc len*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:RBST.Node):auto = self.count(t)\n  proc len*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST):auto = self.len(self.root)\n\n  proc update*[RBST:RandomizedBinarySearchTree](self:\
    \ RBST, t:var RBST.Node):RBST.Node {.inline.} =\n    t.cnt = self.count(t.l) +\
    \ self.count(t.r) + 1\n    when RBST.hasSum:\n      t.sum = RBST.calc_op(RBST.calc_op(self.sum(t.l),\
    \ t.key), self.sum(t.r))\n    t\n\n  proc propagate*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:RBST.Node):auto =\n    when RBST.hasLazy:\n      var t = clone(t)\n\
    \      if t.lazy != self.L0:\n        when RBST.useP:\n          var (li, ri)\
    \ = (0, 0)\n        if t.l != nil:\n          t.l = clone(t.l)\n          t.l.lazy\
    \ = RBST.calc_composition(t.lazy, t.l.lazy)\n          when RBST.useP: ri = li\
    \ + self.count(t.l)\n          t.l.sum = RBST.calc_mapping(when RBST.useP: RBST.calc_p(t.lazy,\
    \ li..<ri) else: t.lazy, t.l.sum)\n        when RBST.useP: li = ri\n        t.key\
    \ = RBST.calc_mapping(when RBST.useP: RBST.calc_p(t.lazy, li..<li+1) else: t.lazy,\
    \ t.key)\n        when RBST.useP: li.inc\n        if t.r != nil:\n          t.r\
    \ = clone(t.r)\n          t.r.lazy = RBST.calc_composition(t.lazy, t.r.lazy)\n\
    \          when RBST.useP: ri = li + self.count(t.r)\n          t.r.sum = RBST.calc_mapping(when\
    \ RBST.useP: RBST.calc_p(t.lazy, li..<ri) else: t.lazy, t.r.sum)\n        t.lazy\
    \ = self.L0\n      self.update(t)\n    else:\n      t\n  \n  proc merge*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, l, r:RBST.Node):auto =\n    if l == nil: return r\n    elif r == nil:\
    \ return l\n    var (l, r) = (l, r)\n    if self.test(l.cnt + r.cnt, l.cnt):\n\
    \      when RBST.hasLazy:\n        l = self.propagate(l)\n      l.r = self.merge(l.r,\
    \ r)\n      return self.update(l)\n    else:\n      when RBST.hasLazy:\n     \
    \   r = self.propagate(r)\n      r.l = self.merge(l, r.l)\n      return self.update(r)\n\
    \  \n  proc split*[RBST:RandomizedBinarySearchTree](self:var RBST, t:RBST.Node,\
    \ k:int):(RBST.Node, RBST.Node) =\n    if t == nil: return (t, t)\n    var t =\
    \ t\n    when RBST.hasLazy:\n      t = self.propagate(t)\n    if k <= self.count(t.l):\n\
    \      var s = self.split(t.l, k)\n      t.l = s[1]\n      return (s[0], self.update(t))\n\
    \    else:\n      var s = self.split(t.r, k - self.count(t.l) - 1)\n      t.r\
    \ = s[0]\n      return (self.update(t), s[1])\n  \n  proc build*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, s:Slice[int], v:seq[RBST.D]):auto =\n    let (l, r) = (s.a, s.b +\
    \ 1)\n    if l + 1 >= r: return self.alloc(v[l])\n    var (x, y) = (self.build(l..<(l\
    \ + r) shr 1, v), self.build((l + r) shr 1..<r, v))\n    return self.merge(x,\
    \ y)\n  \n  proc build*[RBST:RandomizedBinarySearchTree](self: var RBST, v:seq[RBST.D])\
    \ =\n    self.root = self.build(0..<v.len, v)\n  \n  proc to_vec*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, r:RBST.Node, v:var seq[RBST.D], i:var int) =\n    if r == nil: return\n\
    \    when RBST.hasLazy:\n      var r = r\n      r = self.propagate(r)\n    self.to_vec(r.l,\
    \ v, i)\n    v[i] = r.key\n    i.inc\n  #  *it = r.key;\n    self.to_vec(r.r,\
    \ v, i)\n  \n  proc to_vec*[RBST:RandomizedBinarySearchTree](self: var RBST, r:RBST.Node):auto\
    \ =\n    result = newSeq[RBST.D](self.count(r))\n    var i = 0\n    self.to_vec(r,\
    \ result, i)\n  \n  proc to_string*[RBST:RandomizedBinarySearchTree](self: var\
    \ RBST, r:RBST.Node):string =\n    return self.to_vec(r).join(\", \")\n  \n  proc\
    \ write_tree*[RBST:RandomizedBinarySearchTree](self: var RBST, r:RBST.Node, h\
    \ = 0) =\n    if h == 0: echo \"========== tree =======\"\n    if r == nil: return\n\
    \    when RBST.hasLazy:\n      var r = r\n      r = self.propagate(r)\n    for\
    \ i in 0..<h: stdout.write \"  \"\n    stdout.write r.id, \": \", r.key, \", \"\
    , r.sum\n    when RBST.hasLazy:\n      stdout.write \", \", r.lazy\n    echo \"\
    \"\n    self.write_tree(r.l, h+1)\n    self.write_tree(r.r, h+1)\n    if h ==\
    \ 0: echo \"========== end =======\"\n  \n  proc insert*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:var RBST.Node, k:int, v:RBST.D) =\n    var x = self.split(t, k)\n\
    \    t = self.merge(self.merge(x[0], self.alloc(v)), x[1]);\n  \n  proc erase*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:var RBST.Node, k:int) =\n    var x = self.split(t, k)\n    t = self.merge(x[0],\
    \ self.split(x[1], 1)[1])\n  \n  proc prod*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:var RBST.Node, p:Slice[int]):auto =\n    let (a, b) = p.halfOpenEndpoints\n\
    \    var\n      x = self.split(t, a)\n      y = self.split(x[1], b - a)\n    result\
    \ = self.sum(y[0])\n    var m = self.merge(y[0], y[1])\n    t = self.merge(x[0],\
    \ m)\n  \n  proc apply*[RBST:RandomizedBinarySearchTree](self:var RBST, t:var\
    \ RBST.Node, s:Slice[int], p:RBST.L) =\n    static: assert RBST.hasLazy\n    let\
    \ (a, b) = s.halfOpenEndpoints\n    var\n      x = self.split(t, a)\n      y =\
    \ self.split(x[1], b - a)\n    y[0].lazy = RBST.calc_composition(p, y[0].lazy)\n\
    \    var m = self.merge(self.propagate(y[0]), y[1])\n    t = self.merge(x[0],\
    \ m)\n  \n  proc set*[RBST:RandomizedBinarySearchTree](self: var RBST, t:var RBST.Node,\
    \ k:int, x:RBST.D) =\n    when RBST.hasLazy:\n      t = self.propagate(t)\n  \
    \  if k < self.count(t.l): self.set(t.l, k, x)\n    elif k == self.count(t.l):\n\
    \      t.key = x\n      t.sum = x\n    else: self.set(t.r, k - self.count(t.l)\
    \ - 1, x)\n    t = self.update(t)\n  \n  proc empty*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, t:RBST.Node):bool = return t == nil\n  proc makeset*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST):RBST.Node = nil \n\n\n  proc insert*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, k:int, v:RBST.D) = self.insert(self.root, k, v)\n  proc erase*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, k:int) = self.erase(self.root, k)\n  proc prod*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, p:Slice[int]):auto = self.prod(self.root, p)\n  proc `[]`*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, p:Slice[int]):auto = self.prod(self.root, p)\n  proc apply*[RBST:RandomizedBinarySearchTree](self:var\
    \ RBST, s:Slice[int], p:RBST.L) = self.apply(self.root, s, p)\n  proc set*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, k:int, x:RBST.D) = self.set(self.root, k, x)\n  proc `[]=`*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST, k:int, x:RBST.D) = self.set(self.root, k, x)\n  proc empty*[RBST:RandomizedBinarySearchTree](self:\
    \ var RBST):bool = self.empty(self.root)\n  {.pop.}\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  isVerificationFile: false
  path: atcoder/extra/structure/old_randomized_binary_search_tree.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/old_randomized_binary_search_tree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/old_randomized_binary_search_tree.nim
- /library/atcoder/extra/structure/old_randomized_binary_search_tree.nim.html
title: atcoder/extra/structure/old_randomized_binary_search_tree.nim
---
