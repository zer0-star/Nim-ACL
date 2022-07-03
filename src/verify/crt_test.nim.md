---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/math.nim
    title: atcoder/math.nim
  - icon: ':question:'
    path: atcoder/math.nim
    title: atcoder/math.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/186
    links:
    - https://yukicoder.me/problems/no/186
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://yukicoder.me/problems/no/186\n\nimport atcoder/header\n\
    import atcoder/math\n\nlet X1, Y1, X2, Y2, X3, Y3 = nextInt()\nvar (y, z) = crt(@[X1,\
    \ X2, X3], @[Y1, Y2, Y3])\nif y == 0 and z == 0:\n  echo -1\nelse:\n  if y ==\
    \ 0: y += z\n  echo y\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/math.nim
  - atcoder/internal_math.nim
  - atcoder/internal_math.nim
  - atcoder/math.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/crt_test.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/crt_test.nim
layout: document
redirect_from:
- /verify/verify/crt_test.nim
- /verify/verify/crt_test.nim.html
title: verify/crt_test.nim
---
