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
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/math.nim
    title: atcoder/math.nim
  - icon: ':question:'
    path: atcoder/math.nim
    title: atcoder/math.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/sum_of_floor_of_linear
    links:
    - https://judge.yosupo.jp/problem/sum_of_floor_of_linear
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/sum_of_floor_of_linear\n\
    \nimport atcoder/header, atcoder/math\n\nlet T = nextInt()\n\nfor _ in 0..<T:\n\
    \  let N, M, A, B = nextInt()\n  echo floor_sum(N, M, A, B)\n"
  dependsOn:
  - atcoder/math.nim
  - atcoder/internal_math.nim
  - atcoder/header.nim
  - atcoder/math.nim
  - atcoder/internal_math.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/floor_sum_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/floor_sum_test.nim
layout: document
redirect_from:
- /verify/verify/floor_sum_test.nim
- /verify/verify/floor_sum_test.nim.html
title: verify/floor_sum_test.nim
---
