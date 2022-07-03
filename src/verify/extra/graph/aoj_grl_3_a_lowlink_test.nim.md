---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/lowlink.nim
    title: atcoder/extra/graph/lowlink.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/lowlink.nim
    title: atcoder/extra/graph/lowlink.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_A
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_A
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_A\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/lowlink\n\
    \nproc main() =\n  let V,E = nextInt()\n  var g = initGraph(V)\n  for i in 0..<E:\n\
    \    var x,y = nextInt()\n    g.addBiEdge(x,y)\n  var lowlink = LowLink(g)\n \
    \ lowlink.articulation.sort()\n  for v in lowlink.articulation: echo v\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/lowlink.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/header.nim
  - atcoder/extra/graph/lowlink.nim
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
- /verify/verify/extra/graph/aoj_grl_3_a_lowlink_test.nim.html
title: verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
---
