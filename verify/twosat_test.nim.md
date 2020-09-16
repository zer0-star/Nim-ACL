---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_scc.nim
    title: src/nim_acl/internal_scc.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/twosat.nim
    title: src/nim_acl/twosat.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/twosat.nim
    title: src/nim_acl/twosat.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_scc.nim
    title: src/nim_acl/internal_scc.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/two_sat
    links:
    - https://judge.yosupo.jp/problem/two_sat
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/two_sat\n\ninclude\
    \ src/nim_acl/header\ninclude src/nim_acl/twosat\n\nimport sequtils, strutils,\
    \ sugar\n\nblock:\n  let\n    p, cnf = nextString() # dummy\n    N, M = nextInt()\n\
    \  var ts = initTwoSat(N)\n  for _ in 0..<M:\n    var a, b = nextInt()\n    let\
    \ zero = nextString() # summy\n    var f, g:bool\n    if a > 0:\n      f = true\n\
    \    else:\n      f = false\n      a *= -1\n    a.dec\n    if b > 0:\n      g\
    \ = true\n    else:\n      g = false\n      b *= -1\n    b.dec\n    ts.add_clause(a,\
    \ f, b, g)\n  if ts.satisfiable:\n    echo \"s SATISFIABLE\"\n    stdout.write\
    \ \"v \"\n    for i,a in ts.answer:\n      if a:\n        stdout.write i + 1,\
    \ \" \"\n      else:\n        stdout.write -(i + 1), \" \"\n    echo 0\n  else:\n\
    \    echo \"s UNSATISFIABLE\"\n"
  dependsOn:
  - src/nim_acl/internal_scc.nim
  - src/nim_acl/header.nim
  - src/nim_acl/header.nim
  - src/nim_acl/twosat.nim
  - src/nim_acl/twosat.nim
  - src/nim_acl/internal_scc.nim
  isVerificationFile: true
  path: verify/twosat_test.nim
  requiredBy: []
  timestamp: '2020-09-14 00:37:28+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/twosat_test.nim
layout: document
redirect_from:
- /verify/verify/twosat_test.nim
- /verify/verify/twosat_test.nim.html
title: verify/twosat_test.nim
---
