---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/dp/slide_min.nim
    title: atcoder/extra/dp/slide_min.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/dp/slide_min.nim
    title: atcoder/extra/dp/slide_min.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_3_D
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_3_D
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_3_D\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/dp/slide_min\n\nproc main() =\n\
    \  let\n    N, L = nextInt()\n    a = newSeqWith(N, nextInt())\n  echo a.slideMin(L).join(\"\
    \ \")\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/extra/dp/slide_min.nim
  - atcoder/extra/dp/slide_min.nim
  isVerificationFile: true
  path: verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
layout: document
redirect_from:
- /verify/verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
- /verify/verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim.html
title: verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
---
