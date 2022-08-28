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
    path: atcoder/extra/tree/tree_diameter.nim
    title: atcoder/extra/tree/tree_diameter.nim
  - icon: ':x:'
    path: atcoder/extra/tree/tree_diameter.nim
    title: atcoder/extra/tree/tree_diameter.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_A
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_A
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_A\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/tree/tree_diameter\n\
    \nproc main() =\n  let N = nextInt()\n  var g = initGraph(N)\n  for i in 1..<N:\n\
    \    let x, y, z = nextInt()\n    g.addBiEdge(x,y,z)\n  echo g.treeDiameter()[0]\n\
    \nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/tree/tree_diameter.nim
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/tree/tree_diameter.nim
  isVerificationFile: true
  path: verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
layout: document
redirect_from:
- /verify/verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
- /verify/verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim.html
title: verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
---
