---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/link_cut_tree.nim
    title: atcoder/extra/structure/link_cut_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/link_cut_tree.nim
    title: atcoder/extra/structure/link_cut_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
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
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
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
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/dynamic_tree_vertex_set_path_composite
    links:
    - https://judge.yosupo.jp/problem/dynamic_tree_vertex_set_path_composite
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/dynamic_tree_vertex_set_path_composite\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/structure/splay_tree\nimport\
    \ atcoder/extra/structure/link_cut_tree\n\nimport atcoder/modint\n\ntype mint\
    \ = modint998244353\n\nblock:\n  let N, Q = nextInt()\n\n  type pii = ((mint,mint),(mint,mint))\n\
    \  proc f(x,y:(mint, mint)):auto = return (x[0] * y[0], x[1] * y[0] + y[1])\n\
    \  proc ff(a, b:pii):auto = (f(a[0], b[0]), f(b[1], a[1]))\n  proc flip(a:((mint,mint),\
    \ (mint,mint))):auto = (a[1], a[0])\n  var lct = initLinkCutTree(ff, flip, ((mint(0),\
    \ mint(0)), (mint(0), (mint(0)))))\n\n  type ST = lct.splay_tree.type\n  type\
    \ Node = ST.Node\n  var vs = newSeq[Node](N)\n  for i in 0..<N:\n    let x, y\
    \ = nextInt().mint\n    vs[i] = lct.alloc(((x, y), (x, y)))\n  for i in 1..<N:\n\
    \    let a, b = nextInt()\n    lct.evert(vs[a])\n    lct.link(vs[a], vs[b])\n\n\
    \  for _ in 0..<Q:\n    let T = nextInt()\n    case T:\n      of 0:\n        let\
    \ U, V, W, X = nextInt()\n        lct.evert(vs[U])\n        lct.cut(vs[V])\n \
    \       lct.evert(vs[W])\n        lct.link(vs[W], vs[X])\n      of 1:\n      \
    \  let P = nextInt()\n        let a, b = nextInt().mint\n        lct.expose(vs[P])\n\
    \        vs[P].key = ((a, b), (a, b))\n#        lct.update(vs[P]);\n      else:\n\
    \        let U, V = nextInt()\n        let X = nextInt().mint\n        lct.evert(vs[U])\n\
    \        lct.expose(vs[V])\n        let ret = vs[V].sum[0]\n        echo ret[0]\
    \ * X + ret[1]\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/internal_math.nim
  - atcoder/header.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/header.nim
  - atcoder/extra/structure/link_cut_tree.nim
  - atcoder/extra/structure/link_cut_tree.nim
  - atcoder/modint.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
- /verify/verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim.html
title: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
---
