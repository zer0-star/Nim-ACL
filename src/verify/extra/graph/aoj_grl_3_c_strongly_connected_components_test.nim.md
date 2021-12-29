---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_C
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_C
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_C\n\
    \ninclude atcoder/header\nimport atcoder/scc\n\nproc main() =\n  let V, E = nextInt()\n\
    \  var g = initSCCGraph(V)\n  for i in 0..<E:\n    let a,b = nextInt()\n    g.addEdge(a,b)\n\
    \  let scc = g.scc()\n  var belongs = newSeq[int](V)\n  for i in 0..<scc.len:\n\
    \    for v in scc[i]:\n      belongs[v] = i\n  let Q = nextInt()\n  for i in 0..<Q:\n\
    \    let a,b = nextInt()\n    echo if belongs[a] == belongs[b]: 1 else: 0\n\n\
    main()\n"
  dependsOn:
  - atcoder/internal_scc.nim
  - atcoder/header.nim
  - atcoder/scc.nim
  - atcoder/internal_scc.nim
  - atcoder/header.nim
  - atcoder/scc.nim
  - atcoder/internal_csr.nim
  - atcoder/internal_csr.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
- /verify/verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim.html
title: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
---
