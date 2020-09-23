---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/number_of_substrings
    links:
    - https://judge.yosupo.jp/problem/number_of_substrings
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/number_of_substrings\n\
    \nimport atcoder/header\nimport atcoder/string\n\nlet\n  S = nextString()\n  sa\
    \ = S.suffixarray()\n  lcp = S.lcp_array(sa)\n  n = S.len\n\nvar ans = n * (n\
    \ + 1) div 2\nfor v in lcp: ans -= v\necho ans\n"
  dependsOn: []
  isVerificationFile: true
  path: src/verify/lcp_array_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: src/verify/lcp_array_test.nim
layout: document
redirect_from:
- /verify/src/verify/lcp_array_test.nim
- /verify/src/verify/lcp_array_test.nim.html
title: src/verify/lcp_array_test.nim
---
