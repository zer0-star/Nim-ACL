---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
  - icon: ':x:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
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
  code: "import atcoder/segtree\nimport std/sugar, std/sequtils\nimport unittest\n\
    \ntype segtree_naive[S] = object\n  n:int\n  op: (S,S)->S\n  e: ()->S\n  d:seq[string]#\
    \ ??\n\nproc initSegtreeNaive[S](n:int, op:(S,S)->S, e:()->S):segtree_naive[S]\
    \ =\n  segtree_naive[S](n:n, d:newSeqWith(n, e()), op:op, e:e)\n\nproc set[ST:segtree_naive](self:\
    \ var ST, p:int, x:ST.S) =\n  self.d[p] = x\nproc get[ST:segtree_naive](self:\
    \ ST, p:int):ST.S = self.d[p]\n\nproc prod[ST:segtree_naive](self: ST, p:Slice[int]):ST.S\
    \ =\n  var sum = self.e()\n  for i in p:\n    sum = self.op(sum, self.d[i])\n\
    \  return sum\n\nproc all_prod[ST:segtree_naive](self: ST):ST.S = return self.prod(0..<self.n)\n\
    proc max_right[ST:segtree_naive](self: ST, l:int, f:(ST.S)->bool):int =\n  var\
    \ sum = self.e()\n  assert(f(sum))\n  for i in l..<self.n:\n    sum = self.op(sum,\
    \ self.d[i])\n    if not f(sum): return i\n  return self.n\n\nproc min_left[ST:segtree_naive](self:\
    \ ST, r:int, f:(ST.S)->bool):int =\n  var sum = self.e()\n  assert(f(sum))\n \
    \ for i in countdown(r - 1, 0):\n    sum = self.op(self.d[i], sum)\n    if not\
    \ f(sum): return i + 1\n  return 0\n\nproc op(a, b:string):string =\n  assert(a\
    \ == \"$\" or b == \"$\" or a <= b)\n  if a == \"$\": return b\n  if b == \"$\"\
    : return a\n  return a & b\n\nproc e():string = return \"$\"\n\ntest \"SegtreeTest,\
    \ Zero\":\n  block:\n    var s = initSegTree(0, op, e)\n    check(\"$\" == s.all_prod())\n\
    \  #TODO\n  # {\n  #   seg s;\n  #   ASSERT_EQ(\"$\", s.all_prod());\n  # }\n\n\
    \ntest \"SegtreeTest, Invalid\":\n  expect RangeError:\n    var s = initSegTree(-1,\
    \ op, e)\n\n  var s = initSegTree(10, op, e)\n\n  expect AssertionError: discard\
    \ s.get(-1)\n  expect AssertionError: discard s.get(10)\n  \n  expect AssertionError:\
    \ discard s.prod(-1..< -1)\n  expect AssertionError: discard s.prod(3..<2)\n \
    \ expect AssertionError: discard s.prod(0..<11)\n  expect AssertionError: discard\
    \ s.prod(-1..<11)\n\n  expect AssertionError:\n#    discard s.max_right(11, proc(s:string):bool\
    \ = true)\n    proc f(s:string):bool = true\n    discard s.max_right(11, f)\n\
    \  expect AssertionError:\n#    discard s.max_right(-1, proc(s:string):bool =\
    \ true)\n    proc f(s:string):bool = true\n    discard s.max_right(-1, f)\n\n\
    #  expect AssertionError: discard s.max_right(0, proc(s:string):bool = false)\n\
    \  proc f(s:string):bool = false\n  expect AssertionError: \n#    proc f(s:string):bool\
    \ = false\n    discard s.max_right(0, f)\n\ntest \"SegtreeTest, One\":\n  var\
    \ s = initSegTree(1, op, e)\n  check \"$\" == s.all_prod()\n  check \"$\" == s.get(0)\n\
    \  check \"$\" == s[0]\n  check \"$\" == s.prod(0..<1)\n  s.set(0, \"dummy\")\n\
    \  check \"dummy\" == s.get(0)\n  check \"dummy\" == s[0]\n  check \"$\" == s.prod(0\
    \ ..< 0)\n  check \"dummy\" == s.prod(0 ..< 1)\n  check \"$\" == s.prod(1 ..<\
    \ 1)\n\nvar y:string\nproc leq_y(x:string):bool = return x.len <= y.len\n\ntest\
    \ \"SegtreeTest, CompareNaive\":\n  for n in 0..<30:\n    var\n      seg0 = initSegtreeNaive(n,\
    \ op, e)\n      seg1 = initSegTree(n, op, e)\n    for i in 0..<n:\n      var s\
    \ = \"\"\n      s &= chr('a'.int + i)\n      seg0.set(i, s)\n      seg1.set(i,\
    \ s)\n      seg1[i] = s\n\n    for l in 0..n:\n      for r in l..n:\n        check\
    \ seg0.prod(l ..< r) == seg1.prod(l ..< r)\n        check seg0.prod(l ..< r) ==\
    \ seg1[l ..< r]\n\n    for l in 0..n:\n      for r in l..n:\n        y = seg1.prod(l\
    \ ..< r)\n        check seg0.max_right(l, leq_y) == seg1.max_right(l, leq_y)\n\
    \        check seg0.max_right(l, leq_y) ==\n          seg1.max_right(l, (x:string)\
    \ => x.len <= y.len)\n\n    for l in 0..n:\n      for r in l..n:\n        y =\
    \ seg1.prod(l ..< r)\n        check seg0.min_left(r, leq_y) == seg1.min_left(r,\
    \ leq_y)\n        check seg0.min_left(r, leq_y) ==\n          seg1.min_left(r,\
    \ (x:string) => x.len <= y.len)\n\ntest \"SegtreeTest, CompareNaiveBackwards\"\
    :\n  for n in 0..<30:\n    var\n      seg0 = initSegtreeNaive(n, op, e)\n    \
    \  seg1 = initSegTree(n, op, e)\n    for i in 0..<n:\n      var s = \"\"\n   \
    \   s &= chr('a'.int + i)\n      seg0.set(i, s)\n      seg1.set(i, s)\n      seg1[i]\
    \ = s\n\n    for l in 0..n:\n      for r in l..n:\n        check seg0.prod(l ..<\
    \ r) == seg1.prod(l .. ^(n - r + 1))\n        check seg0.prod(l ..< r) == seg1[l\
    \ .. ^(n - r + 1)]\n\ntest \"SegtreeTest, Assign\":\n  var seg0:SegTreeType(string,\
    \ op, e)\n  seg0.init(10)\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  isVerificationFile: false
  path: tests/test_segtree.nim
  requiredBy: []
  timestamp: '2021-05-19 22:57:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_segtree.nim
layout: document
redirect_from:
- /library/tests/test_segtree.nim
- /library/tests/test_segtree.nim.html
title: tests/test_segtree.nim
---
