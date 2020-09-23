---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
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
  code: "import atcoder/string\n\nlet s = \"missisippi\"\nlet sa = suffix_array(s)\n\
    \nlet answer = [\n  \"i\",\n  \"ippi\",\n  \"isippi\",\n  \"issisippi\",\n  \"\
    missisippi\",\n  \"pi\",\n  \"ppi\",\n  \"sippi\",\n  \"sisippi\",\n  \"ssisippi\"\
    ,\n]\n\nassert sa.len == answer.len\nfor i in 0..<sa.len:\n  assert s[sa[i]..^1]\
    \ == answer[i]\n"
  dependsOn:
  - atcoder/string.nim
  - atcoder/string.nim
  isVerificationFile: false
  path: test/example/sa_usage.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/sa_usage.nim
layout: document
redirect_from:
- /library/test/example/sa_usage.nim
- /library/test/example/sa_usage.nim.html
title: test/example/sa_usage.nim
---
