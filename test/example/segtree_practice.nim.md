---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
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
  code: "import atcoder/header\nimport atcoder/segtree\nimport sequtils, sugar\n\n\
    let n, q = nextInt()\nlet a = newSeqWith(n, nextInt())\nvar target:int\nproc f(v:int):bool\
    \ = v < target\nvar seg = initSegTree[int](a, (a:int,b:int)=>max(a, b), () =>\
    \ -1)\n\nfor i in 0..<q:\n  let t = nextInt()\n  if t == 1:\n    var x, v = nextInt()\n\
    \    x.dec\n    seg.set(x, v);\n  elif t == 2:\n    var l, r = nextInt()\n   \
    \ l.dec\n    echo seg.prod(l..<r)\n  elif t == 3:\n    let p = nextInt() - 1\n\
    \    target = nextInt()\n    echo seg.max_right(p, f) + 1\n"
  dependsOn:
  - atcoder/segtree.nim
  - atcoder/rangeutils.nim
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: test/example/segtree_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/segtree_practice.nim
layout: document
redirect_from:
- /library/test/example/segtree_practice.nim
- /library/test/example/segtree_practice.nim.html
title: test/example/segtree_practice.nim
---
