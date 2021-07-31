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
    path: atcoder/lazysegtree.nim
    title: atcoder/lazysegtree.nim
  - icon: ':x:'
    path: atcoder/lazysegtree.nim
    title: atcoder/lazysegtree.nim
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
  code: "import atcoder/lazysegtree\nimport std/unittest\nimport std/sequtils\nimport\
    \ std/random as random_lib\n\nimport \"../test/utils/random.nim\"\n#include \"\
    ../utils/random.hpp\"\n#include <string>\n#include <vector>\n\n# time manager\n\
    type TimeManager = object\n  v:seq[int]\n\nproc initTimeManager(n:int):TimeManager\
    \ =\n  TimeManager(v:newSeqWith(n, -1))\n\nproc action(self: var TimeManager,\
    \ p:Slice[int] , time:int) =\n  for i in p:\n    self.v[i] = time\n\nproc prod(self:\
    \ TimeManager, p:Slice[int]):int =\n  var res = -1\n  for i in p:\n    res = max(res,\
    \ self.v[i])\n  return res\n\ntype S = tuple[l, r, time:int]\n\ntype T = tuple[new_time:int]\n\
    \nproc op_ss(l, r:S):S =\n  if l.l == -1: return r\n  if r.l == -1: return l\n\
    \  assert l.r == r.l\n  return (l.l, r.r, max(l.time, r.time))\n\nproc op_ts(l:T,\
    \ r:S):S =\n  if l.new_time == -1: return r\n  assert r.time < l.new_time\n  return\
    \ (r.l, r.r, l.new_time)\n\nproc op_tt(l, r:T):T =\n  if l.new_time == -1: return\
    \ r\n  if r.new_time == -1: return l\n  assert l.new_time > r.new_time\n  return\
    \ l\n\nproc e_s():S = (-1, -1, -1)\nproc e_t():T = (-1,)\n\n#using seg = lazy_segtree<S,\
    \ op_ss, e_s, T, op_ts, op_tt, e_t>;\n\ntest \"LazySegtreeStressTest, NaiveTest\"\
    :\n  var rnd = initRand(2020)\n  for n in 1..30:\n    for ph in 0..<10:\n    \
    \  var seg0 = initLazySegTree(n, op_ss, e_s, op_ts, op_tt, e_t)\n      var tm\
    \ = initTimeManager(n)\n      for i in 0..<n:\n        seg0.set(i, (i, i + 1,\
    \ -1))\n      var now = 0\n      for q in 0..<3000:\n        let ty = rnd.rand(3)\n\
    \        let (l, r) = randpair(0, n)\n        if ty == 0:\n          let res =\
    \ seg0.prod(l ..< r)\n          check l == res.l\n          check r == res.r\n\
    \          check tm.prod(l ..< r) == res.time\n        elif ty == 1:\n       \
    \   let res = seg0.get(l) # TODO: DOWN when l = n\n          check l == res.l\n\
    \          check l + 1 == res.r\n          check tm.prod(l ..< l + 1) == res.time\n\
    \        elif ty == 2:\n          now.inc\n          seg0.apply(l ..< r, (now,))\n\
    \          tm.action(l ..< r, now)\n        elif ty == 3:\n          now.inc\n\
    \          seg0.apply(l, (now,))\n          tm.action(l ..< l + 1, now)\n    \
    \    else:\n          assert(false)\n\ntest \"LazySegtreeStressTest, MaxRightTest\"\
    :\n  var rnd = initRand(2020)\n  for n in 1..30:\n    for ph in 0..<10:\n    \
    \  var seg0 = initLazySegTree(n, op_ss, e_s, op_ts, op_tt, e_t)\n      var tm\
    \ = initTimeManager(n)\n      for i in 0..<n:\n        seg0.set(i, (i, i + 1,\
    \ -1))\n      var now = 0\n      for q in 0..<1000:\n        let ty = rnd.rand(2)\n\
    \        let (l, r) = randpair(0, n)\n        if ty == 0:\n          check r ==\
    \ seg0.max_right(l, proc(s:S):bool =\n            if s.l == -1: return true\n\
    \            assert s.l == l\n            assert s.time == tm.prod(l ..< s.r)\n\
    \            return s.r <= r\n          )\n        else:\n          now.inc\n\
    \          seg0.apply(l ..< r, (now,))\n          tm.action(l ..< r, now)\n\n\
    test \"LazySegtreeStressTest, MinLeftTest\":\n  var rnd = initRand(2020)\n  for\
    \ n in 1..30:\n    for ph in 0..<10:\n      var seg0 = initLazySegTree(n, op_ss,\
    \ e_s, op_ts, op_tt, e_t)\n      var tm = initTimeManager(n)\n      for i in 0..<n:\n\
    \        seg0.set(i, (i, i + 1, -1))\n      var now = 0\n      for q in 0..<1000:\n\
    \        let ty = rnd.rand(2)\n        let (l, r) = randpair(0, n)\n        if\
    \ ty == 0:\n          check l == seg0.min_left(r, proc(s:S):bool =\n         \
    \   if s.l == -1: return true\n            assert s.r == r\n            assert\
    \ s.time == tm.prod(s.l ..< r)\n            return l <= s.l\n          )\n   \
    \     else:\n          now.inc\n          seg0.apply(l ..< r, (now,))\n      \
    \    tm.action(l ..< r, now)\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/lazysegtree.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/lazysegtree.nim
  isVerificationFile: false
  path: tests/test_lazysegtree_stress.nim
  requiredBy: []
  timestamp: '2020-09-25 20:51:01+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_lazysegtree_stress.nim
layout: document
redirect_from:
- /library/tests/test_lazysegtree_stress.nim
- /library/tests/test_lazysegtree_stress.nim.html
title: tests/test_lazysegtree_stress.nim
---
