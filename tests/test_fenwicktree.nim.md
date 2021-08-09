---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/fenwicktree.nim
    title: atcoder/fenwicktree.nim
  - icon: ':x:'
    path: atcoder/fenwicktree.nim
    title: atcoder/fenwicktree.nim
  - icon: ':x:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
  - icon: ':x:'
    path: atcoder/internal_type_traits.nim
    title: atcoder/internal_type_traits.nim
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
  code: "import std/unittest\nimport atcoder/fenwicktree\nimport atcoder/modint as\
    \ modint_lib\n\ntype ll = int\ntype ull = uint\n\ntest \"FenwickTreeTest, Empty\"\
    :\n  var fw_ll:FenwickTree.getType(ll)\n  check 0 == fw_ll.sum(0 ..< 0)\n\n  var\
    \ fw_modint:FenwickTree.getType(modint)\n  check 0 == fw_modint.sum(0 ..< 0).val()\n\
    \ntest \"FenwickTreeTest, Assign\":\n  var fw = init_fenwick_tree[ll](10)\n\n\
    test \"FenwickTreeTest, Zero\":\n  var fw_ll = init_fenwick_tree[ll](0)\n  check\
    \ 0 == fw_ll.sum(0 ..< 0)\n\n  var fw_modint = init_fenwick_tree[modint](0)\n\
    \  check 0 == fw_modint.sum(0 ..< 0).val()\n\ntest \"FenwickTreeTest, OverFlowULL\"\
    :\n  var fw = init_fenwick_tree[ull](10)\n  for i in 0..<10:\n    fw.add(i, (1'u\
    \ shl 63) + i.uint)\n  for i in 0..10:\n    for j in i..10:\n      var sum = 0'u\n\
    \      for k in i ..< j:\n        sum += k.uint\n      check (if (j - i) mod 2\
    \ == 1: (1'u shl 63) + sum else: sum) == fw.sum(i ..< j)\n\ntest \"FenwickTreeTest,\
    \ NaiveTest\":\n  for n in 0..50:\n    var fw = init_fenwick_tree[ll](n)\n   \
    \ for i in 0..<n:\n      fw.add(i, i * i)\n    for l in 0..n:\n      for r in\
    \ l..n:\n        var sum = 0\n        for i in l..<r:\n          sum += i * i\n\
    \        check sum == fw.sum(l..<r)\n\nuseStaticModInt(mint, 11)\n\ntest \"FenwickTreeTest,\
    \ SMintTest\":\n  for n in 0..50:\n    var fw = init_fenwick_tree[mint](n)\n \
    \   for i in 0..<n:\n      fw.add(i, mint(i) * i)\n    for l in 0..n:\n      for\
    \ r in l..n:\n        var sum = mint(0)\n        for i in l ..< r:\n         \
    \ sum += mint(i) * i;\n        check sum == fw.sum(l ..< r)\n\ntest \"FenwickTreeTest,\
    \ MintTest\":\n  type mint = modint\n  mint.set_mod(11)\n  for n in 0..50:\n \
    \   var fw = init_fenwick_tree[mint](n)\n    for i in 0..<n:\n      fw.add(i,\
    \ mint(i) * i)\n    for l in 0..n:\n      for r in l..n:\n        var sum = mint(0)\n\
    \        for i in l..<r:\n          sum += mint(i) * i\n        check sum == fw.sum(l\
    \ ..< r)\n\ntest \"FenwickTreeTest, Invalid\":\n  expect RangeError:\n    var\
    \ s = init_fenwick_tree[int](-1)\n\n  var s = init_fenwick_tree[int](10)\n\n \
    \ expect AssertionError: s.add(-1, 0)\n  expect AssertionError: s.add(10, 0)\n\
    \n  expect AssertionError: discard s.sum(-1 ..< 3)\n  expect AssertionError: discard\
    \ s.sum(3 ..< 11)\n  expect AssertionError: discard s.sum(5 ..< 3)\n\n\ntest \"\
    FenwickTreeTest, Bound\":\n  var fw = init_fenwick_tree[int32](10)\n  fw.add(3,\
    \ int32.high)\n  fw.add(5, int32.low)\n  check -1 == fw.sum(0 ..< 10)\n  check\
    \ -1 == fw.sum(3 ..< 6)\n  check int32.high == fw.sum(3 ..< 4)\n  check int32.low\
    \ == fw.sum(4 ..< 10)\n\ntest \"FenwickTreeTest, Boundll\":\n  var fw = init_fenwick_tree[ll](10)\n\
    \  fw.add(3, ll.high)\n  fw.add(5, ll.low)\n  check -1 == fw.sum(0 ..< 10)\n \
    \ check -1 == fw.sum(3 ..< 6)\n  check ll.high == fw.sum(3 ..< 4)\n  check ll.low\
    \ == fw.sum(4 ..< 10)\n\ntest \"FenwickTreeTest, OverFlow\":\n  var \n    fw =\
    \ init_fenwick_tree[int32](20)\n    a = newSeq[ll](20)\n  for i in 0 ..< 10:\n\
    \    let x = int32.high\n    a[i] += x\n    fw.add(i, x)\n  for i in 10 ..< 20:\n\
    \    let x = int32.low\n    a[i] += x\n    fw.add(i, x)\n  a[5] += 11111\n  fw.add(5,\
    \ 11111)\n\n  for l in 0..20:\n    for r in l..20:\n      var sum = 0.ll\n   \
    \   for i in l ..< r:\n        sum += a[i]\n      var dif = sum - fw.sum(l ..<\
    \ r)\n      check 0 == dif mod (1.ll shl 32)\n\n##ifndef _MSC_VER\n#\n#TEST(FenwickTreeTest,\
    \ Int128) {\n#  fenwick_tree<__int128> fw(20);\n#  for (int i = 0; i < 20; i++)\
    \ {\n#    fw.add(i, i);\n#  }\n#\n#  for (int l = 0; l <= 20; l++) {\n#    for\
    \ (int r = l; r <= 20; r++) {\n#      ll sum = 0;\n#      for (int i = l; i <\
    \ r; i++) {\n#        sum += i;\n#      }\n#      check sum, fw.sum(l, r));\n\
    #    }\n#  }\n#}\n#\n##endif\n"
  dependsOn:
  - atcoder/internal_type_traits.nim
  - atcoder/fenwicktree.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_type_traits.nim
  - atcoder/fenwicktree.nim
  - atcoder/rangeutils.nim
  isVerificationFile: false
  path: tests/test_fenwicktree.nim
  requiredBy: []
  timestamp: '2020-12-05 23:18:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_fenwicktree.nim
layout: document
redirect_from:
- /library/tests/test_fenwicktree.nim
- /library/tests/test_fenwicktree.nim.html
title: tests/test_fenwicktree.nim
---
