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
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import atcoder/header\nimport atcoder/twosat\n\nlet n, d = nextInt()\nvar\
    \ x, y = newSeq[int](n)\nfor i in 0..<n:\n  (x[i], y[i]) = (nextInt(), nextInt())\n\
    \n# ts[i] = (i-th flag is located on x[i])\nvar ts = init_two_sat(n)\n\nfor i\
    \ in 0..<n:\n  for j in i + 1 ..< n:\n    if abs(x[i] - x[j]) < d:\n      # cannot\
    \ use both of x[i] and x[j]\n      ts.add_clause(i, false, j, false)\n    if abs(x[i]\
    \ - y[j]) < d:\n      ts.add_clause(i, false, j, true)\n    if abs(y[i] - x[j])\
    \ < d:\n      ts.add_clause(i, true, j, false)\n    if abs(y[i] - y[j]) < d:\n\
    \      ts.add_clause(i, true, j, true)\n\nif not ts.satisfiable():\n  echo \"\
    No\"\nelse:\n  echo \"Yes\"\n  let answer = ts.answer\n  for i in 0..<n:\n   \
    \ if answer[i]:\n      echo x[i]\n    else:\n      echo y[i]\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/internal_scc.nim
  - atcoder/twosat.nim
  - atcoder/header.nim
  - atcoder/internal_scc.nim
  - atcoder/twosat.nim
  isVerificationFile: false
  path: test/example/twosat_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/twosat_practice.nim
layout: document
redirect_from:
- /library/test/example/twosat_practice.nim
- /library/test/example/twosat_practice.nim.html
title: test/example/twosat_practice.nim
---
