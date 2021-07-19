---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':question:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
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
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import atcoder/header\nimport atcoder/dsu\n\nlet n, q = nextInt()\nvar d\
    \ = initDSU(n)\nfor i in 0..<q:\n  let t, u, v = nextInt()\n  if t == 0:\n   \
    \ d.merge(u, v)\n  else:\n    if d.same(u, v):\n      echo 1\n    else:\n    \
    \  echo 0\n\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/dsu.nim
  - atcoder/header.nim
  - atcoder/dsu.nim
  isVerificationFile: false
  path: test/example/dsu_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/dsu_practice.nim
layout: document
redirect_from:
- /library/test/example/dsu_practice.nim
- /library/test/example/dsu_practice.nim.html
title: test/example/dsu_practice.nim
---
