---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
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
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':x:'
    path: atcoder/lazysegtree.nim
    title: atcoder/lazysegtree.nim
  - icon: ':x:'
    path: atcoder/lazysegtree.nim
    title: atcoder/lazysegtree.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
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
  code: "import atcoder/header\nimport atcoder/lazysegtree\nimport atcoder/modint\n\
    import sugar\n\ntype mint = modint998244353\n\ntype S = tuple[a:mint, size:int]\n\
    type F = tuple[a:mint, b:mint]\n\nlet op = (l:S, r:S) => (l.a + r.a, l.size +\
    \ r.size)\nlet e = () => (mint(0), 0)\nlet mapping = (l:F, r:S) => (r.a * l.a\
    \ + r.size * l.b, r.size)\nlet composition = (l:F, r:F) => (r.a * l.a, r.b * l.a\
    \ + l.b)\nlet id = () => (mint(1), mint(0))\n\nlet n, q = nextInt()\nvar a = newSeq[S](n)\n\
    \nfor i in 0..<n:\n  let x = nextInt()\n  a[i] = (mint.init(x), 1)\n\nvar seg\
    \ = initLazySegTree(a, op, e, mapping, composition, id)\n\nfor i in 0..<q:\n \
    \ let t = nextInt()\n  if t == 0:\n    let l, r, c, d = nextInt()\n    seg.apply(l..<r,\
    \ (c.mint, d.mint));\n  else:\n    let l, r = nextInt()\n    echo seg.prod(l..<r).a.val()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/rangeutils.nim
  - atcoder/modint.nim
  - atcoder/lazysegtree.nim
  - atcoder/generate_definitions.nim
  - atcoder/lazysegtree.nim
  - atcoder/header.nim
  isVerificationFile: false
  path: test/example/lazyseg_practice1.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/lazyseg_practice1.nim
layout: document
redirect_from:
- /library/test/example/lazyseg_practice1.nim
- /library/test/example/lazyseg_practice1.nim.html
title: test/example/lazyseg_practice1.nim
---
