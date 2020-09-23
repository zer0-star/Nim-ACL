---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/log_of_formal_power_series
    links:
    - https://judge.yosupo.jp/problem/log_of_formal_power_series
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/log_of_formal_power_series\n\
    \nimport atcoder/header, atcoder/modint\nimport atcoder/extra/math/formal_power_series\n\
    import std/strutils\n\nproc main():void =\n  type mint = modint998244353\n  let\
    \ N = nextInt()\n  var p = initFormalPowerSeries[mint](N)\n  for i in 0..<N: p[i]\
    \ = mint.init(nextInt())\n  echo p.log().join(\" \")\n\nmain()\n"
  dependsOn: []
  isVerificationFile: true
  path: src/verify/extra/log_of_formal_power_series_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: src/verify/extra/log_of_formal_power_series_test.nim
layout: document
redirect_from:
- /verify/src/verify/extra/log_of_formal_power_series_test.nim
- /verify/src/verify/extra/log_of_formal_power_series_test.nim.html
title: src/verify/extra/log_of_formal_power_series_test.nim
---
