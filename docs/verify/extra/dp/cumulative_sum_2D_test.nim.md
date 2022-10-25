---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/dp/cumulative_sum_2d.nim
    title: atcoder/extra/dp/cumulative_sum_2d.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/dp/cumulative_sum_2d.nim
    title: atcoder/extra/dp/cumulative_sum_2d.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/dp/dual_cumulative_sum_2d.nim
    title: atcoder/extra/dp/dual_cumulative_sum_2d.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/dp/dual_cumulative_sum_2d.nim
    title: atcoder/extra/dp/dual_cumulative_sum_2d.nim
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
    PROBLEM: https://yukicoder.me/problems/no/1490
    links:
    - https://yukicoder.me/problems/no/1490
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://yukicoder.me/problems/no/1490\n\nimport\
    \ atcoder/header\nimport atcoder/extra/dp/dual_cumulative_sum_2d\nimport atcoder/extra/dp/cumulative_sum_2d\n\
    \nlet H, W, N, M = nextInt()\nvar T, U, L, R, A = newSeq[int](N)\nfor i in 0..<N:\n\
    \  T[i] = nextInt() - 1\n  U[i] = nextInt() - 1\n  L[i] = nextInt() - 1\n  R[i]\
    \ = nextInt() - 1\n  A[i] = nextInt()\n\nvar cs = initDualCumulativeSum2D[int](H,\
    \ W)\n\nfor i in 0..<M:\n  var X, Y, B, C = nextInt()\n  X.dec;Y.dec\n  var xl\
    \ = max(X - B, 0)\n  var yl = max(Y - B, 0)\n  var xr = min(X + B, H - 1)\n  var\
    \ yr = min(Y + B, W - 1)\n  cs.add(xl..xr, yl..yr, C)\n\ncs.build()\n\nvar cs2\
    \ = initCumulativeSum2D[int](H, W)\n\nfor i in 0..<H:\n  for j in 0..<W:\n   \
    \ var d = cs[i, j]\n    cs2.add(i, j, d)\n\ncs2.build()\n\nvar ans = 0\n\nfor\
    \ i in 0..<N:\n  var d = cs2[T[i]..U[i], L[i]..R[i]]\n  if d < A[i]: ans.inc\n\
    \necho ans\n"
  dependsOn:
  - atcoder/extra/dp/dual_cumulative_sum_2d.nim
  - atcoder/extra/dp/cumulative_sum_2d.nim
  - atcoder/header.nim
  - atcoder/extra/dp/dual_cumulative_sum_2d.nim
  - atcoder/extra/dp/cumulative_sum_2d.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/dp/cumulative_sum_2D_test.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:00+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/dp/cumulative_sum_2D_test.nim
layout: document
redirect_from:
- /verify/verify/extra/dp/cumulative_sum_2D_test.nim
- /verify/verify/extra/dp/cumulative_sum_2D_test.nim.html
title: verify/extra/dp/cumulative_sum_2D_test.nim
---
