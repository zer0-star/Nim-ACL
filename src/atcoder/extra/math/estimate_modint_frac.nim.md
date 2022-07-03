---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ESTIMATE_FRACTION_HPP:\n  const ESTIMATE_FRACTION_HPP*\
    \ = 1\n  import std/math\n\n  proc estimate*[ModInt](f:ModInt):string =\n    var\
    \ P = sqrt(ModInt.mod.float).int\n    for d in 1..P:\n      var f = f * d\n  \
    \    if f.val() <= P:\n        return $f & \"/\" & $d\n    return \"(estimation\
    \ failed)\"\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/estimate_modint_frac.nim
  requiredBy: []
  timestamp: '2020-12-05 23:18:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/estimate_modint_frac.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/estimate_modint_frac.nim
- /library/atcoder/extra/math/estimate_modint_frac.nim.html
title: atcoder/extra/math/estimate_modint_frac.nim
---
