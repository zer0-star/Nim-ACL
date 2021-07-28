---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':x:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
  - icon: ':x:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/two_sat
    links:
    - https://judge.yosupo.jp/problem/two_sat
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/two_sat\n\ninclude\
    \ atcoder/header\nimport atcoder/twosat\n\nblock:\n  let\n    p, cnf = nextString()\
    \ # dummy\n    N, M = nextInt()\n  var ts = initTwoSat(N)\n  for _ in 0..<M:\n\
    \    var a, b = nextInt()\n    let zero = nextString() # summy\n    var f, g:bool\n\
    \    if a > 0:\n      f = true\n    else:\n      f = false\n      a *= -1\n  \
    \  a.dec\n    if b > 0:\n      g = true\n    else:\n      g = false\n      b *=\
    \ -1\n    b.dec\n    ts.add_clause(a, f, b, g)\n  if ts.satisfiable:\n    echo\
    \ \"s SATISFIABLE\"\n    stdout.write \"v \"\n    for i,a in ts.answer:\n    \
    \  if a:\n        stdout.write i + 1, \" \"\n      else:\n        stdout.write\
    \ -(i + 1), \" \"\n    echo 0\n  else:\n    echo \"s UNSATISFIABLE\"\n"
  dependsOn:
  - atcoder/twosat.nim
  - atcoder/header.nim
  - atcoder/internal_scc.nim
  - atcoder/internal_scc.nim
  - atcoder/header.nim
  - atcoder/twosat.nim
  isVerificationFile: true
  path: verify/twosat_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/twosat_test.nim
layout: document
redirect_from:
- /verify/verify/twosat_test.nim
- /verify/verify/twosat_test.nim.html
title: verify/twosat_test.nim
---
