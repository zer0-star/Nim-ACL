---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':warning:'
    path: atcoder/extra/math/fft.nim
    title: atcoder/extra/math/fft.nim
  - icon: ':warning:'
    path: atcoder/extra/math/fft.nim
    title: atcoder/extra/math/fft.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import std/unittest\r\nimport atcoder/extra/math/fft\r\nimport atcoder/element_concepts\r\
    \nimport atcoder/extra/math/formal_power_series\r\n\r\n#let p = initFormalPowerSeries[float]([3,\
    \ 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9, 3, 2, 3, 8, 4, 6, 2, 6])\r\nlet p\
    \ = initFormalPowerSeries[float]([3, 1, 4])\r\n\r\nconst EPS = 0.0000001\r\n\r\
    \nproc EQUAL(a, b:float):bool =\r\n  if abs(a - b) < EPS: return true\r\n  if\
    \ abs(a) > EPS and abs((a - b) / a) < EPS:return true\r\n  if abs(b) > EPS and\
    \ abs((a - b) / b) < EPS:return true\r\n  return false\r\n\r\n\r\nproc EQUAL(a,\
    \ b:seq[SomeFloat]):bool =\r\n  check a.len == b.len\r\n  for i in 0..<a.len:\r\
    \n    if not EQUAL(a[i], b[i]): return false\r\n  return true\r\n\r\ntest \"InvTest\"\
    :\r\n  let q = p.inv\r\n  check q.len == p.len\r\n  var r = initFormalPowerSeries[float](p.len)\r\
    \n  r[0] = 1.0\r\n  check EQUAL((p * q)[0..<p.len], r)\r\n\r\ntest \"ExpTest\"\
    :\r\n  let\r\n    p = @[0.0] & p\r\n    q = p.exp()\r\n  check q.len == p.len\r\
    \n  check EQUAL(q.log()[0..<p.len], p)\r\n\r\ntest \"DivModTest\":\r\n  let m\
    \ = initFormalPowerSeries[float]([2, 7, 1, 8])\r\n  let q = p div m\r\n  let r\
    \ = p mod m\r\n  check EQUAL(q * m + r, p)\r\n\r\ntest \"powModTest\":\r\n  let\r\
    \n    m = initFormalPowerSeries[float]([2, 7, 1, 8])\r\n    a = 5\r\n    b = 6\r\
    \n  let u = (powMod(p, a, m) * powMod(p, b, m) mod m)[0..<m.len-1]\r\n  let v\
    \ = powMod(p, a + b, m)\r\n  check EQUAL(u, v)\r\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/extra/math/fft.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/fft.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/formal_power_series.nim
  isVerificationFile: false
  path: tests/test_extra_formal_power_series_float.nim
  requiredBy: []
  timestamp: '2020-11-17 21:17:38+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_extra_formal_power_series_float.nim
layout: document
redirect_from:
- /library/tests/test_extra_formal_power_series_float.nim
- /library/tests/test_extra_formal_power_series_float.nim.html
title: tests/test_extra_formal_power_series_float.nim
---
