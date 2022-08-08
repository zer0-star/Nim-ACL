---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/tree/rerooting.nim
    title: atcoder/extra/tree/rerooting.nim
  - icon: ':x:'
    path: atcoder/extra/tree/rerooting.nim
    title: atcoder/extra/tree/rerooting.nim
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
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://yukicoder.me/problems/no/1333
    links:
    - https://yukicoder.me/problems/no/1333
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://yukicoder.me/problems/no/1333\n\nimport\
    \ atcoder/header\nimport atcoder/modint\nimport atcoder/extra/tree/rerooting\n\
    \nlet N = nextInt()\n\ntype mint = modint1000000007\ntype Data = tuple[n, s, t:mint]\n\
    type Weight = mint\n\nproc f_up(d:Data, w:Weight):Data =\n  var (n, s, t) = d\n\
    \  return (n + 1, s + w * n + w, t + 2 * s * w + w * w * n + w * w)\nproc f_merge(d0,\
    \ d1:Data):Data = (d0.n + d1.n, d0.s + d1.s, d0.t + d1.t)\n\nvar g = initRerooting[Weight,\
    \ Data](N, f_up, f_merge, (mint(0), mint(0), mint(0)))\n\nfor _ in 0 ..< N - 1:\n\
    \  var u, v, w = nextInt()\n  u.dec;v.dec\n  g.addBiEdge(u, v, w)\n\nvar d = g.solve()\n\
    var ans = mint(0)\nfor i, (n, s, t) in d:\n  ans += t\n\necho ans / 2\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  - atcoder/extra/tree/rerooting.nim
  - atcoder/extra/tree/rerooting.nim
  isVerificationFile: true
  path: verify/extra/tree/rerooting_test.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/tree/rerooting_test.nim
layout: document
redirect_from:
- /verify/verify/extra/tree/rerooting_test.nim
- /verify/verify/extra/tree/rerooting_test.nim.html
title: verify/extra/tree/rerooting_test.nim
---
