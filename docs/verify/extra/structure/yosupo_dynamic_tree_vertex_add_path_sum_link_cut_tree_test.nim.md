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
    PROBLEM: https://judge.yosupo.jp/problem/dynamic_tree_vertex_add_path_sum
    links:
    - https://judge.yosupo.jp/problem/dynamic_tree_vertex_add_path_sum
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/dynamic_tree_vertex_add_path_sum\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/structure/link_cut_tree\n\nblock:\n\
    \  let N, Q = nextInt()\n\n  proc add0(a, b:int):int = a + b\n  var lct = initLinkCutTree(add0,\
    \ 0)\n  type Node = lct.splay_tree.Node\n\n  var A = newSeqWith(N, nextInt())\n\
    \n  var vs = newSeq[Node](N)\n  for i in 0..<N:\n    vs[i] = lct.alloc(A[i])\n\
    \n  for i in 1..<N:\n    let a, b = nextInt()\n    lct.evert(vs[a])\n    lct.link(vs[a],\
    \ vs[b])\n\n  for _ in 0..<Q:\n    let T = nextInt()\n    case T:\n      of 0:\n\
    \        let U, V, W, X = nextInt()\n        lct.evert(vs[U])\n        lct.cut(vs[V])\n\
    \        lct.evert(vs[W])\n        lct.link(vs[W], vs[X])\n      of 1:\n     \
    \   let P, X = nextInt()\n        lct.expose(vs[P])\n        vs[P].key += X\n\
    \      else:\n        let U, V = nextInt()\n        lct.evert(vs[U])\n       \
    \ lct.expose(vs[V])\n        echo vs[V].sum\n"
  dependsOn:
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/header.nim
  - atcoder/extra/structure/link_cut_tree.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/link_cut_tree.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
- /verify/verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim.html
title: verify/extra/structure/yosupo_dynamic_tree_vertex_add_path_sum_link_cut_tree_test.nim
---
