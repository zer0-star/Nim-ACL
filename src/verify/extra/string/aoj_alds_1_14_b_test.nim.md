---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/string/rolling_hash.nim
    title: atcoder/extra/string/rolling_hash.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/string/rolling_hash.nim
    title: atcoder/extra/string/rolling_hash.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B\n\
    \nimport atcoder/header\nimport atcoder/extra/string/rolling_hash\n\nproc main()\
    \ =\n  let T, P = nextString()\n  var\n    rh = initRollingHash(T)\n    rh2 =\
    \ initRollingHash(P)\n  for i in 0..T.len - P.len:\n    if rh[i..<i + P.len] ==\
    \ rh2[0..<P.len]: echo i\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/string/rolling_hash.nim
  - atcoder/extra/string/rolling_hash.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/string/aoj_alds_1_14_b_test.nim
  requiredBy: []
  timestamp: '2022-07-03 22:20:00+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/string/aoj_alds_1_14_b_test.nim
layout: document
redirect_from:
- /verify/verify/extra/string/aoj_alds_1_14_b_test.nim
- /verify/verify/extra/string/aoj_alds_1_14_b_test.nim.html
title: verify/extra/string/aoj_alds_1_14_b_test.nim
---