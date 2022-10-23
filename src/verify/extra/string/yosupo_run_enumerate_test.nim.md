---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/string/run_enumerate.nim
    title: atcoder/extra/string/run_enumerate.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/string/run_enumerate.nim
    title: atcoder/extra/string/run_enumerate.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/runenumerate
    links:
    - https://judge.yosupo.jp/problem/runenumerate
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/runenumerate\n\n\
    include atcoder/header\nimport atcoder/extra/string/run_enumerate\n\nproc main()\
    \ =\n  let\n    s = nextString()\n    ans = RunEnumerate(s)\n  echo ans.len\n\
    \  for (t,l,r) in ans:\n    echo t, \" \",l, \" \",r\n\nmain()\n"
  dependsOn:
  - atcoder/string.nim
  - atcoder/string.nim
  - atcoder/extra/string/run_enumerate.nim
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/extra/string/run_enumerate.nim
  isVerificationFile: true
  path: verify/extra/string/yosupo_run_enumerate_test.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/string/yosupo_run_enumerate_test.nim
layout: document
redirect_from:
- /verify/verify/extra/string/yosupo_run_enumerate_test.nim
- /verify/verify/extra/string/yosupo_run_enumerate_test.nim.html
title: verify/extra/string/yosupo_run_enumerate_test.nim
---
