---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/fenwicktree.nim
    title: atcoder/fenwicktree.nim
  - icon: ':x:'
    path: atcoder/fenwicktree.nim
    title: atcoder/fenwicktree.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
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
  code: "import atcoder/header\nimport atcoder/fenwicktree\n\nlet n, q = nextInt()\n\
    var fw = init_fenwick_tree[int](n)\n\nfor i in 0..<n:\n  let a = nextInt()\n \
    \ fw.add(i, a)\n\nfor i in 0..<q:\n  let t = nextInt()\n  if t == 0:\n    let\
    \ p, x = nextInt()\n    fw.add(p, x)\n  else:\n    let l, r = nextInt()\n    echo\
    \ fw.sum(l..<r)\n"
  dependsOn:
  - atcoder/internal_type_traits.nim
  - atcoder/rangeutils.nim
  - atcoder/header.nim
  - atcoder/internal_type_traits.nim
  - atcoder/rangeutils.nim
  - atcoder/fenwicktree.nim
  - atcoder/header.nim
  - atcoder/fenwicktree.nim
  isVerificationFile: false
  path: test/example/fenwick_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/fenwick_practice.nim
layout: document
redirect_from:
- /library/test/example/fenwick_practice.nim
- /library/test/example/fenwick_practice.nim.html
title: test/example/fenwick_practice.nim
---
