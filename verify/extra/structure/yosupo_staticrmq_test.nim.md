---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':x:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':x:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  - icon: ':x:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  - icon: ':x:'
    path: atcoder/extra/structure/sparse_table.nim
    title: atcoder/extra/structure/sparse_table.nim
  - icon: ':x:'
    path: atcoder/extra/structure/sparse_table.nim
    title: atcoder/extra/structure/sparse_table.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/staticrmq
    links:
    - https://judge.yosupo.jp/problem/staticrmq
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/staticrmq\n\ninclude\
    \ atcoder/header\nimport atcoder/extra/other/internal_sugar\nimport atcoder/extra/structure/sparse_table\n\
    \nf(p, q:int) => min(p, q)\n\nlet N, Q = nextInt()\nlet a = newSeqWith(N, nextInt())\n\
    \nvar st = initSparseTable(a, f)\n\nfor _ in 0..<Q:\n  let l, r = nextInt()\n\
    \  echo st[l..<r]\n"
  dependsOn:
  - atcoder/extra/other/internal_underscored_calls.nim
  - atcoder/header.nim
  - atcoder/extra/structure/sparse_table.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/extra/structure/sparse_table.nim
  - atcoder/extra/other/internal_underscored_calls.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_staticrmq_test.nim
  requiredBy: []
  timestamp: '2021-07-18 17:05:28+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_staticrmq_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_staticrmq_test.nim
- /verify/verify/extra/structure/yosupo_staticrmq_test.nim.html
title: verify/extra/structure/yosupo_staticrmq_test.nim
---
