---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/composition_of_formal_power_series
    links:
    - https://judge.yosupo.jp/problem/composition_of_formal_power_series
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/composition_of_formal_power_series\n\
    \nimport atcoder/header, atcoder/modint\nimport atcoder/extra/math/formal_power_series\n\
    import std/sequtils, std/strutils\n\nproc main():void =\n  type mint = modint998244353\n\
    \  type FPS = FormalPowerSeries[mint]\n  let\n    N = nextInt()\n    a = FPS.init(newSeqWith(N,\
    \ mint(nextInt())))\n    b = FPS.init(newSeqWith(N, mint(nextInt())))\n  echo\
    \ composition(b, a).join(\" \")\n\nmain()\n"
  dependsOn: []
  isVerificationFile: false
  path: src/verify/extra/composition_of_formal_power_series_test_backup.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/verify/extra/composition_of_formal_power_series_test_backup.nim
layout: document
redirect_from:
- /library/src/verify/extra/composition_of_formal_power_series_test_backup.nim
- /library/src/verify/extra/composition_of_formal_power_series_test_backup.nim.html
title: src/verify/extra/composition_of_formal_power_series_test_backup.nim
---
