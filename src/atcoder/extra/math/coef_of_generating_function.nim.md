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
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
    title: verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
  - icon: ':x:'
    path: verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
    title: verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not defined ATCODER_COEF_OF_GENERATING_FUNCTION_HPP:\n  const ATCODER_COEF_OF_GENERATING_FUNCTION_HPP*\
    \ = 1\n  import atcoder/extra/math/formal_power_series\n  import atcoder/element_concepts\n\
    \  type RationalFormalPowerSeries*[T] = object\n    num, den: FormalPowerSeries[T]\n\
    \  proc `//`*[T:FieldElem](P, Q:FormalPowerSeries[T]):RationalFormalPowerSeries[T]\
    \ =\n    RationalFormalPowerSeries[T](num:P, den:Q)\n  # P / Q\u306E\u6DFB\u5B57\
    N\u306E\u8981\u7D20\u3092\u8A08\u7B97\n  proc `[]`*[T:FieldElem](r:RationalFormalPowerSeries[T],N:int):T\
    \ =\n    var\n      P = r.num\n      Q = r.den\n      N = N\n    assert Q[0] !=\
    \ 0\n    if Q[0] != 1:\n      let t = Q[0].inv\n      P *= t;Q *= t\n    assert\
    \ Q[0] == 1\n    var q = initFormalPowerSeries[T](0)\n    if Q.len > P.len + 1:\n\
    \      P.setLen(Q.len - 1)\n    elif Q.len < P.len + 1:\n      q = P div Q\n \
    \     P = P mod Q\n      if N < q.len: result += q[N]\n#    Q.setLen(P.len + 1)\n\
    \    while N > 0:\n      var Q1 = Q\n      for i in countup(0, Q.len - 1, 2):\
    \ Q1[i] = Q[i]\n      for i in countup(1, Q.len - 1, 2): Q1[i] = -Q[i]\n     \
    \ block:\n        var PQ1 = P * Q1\n        P.setLen(0)\n        for i in countup(N\
    \ mod 2, PQ1.len - 1, 2): P.add(PQ1[i])\n        var QQ1 = Q * Q1\n        Q.setLen(0)\n\
    \        for i in countup(0, QQ1.len - 1, 2): Q.add(QQ1[i])\n      N = N div 2\n\
    \    result += P[0]\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  isVerificationFile: false
  path: atcoder/extra/math/coef_of_generating_function.nim
  requiredBy: []
  timestamp: '2021-12-11 18:27:17+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
  - verify/extra/math/yosupo_kth_term_of_linearly_recurrent_sequence_test.nim
documentation_of: atcoder/extra/math/coef_of_generating_function.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/coef_of_generating_function.nim
- /library/atcoder/extra/math/coef_of_generating_function.nim.html
title: atcoder/extra/math/coef_of_generating_function.nim
---
