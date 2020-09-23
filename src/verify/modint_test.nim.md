---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/741
    links:
    - https://yukicoder.me/problems/no/741
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://yukicoder.me/problems/no/741\n\nimport atcoder/modint\n\
    import std/strutils, std/sequtils, std/math\n\nlet\n  N = stdin.readLine.parseInt.initModInt()\n\
    \necho (0 ..< 9).mapIt(N + 9 - it).prod / toSeq(1 .. 9).prod\n"
  dependsOn: []
  isVerificationFile: true
  path: src/verify/modint_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: src/verify/modint_test.nim
layout: document
redirect_from:
- /verify/src/verify/modint_test.nim
- /verify/src/verify/modint_test.nim.html
title: src/verify/modint_test.nim
---
