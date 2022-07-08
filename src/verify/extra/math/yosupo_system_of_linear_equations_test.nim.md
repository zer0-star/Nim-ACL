---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
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
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/system_of_linear_equations
    links:
    - https://judge.yosupo.jp/problem/system_of_linear_equations
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/system_of_linear_equations\n\
    \ninclude atcoder/header\nimport atcoder/modint\nimport atcoder/extra/math/matrix\n\
    import options\n\ntype mint = modint998244353\n\nblock main:\n  let N, M = nextInt()\n\
    \  type Mat = MatrixType(mint)\n  let\n    A:Mat = newSeqWith(N, newSeqWith(M,\
    \ mint(nextInt())))\n    b:Vector[mint] = newSeqWith(N, mint(nextInt()))\n  let\
    \ t = linearEquations(A, b)\n  if t.isSome():\n    let (x, vs) = t.get\n    echo\
    \ vs.len\n    echo x.mapIt($it).join(\" \")\n    for v in vs:\n      echo v.mapIt($it).join(\"\
    \ \")\n  else:\n    echo -1\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  - atcoder/header.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  isVerificationFile: true
  path: verify/extra/math/yosupo_system_of_linear_equations_test.nim
  requiredBy: []
  timestamp: '2022-07-03 22:20:00+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/math/yosupo_system_of_linear_equations_test.nim
layout: document
redirect_from:
- /verify/verify/extra/math/yosupo_system_of_linear_equations_test.nim
- /verify/verify/extra/math/yosupo_system_of_linear_equations_test.nim.html
title: verify/extra/math/yosupo_system_of_linear_equations_test.nim
---
