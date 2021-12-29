---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/tree/tree_diameter.nim
    title: atcoder/extra/tree/tree_diameter.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/tree/tree_diameter.nim
    title: atcoder/extra/tree/tree_diameter.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/tree_diameter
    links:
    - https://judge.yosupo.jp/problem/tree_diameter
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/tree_diameter\n\n\
    include atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/tree/tree_diameter\n\
    \nproc main() =\n  let N = nextInt()\n  var g = initGraph(N)\n  for i in 1..<N:\n\
    \    let x, y, z = nextInt()\n    g.addBiEdge(x,y,z)\n  let (d, a) = g.treeDiameter()\n\
    \  echo d, \" \", a.len\n  echo a.mapIt($it).join(\" \")\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/tree/tree_diameter.nim
  - atcoder/header.nim
  - atcoder/extra/tree/tree_diameter.nim
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: true
  path: verify/extra/tree/yosupo_tree_diameter_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/tree/yosupo_tree_diameter_test.nim
layout: document
redirect_from:
- /verify/verify/extra/tree/yosupo_tree_diameter_test.nim
- /verify/verify/extra/tree/yosupo_tree_diameter_test.nim.html
title: verify/extra/tree/yosupo_tree_diameter_test.nim
---
