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
  - icon: ':question:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':question:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/associative_array
    links:
    - https://judge.yosupo.jp/problem/associative_array
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/associative_array\n\
    \nimport atcoder/header\nimport atcoder/extra/structure/set_map\n\nproc main()\
    \ =\n  let Q = nextInt()\n  var a = initSortedMap[int, int]()\n  for q in 0..<Q:\n\
    \    let t = nextInt()\n    if t == 0:\n      let k, v = nextInt()\n      a[k]\
    \ = v\n    else:\n      let k = nextInt()\n      if k in a: echo a[k]\n      else:\
    \ echo 0\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/header.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/red_black_tree.nim
  isVerificationFile: true
  path: verify/map_test.nim
  requiredBy: []
  timestamp: '2022-07-03 22:20:00+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/map_test.nim
layout: document
redirect_from:
- /verify/verify/map_test.nim
- /verify/verify/map_test.nim.html
title: verify/map_test.nim
---
