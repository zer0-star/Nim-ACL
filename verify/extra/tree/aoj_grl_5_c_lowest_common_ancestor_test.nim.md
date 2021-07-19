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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_C
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_C
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_C\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/tree/doubling_lowest_common_ancestor\n\
    \nproc main() =\n  let N = nextInt()\n  var g = initGraph(N)\n  for i in 0..<N:\n\
    \    let k = nextInt()\n    for j in 0..<k:\n      let c = nextInt()\n      g.addBiEdge(i,c)\n\
    \  let lca = initDoublingLowestCommonAncestor(g, 0)\n  let Q = nextInt()\n  for\
    \ i in 0..<Q:\n    let x, y = nextInt()\n    echo lca.lca(x, y)\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/header.nim
  - atcoder/extra/tree/doubling_lowest_common_ancestor.nim
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/tree/doubling_lowest_common_ancestor.nim
  isVerificationFile: true
  path: verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
layout: document
redirect_from:
- /verify/verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
- /verify/verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim.html
title: verify/extra/tree/aoj_grl_5_c_lowest_common_ancestor_test.nim
---
