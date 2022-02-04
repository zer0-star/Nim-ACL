---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':x:'
    path: atcoder/extra/tree/doubling_lowest_common_ancestor.nim
    title: atcoder/extra/tree/doubling_lowest_common_ancestor.nim
  - icon: ':x:'
    path: atcoder/extra/tree/doubling_lowest_common_ancestor.nim
    title: atcoder/extra/tree/doubling_lowest_common_ancestor.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/lca
    links:
    - https://judge.yosupo.jp/problem/lca
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/lca\n\ninclude atcoder/header\n\
    import atcoder/extra/graph/graph_template\n\nimport atcoder/extra/tree/doubling_lowest_common_ancestor\n\
    \nproc main() =\n  let N, Q = nextInt()\n  var g = initGraph(N)\n  for i in 1..<N:\n\
    \    let p = nextInt()\n    g.addBiEdge(i, p)\n  let lca = initDoublingLowestCommonAncestor(g,\
    \ 0)\n  for i in 0..<Q:\n    let x, y = nextInt()\n    echo lca.lca(x, y)\n\n\
    main()\n"
  dependsOn:
  - atcoder/extra/tree/doubling_lowest_common_ancestor.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/header.nim
  - atcoder/extra/tree/doubling_lowest_common_ancestor.nim
  isVerificationFile: true
  path: verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
layout: document
redirect_from:
- /verify/verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
- /verify/verify/extra/tree/yosupo_lowest_common_ancestor_test.nim.html
title: verify/extra/tree/yosupo_lowest_common_ancestor_test.nim
---