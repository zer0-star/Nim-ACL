---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/warshall_floyd.nim
    title: atcoder/extra/graph/warshall_floyd.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/warshall_floyd.nim
    title: atcoder/extra/graph/warshall_floyd.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_C
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_C
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_C\n\
    \ninclude atcoder/header\nimport atcoder/extra/graph/warshall_floyd\n\nproc main()\
    \ =\n  var\n    V = nextInt()\n    E = nextInt()\n    mat = newSeqWith(V, newSeqWith(V,\
    \ int.inf))\n  for i in 0..<V: mat[i][i] = 0\n  for i in 0..<E:\n    var x, y,\
    \ z = nextInt()\n    mat[x][y] = z\n  let dist = warshall_floyd(mat)\n  for i\
    \ in 0..<V:\n    if dist[i][i] < 0:\n      echo \"NEGATIVE CYCLE\"\n      return\n\
    \  for i in 0..<V:\n    for j in 0..<V:\n      if j > 0: stdout.write \" \"\n\
    \      if dist[i][j] == int.inf: stdout.write \"INF\"\n      else:\n        let\
    \ p = dist.path(i, j)\n        var s = 0\n        for k in 0..<p.len - 1: s +=\
    \ mat[p[k]][p[k + 1]]\n        assert s == dist[i][j]\n        stdout.write dist[i][j]\n\
    \    echo \"\"\n\nmain()\n"
  dependsOn:
  - atcoder/extra/graph/warshall_floyd.nim
  - atcoder/extra/other/inf.nim
  - atcoder/header.nim
  - atcoder/extra/graph/warshall_floyd.nim
  - atcoder/header.nim
  - atcoder/extra/other/inf.nim
  isVerificationFile: true
  path: verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
- /verify/verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim.html
title: verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
---
