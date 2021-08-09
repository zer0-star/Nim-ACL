---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':warning:'
    path: atcoder/extra/math/formal_power_series_sparse.nim
    title: atcoder/extra/math/formal_power_series_sparse.nim
  - icon: ':warning:'
    path: atcoder/extra/math/formal_power_series_sparse.nim
    title: atcoder/extra/math/formal_power_series_sparse.nim
  - icon: ':x:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':x:'
    path: atcoder/extra/math/ntt.nim
    title: atcoder/extra/math/ntt.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
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
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import std/unittest\r\nimport atcoder/modint\r\nimport atcoder/extra/math/ntt\r\
    \nimport atcoder/extra/math/formal_power_series\r\nimport atcoder/extra/math/formal_power_series_sparse\r\
    \n\r\nblock:\r\n  type mint = modint998244353\r\n  let p = initFormalPowerSeries[mint]([3,\
    \ 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9, 3, 2, 3, 8, 4, 6, 2, 6])\r\n\r\n \
    \ test \"InvTest\":\r\n    let\r\n      q = p.inv\r\n    check q.len == p.len\r\
    \n    var r = initFormalPowerSeries[mint](p.len)\r\n    r[0] = mint(1)\r\n   \
    \ check (p * q)[0..<p.len] == r\r\n\r\n  test \"ExpTest\":\r\n    let\r\n    \
    \  p = @[mint(0)] & p\r\n      q = p.exp()\r\n    check q.len == p.len\r\n   \
    \ check q.log()[0..<p.len] == p\r\n\r\n  test \"DivModTest\":\r\n    let m = initFormalPowerSeries[mint]([2,\
    \ 7, 1, 8])\r\n    let q = p div m\r\n    let r = p mod m\r\n    let ms = @[(0,\
    \ mint(2)), (1, mint(7)), (2, mint(1)), (3, mint(8))]\r\n    let dm = p.divMod(ms)\r\
    \n    check q * m + r == p\r\n    check dm[0] == q\r\n    check dm[1] == r\r\n\
    \r\n  test \"powModTest\":\r\n    let\r\n      m = initFormalPowerSeries[mint]([2,\
    \ 7, 1, 8])\r\n      a = 3782\r\n      b = 9265\r\n    let u = (powMod(p, a, m)\
    \ * powMod(p, b, m) mod m)[0..<m.len-1]\r\n    let v = powMod(p, a + b, m)\r\n\
    \    check u == v\r\n\r\nblock:\r\n  type mint = modint1000000007\r\n  let p =\
    \ initFormalPowerSeries[mint]([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9, 3,\
    \ 2, 3, 8, 4, 6, 2, 6])\r\n  test \"InvTestArbitrary\":\r\n    let\r\n      q\
    \ = p.inv\r\n    check q.len == p.len\r\n    var r = initFormalPowerSeries[mint](p.len)\r\
    \n    r[0] = mint(1)\r\n    check (p * q)[0..<p.len] == r\r\n\r\n  test \"ExpTestArbitrary\"\
    :\r\n    let\r\n      p = @[mint(0)] & p\r\n      q = p.exp()\r\n    check q.len\
    \ == p.len\r\n    check q.log()[0..<p.len] == p\r\n\r\n  test \"DivModTestArbitrary\"\
    :\r\n    let m = initFormalPowerSeries[mint]([2, 7, 1, 8])\r\n    let q = p div\
    \ m\r\n    let r = p mod m\r\n    let ms = @[(0, mint(2)), (1, mint(7)), (2, mint(1)),\
    \ (3, mint(8))]\r\n    let dm = p.divMod(ms)\r\n    check q * m + r == p\r\n \
    \   check dm[0] == q\r\n    check dm[1] == r\r\n\r\n  test \"powModTestArbitrary\"\
    :\r\n    let\r\n      m = initFormalPowerSeries[mint]([2, 7, 1, 8])\r\n      a\
    \ = 3782\r\n      b = 9265\r\n    let u = (powMod(p, a, m) * powMod(p, b, m) mod\
    \ m)[0..<m.len-1]\r\n    let v = powMod(p, a + b, m)\r\n    check u == v\r\n\r\
    \nblock:\r\n  type mint = modint\r\n  mint.setMod(1000000009)\r\n  let p = initFormalPowerSeries[mint]([3,\
    \ 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9, 3, 2, 3, 8, 4, 6, 2, 6])\r\n  test\
    \ \"InvTestArbitraryDinamic\":\r\n    let\r\n      q = p.inv\r\n    check q.len\
    \ == p.len\r\n    var r = initFormalPowerSeries[mint](p.len)\r\n    r[0] = mint(1)\r\
    \n    check (p * q)[0..<p.len] == r\r\n\r\n  test \"ExpTestArbitraryDinamic\"\
    :\r\n    let\r\n      p = @[mint(0)] & p\r\n      q = p.exp()\r\n    check q.len\
    \ == p.len\r\n    check q.log()[0..<p.len] == p\r\n\r\n  test \"DivModTestArbitraryDinamic\"\
    :\r\n    let m = initFormalPowerSeries[mint]([2, 7, 1, 8])\r\n    let q = p div\
    \ m\r\n    let r = p mod m\r\n    let ms = @[(0, mint(2)), (1, mint(7)), (2, mint(1)),\
    \ (3, mint(8))]\r\n    let dm = p.divMod(ms)\r\n    check q * m + r == p\r\n \
    \   check dm[0] == q\r\n    check dm[1] == r\r\n\r\n  test \"powModTestArbitraryDinamic\"\
    :\r\n    let\r\n      m = initFormalPowerSeries[mint]([2, 7, 1, 8])\r\n      a\
    \ = 3782\r\n      b = 9265\r\n    let u = (powMod(p, a, m) * powMod(p, b, m) mod\
    \ m)[0..<m.len-1]\r\n    let v = powMod(p, a + b, m)\r\n    check u == v\r\n"
  dependsOn:
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/extra/math/ntt.nim
  - atcoder/extra/math/formal_power_series_sparse.nim
  - atcoder/extra/math/formal_power_series_sparse.nim
  - atcoder/element_concepts.nim
  - atcoder/convolution.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_bit.nim
  - atcoder/convolution.nim
  isVerificationFile: false
  path: tests/test_extra_formal_power_series.nim
  requiredBy: []
  timestamp: '2021-05-19 22:57:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_extra_formal_power_series.nim
layout: document
redirect_from:
- /library/tests/test_extra_formal_power_series.nim
- /library/tests/test_extra_formal_power_series.nim.html
title: tests/test_extra_formal_power_series.nim
---
