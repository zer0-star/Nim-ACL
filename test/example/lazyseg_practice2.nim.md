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
  code: "include atcoder/header\nimport atcoder/lazysegtree\n\nblock:\n  type S =\
    \ tuple[zero, one, inversion:int]\n  # swapping flag\n  type F = bool\n\n  proc\
    \ op(l, r:S):S =\n    (l.zero + r.zero,\n     l.one + r.one,\n     l.inversion\
    \ + r.inversion + l.one * r.zero)\n  proc e():S = (0,0,0)\n  proc mapping(l:F,\
    \ r:S):S =\n      if not l: return r\n      return (r.one, r.zero, r.one * r.zero\
    \ - r.inversion)\n  proc composition(l, r:F):F = (l and not r) or (not l and r)\n\
    \  proc id():F = false\n  \n  let n, q = nextInt()\n  var a = newSeq[S](n)\n \
    \ for i in 0..<n:\n    let x = nextInt()\n    if x == 0:\n      a[i] = (1, 0,\
    \ 0)\n    else:\n      a[i] = (0, 1, 0)\n\n  var seg = init_lazy_segtree(a, op,\
    \ e, mapping, composition, id)\n  for i in 0..<q:\n    var t, l, r = nextInt()\n\
    \    l.dec\n    if t == 1:\n      seg.apply(l..<r, true)\n    else:\n      echo\
    \ seg.prod(l..<r).inversion\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/rangeutils.nim
  - atcoder/lazysegtree.nim
  - atcoder/lazysegtree.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: test/example/lazyseg_practice2.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/lazyseg_practice2.nim
layout: document
redirect_from:
- /library/test/example/lazyseg_practice2.nim
- /library/test/example/lazyseg_practice2.nim.html
title: test/example/lazyseg_practice2.nim
---
