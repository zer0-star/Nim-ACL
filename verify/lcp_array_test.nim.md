---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/string.nim
    title: src/nim_acl/string.nim
  - icon: ':question:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/string.nim
    title: src/nim_acl/string.nim
  - icon: ':question:'
    path: src/nim_acl/header.nim
    title: src/nim_acl/header.nim
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
    \ninclude src/nim_acl/header\nimport src/nim_acl/string\n\nlet\n  S = nextString()\n\
    \  sa = S.suffixarray()\n  lcp = S.lcp_array(sa)\n  n = S.len\n\nvar ans = n *\
    \ (n + 1) div 2\nfor v in lcp: ans -= v\necho ans\n"
  dependsOn:
  - src/nim_acl/string.nim
  - src/nim_acl/header.nim
  - src/nim_acl/string.nim
  - src/nim_acl/header.nim
  isVerificationFile: true
  path: verify/lcp_array_test.nim
  requiredBy: []
  timestamp: '2020-09-16 23:07:19+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/lcp_array_test.nim
layout: document
redirect_from:
- /verify/verify/lcp_array_test.nim
- /verify/verify/lcp_array_test.nim.html
title: verify/lcp_array_test.nim
---
