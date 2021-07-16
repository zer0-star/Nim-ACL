---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
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
  code: "import std/unittest\nimport atcoder/internal_math\nimport ../test/utils/math\n\
    \ntest \"UtilsMathTest, FactorsTest\":\n  for m in 1..50000:\n    var m2 = m\n\
    \    for x in factors(m):\n      check 0 == m mod x\n      while m2 mod x == 0:\
    \ m2 = m2 div x\n    check 1 == m2\n\nproc is_primitive_root_naive(m, g:int):bool\
    \ =\n  assert 1 <= g and g < m\n#  auto prs = factors(m - 1);\n  var x = 1\n \
    \ for i in 1..m-2:\n    x = x * g mod m\n    # x == n^i\n    if x == 1: return\
    \ false\n  x = x * g mod m\n  assert x == 1\n  return true\n\ntest \"UtilsMathTest,\
    \ IsPrimitiveRootTest\":\n  for m in 2..500:\n    if not is_prime_constexpr(m):\
    \ continue\n    for g in 1..<m:\n      check is_primitive_root_naive(m, g) ==\
    \ is_primitive_root(m, g)\n"
  dependsOn:
  - atcoder/internal_math.nim
  - atcoder/internal_math.nim
  isVerificationFile: false
  path: tests/test_utils_math.nim
  requiredBy: []
  timestamp: '2020-11-17 21:17:38+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_utils_math.nim
layout: document
redirect_from:
- /library/tests/test_utils_math.nim
- /library/tests/test_utils_math.nim.html
title: tests/test_utils_math.nim
---
