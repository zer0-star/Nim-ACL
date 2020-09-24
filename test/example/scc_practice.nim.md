---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "include atcoder/header\nimport atcoder/scc as scc_lib\n\nlet n, m = nextInt()\n\
    \nvar g = init_scc_graph(n)\n\nfor i in 0..<m:\n  let u, v = nextInt()\n  g.add_edge(u,\
    \ v)\n\nvar scc = g.scc()\n\necho scc.len\nfor v in scc:\n  echo v.len, \" \"\
    , v.join(\" \")\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/header.nim
  isVerificationFile: false
  path: test/example/scc_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/scc_practice.nim
layout: document
redirect_from:
- /library/test/example/scc_practice.nim
- /library/test/example/scc_practice.nim.html
title: test/example/scc_practice.nim
---
