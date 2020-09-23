---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/sum_of_floor_of_linear
    links:
    - https://judge.yosupo.jp/problem/sum_of_floor_of_linear
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/sum_of_floor_of_linear\n\
    \nimport atcoder/header, atcoder/math\n\nlet T = nextInt()\n\nfor _ in 0..<T:\n\
    \  let N, M, A, B = nextInt()\n  echo floor_sum(N, M, A, B)\n"
  dependsOn: []
  isVerificationFile: true
  path: src/verify/floor_sum_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: src/verify/floor_sum_test.nim
layout: document
redirect_from:
- /verify/src/verify/floor_sum_test.nim
- /verify/src/verify/floor_sum_test.nim.html
title: src/verify/floor_sum_test.nim
---
