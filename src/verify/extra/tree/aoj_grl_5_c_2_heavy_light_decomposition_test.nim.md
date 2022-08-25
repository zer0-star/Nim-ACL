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
    path: atcoder/extra/tree/heavy_light_decomposition.nim
    title: atcoder/extra/tree/heavy_light_decomposition.nim
  - icon: ':x:'
    path: atcoder/extra/tree/heavy_light_decomposition.nim
    title: atcoder/extra/tree/heavy_light_decomposition.nim
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_C\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/tree/heavy_light_decomposition\n\
    \nproc main() =\n  let N = nextInt()\n  var g = initGraph(N)\n  for i in 0..<N:\n\
    \    let k = nextInt()\n    for j in 0..<k:\n      let c = nextInt()\n      g.addBiEdge(i,\
    \ c)\n  let tree = initHeavyLightDecomposition(g)\n  let Q = nextInt()\n  for\
    \ i in 0..<Q:\n    let u, v = nextInt()\n    echo tree.lca(u, v)\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/tree/heavy_light_decomposition.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/tree/heavy_light_decomposition.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
layout: document
redirect_from:
- /verify/verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
- /verify/verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim.html
title: verify/extra/tree/aoj_grl_5_c_2_heavy_light_decomposition_test.nim
---
