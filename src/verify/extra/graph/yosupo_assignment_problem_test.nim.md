---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/hungarian.nim
    title: atcoder/extra/graph/hungarian.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/hungarian.nim
    title: atcoder/extra/graph/hungarian.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/assignment
    links:
    - https://judge.yosupo.jp/problem/assignment
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/assignment\n\ninclude\
    \ atcoder/header\nimport atcoder/extra/graph/hungarian\n\nproc main() =\n  let\n\
    \    N = nextInt()\n    a = newSeqWith(N, newSeqWith(N, nextInt()))\n  let (X,\
    \ p) = a.hungarian()\n  echo X\n  echo p.mapIt($it).join(\" \")\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/extra/graph/hungarian.nim
  - atcoder/extra/graph/hungarian.nim
  isVerificationFile: true
  path: verify/extra/graph/yosupo_assignment_problem_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/yosupo_assignment_problem_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/yosupo_assignment_problem_test.nim
- /verify/verify/extra/graph/yosupo_assignment_problem_test.nim.html
title: verify/extra/graph/yosupo_assignment_problem_test.nim
---
