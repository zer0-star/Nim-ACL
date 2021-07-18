---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree.nim
    title: atcoder/extra/structure/randomized_binary_search_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree.nim
    title: atcoder/extra/structure/randomized_binary_search_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':x:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
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
  code: "import std/unittest\nimport atcoder/extra/structure/set_map\n\ntest \"sortedSet,\
    \ int\":\n  var a = initSortedSet[int]()\n  a.insert(3)\n  a.insert(1)\n  a.insert(4)\n\
    \  a.insert(1)\n  a.insert(5)\n  check a{0} == 1\n  check a{1} == 3\n  check a{2}\
    \ == 4\n  check a{3} == 5\n  a.erase(1)\n  check a{1} == 4\n  check a{2} == 5\n\
    \ntest \"sortedMap, strind, int\":\n  var a = initSortedMap[string, int]()\n \
    \ a[\"three\"] = 3\n  a[\"one\"] = 2\n  check a{0} == (\"one\", 2)\n  a[\"four\"\
    ] = 4\n  a[\"one\"] = 1\n  a[\"five\"] = 5\n  check a{0} == (\"five\", 5)\n  check\
    \ a{1} == (\"four\", 4)\n  check a{2} == (\"one\", 1)\n  check a{3} == (\"three\"\
    , 3)\n\ntest \"sortedMultiSet, int\":\n  var a = initSortedMultiSet[int]()\n \
    \ a.insert(3)\n  a.insert(1)\n  a.insert(4)\n  a.insert(1)\n  a.insert(5)\n  check\
    \ a{0} == 1\n  check a{1} == 1\n  check a{2} == 3\n  check a{3} == 4\n  check\
    \ a{4} == 5\n  a.erase(1)\n  check a{0} == 1\n  check a{1} == 3\n  check a{2}\
    \ == 4\n  check a{3} == 5\n\ntest \"sortedMultiMap, strind, int\":\n  var a =\
    \ initSortedMultiMap[string, int]()\n  a.insert((\"three\", 3))\n  a.insert((\"\
    one\", 100))\n  a.insert((\"four\", 4))\n  a.insert((\"one\", 1))\n  a.insert((\"\
    five\", 5))\n  a.insert((\"one\", 3))\n  check a{0} == (\"five\", 5)\n  check\
    \ a{1} == (\"four\", 4)\n  check a{2} == (\"one\", 100)\n  check a{3} == (\"one\"\
    , 1)\n  check a{4} == (\"one\", 3)\n  check a{5} == (\"three\", 3)\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/randomized_binary_search_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map.nim
  isVerificationFile: false
  path: tests/test_extra_set_map.nim
  requiredBy: []
  timestamp: '2021-04-18 04:42:38+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_extra_set_map.nim
layout: document
redirect_from:
- /library/tests/test_extra_set_map.nim
- /library/tests/test_extra_set_map.nim.html
title: tests/test_extra_set_map.nim
---
