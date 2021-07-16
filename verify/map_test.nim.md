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
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/associative_array\n\
    \nimport atcoder/header\nimport atcoder/extra/structure/set_map\n\nproc main()\
    \ =\n  let Q = nextInt()\n  var a = initSortedMap[int,int]()\n  for q in 0..<Q:\n\
    \    let t = nextInt()\n    if t == 0:\n      let k, v = nextInt()\n      a[k]\
    \ = v\n    else:\n      let k = nextInt()\n      if k in a: echo a[k]\n      else:\
    \ echo 0\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/rangeutils.nim
  - atcoder/header.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/randomized_binary_search_tree.nim
  - atcoder/extra/structure/randomized_binary_search_tree.nim
  - atcoder/extra/structure/set_map.nim
  isVerificationFile: true
  path: verify/map_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/map_test.nim
layout: document
redirect_from:
- /verify/verify/map_test.nim
- /verify/verify/map_test.nim.html
title: verify/map_test.nim
---
