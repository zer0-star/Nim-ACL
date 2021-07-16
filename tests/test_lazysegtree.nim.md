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
  code: "import std/unittest\nimport std/sequtils\nimport atcoder/lazysegtree\n\n\
    #include <algorithm>\n#include <atcoder/lazysegtree>\n#include <string>\n#include\
    \ <vector>\n\n\nproc op_ss(a, b:int):int = max(a, b)\nproc op_ts(a, b:int):int\
    \ = a + b\nproc op_tt(a, b:int):int = a + b\nproc e_s():int = -1_000_000_000\n\
    proc e_t():int = 0\n\n#using starry_seg = lazy_segtree<int,\n#               \
    \ starry::op_ss,\n#                starry::e_s,\n#                int,\n#    \
    \            starry::op_ts,\n#                starry::op_tt,\n#              \
    \  starry::e_t>;\n\ntest \"LazySegtreeTest, Zero\":\n  block:\n    var s = initLazySegTree(0,\
    \ op_ss, e_s, op_ts, op_tt, e_t)\n    check -1_000_000_000 == s.all_prod()\n \
    \ block:\n    var s = initLazySegTree(0, op_ss, e_s, op_ts, op_tt, e_t)\n    check\
    \ -1_000_000_000 == s.all_prod()\n  block:\n    var s = initLazySegTree(10, op_ss,\
    \ e_s, op_ts, op_tt, e_t)\n    check -1_000_000_000 == s.all_prod()\n\ntest \"\
    LazySegtreeTest, Assign\":\n  var seg0 = initLazySegTree(10, op_ss, e_s, op_ts,\
    \ op_tt, e_t)\n\ntest \"LazySegtreeTest, Invalid\":\n  expect RangeError:\n  \
    \  var s = initLazySegTree(-1, op_ss, e_s, op_ts, op_tt, e_t)\n  var s = initLazySegTree(10,\
    \ op_ss, e_s, op_ts, op_tt, e_t)\n\n  expect AssertionError: discard s.get(-1)\n\
    \  expect AssertionError: discard s[-1]\n  expect AssertionError: discard s.get(10)\n\
    \  expect AssertionError: discard s[10]\n\n  expect AssertionError: discard s.prod(-1\
    \ ..< -1)\n  expect AssertionError: discard s.prod(3 ..< 2)\n  expect AssertionError:\
    \ discard s.prod(0 ..< 11)\n  expect AssertionError: discard s.prod(-1 ..< 11)\n\
    \ntest \"LazySegtreeTest, NaiveProd\":\n  for n in 0..50:\n    var seg = initLazySegTree(n,\
    \ op_ss, e_s, op_ts, op_tt, e_t)\n    var p = newSeq[int](n)\n    for i in 0..<n:\n\
    \      p[i] = (i * i + 100) mod 31\n#      seg.set(i, p[i])\n      seg[i] = p[i]\n\
    \    for l in 0..n:\n      for r in l..n:\n        var e = -1_000_000_000\n  \
    \      for i in l..<r:\n          e = max(e, p[i])\n        check e == seg.prod(l\
    \ ..< r)\n        check e == seg[l ..< r]\n\ntest \"LazySegtreeTest, NaiveProdBackwards\"\
    :\n  for n in 0..50:\n    var seg = initLazySegTree(n, op_ss, e_s, op_ts, op_tt,\
    \ e_t)\n    var p = newSeq[int](n)\n    for i in 0..<n:\n      p[i] = (i * i +\
    \ 100) mod 31\n#      seg.set(i, p[i])\n      seg[i] = p[i]\n    for l in 0..n:\n\
    \      for r in l..n:\n        var e = -1_000_000_000\n        for i in l..<r:\n\
    \          e = max(e, p[i])\n        check e == seg.prod(l .. ^(n - r + 1))\n\
    \        check e == seg[l .. ^(n - r + 1)]\n\ntest \"LazySegtreeTest, Usage\"\
    :\n  var seg = initLazySegTree(newSeqWith(10, 0), op_ss, e_s, op_ts, op_tt, e_t)\n\
    \  check 0 == seg.all_prod()\n  seg.apply(0 ..< 3, 5)\n  check 5 == seg.all_prod()\n\
    \  seg.apply(2, -10)\n  check -5 == seg.prod(2 ..< 3)\n  check -5 == seg[2 ..<\
    \ 3]\n  check 0 == seg.prod(2 ..< 4)\n  check 0 == seg[2 ..< 4]\n"
  dependsOn:
  - atcoder/lazysegtree.nim
  - atcoder/internal_bit.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/rangeutils.nim
  - atcoder/lazysegtree.nim
  isVerificationFile: false
  path: tests/test_lazysegtree.nim
  requiredBy: []
  timestamp: '2021-05-19 22:57:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_lazysegtree.nim
layout: document
redirect_from:
- /library/tests/test_lazysegtree.nim
- /library/tests/test_lazysegtree.nim.html
title: tests/test_lazysegtree.nim
---
