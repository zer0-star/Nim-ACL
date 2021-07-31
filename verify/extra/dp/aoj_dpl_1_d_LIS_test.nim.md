---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/dp/longest_increasing_subsequence.nim
    title: atcoder/extra/dp/longest_increasing_subsequence.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/dp/longest_increasing_subsequence.nim
    title: atcoder/extra/dp/longest_increasing_subsequence.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_D
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_D
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_D\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/dp/longest_increasing_subsequence\n\
    \nproc main() =\n  let\n    N = nextInt()\n    A = newSeqWith(N, nextInt())\n\
    \  echo longestIncreasingSubsequence(A, true)\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/dp/longest_increasing_subsequence.nim
  - atcoder/extra/dp/longest_increasing_subsequence.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
layout: document
redirect_from:
- /verify/verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
- /verify/verify/extra/dp/aoj_dpl_1_d_LIS_test.nim.html
title: verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
---
