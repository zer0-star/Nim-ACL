---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/741
    links:
    - https://yukicoder.me/problems/no/741
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://yukicoder.me/problems/no/741\n\nimport atcoder/modint\n\
    import std/strutils, std/sequtils, std/math\n\nlet\n  N = stdin.readLine.parseInt.initModInt()\n\
    \necho (0 ..< 9).mapIt(N + 9 - it).prod / toSeq(1 .. 9).prod\n"
  dependsOn:
  - atcoder/modint.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  isVerificationFile: true
  path: verify/modint_test.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/modint_test.nim
layout: document
redirect_from:
- /verify/verify/modint_test.nim
- /verify/verify/modint_test.nim.html
title: verify/modint_test.nim
---
