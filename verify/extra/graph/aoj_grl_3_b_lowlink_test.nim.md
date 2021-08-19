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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_B
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_B
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_B\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/lowlink\n\
    \nproc main() =\n  let V, E = nextInt()\n  var g = initGraph(V)\n  for i in 0..<E:\n\
    \    let x,y = nextInt()\n    g.addBiEdge(x,y)\n  var lowlink = LowLink(g)\n \
    \ lowlink.bridge.sort()\n  for p in lowlink.bridge: echo p[0], \" \", p[1]\n\n\
    main()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/extra/graph/lowlink.nim
  - atcoder/extra/graph/lowlink.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
- /verify/verify/extra/graph/aoj_grl_3_b_lowlink_test.nim.html
title: verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
---
