---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':x:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':x:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':x:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':x:'
    path: atcoder/extra/math/combination.nim
    title: atcoder/extra/math/combination.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/math/yukicoder_factorial_test.nim
    title: verify/extra/math/yukicoder_factorial_test.nim
  - icon: ':x:'
    path: verify/extra/math/yukicoder_factorial_test.nim
    title: verify/extra/math/yukicoder_factorial_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_FACTORIAL_HPP:\n  const ATCODER_FACTORIAL_HPP*\
    \ = 1\n  import atcoder/extra/math/combination\n  import atcoder/extra/math/formal_power_series\n\
    \  import math\n  proc factorial*[ModInt](n:int):ModInt =\n    if n >= ModInt.mod():\
    \ return 0\n    if n == 0: return 1\n  \n    let\n      sn = sqrt(n.float).int\n\
    \      sn_inv = ModInt(1) / sn\n  \n    proc shift(f:FormalPowerSeries[ModInt],\
    \ dx:ModInt):auto = \n      let\n        n = f.len\n        a = dx * sn_inv\n\
    \      var p1 = f\n      for i in 0..<n:\n        var d = ModInt.rfact(i) * ModInt.rfact((n\
    \ - 1) - i)\n        if ((n - 1 - i) and 1) != 0: d = -d\n        p1[i] *= d\n\
    \      var p2 = initFormalPowerSeries[ModInt](2 * n)\n      for i in 0..<p2.len:\n\
    \        p2[i] = if ((a.val) + i - n) <= 0: 1 else: (a + i - n).val\n      for\
    \ i in 1..<p2.len:\n        p2[i] *= p2[i - 1]\n      var\n        prod = p2[2\
    \ * n - 1]\n        prod_inv = ModInt(1) / prod\n      for i in countdown(2 *\
    \ n - 1, 1):\n        p2[i] = prod_inv * p2[i - 1]\n        prod_inv *= a + i\
    \ - n\n      p2[0] = prod_inv\n#      var fft = p2.getFFT()\n#      var p3 = fft[].multiply(p1,\
    \ p2, (int) p2.len)\n\n#      p1 = p3[p1.len..<p2.len]\n\n      p1 = (p1 * p2)[p1.len..<p2.len]\n\
    \      prod = 1\n      for i in 0..<n:\n        prod *= a + n - 1 - i\n      for\
    \ i in countdown(n - 1, 0):\n        p1[i] *= prod\n        prod *= p2[n + i]\
    \ * (a + i - n)\n      return p1\n    proc rec(n:int):seq[ModInt] =\n      if\
    \ n == 1: return initFormalPowerSeries[ModInt](@[1, 1 + sn])\n      let nh = n\
    \ shr 1\n      var\n        a1 = rec(nh)\n        a2 = shift(a1, nh)\n       \
    \ b1 = shift(a1, sn * nh)\n        b2 = shift(a1, sn * nh + nh)\n      for i in\
    \ 0..nh: a1[i] *= a2[i]\n      for i in 1..nh: a1.add(b1[i] * b2[i])\n      if\
    \ (n and 1) != 0:\n        for i in 0..<n:\n          a1[i] *= n + sn * i\n  \
    \      var prod = ModInt(1)\n        for i in n * sn..<n * sn + n:\n         \
    \ prod *= (i + 1)\n        a1.add(prod.val)\n      return a1;\n    let vs = rec(sn)\n\
    \    result = ModInt(1)\n    for i in 0..<sn: result *= vs[i]\n    for i in sn\
    \ * sn + 1..n: result *= i\n"
  dependsOn:
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/combination.nim
  - atcoder/extra/math/formal_power_series.nim
  isVerificationFile: false
  path: atcoder/extra/math/factorial.nim
  requiredBy: []
  timestamp: '2021-12-11 18:27:17+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/math/yukicoder_factorial_test.nim
  - verify/extra/math/yukicoder_factorial_test.nim
documentation_of: atcoder/extra/math/factorial.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/factorial.nim
- /library/atcoder/extra/math/factorial.nim.html
title: atcoder/extra/math/factorial.nim
---
