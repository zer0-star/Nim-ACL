---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/graph/gabow_edmonds.nim
    title: atcoder/extra/graph/gabow_edmonds.nim
  - icon: ':x:'
    path: atcoder/extra/graph/gabow_edmonds.nim
    title: atcoder/extra/graph/gabow_edmonds.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/general_matching
    links:
    - https://judge.yosupo.jp/problem/general_matching
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/general_matching\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/gabow_edmonds\n\nproc main()\
    \ =\n  let N, M = nextInt()\n  var g = initGabowEdmonds(N)\n  for i in 0..<M:\n\
    \    let u, v = nextInt()\n    g.addEdge(u, v)\n  \n  let p = g.maxMatching()\n\
    \  echo p.len\n  for p in p:\n    echo p[0], \" \", p[1]\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/gabow_edmonds.nim
  - atcoder/extra/graph/gabow_edmonds.nim
  - atcoder/header.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/graph/yosupo_matching_on_general_graph_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/graph/yosupo_matching_on_general_graph_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/yosupo_matching_on_general_graph_test.nim
- /verify/verify/extra/graph/yosupo_matching_on_general_graph_test.nim.html
title: verify/extra/graph/yosupo_matching_on_general_graph_test.nim
---
