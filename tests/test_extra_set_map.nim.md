---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_utils.nim
    title: atcoder/extra/structure/binary_tree_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_utils.nim
    title: atcoder/extra/structure/binary_tree_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':x:'
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
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
  code: "import std/unittest\n\nimport std/algorithm, std/sequtils, std/sets, std/tables\n\
    import random\n# TODO: include\u3058\u3083\u306A\u3044\u3068\u3060\u3081\u306A\
    \u306E\u6CBB\u3059\nimport atcoder/extra/structure/set_map\n#{.checks:on.}\n\n\
    test \"sortedSet, int\":\n  var a = initSortedSet(int)\n  check a.empty()\n  a.checkTree()\n\
    \  a.insert(3)\n  a.checkTree()\n  a.insert(1)\n  a.checkTree()\n  a.insert(4)\n\
    \  a.checkTree()\n  a.insert(1)\n  a.checkTree()\n  a.insert(5)\n  a.checkTree()\n\
    \  check 4 in a\n  var it = a.find(4)\n  check it != a.end() and *it == 4\n  check\
    \ 2 notin a\n  check a.find(2) == a.end()\n  a.erase(4)\n  check 4 notin a\n \
    \ check a.find(4) == a.end()\n  a.checkTree()\n\ntest \"CountableSortedSet, int\"\
    :\n  var a = initSortedSet(int, true)\n  check a.empty()\n  a.checkTree()\n  a.insert(3)\n\
    \  a.checkTree()\n  a.insert(1)\n  a.checkTree()\n  a.insert(4)\n  a.checkTree()\n\
    \  a.insert(1)\n  a.checkTree()\n  a.insert(5)\n  a.checkTree()\n  check 4 in\
    \ a\n  var it = a.find(4)\n  check it != a.end() and *it == 4\n  check 2 notin\
    \ a\n  check a.find(2) == a.end()\n  check *a{0} == 1\n  check *a{1} == 3\n  check\
    \ *a{2} == 4\n  check *a{3} == 5\n  for i in 0..<a.len:\n    check a{i}.index\
    \ == i\n  a.erase(4)\n  a.checkTree()\n  check 4 notin a\n  check a.find(4) ==\
    \ a.end()\n  check *a{0} == 1\n  check *a{1} == 3\n  check *a{2} == 5\n  for i\
    \ in 0..<a.len:\n    check a{i}.index == i\n  check 3 in a\n  a.erase(3)\n  a.checkTree()\n\
    \  check 3 notin a\n  check *a{0} == 1\n  check *a{1} == 5\n\ntest \"CountableSortedSet,\
    \ int, reverse\":\n  proc f(a, b:int):bool = a > b\n  var a = initSortedSet(int,\
    \ true, f)\n  check a.empty()\n#  var a = initSortedSet(int, true)\n  a.checkTree()\n\
    \  a.insert(3)\n  a.checkTree()\n  a.insert(1)\n  a.checkTree()\n  a.insert(4)\n\
    \  a.checkTree()\n  a.insert(1)\n  a.checkTree()\n  a.insert(5)\n  a.checkTree()\n\
    \  check 4 in a\n  check a.find(4) != a.end()\n  check 2 notin a\n  check a.find(2)\
    \ == a.end()\n  check *a{0} == 5\n  check *a{1} == 4\n  check *a{2} == 3\n  check\
    \ *a{3} == 1\n  for i in 0..<a.len:\n    check a{i}.index == i\n  a.erase(4)\n\
    \  a.checkTree()\n  check 4 notin a\n  check *a{0} == 5\n  check *a{1} == 3\n\
    \  check *a{2} == 1\n  for i in 0..<a.len:\n    check a{i}.index == i\n  check\
    \ 3 in a\n  a.erase(3)\n  a.checkTree()\n  check 3 notin a\n  check *a{0} == 5\n\
    \  check *a{1} == 1\n\ntest \"sortedMap, strind, int\":\n  var a = initSortedMap(string,\
    \ int)\n  check a.empty()\n  a[\"three\"] = 3\n  a.checkTree()\n  a[\"one\"] =\
    \ 2\n  a.checkTree()\n  a[\"four\"] = 4\n  a.checkTree()\n  a[\"one\"] = 1\n \
    \ a.checkTree()\n  a[\"five\"] = 5\n  a.checkTree()\n  check \"four\" in a\n \
    \ check a[\"four\"] == 4\n  check \"hoge\" notin a\n  a.erase(\"four\")\n  a.checkTree()\n\
    \  check \"four\" notin a\n\ntest \"sortedMultiSet, int\":\n  var a = initSortedMultiSet(int)\n\
    \  a.checkTree()\n  check a.empty()\n  a.insert(3)\n  a.checkTree()\n  a.insert(1)\n\
    \  a.checkTree()\n  a.insert(4)\n  a.checkTree()\n  a.insert(1)\n  a.checkTree()\n\
    \  a.insert(5)\n  a.checkTree()\n  check 1 in a\n  check 7 notin a\n  a.erase(1)\n\
    \  check 1 in a\n  a.erase(1)\n  check 1 notin a\n\ntest \"sortedMultiMap, string,\
    \ int\":\n  var a = initSortedMultiMap(string, int, countable = false)\n  check\
    \ a.empty()\n  a.checkTree()\n  a.insert((\"three\", 3))\n  a.checkTree()\n  a.insert((\"\
    one\", 100))\n  a.checkTree()\n  a.insert((\"four\", 4))\n  a.checkTree()\n  a.insert((\"\
    one\", 1))\n  a.checkTree()\n  a.insert((\"five\", 5))\n  a.checkTree()\n  a.insert((\"\
    one\", 3))\n  a.checkTree()\n  check \"one\" in a\n  check \"hundred\" notin a\n\
    \  a.erase(\"one\")\n  a.checkTree()\n  check \"one\" in a\n  a.erase(\"one\"\
    )\n  a.checkTree()\n  check \"one\" in a\n  a.erase(\"one\")\n  a.checkTree()\n\
    \  check \"one\" notin a\n\n\ntest \"sortedSet, int\":\n  var rnd = initRand(2021)\n\
    #  var st = initSortedSet(int)\n  var st = SortedSet(int).default\n  check st.empty()\n\
    \  var v = newSeq[int]()\n  for i in 0..1000:\n    let t = rnd.rand(1..2)\n  \
    \  if t == 1: # insert\n      let r = rnd.rand(1..30)\n      v.add(r)\n      v\
    \ = v.toHashSet.toSeq.sorted\n      st.insert(r)\n      st.checkTree()\n    elif\
    \ t == 2: # erase\n      var r = rnd.rand(1..30)\n      if r notin st: continue\n\
    \      var v2 = newSeq[int]()\n      for p in v.mitems:\n        if p == r: continue\n\
    \        v2.add(p)\n      swap(v, v2)\n      st.erase(r)\n      st.checkTree()\n\
    \    else:\n      check false\n    var v2 = newSeq[int]()\n    for t in st:\n\
    \      v2.add(t)\n    check v == v2\n\ntest \"sortedMap, int\":\n  var rnd = initRand(2021)\n\
    \  var st = initSortedMap(int, int, true)\n  check st.empty()\n  st.checkTree()\n\
    \  var v = initTable[int, int]()\n  for i in 0..1000:\n    let t = rnd.rand(1..2)\n\
    \    if t == 1:\n      let r, s = rnd.rand(1..30)\n      if r notin v: v[r] =\
    \ 0\n      v[r] = s\n      st[r] = s\n      st.checkTree()\n    elif t == 2:\n\
    \      let r = rnd.rand(1..30)\n      if r notin st: continue\n      v.del(r)\n\
    \      while r in st: st.erase(r); st.checkTree()\n    else:\n      check false\n\
    \    var v2 = newSeq[(int, int)]()\n    for k,v in st:\n      v2.add((k,v))\n\
    \    var v3 = newSeq[(int, int)]()\n    for k,v in v:\n      v3.add((k,v))\n \
    \   v3.sort\n    check v3 == v2\n  var v3 = newSeq[(int, int)]()\n  for k,v in\
    \ v:\n    v3.add((k,v))\n  v3.sort\n  for i in 0..<v.len:\n    check v3[i] ==\
    \ *st{i}\n    check st{i}.index == i\n\ntest \"sortedMultiSet, int\":\n  var rnd\
    \ = initRand(2021)\n  var st = initSortedMultiSet(int, true)\n  check st.empty()\n\
    \  var v = newSeq[int]()\n  for i in 0..1000:\n    let t = rnd.rand(1..2)\n  \
    \  if t == 1: # insert\n      let r = rnd.rand(1..30)\n      st.insert(r)\n  \
    \    st.checkTree()\n      v.add(r)\n      v.sort()\n    elif t == 2: # erase\n\
    \      var r = rnd.rand(1..30)\n      if r notin st: continue\n      var v2 =\
    \ newSeq[int]()\n      for p in v.mitems:\n        if p == r: continue\n     \
    \   v2.add(p)\n      swap(v, v2)\n      while r in st: st.erase(r);st.checkTree()\n\
    \    else:\n      check false\n    var v2 = newSeq[int]()\n    for t in st:\n\
    \      v2.add(t)\n    check v == v2\n  for i in 0..<v.len:\n    check v[i] ==\
    \ *st{i}\n    check st{i}.index == i\n\ntest \"sortedMultiMap, int\":\n  var rnd\
    \ = initRand(2021)\n  var st = initSortedMultiMap(int, int)\n  check st.empty()\n\
    \  var v = newSeq[(int, int)]()\n  var s = 0\n  for i in 0..1000:\n    let t =\
    \ rnd.rand(1..2)\n    if t == 1:\n      s.inc\n      let r = rnd.rand(1..30)\n\
    \      v.add((r, s))\n      v.sort()\n      st.insert((r, s))\n      st.checkTree()\n\
    \    elif t == 2:\n      let r = rnd.rand(1..30)\n      if r notin st: continue\n\
    \      var v2 = newSeq[(int, int)]()\n      for p in v.mitems:\n        if p[0]\
    \ != r: v2.add(p)\n      swap(v, v2)\n      while r in st: st.erase(r);st.checkTree()\n\
    \    else:\n      check false\n    var v2 = newSeq[(int, int)]()\n    for k,v\
    \ in st:\n      v2.add((k,v))\n    check v == v2\n\ntest \"sortedMapMultiDimension,\
    \ int\":\n  var st = initSortedMap(int, SortedMap(int, SortedMap(int, SortedMap(int,\
    \ int))))\n  check st.empty()\n  const B = 10\n  for i in 0..<B:\n    for j in\
    \ 0..<B:\n      for k in 0..<B:\n        for l in 0..<B:\n          st[i][j][k][l]\
    \ = i * j * k * l\n  for i in 0..<B:\n    for j in 0..<B:\n      for k in 0..<B:\n\
    \        for l in 0..<B:\n          check st[i][j][k][l] == i * j * k * l\n"
  dependsOn:
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  isVerificationFile: false
  path: tests/test_extra_set_map.nim
  requiredBy: []
  timestamp: '2021-08-20 02:39:44+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_extra_set_map.nim
layout: document
redirect_from:
- /library/tests/test_extra_set_map.nim
- /library/tests/test_extra_set_map.nim.html
title: tests/test_extra_set_map.nim
---
