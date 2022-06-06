---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/factorization.nim
    title: atcoder/extra/math/factorization.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/factorization.nim
    title: atcoder/extra/math/factorization.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/factorize
    links:
    - https://judge.yosupo.jp/problem/factorize
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/factorize\n\ninclude\
    \ atcoder/header\nimport atcoder/extra/math/factorization\n\nblock main:\n  let\
    \ Q = nextInt()\n  for _ in 0..<Q:\n    let x = factor(nextInt()).sorted()\n \
    \   stdout.write(x.len, \" \")\n    stdout.write(x.mapIt($it).join(\" \"))\n \
    \   echo \"\"\n"
  dependsOn:
  - atcoder/extra/math/factorization.nim
  - atcoder/extra/math/factorization.nim
  - atcoder/header.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/math/yosupo_factorization_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/math/yosupo_factorization_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/yosupo_factorization_test.nim
- /verify/verify/extra/math/yosupo_factorization_test.nim.html
title: verify/extra/math/yosupo_factorization_test.nim
---
