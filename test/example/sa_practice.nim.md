---
data:
  _extendedDependsOn: []
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
  code: "include atcoder/header\nimport atcoder/string\n\nlet\n  s = nextString()\n\
    \  sa = suffix_array(s)\nvar answer = s.len * (s.len + 1) div 2\nfor x in lcp_array(s,\
    \ sa):\n  answer -= x\necho answer\n"
  dependsOn: []
  isVerificationFile: false
  path: test/example/sa_practice.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/sa_practice.nim
layout: document
redirect_from:
- /library/test/example/sa_practice.nim
- /library/test/example/sa_practice.nim.html
title: test/example/sa_practice.nim
---
